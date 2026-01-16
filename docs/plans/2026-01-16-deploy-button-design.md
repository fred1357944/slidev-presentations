# 一鍵部署按鈕設計文件

**日期**：2026-01-16
**狀態**：已確認，待實作

---

## 目標

在首頁新增管理面板，提供一鍵部署功能，取代手動執行腳本。

## 功能範圍

1. 掃描所有課程和版本
2. 建置每個簡報（跳過未修改的）
3. Git commit + push
4. 即時顯示進度

## 技術架構

### 檔案結構
```
slidev-presentation/
├── index.html          # 首頁 (加入部署按鈕)
├── server.js           # 本地 API 服務
├── package.json        # 加入 dev script
└── scripts/
    ├── build-version.sh
    └── build-all.js    # Node 版建置邏輯
```

### API 設計
- `POST /api/deploy` - 觸發部署，回傳 SSE 串流進度
- `GET /api/status` - 回傳所有課程建置狀態

### 技術選擇
- 後端：Express.js
- 即時更新：Server-Sent Events (SSE)
- 建置執行：child_process 呼叫 shell 腳本

## UI 設計

### 管理面板
- 顯示所有課程/版本的建置狀態
- 「部署全部」按鈕
- 「重新整理」按鈕

### 部署進度
- 進度條
- 每個版本的即時狀態（✅ 完成 / 🔄 建置中 / ⏳ 等待）
- 取消按鈕

### 完成提示
- 顯示成功/失敗
- GitHub repo 連結

## 啟動方式
```bash
npm run dev    # 同時啟動預覽伺服器 + 部署 API
```
