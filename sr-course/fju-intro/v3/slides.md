---
theme: default
background: https://images.unsplash.com/photo-1451187580459-43490279c0fa?q=80&w=2072&auto=format&fit=crop
class: text-center
highlighter: shiki
lineNumbers: false
info: |
  ## 輔仁大學永續報告書製作系統介紹
  給永續發展暨校務研究中心同事的技術分享
transition: slide-left
mdc: true
---

# 輔仁大學永續報告書製作系統介紹

<div class="opacity-80 text-xl mt-4 font-light tracking-wide text-white/90">
給永續發展暨校務研究中心同事的技術分享
</div>

<div class="pt-12">
  <span @click="$slidev.nav.next" class="px-4 py-2 rounded border border-white/20 hover:bg-white/10 cursor-pointer transition">
    開始探索 <carbon:arrow-right class="inline ml-1"/>
  </span>
</div>

<div class="abs-br m-6 flex gap-2">
  <span class="text-sm opacity-50 text-white">2026-01-13</span>
  <span class="text-sm bg-blue-500/20 text-blue-300 border border-blue-500/30 px-2 rounded">v4.0.0</span>
</div>

---
layout: statement
---

# 💬 一個關於「複製貼上」的惡夢...

<div class="text-left text-lg opacity-80 mt-8 max-w-3xl mx-auto leading-relaxed">
  <v-click>
  <div class="flex items-start gap-4 mb-6">
    <div class="text-3xl text-blue-400 mt-1 flex-shrink-0">📅</div>
    <span>想像一下，現在是 12 月底的最後一個工作週。</span>
  </div>
  </v-click>

  <v-click>
  <div class="flex items-start gap-4 mb-6">
    <div class="text-3xl text-red-400 mt-1 flex-shrink-0">📧</div>
    <span>你的信箱裡躺著 <b>58 封</b> 來自不同處室的郵件，每封都夾帶著一份格式完全不同的 PPT。</span>
  </div>
  </v-click>

  <v-click>
  <div class="flex items-start gap-4 mb-6">
    <carbon:warning class="text-3xl text-yellow-400 mt-1 flex-shrink-0" />
    <span class="italic text-gray-400">"這張圖太糊了"、"那個單位的數據單位是錯的"、"為什麼這一頁用了 Comic Sans 字體？"</span>
  </div>
  </v-click>

  <v-click>
  <div class="border-l-4 border-green-500 pl-4 py-2 bg-green-500/10 rounded-r mt-8">
    而你的任務，是在一週內將它們變成一份<b>國際標準的永續報告書</b>。
    這就是我們過去每一年面臨的真實挑戰。
  </div>
  </v-click>
</div>

---
transition: fade-out
---

# 📚 課程導航

<div class="grid grid-cols-2 gap-6 mt-8">

<div class="space-y-4">
  <v-click>
  <div class="flex items-center gap-4 bg-gray-800/50 p-4 rounded-lg hover:bg-gray-800 transition border border-gray-700/50">
    <div class="w-10 h-10 rounded-full bg-red-500/20 flex items-center justify-center text-red-400 font-bold border border-red-500/30">1</div>
    <div>
      <div class="font-bold">問題與挑戰</div>
      <div class="text-xs opacity-50 font-mono">Problems & Challenges</div>
    </div>
  </div>
  </v-click>

  <v-click>
  <div class="flex items-center gap-4 bg-gray-800/50 p-4 rounded-lg hover:bg-gray-800 transition border border-gray-700/50">
    <div class="w-10 h-10 rounded-full bg-blue-500/20 flex items-center justify-center text-blue-400 font-bold border border-blue-500/30">2</div>
    <div>
      <div class="font-bold">解決方案架構</div>
      <div class="text-xs opacity-50 font-mono">Solution Architecture</div>
    </div>
  </div>
  </v-click>

  <v-click>
  <div class="flex items-center gap-4 bg-gray-800/50 p-4 rounded-lg hover:bg-gray-800 transition border border-gray-700/50">
    <div class="w-10 h-10 rounded-full bg-purple-500/20 flex items-center justify-center text-purple-400 font-bold border border-purple-500/30">3</div>
    <div>
      <div class="font-bold">雲端編輯器</div>
      <div class="text-xs opacity-50 font-mono">Cloud Editor</div>
    </div>
  </div>
  </v-click>
</div>

<div class="space-y-4">
  <v-click>
  <div class="flex items-center gap-4 bg-gray-800/50 p-4 rounded-lg hover:bg-gray-800 transition border border-gray-700/50">
    <div class="w-10 h-10 rounded-full bg-yellow-500/20 flex items-center justify-center text-yellow-400 font-bold border border-yellow-500/30">4</div>
    <div>
      <div class="font-bold">驗證與評分系統</div>
      <div class="text-xs opacity-50 font-mono">Validation & Scoring</div>
    </div>
  </div>
  </v-click>

  <v-click>
  <div class="flex items-center gap-4 bg-gray-800/50 p-4 rounded-lg hover:bg-gray-800 transition border border-gray-700/50">
    <div class="w-10 h-10 rounded-full bg-teal-500/20 flex items-center justify-center text-teal-400 font-bold border border-teal-500/30">5</div>
    <div>
      <div class="font-bold">v4.0 未來規劃</div>
      <div class="text-xs opacity-50 font-mono">Roadmap</div>
    </div>
  </div>
  </v-click>

  <v-click>
  <div class="flex items-center gap-4 bg-gray-800/50 p-4 rounded-lg hover:bg-gray-800 transition border border-gray-700/50">
    <div class="w-10 h-10 rounded-full bg-green-500/20 flex items-center justify-center text-green-400 font-bold border border-green-500/30">6</div>
    <div>
      <div class="font-bold">總結與 Q&A</div>
      <div class="text-xs opacity-50 font-mono">Summary</div>
    </div>
  </div>
  </v-click>
</div>

</div>

---
layout: section
---

# Part 1
## 問題與挑戰
### ⚠️ 突破傳統報告彙整的瓶頸

---

# 🤔 傳統報告製作的痛點

<div class="grid grid-cols-2 gap-12 mt-8">

<div class="space-y-6">
  <div class="flex items-start gap-4" v-click>
    <div class="text-3xl">📚</div>
    <div>
      <h3 class="text-xl font-bold text-red-400">來源繁雜</h3>
      <p class="opacity-80 text-sm">每年需處理約 <b>58 份</b> 期末管考 PPT，來自 17 個不同學院與行政單位。</p>
    </div>
  </div>

  <div class="flex items-start gap-4" v-click>
    <div class="text-3xl">🔄</div>
    <div>
      <h3 class="text-xl font-bold text-red-400">人工彙整耗時</h3>
      <p class="opacity-80 text-sm">格式不統一（字體、版面迥異），數據散落難以提取，需大量人工潤飾。</p>
    </div>
  </div>
</div>

<div class="space-y-6">
  <div class="flex items-start gap-4" v-click>
    <div class="text-3xl">📉</div>
    <div>
      <h3 class="text-xl font-bold text-red-400">難以追蹤</h3>
      <p class="opacity-80 text-sm">數據來源不可考，修改歷程無法回溯。</p>
    </div>
  </div>

  <div class="flex items-start gap-4" v-click>
    <div class="text-3xl">⚠️</div>
    <div>
      <h3 class="text-xl font-bold text-red-400">漂綠風險</h3>
      <p class="opacity-80 text-sm">Greenwashing 難以控管，誇大用語容易出現。</p>
    </div>
  </div>
</div>

</div>

---

# 💡 Paradigm Shift：從「手動」到「AI 輔助」

<div class="grid grid-cols-2 gap-8 mt-8">

<div class="bg-gray-800/30 p-6 rounded-xl border border-gray-700">
  <h3 class="text-center mb-4 font-bold text-gray-400 flex items-center justify-center gap-2">
    ❌ 傳統方式 (Manual)
  </h3>
  <div class="font-mono text-sm bg-black/40 p-4 rounded text-gray-300">
    1. 收集 58 份 PPT<br>
    2. 逐一開啟、複製數據<br>
    3. 貼入 Word 文檔<br>
    4. 手動校對格式...<br>
    <span class="text-red-400">5. 重複 N 次</span>
  </div>
  <p class="mt-4 text-center text-sm opacity-70">"每一步都需要人工判斷"</p>
</div>

<div class="bg-blue-900/20 p-6 rounded-xl border border-blue-500/30">
  <h3 class="text-center mb-4 font-bold text-blue-400 flex items-center justify-center gap-2">
    <carbon:checkmark-outline class="text-green-400" /> AI 輔助 (Automated)
  </h3>
  <div class="font-mono text-sm bg-black/40 p-4 rounded text-blue-200">
    1. PPT 批次匯入<br>
    2. <span class="text-green-400">AI 自動提取數據</span><br>
    3. <span class="text-green-400">AI 生成草稿</span><br>
    4. <span class="text-yellow-400">人工審核修訂</span><br>
    5. 一鍵輸出報告
  </div>
  <p class="mt-4 text-center text-sm opacity-70">"讓 AI 處理重複工作，人專注審核"</p>
</div>

</div>

<div class="mt-8 text-center text-sm opacity-60">
  我們的目標：減少 80% 的重複性勞動，同時提升報告品質
</div>

---
layout: section
---

# Part 2
## 解決方案架構
### 🔧 自動化管線設計

---

# 🏗️ 系統架構圖

```mermaid
graph LR
    A[📂 原始 PPTs] -->|解析| B(📄 JSON 中介格式)
    B -->|AI 處理| C{🤖 LLM Pipeline}
    C -->|生成| D[📝 Markdown 草稿]
    D -->|編輯 & 審核| E[📊 永續報告書]

    style C fill:#e1f5fe,stroke:#01579b,stroke-width:2px
    style E fill:#e8f5e9,stroke:#2e7d32,stroke-width:2px
```

<div class="grid grid-cols-2 gap-4 mt-8">
  <v-click>
    <div class="bg-blue-50/10 p-4 rounded border border-blue-500/20">
      <div class="text-xl font-bold mb-2 text-blue-400 flex items-center gap-2">
        🎯 目標
      </div>
      <div>支援 17 個學院/單位的批次處理，大幅縮短彙整時間</div>
    </div>
  </v-click>
  <v-click>
    <div class="bg-green-50/10 p-4 rounded border border-green-500/20">
      <div class="text-xl font-bold mb-2 text-green-400 flex items-center gap-2">
        ⚡ 效益
      </div>
      <div>統一格式、自動提取數據、標準化語氣</div>
    </div>
  </v-click>
</div>

---

# 🔧 四階段處理流程 (Agentic Workflow)

<div class="grid grid-cols-2 gap-4 mt-4">

<v-click>
<div class="flex items-center gap-4 bg-gray-800 p-4 rounded-lg hover:bg-gray-750 transition border-l-4 border-blue-500">
  <div class="text-3xl">1️⃣</div>
  <div>
    <h4 class="font-bold text-blue-400">Intent Decomposition</h4>
    <p class="text-sm opacity-80">將複雜的報告需求拆解為獨立的撰寫任務</p>
  </div>
</div>
</v-click>

<v-click>
<div class="flex items-center gap-4 bg-gray-800 p-4 rounded-lg hover:bg-gray-750 transition border-l-4 border-green-500">
  <div class="text-3xl">2️⃣</div>
  <div>
    <h4 class="font-bold text-green-400">Tool Retrieval</h4>
    <p class="text-sm opacity-80">根據任務需求，自動選取適合的數據提取工具</p>
  </div>
</div>
</v-click>

<v-click>
<div class="flex items-center gap-4 bg-gray-800 p-4 rounded-lg hover:bg-gray-750 transition border-l-4 border-yellow-500">
  <div class="text-3xl">3️⃣</div>
  <div>
    <h4 class="font-bold text-yellow-400">Prompt Generation</h4>
    <p class="text-sm opacity-80">動態組裝上下文，生成高品質的 LLM 指令</p>
  </div>
</div>
</v-click>

<v-click>
<div class="flex items-center gap-4 bg-gray-800 p-4 rounded-lg hover:bg-gray-750 transition border-l-4 border-red-500">
  <div class="text-3xl">4️⃣</div>
  <div>
    <h4 class="font-bold text-red-400">Config Assembly</h4>
    <p class="text-sm opacity-80">整合所有參數，驅動生成最終內容</p>
  </div>
</div>
</v-click>

</div>

---
layout: section
---

# Part 3
## 雲端編輯器
### ✏️ 專為永續報告設計的協作平台

---
layout: two-cols
---

# 🌐 Flask Editor

專為永續報告書設計的協作平台

### 核心功能

<v-clicks>

- **即時 Markdown 編輯**
  - 所見即所得，支援實時預覽
- **智慧驗證系統**
  - 自動比對原始數據
  - 漂綠關鍵字檢測
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
    <span class="text-blue-300">🔍 Diff View</span> 確保改動透明化
  </div>
</div>

---
layout: section
---

# Part 4
## 驗證與評分系統
### 📊 確保報告品質與可信度

---

# 📊 三大評分維度

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
      <td class="p-3 border-b border-gray-700 font-bold text-blue-300">
        ✓ 數據準確性
      </td>
      <td class="p-3 border-b border-gray-700 font-mono text-sm">Data Accuracy</td>
      <td class="p-3 border-b border-gray-700">數字是否與原始 PPT 一致？單位是否正確？</td>
    </tr>
    <tr>
      <td class="p-3 border-b border-gray-700 font-bold text-green-300">
        🔗 事實可追溯性
      </td>
      <td class="p-3 border-b border-gray-700 font-mono text-sm">Fact Traceability</td>
      <td class="p-3 border-b border-gray-700">每個聲明是否有明確的來源佐證？</td>
    </tr>
    <tr>
      <td class="p-3 border-b border-gray-700 font-bold text-yellow-300">
        ⚖️ 語調客觀性
      </td>
      <td class="p-3 border-b border-gray-700 font-mono text-sm">Tone Objectivity</td>
      <td class="p-3 border-b border-gray-700">是否使用了誇大、行銷式的用語？</td>
    </tr>
  </tbody>
</table>
</div>

<v-click>
<div class="mt-6 bg-yellow-500/10 p-4 border-l-4 border-yellow-500 rounded flex items-start gap-3">
  <carbon:warning class="text-2xl text-yellow-400 flex-shrink-0" />
  <div>
    <span class="font-bold block">自動偵測問題類型：</span>
    <span class="text-sm opacity-90">數字錯誤、實體缺失、誇大用語（如「完美」、「世界第一」）、邏輯矛盾</span>
  </div>
</div>
</v-click>

---
layout: center
class: text-center
---

# 🧠 練習時間 (Interactive Session)

<div class="mb-8">請找出下列句子中的「潛在問題」：</div>

<div class="bg-white/10 p-6 rounded-xl text-xl font-serif italic mb-8 mx-auto max-w-2xl border border-gray-600">
  "本學院今年度推動了<b>無數場</b>環保講座，參與人數<b>爆滿</b>，<br>
  成效達到<b>世界級水準</b>，完全落實永續精神。"
</div>

<v-click>
  <div class="grid grid-cols-3 gap-4 text-left max-w-3xl mx-auto">
    <div class="bg-red-500/20 p-3 rounded border border-red-500/50">
      <div class="font-bold text-red-300 flex items-center gap-1">
        ❌ "無數場"
      </div>
      <div class="text-xs">數據模糊，缺乏具體量化指標</div>
    </div>
    <div class="bg-red-500/20 p-3 rounded border border-red-500/50">
      <div class="font-bold text-red-300 flex items-center gap-1">
        ❌ "爆滿"
      </div>
      <div class="text-xs">主觀形容詞，應提供具體人數</div>
    </div>
    <div class="bg-red-500/20 p-3 rounded border border-red-500/50">
      <div class="font-bold text-red-300 flex items-center gap-1">
        ❌ "世界級水準"
      </div>
      <div class="text-xs">誇大行銷用語 (Marketing Fluff)</div>
    </div>
  </div>
</v-click>

---
layout: section
---

# Part 5
## v4.0 未來規劃
### 🚀 Roadmap

---
layout: two-cols
---

# 🖥️ 架構升級

### Sidebar 雙分頁設計

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
    <div class="font-bold mb-1 flex items-center gap-2">
      ⚡ 即時反饋
    </div>
    <div class="text-sm opacity-80">邊改邊看分數變化，寫作就像玩遊戲</div>
  </div>
  </v-click>

  <v-click>
  <div class="bg-gradient-to-r from-purple-900/40 to-blue-900/40 p-4 rounded-lg border border-purple-500/30">
    <div class="font-bold mb-1 flex items-center gap-2">
      📈 動態模擬
    </div>
    <div class="text-sm opacity-80">修改數據後，自動計算對 SDGs 的影響</div>
  </div>
  </v-click>
</div>

---

# 📊 開發時程 (Roadmap)

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

<div class="grid grid-cols-3 gap-4 mt-6">
  <v-click>
  <div class="text-center p-4 bg-gray-800 rounded-xl border-t-4 border-gray-500 opacity-50">
    <div class="text-2xl mb-1">Phase 1</div>
    <div class="text-sm">融合與復活</div>
    <div class="text-xs opacity-60 mt-2">✅ 已完成</div>
  </div>
  </v-click>

  <v-click>
  <div class="text-center p-4 bg-gray-800 rounded-xl border-t-4 border-blue-500">
    <div class="text-2xl mb-1 text-blue-400">Phase 2</div>
    <div class="text-sm">多院版本比對</div>
    <div class="text-xs bg-blue-500/20 text-blue-300 px-2 py-1 rounded mt-2 inline-block">進行中</div>
  </div>
  </v-click>

  <v-click>
  <div class="text-center p-4 bg-gray-800 rounded-xl border-t-4 border-gray-600">
    <div class="text-2xl mb-1">Phase 3</div>
    <div class="text-sm">IDML 出版串接</div>
    <div class="text-xs opacity-60 mt-2">即將開始</div>
  </div>
  </v-click>
</div>

---
layout: statement
---

# Part 6
## 總結
### <carbon:checkmark-outline class="inline" /> Summary

---

# 📈 成效總結

<div class="flex justify-center gap-8 mt-10">

<v-click>
<div class="text-center p-6 bg-gray-800 rounded-xl w-40 border-t-4 border-blue-500">
  <div class="text-4xl font-bold mb-2">58</div>
  <div class="text-xs text-gray-400 uppercase tracking-widest">PPT 處理</div>
</div>
</v-click>

<v-click>
<div class="text-center p-6 bg-gray-800 rounded-xl w-40 border-t-4 border-purple-500">
  <div class="text-4xl font-bold mb-2">17</div>
  <div class="text-xs text-gray-400 uppercase tracking-widest">單位覆蓋</div>
</div>
</v-click>

<v-click>
<div class="text-center p-6 bg-gray-800 rounded-xl w-40 border-t-4 border-red-500">
  <div class="text-4xl font-bold mb-2">80%</div>
  <div class="text-xs text-gray-400 uppercase tracking-widest">效率提升</div>
</div>
</v-click>

<v-click>
<div class="text-center p-6 bg-gray-800 rounded-xl w-40 border-t-4 border-green-500">
  <div class="text-4xl font-bold mb-2 text-green-400">✓</div>
  <div class="text-xs text-gray-400 uppercase tracking-widest">漂綠控管</div>
</div>
</v-click>

</div>

<div class="mt-12 text-center opacity-60">
  "從手工彙整到 AI 輔助，我們不只是在寫報告，而是在建立永續資料的數位資產。"
</div>

---

# 💎 核心價值

<div class="grid grid-cols-3 gap-6 mt-8">

<v-click>
<div class="flex items-center gap-4 bg-gray-800 p-4 rounded-lg border-l-4 border-blue-500">
  <div class="text-3xl">🤖</div>
  <div>
    <h4 class="font-bold text-blue-400">自動化</h4>
    <p class="text-sm opacity-80">減少 80% 重複性勞動</p>
  </div>
</div>
</v-click>

<v-click>
<div class="flex items-center gap-4 bg-gray-800 p-4 rounded-lg border-l-4 border-green-500">
  <div class="text-3xl">⚖️</div>
  <div>
    <h4 class="font-bold text-green-400">標準化</h4>
    <p class="text-sm opacity-80">統一格式與語調</p>
  </div>
</div>
</v-click>

<v-click>
<div class="flex items-center gap-4 bg-gray-800 p-4 rounded-lg border-l-4 border-purple-500">
  <div class="text-3xl">🚀</div>
  <div>
    <h4 class="font-bold text-purple-400">智慧化</h4>
    <p class="text-sm opacity-80">數據驅動決策</p>
  </div>
</div>
</v-click>

</div>

---

# 📑 簡報索引 (Q&A 快速導航)

<div class="grid grid-cols-2 gap-4 mt-4 text-sm">

<div>

### Part 1-3
- [#2 開場故事](/2)
- [#3 課程導航](/3)
- [#5 傳統痛點](/5)
- [#6 方案對比](/6)
- [#8 系統架構](/8)
- [#9 四階段流程](/9)

</div>

<div>

### Part 4-6
- [#12 三大評分維度](/12)
- [#13 練習時間](/13)
- [#15 數位孿生](/15)
- [#16 開發時程](/16)
- [#18 成效總結](/18)
- [#19 核心價值](/19)

</div>

</div>

<div class="mt-4 text-center text-xs opacity-60">
  按 <kbd>G</kbd> 鍵可輸入頁碼快速跳轉 ｜ 按 <kbd>O</kbd> 鍵開啟總覽模式
</div>

---
layout: center
class: text-center
---

# 🙋 Q&A

<div class="text-xl mb-8">永續報告書製作系統</div>

<div class="grid grid-cols-2 gap-4 text-left max-w-2xl mx-auto text-sm opacity-80">
  <div class="p-3 border border-gray-700 rounded hover:bg-gray-800 transition">
    ❓ 系統如何處理舊版 PPT?
  </div>
  <div class="p-3 border border-gray-700 rounded hover:bg-gray-800 transition">
    ❓ AI 驗證的準確率如何?
  </div>
  <div class="p-3 border border-gray-700 rounded hover:bg-gray-800 transition">
    ❓ 是否支援其他部門擴充?
  </div>
  <div class="p-3 border border-gray-700 rounded hover:bg-gray-800 transition">
    ❓ 導入系統的技術門檻?
  </div>
</div>

<div class="mt-12">
  <span class="px-4 py-2 rounded bg-white/10 text-xs font-mono">
    Thank you for listening! ❤️
  </span>
</div>
