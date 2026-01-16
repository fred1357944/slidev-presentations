const express = require('express');
const { spawn } = require('child_process');
const path = require('path');
const fs = require('fs');

const app = express();
const PORT = 3002; // API 服務端口

// 靜態檔案服務
app.use(express.static('.'));
app.use(express.json());

// CORS 設定
app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Headers', 'Content-Type');
  next();
});

// 取得所有課程和版本的建置狀態
app.get('/api/status', (req, res) => {
  const courses = [];
  const coursesJson = JSON.parse(fs.readFileSync('courses.json', 'utf-8'));

  for (const course of coursesJson.courses) {
    const courseDir = course.folder;
    const projectsPath = path.join(courseDir, 'projects.json');

    if (!fs.existsSync(projectsPath)) continue;

    const projectsJson = JSON.parse(fs.readFileSync(projectsPath, 'utf-8'));

    for (const project of projectsJson.projects) {
      const projectDir = path.join(courseDir, project.folder);

      // 找出所有版本
      if (!fs.existsSync(projectDir)) continue;

      const versions = fs.readdirSync(projectDir)
        .filter(f => f.startsWith('v') && fs.statSync(path.join(projectDir, f)).isDirectory());

      for (const version of versions) {
        const versionDir = path.join(projectDir, version);
        const indexPath = path.join(versionDir, 'index.html');
        const slidesPath = path.join(versionDir, 'slides.md');

        let status = 'not_built';
        let needsRebuild = false;

        if (fs.existsSync(indexPath)) {
          status = 'built';
          // 檢查是否需要重新建置
          if (fs.existsSync(slidesPath)) {
            const indexStat = fs.statSync(indexPath);
            const slidesStat = fs.statSync(slidesPath);
            if (slidesStat.mtime > indexStat.mtime) {
              needsRebuild = true;
            }
          }
        }

        courses.push({
          course: course.name,
          courseId: course.id,
          project: project.name,
          projectId: project.id,
          version,
          path: `${courseDir}/${project.folder}/${version}`,
          status,
          needsRebuild
        });
      }
    }
  }

  res.json({ courses });
});

// 部署 API (SSE 串流)
app.post('/api/deploy', (req, res) => {
  res.setHeader('Content-Type', 'text/event-stream');
  res.setHeader('Cache-Control', 'no-cache');
  res.setHeader('Connection', 'keep-alive');

  const sendEvent = (type, data) => {
    res.write(`data: ${JSON.stringify({ type, ...data })}\n\n`);
  };

  // 取得所有需要建置的版本
  const coursesJson = JSON.parse(fs.readFileSync('courses.json', 'utf-8'));
  const buildQueue = [];

  for (const course of coursesJson.courses) {
    const projectsPath = path.join(course.folder, 'projects.json');
    if (!fs.existsSync(projectsPath)) continue;

    const projectsJson = JSON.parse(fs.readFileSync(projectsPath, 'utf-8'));

    for (const project of projectsJson.projects) {
      const projectDir = path.join(course.folder, project.folder);
      if (!fs.existsSync(projectDir)) continue;

      const versions = fs.readdirSync(projectDir)
        .filter(f => f.startsWith('v') && fs.statSync(path.join(projectDir, f)).isDirectory());

      for (const version of versions) {
        const versionDir = path.join(projectDir, version);
        if (fs.existsSync(path.join(versionDir, 'slides.md'))) {
          buildQueue.push({
            courseId: course.id,
            projectId: project.id,
            version,
            path: versionDir
          });
        }
      }
    }
  }

  sendEvent('start', { total: buildQueue.length });

  let current = 0;

  const buildNext = () => {
    if (current >= buildQueue.length) {
      // 全部建置完成，執行 git push
      sendEvent('git', { status: 'pushing' });

      const gitAdd = spawn('git', ['add', '.']);
      gitAdd.on('close', (code) => {
        if (code !== 0) {
          sendEvent('error', { message: 'Git add failed' });
          res.end();
          return;
        }

        const gitCommit = spawn('git', ['commit', '-m', `deploy: 自動部署 ${new Date().toISOString()}`]);
        gitCommit.on('close', (code) => {
          // code 1 means nothing to commit, which is OK
          const gitPush = spawn('git', ['push']);
          gitPush.on('close', (pushCode) => {
            if (pushCode === 0) {
              sendEvent('complete', { success: true });
            } else {
              sendEvent('complete', { success: false, message: 'Git push failed' });
            }
            res.end();
          });
        });
      });
      return;
    }

    const item = buildQueue[current];
    sendEvent('building', {
      current: current + 1,
      total: buildQueue.length,
      item: `${item.courseId}/${item.projectId}/${item.version}`
    });

    const build = spawn('./scripts/build-version.sh', [
      item.courseId,
      item.projectId,
      item.version
    ]);

    build.stdout.on('data', (data) => {
      sendEvent('log', { message: data.toString() });
    });

    build.stderr.on('data', (data) => {
      sendEvent('log', { message: data.toString(), error: true });
    });

    build.on('close', (code) => {
      if (code === 0) {
        sendEvent('built', {
          item: `${item.courseId}/${item.projectId}/${item.version}`,
          success: true
        });
      } else {
        sendEvent('built', {
          item: `${item.courseId}/${item.projectId}/${item.version}`,
          success: false
        });
      }
      current++;
      buildNext();
    });
  };

  buildNext();

  req.on('close', () => {
    // 客戶端斷開連接
  });
});

app.listen(PORT, () => {
  console.log(`🚀 部署 API 服務運行於 http://localhost:${PORT}`);
  console.log(`📂 靜態檔案服務於 http://localhost:${PORT}`);
});
