# 開發日誌：一鍵部署功能

**日期**：2026-01-16
**版本**：1.0.0
**狀態**：已完成

---

## 目錄

1. [功能概述](#功能概述)
2. [技術架構](#技術架構)
3. [實作細節](#實作細節)
4. [UI 設計](#ui-設計)
5. [檔案清單](#檔案清單)
6. [使用方式](#使用方式)
7. [未來改進](#未來改進)

---

## 功能概述

### 需求背景

原本部署 Slidev 簡報需要手動執行多個步驟：
1. 進入每個版本目錄
2. 執行 `slidev build`
3. 手動 `git add`, `commit`, `push`

這個流程繁瑣且容易出錯，因此開發了「一鍵部署」功能。

### 功能範圍

- **自動掃描**：找出所有課程/專案/版本
- **批次建置**：依序建置每個簡報
- **即時進度**：SSE 串流顯示建置狀態
- **Git 整合**：自動 commit 和 push
- **狀態監控**：顯示每個版本的建置狀態

---

## 技術架構

### 系統架構圖

```
┌─────────────────────────────────────────────────────────┐
│                     瀏覽器 (Frontend)                    │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────┐  │
│  │  課程卡片   │  │  管理面板   │  │   進度顯示      │  │
│  └─────────────┘  └──────┬──────┘  └────────▲────────┘  │
│                          │                   │          │
│                          │ fetch             │ SSE      │
└──────────────────────────┼───────────────────┼──────────┘
                           │                   │
                           ▼                   │
┌─────────────────────────────────────────────────────────┐
│                   Express Server (Backend)               │
│                      Port: 3002                          │
│  ┌─────────────────┐  ┌─────────────────────────────┐   │
│  │ GET /api/status │  │ POST /api/deploy            │   │
│  │ 回傳建置狀態    │  │ 觸發建置 + SSE 串流進度    │   │
│  └─────────────────┘  └──────────────┬──────────────┘   │
│                                       │                  │
│                          ┌────────────▼────────────┐    │
│                          │    child_process        │    │
│                          │  spawn build-version.sh │    │
│                          └────────────┬────────────┘    │
│                                       │                  │
│                          ┌────────────▼────────────┐    │
│                          │      Git Operations     │    │
│                          │  add → commit → push    │    │
│                          └─────────────────────────┘    │
└─────────────────────────────────────────────────────────┘
```

### 技術選型

| 層級 | 技術 | 選擇原因 |
|------|------|----------|
| 後端框架 | Express.js | 輕量、簡單、適合小型 API |
| 即時通訊 | Server-Sent Events | 單向串流、無需 WebSocket 複雜度 |
| 建置工具 | Shell Script | 直接呼叫 slidev CLI |
| 前端 | Vanilla JS + CSS | 無需打包，保持簡單 |

### API 設計

#### `GET /api/status`

回傳所有課程/版本的建置狀態。

**Response:**
```json
{
  "courses": [
    {
      "course": "行銷課",
      "courseId": "marketing-course",
      "project": "行銷入門",
      "projectId": "intro",
      "version": "v1",
      "path": "marketing-course/intro/v1",
      "status": "built",
      "needsRebuild": false
    }
  ]
}
```

#### `POST /api/deploy`

觸發部署流程，回傳 SSE 串流。

**SSE Event Types:**
```javascript
// 開始部署
{ "type": "start", "total": 9 }

// 正在建置
{ "type": "building", "current": 1, "total": 9, "item": "marketing-course/intro/v1" }

// 建置完成
{ "type": "built", "item": "marketing-course/intro/v1", "success": true }

// Git 操作
{ "type": "git", "status": "pushing" }

// 部署完成
{ "type": "complete", "success": true }

// 日誌
{ "type": "log", "message": "Building slides...", "error": false }

// 錯誤
{ "type": "error", "message": "Build failed" }
```

---

## 實作細節

### server.js

主要邏輯：

```javascript
// 1. 靜態檔案服務
app.use(express.static('.'));

// 2. 狀態 API - 掃描所有版本
app.get('/api/status', (req, res) => {
  // 讀取 courses.json → projects.json → 掃描版本目錄
  // 檢查 index.html 是否存在（已建置）
  // 比較 slides.md 和 index.html 的修改時間（是否需要重建）
});

// 3. 部署 API - SSE 串流
app.post('/api/deploy', (req, res) => {
  // 設定 SSE headers
  res.setHeader('Content-Type', 'text/event-stream');

  // 建置佇列
  const buildQueue = [...]; // 所有需要建置的版本

  // 遞迴建置
  const buildNext = () => {
    // spawn('./scripts/build-version.sh', [...])
    // 完成後 buildNext()
    // 全部完成後 git add/commit/push
  };
});
```

### 狀態判斷邏輯

```javascript
// 狀態判斷
let status = 'not_built';  // 預設：未建置
let needsRebuild = false;

if (fs.existsSync(indexPath)) {
  status = 'built';  // index.html 存在 → 已建置

  // 檢查是否需要重建
  if (fs.existsSync(slidesPath)) {
    const indexTime = fs.statSync(indexPath).mtime;
    const slidesTime = fs.statSync(slidesPath).mtime;

    if (slidesTime > indexTime) {
      needsRebuild = true;  // slides.md 比 index.html 新 → 需要重建
    }
  }
}
```

---

## UI 設計

### 設計原則

採用 **Vercel/Geist** 風格的深色主題：

1. **極簡主義** - 減少視覺干擾，聚焦內容
2. **設計 Tokens** - CSS 自訂屬性確保一致性
3. **微妙互動** - 細緻的 hover/active 效果
4. **專業感** - SVG 圖標取代 emoji

### 色彩系統

```css
:root {
  /* 背景層級 */
  --bg-primary: #0a0a0a;    /* 最深 - 頁面背景 */
  --bg-secondary: #111111;  /* 中等 - 卡片背景 */
  --bg-tertiary: #171717;   /* 較淺 - 內嵌元素 */

  /* 邊框 */
  --border-default: #2e2e2e;
  --border-hover: #3e3e3e;

  /* 文字 */
  --text-primary: #ededed;   /* 主要文字 */
  --text-secondary: #a1a1a1; /* 次要文字 */
  --text-tertiary: #737373;  /* 輔助文字 */

  /* 強調色 */
  --accent-primary: #f97316; /* 橙色 - 主要操作 */
  --accent-success: #22c55e; /* 綠色 - 成功狀態 */
  --accent-warning: #eab308; /* 黃色 - 警告狀態 */
  --accent-error: #ef4444;   /* 紅色 - 錯誤狀態 */
}
```

### 狀態徽章

| 狀態 | 顏色 | 說明 |
|------|------|------|
| ✅ 已建置 | 綠色 | index.html 存在且為最新 |
| ⚠️ 需更新 | 黃色 | slides.md 比 index.html 新 |
| ❌ 未建置 | 紅色 | index.html 不存在 |
| 🔄 建置中 | 橙色 | 正在執行 slidev build |

### 響應式設計

```css
@media (max-width: 640px) {
  .grid {
    grid-template-columns: 1fr;  /* 手機：單欄 */
  }

  .admin-header {
    flex-direction: column;  /* 按鈕換行 */
  }

  .admin-buttons .btn {
    flex: 1;  /* 按鈕平分寬度 */
  }
}
```

---

## 檔案清單

### 新增檔案

| 檔案 | 說明 |
|------|------|
| `server.js` | Express API 伺服器 |
| `docs/plans/2026-01-16-deploy-button-design.md` | 設計文件 |
| `docs/DEVELOPMENT_LOG.md` | 本文件 |

### 修改檔案

| 檔案 | 變更內容 |
|------|----------|
| `index.html` | 新增管理面板 UI、Vercel 風格 CSS |
| `package.json` | 新增 `express` 依賴、`dev` script |

### 檔案結構

```
slidev-presentation/
├── server.js                 # API 伺服器
├── index.html                # 首頁 + 管理面板
├── package.json              # 專案配置
├── courses.json              # 課程清單
├── docs/
│   ├── plans/
│   │   └── 2026-01-16-deploy-button-design.md
│   └── DEVELOPMENT_LOG.md    # 本文件
├── scripts/
│   └── build-version.sh      # 建置腳本
├── marketing-course/         # 行銷課
├── sr-course/                # 永續報告書課程
└── programming-course/       # 程式設計課
```

---

## 使用方式

### 啟動服務

```bash
# 安裝依賴（首次）
npm install

# 啟動開發伺服器
npm run dev

# 服務運行於 http://localhost:3002
```

### 部署流程

1. 開啟 `http://localhost:3002`
2. 瀏覽課程卡片
3. 在「管理面板」查看建置狀態
4. 點擊「部署全部」按鈕
5. 觀看即時建置進度
6. 等待 Git push 完成

### 手動操作

```bash
# 單獨建置某個版本
./scripts/build-version.sh marketing-course intro v1

# 查看建置狀態
curl http://localhost:3002/api/status | jq

# 觸發部署（命令列）
curl -X POST http://localhost:3002/api/deploy
```

---

## 未來改進

### 短期（v1.1）

- [ ] 取消部署按鈕
- [ ] 選擇性部署（只部署勾選的版本）
- [ ] 部署歷史記錄

### 中期（v1.2）

- [ ] 預覽功能（在部署前預覽簡報）
- [ ] 差異比較（顯示 slides.md 的變更）
- [ ] 通知系統（部署完成後通知）

### 長期（v2.0）

- [ ] 多人協作（權限管理）
- [ ] CI/CD 整合（GitHub Actions 觸發）
- [ ] 版本回滾功能

---

## 開發心得

### 技術選擇

選擇 Server-Sent Events 而非 WebSocket 是正確的決定：
- 部署是單向的（伺服器 → 客戶端）
- 不需要雙向通訊
- 實作更簡單，瀏覽器原生支援

### UI 設計

從「功能先行」到「Vercel 風格優化」的過程：
1. 先做出能用的 MVP
2. 用戶反饋「希望更專業」
3. 參考 Vercel/Geist 設計系統
4. 使用 CSS 自訂屬性建立設計 tokens

### Linus 式思考

> "好程式碼沒有特殊情況"

狀態判斷邏輯的簡化：
- 不用複雜的狀態機
- 只檢查檔案是否存在、修改時間
- 簡單的 if/else 足矣

---

*文件版本：1.0.0*
*最後更新：2026-01-16*
