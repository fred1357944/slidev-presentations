#!/bin/bash
# Slidev 一鍵部署腳本
# 用法: ./scripts/deploy-version.sh <course> <project> <version> "<description>"
# 範例: ./scripts/deploy-version.sh sr-course fju-intro v4 "新增互動練習環節"

set -e

# 顏色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 取得腳本所在目錄
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# 參數檢查
if [ $# -lt 4 ]; then
    echo -e "${RED}錯誤: 參數不足${NC}"
    echo ""
    echo "用法: $0 <course> <project> <version> \"<description>\""
    echo ""
    echo "範例:"
    echo "  $0 sr-course fju-intro v4 \"新增互動練習環節\""
    echo ""
    echo "可用課程:"
    if [ -f "$PROJECT_ROOT/courses.json" ]; then
        cat "$PROJECT_ROOT/courses.json" | grep '"folder"' | sed 's/.*"folder": "\(.*\)".*/  - \1/'
    fi
    exit 1
fi

COURSE=$1
PROJECT=$2
VERSION=$3
DESCRIPTION=$4

# 路徑定義
COURSE_DIR="$PROJECT_ROOT/$COURSE"
PROJECT_DIR="$COURSE_DIR/$PROJECT"
VERSION_DIR="$PROJECT_DIR/$VERSION"
SLIDES_FILE="$VERSION_DIR/slides.md"
VERSIONS_FILE="$PROJECT_DIR/versions.json"

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Slidev 一鍵部署${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""
echo -e "課程: ${GREEN}$COURSE${NC}"
echo -e "專案: ${GREEN}$PROJECT${NC}"
echo -e "版本: ${GREEN}$VERSION${NC}"
echo -e "描述: ${GREEN}$DESCRIPTION${NC}"
echo ""

# 步驟 1: 驗證路徑
echo -e "${YELLOW}[1/5] 驗證路徑...${NC}"

if [ ! -d "$COURSE_DIR" ]; then
    echo -e "${RED}錯誤: 課程目錄不存在: $COURSE_DIR${NC}"
    exit 1
fi

if [ ! -d "$PROJECT_DIR" ]; then
    echo -e "${RED}錯誤: 專案目錄不存在: $PROJECT_DIR${NC}"
    exit 1
fi

if [ ! -f "$SLIDES_FILE" ]; then
    echo -e "${RED}錯誤: slides.md 不存在: $SLIDES_FILE${NC}"
    exit 1
fi

if [ ! -f "$VERSIONS_FILE" ]; then
    echo -e "${RED}錯誤: versions.json 不存在: $VERSIONS_FILE${NC}"
    exit 1
fi

echo -e "${GREEN}✓ 路徑驗證通過${NC}"

# 步驟 2: 檢查無效 Carbon Icons
echo -e "${YELLOW}[2/5] 檢查 Carbon Icons...${NC}"

INVALID_ICONS_FILE="$SCRIPT_DIR/lib/invalid-carbon-icons.txt"
FOUND_INVALID=""

if [ -f "$INVALID_ICONS_FILE" ]; then
    while IFS= read -r icon || [ -n "$icon" ]; do
        # 跳過註解和空行
        [[ "$icon" =~ ^#.*$ ]] && continue
        [[ -z "$icon" ]] && continue

        if grep -q "$icon" "$SLIDES_FILE" 2>/dev/null; then
            FOUND_INVALID="$FOUND_INVALID $icon"
        fi
    done < "$INVALID_ICONS_FILE"
fi

if [ -n "$FOUND_INVALID" ]; then
    echo -e "${RED}⚠️  發現無效的 Carbon Icons:${NC}"
    for icon in $FOUND_INVALID; do
        echo -e "   ${RED}- $icon${NC}"
    done
    echo ""
    echo -e "${YELLOW}建議使用 emoji 替代，參考:${NC}"
    echo "   carbon:target → 🎯"
    echo "   carbon:calendar → 📅"
    echo "   carbon:email → 📧"
    echo ""
    read -p "是否繼續部署？(y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${RED}已取消部署${NC}"
        exit 1
    fi
else
    echo -e "${GREEN}✓ 未發現無效 Carbon Icons${NC}"
fi

# 步驟 3: Build
echo -e "${YELLOW}[3/5] 執行 Slidev Build...${NC}"

cd "$PROJECT_ROOT"

# 執行 build
npx slidev build "$COURSE/$PROJECT/$VERSION/slides.md" \
    --base "/$COURSE/$PROJECT/$VERSION/" \
    --out "$COURSE/$PROJECT/$VERSION/"

# 修正巢狀目錄結構
NESTED_DIR="$VERSION_DIR/$COURSE/$PROJECT/$VERSION"
if [ -d "$NESTED_DIR" ]; then
    echo -e "${YELLOW}   修正巢狀目錄結構...${NC}"
    mv "$NESTED_DIR"/* "$VERSION_DIR/" 2>/dev/null || true
    rm -rf "$VERSION_DIR/$COURSE"
fi

echo -e "${GREEN}✓ Build 完成${NC}"

# 步驟 4: 更新 versions.json
echo -e "${YELLOW}[4/5] 更新 versions.json...${NC}"

TODAY=$(date +%Y-%m-%d)

# 使用 node 來安全地更新 JSON
node -e "
const fs = require('fs');
const path = '$VERSIONS_FILE';
const data = JSON.parse(fs.readFileSync(path, 'utf8'));

// 檢查版本是否已存在
const existingIndex = data.versions.findIndex(v => v.id === '$VERSION');

const newVersion = {
    id: '$VERSION',
    name: '第${VERSION#v}版',
    description: '$DESCRIPTION',
    date: '$TODAY',
    folder: '$VERSION',
    status: 'stable'
};

if (existingIndex >= 0) {
    // 更新現有版本
    data.versions[existingIndex] = newVersion;
    console.log('更新現有版本: $VERSION');
} else {
    // 新增版本
    data.versions.push(newVersion);
    console.log('新增版本: $VERSION');
}

// 更新 current
data.current = '$VERSION';

fs.writeFileSync(path, JSON.stringify(data, null, 2) + '\n');
console.log('versions.json 已更新');
"

echo -e "${GREEN}✓ versions.json 已更新${NC}"

# 步驟 5: 完成
echo -e "${YELLOW}[5/5] 驗證結果...${NC}"

if [ -f "$VERSION_DIR/index.html" ]; then
    echo -e "${GREEN}✓ index.html 存在${NC}"
else
    echo -e "${RED}⚠️  警告: index.html 不存在${NC}"
fi

if [ -d "$VERSION_DIR/assets" ]; then
    ASSET_COUNT=$(ls -1 "$VERSION_DIR/assets" | wc -l | tr -d ' ')
    echo -e "${GREEN}✓ assets/ 目錄存在 ($ASSET_COUNT 個檔案)${NC}"
else
    echo -e "${RED}⚠️  警告: assets/ 目錄不存在${NC}"
fi

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  ✅ 部署完成！${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo -e "預覽 URL: ${BLUE}/$COURSE/$PROJECT/$VERSION/${NC}"
echo ""
