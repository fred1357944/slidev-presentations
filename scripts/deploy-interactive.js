#!/usr/bin/env node
/**
 * Slidev 互動式部署 CLI
 * 用法: npm run deploy 或 node scripts/deploy-interactive.js
 */

import inquirer from 'inquirer';
import { execSync } from 'child_process';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const PROJECT_ROOT = path.dirname(__dirname);

// 顏色輸出
const colors = {
    green: (text) => `\x1b[32m${text}\x1b[0m`,
    yellow: (text) => `\x1b[33m${text}\x1b[0m`,
    blue: (text) => `\x1b[34m${text}\x1b[0m`,
    red: (text) => `\x1b[31m${text}\x1b[0m`,
};

async function main() {
    console.log(colors.blue('\n========================================'));
    console.log(colors.blue('  Slidev 互動式部署'));
    console.log(colors.blue('========================================\n'));

    // 讀取課程列表
    const coursesFile = path.join(PROJECT_ROOT, 'courses.json');
    if (!fs.existsSync(coursesFile)) {
        console.log(colors.red('錯誤: courses.json 不存在'));
        process.exit(1);
    }
    const coursesData = JSON.parse(fs.readFileSync(coursesFile, 'utf8'));

    // 步驟 1: 選擇課程
    const courseChoices = coursesData.courses.map(c => ({
        name: `${c.folder} (${c.name})`,
        value: c.folder,
    }));

    const { course } = await inquirer.prompt([
        {
            type: 'list',
            name: 'course',
            message: '選擇課程:',
            choices: courseChoices,
        },
    ]);

    // 讀取專案列表
    const projectsFile = path.join(PROJECT_ROOT, course, 'projects.json');
    if (!fs.existsSync(projectsFile)) {
        console.log(colors.red(`錯誤: ${course}/projects.json 不存在`));
        process.exit(1);
    }
    const projectsData = JSON.parse(fs.readFileSync(projectsFile, 'utf8'));

    // 步驟 2: 選擇專案
    const projectChoices = projectsData.projects.map(p => ({
        name: `${p.folder} (${p.name})`,
        value: p.folder,
    }));

    const { project } = await inquirer.prompt([
        {
            type: 'list',
            name: 'project',
            message: '選擇專案:',
            choices: projectChoices,
        },
    ]);

    // 讀取版本列表
    const versionsFile = path.join(PROJECT_ROOT, course, project, 'versions.json');
    if (!fs.existsSync(versionsFile)) {
        console.log(colors.red(`錯誤: ${course}/${project}/versions.json 不存在`));
        process.exit(1);
    }
    const versionsData = JSON.parse(fs.readFileSync(versionsFile, 'utf8'));

    // 計算建議的下一個版本號
    const versions = versionsData.versions || [];
    let suggestedVersion = 'v1';
    if (versions.length > 0) {
        const lastVersion = versions[versions.length - 1].id;
        const versionNum = parseInt(lastVersion.replace('v', '')) || 0;
        suggestedVersion = `v${versionNum + 1}`;
    }

    // 檢查現有版本目錄
    const existingVersionDirs = fs.readdirSync(path.join(PROJECT_ROOT, course, project))
        .filter(f => f.startsWith('v') && fs.statSync(path.join(PROJECT_ROOT, course, project, f)).isDirectory());

    // 步驟 3: 選擇或輸入版本號
    const versionChoices = [
        { name: `${suggestedVersion} (新版本)`, value: suggestedVersion },
        ...existingVersionDirs
            .filter(v => v !== suggestedVersion)
            .map(v => ({ name: `${v} (重新部署)`, value: v })),
        { name: '自訂版本號...', value: '__custom__' },
    ];

    let { version } = await inquirer.prompt([
        {
            type: 'list',
            name: 'version',
            message: '選擇版本:',
            choices: versionChoices,
        },
    ]);

    if (version === '__custom__') {
        const { customVersion } = await inquirer.prompt([
            {
                type: 'input',
                name: 'customVersion',
                message: '輸入版本號 (例如 v5):',
                validate: (input) => {
                    if (/^v\d+$/.test(input)) return true;
                    return '版本號格式應為 v 加數字，例如 v5';
                },
            },
        ]);
        version = customVersion;
    }

    // 檢查 slides.md 是否存在
    const slidesFile = path.join(PROJECT_ROOT, course, project, version, 'slides.md');
    if (!fs.existsSync(slidesFile)) {
        console.log(colors.red(`\n錯誤: ${course}/${project}/${version}/slides.md 不存在`));
        console.log(colors.yellow('請先創建 slides.md 檔案'));
        process.exit(1);
    }

    // 步驟 4: 輸入描述
    const existingVersion = versions.find(v => v.id === version);
    const defaultDescription = existingVersion?.description || '';

    const { description } = await inquirer.prompt([
        {
            type: 'input',
            name: 'description',
            message: '版本描述:',
            default: defaultDescription,
            validate: (input) => {
                if (input.trim().length > 0) return true;
                return '請輸入版本描述';
            },
        },
    ]);

    // 步驟 5: 確認
    console.log(colors.yellow('\n📋 部署摘要:'));
    console.log(`   課程: ${colors.green(course)}`);
    console.log(`   專案: ${colors.green(project)}`);
    console.log(`   版本: ${colors.green(version)}`);
    console.log(`   描述: ${colors.green(description)}`);
    console.log('');

    const { confirm } = await inquirer.prompt([
        {
            type: 'confirm',
            name: 'confirm',
            message: '確認部署？',
            default: true,
        },
    ]);

    if (!confirm) {
        console.log(colors.yellow('\n已取消部署'));
        process.exit(0);
    }

    // 執行部署腳本
    console.log(colors.blue('\n🚀 開始部署...\n'));

    const deployScript = path.join(__dirname, 'deploy-version.sh');
    const cmd = `"${deployScript}" "${course}" "${project}" "${version}" "${description}"`;

    try {
        execSync(cmd, { stdio: 'inherit', cwd: PROJECT_ROOT });
    } catch (error) {
        console.log(colors.red('\n部署失敗'));
        process.exit(1);
    }
}

main().catch((error) => {
    console.error(colors.red('錯誤:'), error.message);
    process.exit(1);
});
