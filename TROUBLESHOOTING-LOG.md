# Slidev + Zeabur 部署排錯記錄

**日期:** 2026-01-06
**專案:** 行銷課簡報多版本部署系統

---

## 核心問題：工作路徑變更

當資料夾 B 移入資料夾 A 時，會影響：
1. **Git 的路徑追蹤** - Git 視為「刪除舊 B」並「新增 A/B」
2. **Zeabur 的構建路徑** - Root Directory 設定需要更新
3. **程式碼相對路徑** - 所有 `../B` 需改為 `./B`

---

## 問題總覽

| # | 問題 | 根因 | 解決方案 |
|---|------|------|----------|
| 1 | Slidev build 失敗 | slide 27 的 `---` 被當作 slide delimiter | 改用 `<div>` 替代 |
| 2 | Zeabur 部署錯誤 repo | 連接的是 slidev-marketing-course 不是 Claudsidian | 直接推送到正確 repo |
| 3 | Root Directory 不存在 | Zeabur 設定指向舊路徑 | 改為 `.` 根目錄 |
| 4 | Git 分支混亂 | main/master 兩個分支並存 | 刪除 main，保留 master |
| 5 | 簡報頁面空白 | build 時 base path 錯誤 | 使用 `--base /v2/` 重新 build |

---

## 詳細排錯過程

### 問題 1: Slidev Build 失敗

**症狀:**
```
Error: Element is missing end tag (slide 27)
```

**分析:**
- Slidev 使用 `---` 作為 slide 分隔符
- slide 27 內容中使用 `---` 作為視覺分隔線
- Markdown parser 誤認為是新 slide 開始，導致 HTML 標籤不匹配

**解決:**
```markdown
# 錯誤寫法
<div>
內容
---
更多內容
</div>

# 正確寫法
<div>
內容
<div class="my-4 border-t border-gray-300"></div>
更多內容
</div>
```

**教訓:** Slidev 中避免在 slide 內容使用 `---`，改用 HTML/CSS 實現分隔線

---

### 問題 2: Zeabur 部署錯誤 Repository

**症狀:**
- Zeabur 顯示舊的檔案結構（package.json, slides.md）
- 推送到 Claudsidian 但 Zeabur 沒有更新

**分析:**
```bash
git remote -v
# origin → Claudsidian (錯誤)
# zeabur → slidev-marketing-course (正確)
```

**決策過程:**
1. 選項 A: 改變 Zeabur 連接的 repo → 需要重新設定
2. 選項 B: 推送到 slidev-marketing-course → 直接有效 ✓

**解決:**
```bash
cd /tmp/slidev-deploy
cp -r 行銷課/* .
git init
git remote add origin https://github.com/fred1357944/slidev-marketing-course.git
git add .
git commit -m "靜態版本選擇器"
git push -f origin main:master
```

**教訓:** 部署前先確認 CI/CD 連接的是哪個 repo

---

### 問題 3: Root Directory 不存在

**症狀:**
```
⚠️ The specified Root Directory does not exist
Your current Root Directory setting is: 01_Projects/slidev-presentation/行銷課
```

**分析:**
- Zeabur 設定指向 Claudsidian repo 的路徑
- 但實際內容在 slidev-marketing-course repo 的根目錄

**解決:**
- Zeabur Settings → Root Directory → 改為 `.` 或留空

**教訓:** 換 repo 後記得更新 Root Directory 設定

---

### 問題 4: Git 分支混亂

**症狀:**
- GitHub 顯示 2 個分支：main, master
- 預設顯示 master（舊內容）
- 新推送在 main（新內容）

**分析:**
```bash
# 第一次推送
git push -f origin main  # 建立 main 分支

# 後來推送
git push -f origin main:master  # 更新 master
```

**解決:**
```bash
# 刪除 main 分支，只保留 master
gh api repos/fred1357944/slidev-marketing-course/git/refs/heads/main -X DELETE
```

**教訓:**
- 統一使用一個分支名稱
- 推送前確認目標分支
- `git push origin local:remote` 語法可以指定遠端分支名

---

### 問題 5: 簡報頁面空白

**症狀:**
- 版本選擇器正常顯示
- 點擊「查看簡報」後頁面空白
- 瀏覽器 Console 顯示 404 錯誤

**分析:**
```html
<!-- v2/index.html 中的引用 -->
<script src="/assets/index-xxx.js"></script>

<!-- 實際檔案位置 -->
/v2/assets/index-xxx.js
```

Slidev build 預設使用絕對路徑 `/assets/`，但檔案在 `/v2/assets/`

**解決:**
```bash
# 重新 build，指定 base path
npx slidev build --base /v2/ --out dist-v2

# 結果：assets 路徑變成 /v2/assets/
```

**教訓:** 子目錄部署時，build 必須設定 `--base` 參數

---

## 最終正確流程

```bash
# 1. Build with correct base path
cd slidev-presentation
npx slidev build --base /v1/ --out dist-v1
npx slidev build --base /v2/ --out dist-v2

# 2. Prepare deployment folder
mkdir -p deploy
cp index.html versions.json zeabur.json deploy/
cp -r dist-v1 deploy/v1
cp -r dist-v2 deploy/v2

# 3. Push to correct repo
cd deploy
git init
git remote add origin https://github.com/xxx/slidev-marketing-course.git
git add .
git commit -m "Deploy"
git push -f origin main:master

# 4. Zeabur settings
# - Root Directory: . (empty)
# - Build Type: Static
```

---

## 檢查清單

部署 Slidev 到 Zeabur 前的檢查：

- [ ] slides.md 內容中沒有使用 `---` 作為分隔線
- [ ] 確認 Zeabur 連接的 GitHub repo
- [ ] 確認 Zeabur Root Directory 設定
- [ ] Build 時設定正確的 `--base` 路徑
- [ ] Git 推送到正確的分支
- [ ] zeabur.json 設定 build_type: static

---

---

## 最終解決方案（2026-01-06）

**v2 顯示 v1 內容的根本原因：**
- 源碼 slides.md 放錯位置（放在根目錄而非 v2 資料夾）
- Build 時使用了錯誤的 slides.md

**正確的版本管理結構：**
```
slidev-presentation/
├── 行銷課/
│   ├── v1/
│   │   └── slides.md    ← v1 源碼
│   ├── v2/
│   │   └── slides.md    ← v2 源碼（最新版）
│   ├── index.html       ← 版本選擇器
│   └── versions.json
└── package.json
```

**正確的 Build 流程：**
```bash
# 進入 v2 資料夾
cd 行銷課/v2

# 使用正確的 base path build
npx slidev build --base /v2/ --out dist

# 結果：dist/index.html 中的路徑會是 /v2/assets/...
```

---

## 相關指令速查

```bash
# 檢查遠端 repo
git remote -v

# 推送到不同分支名
git push origin local-branch:remote-branch

# 刪除遠端分支
git push origin --delete branch-name
# 或
gh api repos/owner/repo/git/refs/heads/branch -X DELETE

# 列出所有遠端分支
gh api repos/owner/repo/branches --jq '.[].name'

# Slidev build with base path
npx slidev build --base /subdir/ --out dist
```

---

## 多專案系統部署（2026-01-07）

### 新增功能

成功部署多專案管理系統，支援：
- 專案選擇器首頁
- 每個專案獨立版本選擇
- 範本系統方便複製新增

### 部署的專案

| 專案 | 路徑 | 版本 | 狀態 |
|------|------|------|------|
| 行銷課 | `/marketing/` → `/v1/`, `/v2/` | v1, v2 | ✅ 正常 |
| 技術分享 | `/tech-sharing/v1/` | v1 | ✅ 正常 |
| 產品發表 | `/product-launch/v1/` | v1 | ✅ 正常 |

### 關鍵配置文件

**projects.json** - 專案清單
```json
{
  "title": "簡報管理系統",
  "subtitle": "Fred Lai 的簡報專案庫",
  "projects": [
    {"id": "marketing", "name": "行銷課", "folder": "marketing", ...},
    {"id": "tech-sharing", "name": "技術分享", "folder": "tech-sharing", ...},
    {"id": "product-launch", "name": "產品發表", "folder": "product-launch", ...}
  ]
}
```

**versions.json** - 各專案版本配置
```json
{
  "project": {"name": "專案名稱", "icon": "📊"},
  "versions": [
    {"id": "v1", "folder": "v1", "status": "stable", ...}
  ],
  "current": "v1"
}
```

### Build 指令

```bash
# tech-sharing
cd tech-sharing/v1
npx slidev build --base /tech-sharing/v1/ --out dist
mv dist/* .

# product-launch
cd product-launch/v1
npx slidev build --base /product-launch/v1/ --out dist
mv dist/* .
```

### 注意事項

1. **行銷課特殊結構**：v1/v2 在根目錄，marketing/ 只有版本選擇器
2. **Build 後移動檔案**：dist 內容需移到 v1/ 根目錄
3. **Base path 格式**：必須包含開頭和結尾的斜線 `/tech-sharing/v1/`

---

## GitHub Repository

- **Repo**: `fred1357944/slidev-marketing-course`
- **Branch**: `master` (Zeabur 部署分支)
- **部署平台**: Zeabur (Static Site)
