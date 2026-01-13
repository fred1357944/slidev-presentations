# Marketing Toolkit Plugin

行銷工具包：為創業者和行銷人員設計的 Claude Code Skills。

## 安裝

```bash
# 複製到 Claude Code 的 skills 目錄
cp -r marketing-toolkit ~/.claude/skills/
```

或透過 Git：

```bash
cd ~/.claude/skills
git clone https://github.com/fred1357944/marketing-toolkit
```

## 包含的 Skills

### 1. `/stp-analyzer` - STP 分析器

分析客戶的市場定位，採用進階的「生命階段 + 情境」框架。

```bash
/stp-analyzer 綠藻淨氣減碳機 - 結合綠藻生物技術的室內空氣淨化設備
```

**輸出：**
- 生命階段分析
- 情境分析
- 目標市場定義
- 品牌定位建議

---

### 2. `/brand-story` - 品牌故事生成器

生成品牌故事文案，採用三段式敘事結構。

```bash
/brand-story
```

互動式引導，或直接輸入：

```bash
/brand-story 品牌名稱：綠亦 / 創立：2023台北 / 核心價值：永續、科技、美學
```

**輸出：**
- 完整版品牌故事（官網用）
- 精簡版（社群用）
- 一句話定位
- 延伸應用建議

---

### 3. `/pitch-deck` - 簡報大綱生成器

自動產出 Slidev 格式的簡報大綱。

```bash
/pitch-deck investor 綠亦有限公司
/pitch-deck sales B2B 空氣淨化解決方案
/pitch-deck intro 公司介紹
/pitch-deck course 行銷實戰課程
```

**支援類型：**
- `investor` - 投資人簡報
- `sales` - 銷售提案
- `intro` - 公司介紹
- `course` - 課程簡報

---

## 使用場景

| 場景 | 推薦 Skill | 說明 |
|------|-----------|------|
| 創業初期定位 | `/stp-analyzer` | 找到目標市場 |
| 官網文案撰寫 | `/brand-story` | 建立品牌敘事 |
| 準備融資簡報 | `/pitch-deck investor` | 快速產出結構 |
| 參展準備 | `/pitch-deck intro` + `/brand-story` | 介紹 + 故事 |
| 客戶提案 | `/stp-analyzer` + `/pitch-deck sales` | 分析 + 簡報 |

---

## 理論基礎

### STP 2.0 框架

傳統 STP 的問題：「25-40歲女性小資族」這種描述太模糊。

進階版加入：
- **Stage of Life（生命階段）**：需求在進入/離開某階段時最急迫
- **Situation（情境）**：讓需求成功轉換為購買的關鍵

### 品牌故事三段式

1. **時空背景 + 品牌承諾**：宏觀趨勢 → 我們的承諾
2. **品牌核心 + 權威基礎**：差異化價值 → 為什麼可信
3. **創辦初衷 + 消費者印象**：感性連結 → 真實回饋

---

## 作者

**Fred Lai / 賴弘翌**
- 綠亦有限公司 創辦人
- 台科大建築所博士班
- 美國 LEED AP BD+C 認證師

---

## License

MIT
