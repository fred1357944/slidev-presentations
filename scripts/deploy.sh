#!/bin/bash

# 用法: ./scripts/deploy.sh [Commit Message]
# 範例: ./scripts/deploy.sh "新增程式設計課"
#
# 直接部署模式 - 因為此 repo 已經是獨立的 Git repo
# 只需要 git add, commit, push 即可觸發 Zeabur 部署

COMMIT_MSG=${1:-"Update course content"}

SCRIPT_DIR="$(dirname "$0")"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$ROOT_DIR"

# 檢查是否有 .git
if [ ! -d ".git" ]; then
    echo "❌ 錯誤: 此目錄不是 Git repo"
    exit 1
fi

echo "🚀 開始部署..."
echo "📂 Repo: $ROOT_DIR"

# 檢查是否有變更
if [ -z "$(git status --porcelain)" ]; then
    echo "⚠️  沒有檔案變更，跳過部署"
    exit 0
fi

# Git add, commit, push
git add .
git commit -m "$COMMIT_MSG

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>"

git push

echo "✅ 部署完成！Zeabur 將自動更新"
