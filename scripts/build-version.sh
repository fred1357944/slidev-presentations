#!/bin/bash

# 用法: ./scripts/build-version.sh <課程ID> <專案ID> <版本>
# 範例: ./scripts/build-version.sh marketing-course intro v1

COURSE_ID=$1
PROJECT_ID=$2
VERSION=$3

if [ -z "$VERSION" ]; then
    echo "錯誤: 請提供參數"
    echo "用法: $0 <課程ID> <專案ID> <版本>"
    exit 1
fi

SCRIPT_DIR="$(dirname "$0")"
ROOT_DIR="$SCRIPT_DIR/.."
WORK_DIR="$ROOT_DIR/$COURSE_ID/$PROJECT_ID/$VERSION"

if [ ! -d "$WORK_DIR" ]; then
    echo "錯誤: 目錄 $WORK_DIR 不存在"
    exit 1
fi

# 計算 Base URL (很重要，為了讓靜態資源路徑正確)
BASE_URL="/$COURSE_ID/$PROJECT_ID/$VERSION/"

echo "🚀 開始建置 $COURSE_ID / $PROJECT_ID / $VERSION"
echo "📂 Base URL: $BASE_URL"

cd "$WORK_DIR"

# 清理舊的 build 結果 (保留 slides.md)
rm -rf dist index.html 404.html _redirects assets

# 執行 Slidev Build
npx slidev build --base "$BASE_URL"

# 移動 dist 內容到當前目錄
if [ -d "dist" ]; then
    mv dist/* .
    rm -rf dist
    echo "✅ 建置完成！"
else
    echo "❌ 建置失敗，找不到 dist 目錄"
    exit 1
fi
