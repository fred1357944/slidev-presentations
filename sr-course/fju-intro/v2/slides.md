---
theme: default
title: 輔仁大學永續報告書製作系統介紹
info: |
  ## 輔仁大學永續報告書製作系統介紹
  給永續發展暨校務研究中心同事的技術分享
transition: slide-left
mdc: true
---

# 輔仁大學永續報告書製作系統介紹

<div class="opacity-80">
給永續發展暨校務研究中心同事的技術分享
</div>

<div class="abs-br m-6 flex gap-2">
  <span class="text-sm opacity-50">2026-01-13</span>
  <span class="text-sm bg-gray-100 text-gray-800 px-2 rounded">v4.0.0</span>
</div>

---
layout: statement
---

# 一個關於「複製貼上」的惡夢...

<div class="text-left text-lg opacity-80 mt-8 max-w-3xl mx-auto leading-relaxed">
  <v-click>
  想像一下，現在是 12 月底的最後一個工作週。
  </v-click>
  <v-click>
  你的信箱裡躺著 <b>58 封</b> 來自不同處室的郵件，每封都夾帶著一份格式完全不同的 PPT。
  </v-click>
  <v-click>
  "這張圖太糊了"、"那個單位的數據單位是錯的"、"為什麼這一頁用了 Comic Sans 字體？"
  </v-click>
  <br>
  <v-click>
  而你的任務，是在一週內將它們變成一份<b>國際標準的永續報告書</b>。
  這就是我們過去每一年面臨的真實挑戰。
  </v-click>
</div>

---
layout: section
---

# Part 1: 問題與挑戰
## (Problems & Challenges)

---
layout: two-cols
---

## 原本的痛點：資料散落與格式混亂

<v-clicks>

- 📚 **來源繁雜**
  - 每年需處理約 **58 份** 期末管考 PPT
  - 來自 17 個不同學院與行政單位
- 🔄 **人工彙整耗時**
  - 格式不統一（字體、版面、圖表風格迥異）
  - 數據散落在投影片角落，難以提取
  - 缺乏統一敘事邏輯，需大量人工潤飾
- 📉 **難以追蹤**
  - 數據來源不可考
  - 修改歷程無法回溯
  - 漂綠風險（Greenwashing）難以控管

</v-clicks>

::right::

<div class="flex h-full items-center justify-center p-8">
  <div class="bg-red-50 p-6 rounded-xl border-l-4 border-red-500 shadow-lg transform rotate-2 hover:rotate-0 transition duration-300">
    <div class="text-4xl mb-4">😫</div>
    <div class="text-xl font-bold text-red-800">58 份 PPT</div>
    <div class="text-lg text-red-600">x 30 頁/份</div>
    <div class="h-1 w-full bg-red-200 my-2"></div>
    <div class="text-2xl font-black text-red-900">= 1,740 頁</div>
    <div class="text-sm opacity-75 mt-2">人工審閱地獄</div>
  </div>
</div>

---
layout: section
---

# Part 2: 解決方案架構
## (Solution Architecture)

---

## 自動化管線：從 PPT 到 Markdown

將非結構化的 PPT 轉換為標準化的永續報告書草稿

<div class="my-8">

```mermaid
graph LR
    A[📂 原始 PPTs] -->|解析| B(📄 JSON 中介格式)
    B -->|AI 處理| C{🤖 LLM Pipeline}
    C -->|生成| D[📝 Markdown 草稿]
    D -->|編輯 & 審核| E[📊 永續報告書]

    style C fill:#e1f5fe,stroke:#01579b,stroke-width:2px
    style E fill:#e8f5e9,stroke:#2e7d32,stroke-width:2px
```

</div>

<div class="grid grid-cols-2 gap-4">
  <v-click>
    <div class="bg-blue-50/10 p-4 rounded border border-blue-500/20">
      <div class="text-xl font-bold mb-2 text-blue-400">🎯 目標</div>
      <div>支援 17 個學院/單位的批次處理，大幅縮短彙整時間</div>
    </div>
  </v-click>
  <v-click>
    <div class="bg-green-50/10 p-4 rounded border border-green-500/20">
      <div class="text-xl font-bold mb-2 text-green-400">⚡ 效益</div>
      <div>統一格式、自動提取數據、標準化語氣</div>
    </div>
  </v-click>
</div>

---

## 四階段處理流程 (Pipeline Stages)

我們採用了先進的 Agentic Workflow 設計：

<div class="grid grid-cols-2 gap-4 mt-4">

<v-click>
<div class="card bg-white/5 p-4 rounded hover:bg-white/10 transition border-l-4 border-blue-400">
  <div class="text-lg font-bold text-blue-400">1. Intent Decomposition</div>
  <div class="text-sm opacity-80">意圖分解</div>
  <div class="text-xs mt-2 opacity-60">將複雜的報告需求拆解為獨立的撰寫任務</div>
</div>
</v-click>

<v-click>
<div class="card bg-white/5 p-4 rounded hover:bg-white/10 transition border-l-4 border-green-400">
  <div class="text-lg font-bold text-green-400">2. Tool Retrieval</div>
  <div class="text-sm opacity-80">工具檢索</div>
  <div class="text-xs mt-2 opacity-60">根據任務需求，自動選取適合的數據提取工具</div>
</div>
</v-click>

<v-click>
<div class="card bg-white/5 p-4 rounded hover:bg-white/10 transition border-l-4 border-yellow-400">
  <div class="text-lg font-bold text-yellow-400">3. Prompt Generation</div>
  <div class="text-sm opacity-80">提示詞生成</div>
  <div class="text-xs mt-2 opacity-60">動態組裝上下文，生成高品質的 LLM 指令</div>
</div>
</v-click>

<v-click>
<div class="card bg-white/5 p-4 rounded hover:bg-white/10 transition border-l-4 border-red-400">
  <div class="text-lg font-bold text-red-400">4. Config Assembly</div>
  <div class="text-sm opacity-80">配置組裝</div>
  <div class="text-xs mt-2 opacity-60">整合所有參數，驅動生成最終內容</div>
</div>
</v-click>

</div>

---
layout: section
---

# Part 3: 雲端編輯器
## (Cloud Editor)

---
layout: two-cols
---

## Flask Editor 架構與功能亮點

專為永續報告書設計的協作平台

### 🚀 核心功能

<v-clicks>

- **即時 Markdown 編輯**
  - 所見即所得，支援實時預覽
- **智慧驗證系統**
  - 自動比對原始數據
  - 漂綠關鍵字檢測 (Greenwashing Detection)
- **評分機制**
  - 數據準確性 (Accuracy)
  - 可追溯性 (Traceability)
  - 語調客觀性 (Objectivity)

</v-clicks>

::right::

### 📝 追蹤修訂 (Track Changes)

<div class="mt-4 bg-gray-900 p-4 rounded-lg text-sm font-mono">
  <div class="text-gray-400">// 類似 Word 的審閱模式</div>
  <br>
  <div class="flex items-center gap-2 mb-2">
    <span class="text-green-500">✅ 採納 (Accept)</span>
    <span class="text-xs opacity-60">確認 AI 修改正確</span>
  </div>
  <div class="flex items-center gap-2 mb-2">
    <span class="text-red-500">❌ 拒絕 (Reject)</span>
    <span class="text-xs opacity-60">保留原始版本</span>
  </div>

  <div class="mt-4 pt-4 border-t border-gray-700">
    <span class="text-blue-300">Diff View</span> 確保改動透明化
  </div>
</div>

---

## 編輯器介面展示 (Demo)

<div class="border border-gray-500/50 rounded-lg p-4 h-80 flex items-center justify-center bg-gray-900/50">
  <div class="text-center">
    <div class="text-6xl mb-4">🖥️</div>
    <div class="text-xl font-bold">Live Editor Interface</div>
    <div class="text-sm opacity-60">左側編輯 Markdown / 右側即時預覽與評分面板</div>
    <div class="text-xs opacity-40 mt-4">【截圖待補充】</div>
  </div>
</div>

---
layout: section
---

# Part 4: 驗證與評分系統
## (Validation & Scoring)

---

## 三大評分維度

系統會針對每一段落進行自動評分，確保報告品質

<div class="overflow-x-auto mt-6">
<table class="w-full border-collapse">
  <thead>
    <tr class="bg-gray-100/10 text-left">
      <th class="p-3 border-b border-gray-600">維度</th>
      <th class="p-3 border-b border-gray-600">英文指標</th>
      <th class="p-3 border-b border-gray-600">說明</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td class="p-3 border-b border-gray-700 font-bold text-blue-300">數據準確性</td>
      <td class="p-3 border-b border-gray-700 font-mono text-sm">Data Accuracy</td>
      <td class="p-3 border-b border-gray-700">數字是否與原始 PPT 一致？單位是否正確？</td>
    </tr>
    <tr>
      <td class="p-3 border-b border-gray-700 font-bold text-green-300">事實可追溯性</td>
      <td class="p-3 border-b border-gray-700 font-mono text-sm">Fact Traceability</td>
      <td class="p-3 border-b border-gray-700">每個聲明是否有明確的來源佐證？</td>
    </tr>
    <tr>
      <td class="p-3 border-b border-gray-700 font-bold text-yellow-300">語調客觀性</td>
      <td class="p-3 border-b border-gray-700 font-mono text-sm">Tone Objectivity</td>
      <td class="p-3 border-b border-gray-700">是否使用了誇大、行銷式的用語？</td>
    </tr>
  </tbody>
</table>
</div>

<v-click>
<div class="mt-6 bg-yellow-500/10 p-4 border-l-4 border-yellow-500 rounded flex items-start gap-3">
  <div class="text-2xl">⚠️</div>
  <div>
    <span class="font-bold block">自動偵測問題類型：</span>
    <span class="text-sm opacity-90">數字錯誤、實體缺失（漏掉重要單位）、誇大用語（如「完美」、「世界第一」）、邏輯矛盾</span>
  </div>
</div>
</v-click>

---
layout: center
class: text-center
---

# 🧠 練習時間 (Interactive Session)

<div class="mb-8">請找出下列句子中的「潛在問題」：</div>

<div class="bg-white/10 p-6 rounded-xl text-xl font-serif italic mb-8 mx-auto max-w-2xl">
  "本學院今年度推動了<b>無數場</b>環保講座，參與人數<b>爆滿</b>，<br>
  成效達到<b>世界級水準</b>，完全落實永續精神。"
</div>

<v-click>
  <div class="grid grid-cols-3 gap-4 text-left max-w-3xl mx-auto">
    <div class="bg-red-500/20 p-3 rounded border border-red-500/50">
      <div class="font-bold text-red-300">❌ "無數場"</div>
      <div class="text-xs">數據模糊，缺乏具體量化指標</div>
    </div>
    <div class="bg-red-500/20 p-3 rounded border border-red-500/50">
      <div class="font-bold text-red-300">❌ "爆滿"</div>
      <div class="text-xs">主觀形容詞，應提供具體人數</div>
    </div>
    <div class="bg-red-500/20 p-3 rounded border border-red-500/50">
      <div class="font-bold text-red-300">❌ "世界級水準"</div>
      <div class="text-xs">誇大行銷用語 (Marketing Fluff)</div>
    </div>
  </div>
</v-click>

---
layout: section
---

# Part 5: v4.0 未來規劃
## (Roadmap)

---
layout: two-cols
---

## 架構升級：打造數位孿生體驗

### 🖥️ Sidebar 雙分頁設計
左側導航欄將進化為雙模式：

<v-clicks>

1. **分析模式 (Analysis Mode)**
   - 查看各學院的數據統計
   - 進度概覽 Dashboard
2. **編輯模式 (Edit Mode)**
   - 專注於文本修訂
   - 傳統的 Markdown 編輯體驗

</v-clicks>

::right::

### 🔄 數位孿生 (Digital Twin)

<div class="flex flex-col gap-4 mt-4">
  <v-click>
  <div class="bg-gradient-to-r from-purple-900/40 to-blue-900/40 p-4 rounded-lg border border-purple-500/30">
    <div class="font-bold mb-1">⚡ 即時反饋</div>
    <div class="text-sm opacity-80">邊改邊看分數變化，寫作就像玩遊戲</div>
  </div>
  </v-click>

  <v-click>
  <div class="bg-gradient-to-r from-purple-900/40 to-blue-900/40 p-4 rounded-lg border border-purple-500/30">
    <div class="font-bold mb-1">📊 動態模擬</div>
    <div class="text-sm opacity-80">修改某個數據後，自動計算對整體永續指標(SDGs)的影響</div>
  </div>
  </v-click>
</div>

---

## 多院版本比對 (Side-by-side Diff View)

針對 17 個單位的大量資料，提供高效率的比對工具：

<div class="my-6">

```mermaid
graph TD
    A[原始 PPT 內容]
    B[AI 初步修訂版]
    C[人工核可版]

    A -.->|Diff 1| B
    B -.->|Diff 2| C

    style A fill:#333,stroke:#fff
    style B fill:#444,stroke:#aaf
    style C fill:#252,stroke:#afa
```

</div>

<v-clicks>

- **三欄對照**：原始資料 vs AI 生成 vs 最終定稿
- **版本控制**：完整記錄每一次決策過程 (Git-like History)
- **批次審閱**：一鍵套用相同類型的修改建議

</v-clicks>

---

## InDesign 出版串接 (IDML Integration)

打通從「編輯」到「出版」的最後一哩路

<div class="grid grid-cols-2 gap-8 mt-6">

<div>
  <h3 class="text-xl font-bold mb-4 text-pink-400">功能亮點</h3>
  <ul class="list-disc pl-5 space-y-2">
    <v-click><li><b>IDML 匯出</b>：支援 Adobe InDesign 交換格式</li></v-click>
    <v-click><li><b>樣式對照表</b> (Style Mapping)：
      <ul class="list-circle pl-5 mt-1 text-sm opacity-70">
        <li>Markdown H1 → InDesign "章節標題"</li>
        <li>Markdown Quote → InDesign "重點引言"</li>
      </ul>
    </li></v-click>
  </ul>
</div>

<div>
  <h3 class="text-xl font-bold mb-4 text-pink-400">開發時程</h3>
  <div class="space-y-3">
    <v-click>
    <div class="flex items-center gap-3 opacity-50">
      <div class="bg-gray-600 text-white w-6 h-6 rounded-full flex items-center justify-center text-xs">1</div>
      <span>Phase 1 融合與復活</span>
    </div>
    </v-click>
    <v-click>
    <div class="flex items-center gap-3">
      <div class="bg-blue-600 text-white w-6 h-6 rounded-full flex items-center justify-center text-xs">2</div>
      <span>Phase 2 多院版本比對 <span class="text-xs bg-blue-500/20 text-blue-300 px-1 rounded ml-2">Doing</span></span>
    </div>
    </v-click>
    <v-click>
    <div class="flex items-center gap-3">
      <div class="bg-gray-600 text-white w-6 h-6 rounded-full flex items-center justify-center text-xs">3</div>
      <span>Phase 3 出版串接</span>
    </div>
    </v-click>
  </div>
</div>

</div>

---
layout: statement
---

# Part 6: 總結
## (Summary)

---

## 下一步行動

<div class="text-xl leading-relaxed">

從 <span class="text-red-400 line-through decoration-2">手工彙整</span> 到 <span class="text-green-400 font-bold">AI 輔助自動化</span>
<br>
我們不只是在寫報告，而是在建立**永續資料的數位資產**

</div>

<div class="mt-12 grid grid-cols-3 gap-4 text-center">
  <v-click>
  <div class="bg-white/5 p-6 rounded-xl hover:bg-white/10 transition">
    <div class="text-5xl mb-4">🤖</div>
    <div class="font-bold text-xl mb-2">自動化</div>
    <div class="text-sm opacity-60">減少 80% 重複勞動</div>
  </div>
  </v-click>

  <v-click>
  <div class="bg-white/5 p-6 rounded-xl hover:bg-white/10 transition">
    <div class="text-5xl mb-4">⚖️</div>
    <div class="font-bold text-xl mb-2">標準化</div>
    <div class="text-sm opacity-60">統一語調與格式</div>
  </div>
  </v-click>

  <v-click>
  <div class="bg-white/5 p-6 rounded-xl hover:bg-white/10 transition">
    <div class="text-5xl mb-4">🚀</div>
    <div class="font-bold text-xl mb-2">智慧化</div>
    <div class="text-sm opacity-60">數據驅動決策</div>
  </div>
  </v-click>
</div>

---

# 簡報索引 (Q&A 快速導航)

<div class="grid grid-cols-2 gap-4 mt-4 text-sm">

<div>

### Part 1 問題與挑戰
- [#3 開場故事](/3)
- [#5 痛點分析](/5)

### Part 2 解決方案架構
- [#7 自動化管線](/7)
- [#8 四階段流程](/8)

### Part 3 雲端編輯器
- [#10 Flask Editor](/10)
- [#11 編輯器展示](/11)

</div>

<div>

### Part 4 驗證與評分
- [#13 三大評分維度](/13)
- [#14 練習時間](/14)

### Part 5 未來規劃
- [#16 數位孿生](/16)
- [#17 版本比對](/17)
- [#18 IDML 串接](/18)

### Part 6 總結
- [#20 下一步行動](/20)

</div>

</div>

<div class="mt-4 text-center text-xs opacity-60">
  按 G 鍵可輸入頁碼快速跳轉 ｜ 按 O 鍵開啟總覽模式
</div>

---
layout: center
class: text-center
---

# 謝謝聆聽
## Q & A

<div class="mt-8 grid grid-cols-2 gap-4 text-left max-w-2xl mx-auto">
  <div class="p-4 border border-gray-700 rounded hover:bg-gray-800 transition cursor-pointer">
    <span class="text-blue-400 font-bold">Q1:</span> 系統如何處理舊版 PPT?
  </div>
  <div class="p-4 border border-gray-700 rounded hover:bg-gray-800 transition cursor-pointer">
     <span class="text-green-400 font-bold">Q2:</span> AI 驗證的準確率如何?
  </div>
  <div class="p-4 border border-gray-700 rounded hover:bg-gray-800 transition cursor-pointer">
     <span class="text-yellow-400 font-bold">Q3:</span> 是否支援其他部門擴充?
  </div>
  <div class="p-4 border border-gray-700 rounded hover:bg-gray-800 transition cursor-pointer">
     <span class="text-purple-400 font-bold">Q4:</span> 導入系統的技術門檻?
  </div>
</div>
