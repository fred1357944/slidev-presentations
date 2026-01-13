#!/bin/bash

# 用法: ./scripts/new-project.sh <課程ID> <專案ID> <專案名稱> <icon>
# 範例: ./scripts/new-project.sh marketing-course investor-pitch "投資人簡報" "💼"

COURSE_ID=$1
PROJECT_ID=$2
PROJECT_NAME=$3
PROJECT_ICON=$4

if [ -z "$PROJECT_ID" ] || [ -z "$PROJECT_NAME" ]; then
    echo "錯誤: 請提供參數"
    echo "用法: $0 <課程ID> <專案ID> <專案名稱> <icon>"
    exit 1
fi

SCRIPT_DIR="$(dirname "$0")"
ROOT_DIR="$SCRIPT_DIR/.."
COURSE_DIR="$ROOT_DIR/$COURSE_ID"
PROJECT_DIR="$COURSE_DIR/$PROJECT_ID"

if [ ! -d "$COURSE_DIR" ]; then
    echo "錯誤: 課程目錄 $COURSE_ID 不存在"
    exit 1
fi

if [ -d "$PROJECT_DIR" ]; then
    echo "錯誤: 專案目錄 $PROJECT_ID 已存在"
    exit 1
fi

echo "正在建立專案: $PROJECT_NAME..."

# 1. 建立目錄結構 (包含 v1)
mkdir -p "$PROJECT_DIR/v1"

# 2. 複製版本選擇器
cp "$ROOT_DIR/marketing-course/intro/index.html" "$PROJECT_DIR/"

# 3. 建立 versions.json
cat > "$PROJECT_DIR/versions.json" <<EOF
{
  "project": {
    "name": "$PROJECT_NAME",
    "icon": "$PROJECT_ICON"
  },
  "versions": [
    {
      "id": "v1",
      "name": "第一版",
      "description": "初始版本",
      "date": "$(date +%Y-%m-%d)",
      "folder": "v1",
      "status": "draft"
    }
  ],
  "current": "v1"
}
EOF

# 4. 建立初始 slides.md
# 如果有 template 就用 template，沒有就寫一個基本的
if [ -f "$ROOT_DIR/templates/slides-template.md" ]; then
    cp "$ROOT_DIR/templates/slides-template.md" "$PROJECT_DIR/v1/slides.md"
else
    cat > "$PROJECT_DIR/v1/slides.md" <<EOF
---
theme: default
title: $PROJECT_NAME
info: $PROJECT_NAME 簡報
---

# $PROJECT_NAME

$PROJECT_ICON $PROJECT_NAME

---

# Page 2

內容...
EOF
fi

# 5. 自動更新課程的 projects.json
PROJECTS_JSON="$COURSE_DIR/projects.json"
if [ -f "$PROJECTS_JSON" ]; then
    node -e "
        const fs = require('fs');
        const data = JSON.parse(fs.readFileSync('$PROJECTS_JSON', 'utf8'));
        const newProject = {
            id: '$PROJECT_ID',
            name: '$PROJECT_NAME',
            icon: '$PROJECT_ICON',
            description: '$PROJECT_NAME 簡報',
            folder: '$PROJECT_ID'
        };
        if (!data.projects.find(p => p.id === '$PROJECT_ID')) {
            data.projects.push(newProject);
            fs.writeFileSync('$PROJECTS_JSON', JSON.stringify(data, null, 2));
            console.log('✓ 已自動更新 projects.json');
        }
    "
fi

echo ""
echo "✅ 專案 '$PROJECT_NAME' 建立完成！"
echo "   → 目錄: $PROJECT_DIR/"
echo "   → slides.md: $PROJECT_DIR/v1/slides.md"
echo "   → 下一步: 編輯 slides.md 後執行 ./scripts/build-version.sh $COURSE_ID $PROJECT_ID v1"
