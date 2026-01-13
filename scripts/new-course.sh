#!/bin/bash

# 用法: ./scripts/new-course.sh <課程ID> <課程名稱> <icon>
# 範例: ./scripts/new-course.sh programming-course "程式設計課" "💻"

COURSE_ID=$1
COURSE_NAME=$2
COURSE_ICON=$3

if [ -z "$COURSE_ID" ] || [ -z "$COURSE_NAME" ] || [ -z "$COURSE_ICON" ]; then
    echo "錯誤: 請提供參數"
    echo "用法: $0 <課程ID> <課程名稱> <icon>"
    exit 1
fi

SCRIPT_DIR="$(dirname "$0")"
ROOT_DIR="$SCRIPT_DIR/.."
TARGET_DIR="$ROOT_DIR/$COURSE_ID"

if [ -d "$TARGET_DIR" ]; then
    echo "錯誤: 課程目錄 $COURSE_ID 已存在"
    exit 1
fi

echo "正在建立課程: $COURSE_NAME ($COURSE_ID)..."

# 1. 建立目錄
mkdir -p "$TARGET_DIR"

# 2. 複製專案選擇器 (Index)
# 使用 marketing-course 的 index.html 作為範本
cp "$ROOT_DIR/marketing-course/index.html" "$TARGET_DIR/"

# 3. 建立 projects.json
cat > "$TARGET_DIR/projects.json" <<EOF
{
  "course": {
    "name": "$COURSE_NAME",
    "icon": "$COURSE_ICON"
  },
  "projects": []
}
EOF

# 4. 自動更新根目錄 courses.json
COURSES_JSON="$ROOT_DIR/courses.json"
if [ -f "$COURSES_JSON" ]; then
    node -e "
        const fs = require('fs');
        const data = JSON.parse(fs.readFileSync('$COURSES_JSON', 'utf8'));
        const newCourse = {
            id: '$COURSE_ID',
            name: '$COURSE_NAME',
            icon: '$COURSE_ICON',
            description: '$COURSE_NAME 相關簡報',
            folder: '$COURSE_ID'
        };
        if (!data.courses.find(c => c.id === '$COURSE_ID')) {
            data.courses.push(newCourse);
            fs.writeFileSync('$COURSES_JSON', JSON.stringify(data, null, 2));
            console.log('✓ 已自動更新 courses.json');
        }
    "
fi

echo ""
echo "✅ 課程 '$COURSE_NAME' 建立完成！"
echo "   → 目錄: $TARGET_DIR/"
echo "   → 下一步: ./scripts/new-project.sh $COURSE_ID <專案ID> <專案名稱> <icon>"
