# Slidev 多課程簡報系統 - 專業操作流程

## 系統架構概覽

```
slidev-presentations/
├── index.html              # 課程選擇器首頁
├── courses.json            # 課程清單設定
├── package.json            # Node.js 套件設定
├── .gitignore              # Git 忽略設定
├── zbpack.json             # Zeabur 部署設定
│
├── marketing-course/       # 課程資料夾
│   ├── index.html          # 專案選擇器
│   ├── projects.json       # 專案清單
│   └── intro/              # 專案資料夾
│       ├── versions.json   # 版本清單
│       └── v1/             # 版本資料夾 (Slidev build 輸出)
│           ├── index.html
│           └── assets/
│
└── sr-course/              # 另一個課程...
```

---

## 快速開始（在新電腦上）

### 1. 複製專案

```bash
git clone https://github.com/fred1357944/slidev-presentations.git
cd slidev-presentations
npm install
```

### 2. 本地預覽

```bash
# 預覽課程選擇器（靜態網站）
npx serve . -l 3030
# 瀏覽器開啟 http://localhost:3030

# 或開發單一簡報
cd marketing-course/intro
npx slidev slides.md --port 3030
```

---

## 新增簡報流程

### 步驟 1：建立簡報原始檔

```bash
# 進入專案目錄
cd marketing-course/intro

# 建立或編輯 slides.md
code slides.md
```

### 步驟 2：本地開發與預覽

```bash
npx slidev slides.md --port 3030
# 即時編輯，瀏覽器自動更新
```

### 步驟 3：建置靜態檔案

```bash
# 建置到指定版本資料夾
npx slidev build --base /marketing-course/intro/v2/ --out ./v2
```

### 步驟 4：更新版本設定

編輯 `versions.json`：

```json
{
	"versions": [
		{ "version": "v2", "name": "第二版", "date": "2026-01-13" },
		{ "version": "v1", "name": "第一版", "date": "2026-01-01" }
	]
}
```

---

## 推送到 GitHub

### 標準流程

```bash
# 1. 檢查狀態
git status

# 2. 加入所有變更
git add .

# 3. 提交（使用有意義的訊息）
git commit -m "feat: 新增行銷課程 v2 簡報"

# 4. 推送
git push origin main
```

### 首次設定（新電腦）

```bash
# 設定 Git 使用者資訊
git config --global user.name "your-name"
git config --global user.email "your-email@example.com"

# 設定 GitHub 認證（推薦使用 SSH 或 Personal Access Token）
```

---

## Zeabur 自動部署

> **NOTE:** 專案已設定 Zeabur 與 GitHub 整合，推送到 `main` 分支後會自動部署。

### 部署設定檔 (`zbpack.json`)

```json
{
	"static": true
}
```

### 驗證部署

1. 推送後等待 1-2 分鐘
2. 前往 Zeabur Dashboard 確認部署狀態
3. 訪問您的 Zeabur 網址確認更新

---

## .gitignore 設定

```gitignore
# Node.js
node_modules/

# Slidev 暫存
.slidev/
dist/

# 系統檔案
.DS_Store
*.local

# 大型檔案（避免 GitHub 上傳限制）
*.pptx
*.zip
*.mov
*.mp4

# 排除的資料夾
永續報告書製作/
```

---

## 常見問題

### Q: 推送失敗，顯示檔案過大？

**A:** 檢查是否有大型檔案（>50MB）未被 `.gitignore` 排除。

### Q: Zeabur 未自動部署？

**A:** 確認推送的是 `main` 分支，並檢查 Zeabur Dashboard 的部署日誌。

### Q: 本地預覽只看到投影片，沒有課程選擇器？

**A:** 使用 `npx serve . -l 3030` 而非 `npm run dev`。

---

## 未來擴展方向

> **TIP:** 這些功能可在新的 GitHub Repo 中實現

- **多人協作**：使用 Git 分支管理不同講者的簡報
- **權限控制**：整合 Auth0 或 Firebase Authentication
- **簡報管理後台**：React/Vue 管理介面 + API 後端
- **版本比較**：自動 diff 不同版本的投影片內容
