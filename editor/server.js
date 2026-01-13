const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = 3031;
const SLIDES_PATH = path.join(__dirname, '..', 'slides.md');
const EDITOR_HTML = path.join(__dirname, 'index.html');

const server = http.createServer((req, res) => {
  // CORS headers
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') {
    res.writeHead(200);
    res.end();
    return;
  }

  // API: Load slides.md
  if (req.url === '/api/load' && req.method === 'GET') {
    try {
      const content = fs.readFileSync(SLIDES_PATH, 'utf-8');
      res.writeHead(200, { 'Content-Type': 'text/plain; charset=utf-8' });
      res.end(content);
    } catch (err) {
      res.writeHead(500);
      res.end('Error loading file');
    }
    return;
  }

  // API: Save slides.md
  if (req.url === '/api/save' && req.method === 'POST') {
    let body = '';
    req.on('data', chunk => body += chunk);
    req.on('end', () => {
      try {
        fs.writeFileSync(SLIDES_PATH, body, 'utf-8');
        res.writeHead(200);
        res.end('Saved');
      } catch (err) {
        res.writeHead(500);
        res.end('Error saving file');
      }
    });
    return;
  }

  // Serve editor HTML
  if (req.url === '/' || req.url === '/index.html') {
    try {
      const html = fs.readFileSync(EDITOR_HTML, 'utf-8');
      res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
      res.end(html);
    } catch (err) {
      res.writeHead(500);
      res.end('Error loading editor');
    }
    return;
  }

  // 404
  res.writeHead(404);
  res.end('Not Found');
});

server.listen(PORT, () => {
  console.log(`
╔════════════════════════════════════════════════════════════╗
║                    Slidev Editor Server                    ║
╠════════════════════════════════════════════════════════════╣
║  Editor:  http://localhost:${PORT}                           ║
║  Preview: http://localhost:3030                            ║
║                                                            ║
║  Make sure Slidev is running: npm run dev                  ║
╚════════════════════════════════════════════════════════════╝
`);
});
