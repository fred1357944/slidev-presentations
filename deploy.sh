#!/bin/bash

# 行銷課簡報部署腳本
# 用法: ./deploy.sh [版本號]
# 範例: ./deploy.sh v2

set -e

# 設定路徑
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$SCRIPT_DIR/../行銷課"

# 顏色輸出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 顯示標題
echo -e "${BLUE}"
echo "╔════════════════════════════════════════╗"
echo "║     行銷課簡報部署工具                 ║"
echo "╚════════════════════════════════════════╝"
echo -e "${NC}"

# 列出可用版本
list_versions() {
    echo -e "${YELLOW}可用版本:${NC}"
    for dir in "$SCRIPT_DIR"/v*/; do
        if [ -d "$dir" ]; then
            version=$(basename "$dir")
            if [ -f "$dir/slides.md" ]; then
                # 讀取第一行標題
                title=$(head -20 "$dir/slides.md" | grep "^# " | head -1 | sed 's/^# //')
                echo -e "  ${GREEN}$version${NC} - $title"
            fi
        fi
    done
    echo ""
}

# 檢查版本是否存在
check_version() {
    local version=$1
    if [ ! -d "$SCRIPT_DIR/$version" ]; then
        echo -e "${RED}錯誤: 版本 '$version' 不存在${NC}"
        list_versions
        exit 1
    fi
    if [ ! -f "$SCRIPT_DIR/$version/slides.md" ]; then
        echo -e "${RED}錯誤: 版本 '$version' 缺少 slides.md${NC}"
        exit 1
    fi
}

# 部署版本
deploy_version() {
    local version=$1

    echo -e "${BLUE}正在部署 $version 到行銷課...${NC}"

    # 複製檔案（保留 index.html 和其他現有檔案）
    cp "$SCRIPT_DIR/$version/slides.md" "$TARGET_DIR/"
    cp "$SCRIPT_DIR/$version/package.json" "$TARGET_DIR/" 2>/dev/null || true
    cp "$SCRIPT_DIR/$version/zbpack.json" "$TARGET_DIR/" 2>/dev/null || true

    # 更新 versions.json 中的 current
    if [ -f "$SCRIPT_DIR/versions.json" ]; then
        # 使用 sed 更新 current 欄位
        sed -i '' "s/\"current\": \"v[0-9]*\"/\"current\": \"$version\"/" "$SCRIPT_DIR/versions.json"
    fi

    echo -e "${GREEN}✓ 部署完成!${NC}"
    echo ""
    echo -e "已部署的檔案:"
    echo -e "  - slides.md"
    echo -e "  - package.json"
    echo -e "  - zbpack.json"
    echo ""
    echo -e "${YELLOW}下一步:${NC}"
    echo -e "  1. Zeabur 會自動偵測變更並重新部署"
    echo -e "  2. 等待 1-2 分鐘後訪問: https://fredppt.zeabur.app/"
    echo ""
}

# 互動式選擇
interactive_select() {
    list_versions
    echo -e "${YELLOW}請輸入要部署的版本 (例如: v2):${NC}"
    read -r version

    if [ -z "$version" ]; then
        echo -e "${RED}錯誤: 請輸入版本號${NC}"
        exit 1
    fi

    check_version "$version"
    deploy_version "$version"
}

# 主程式
main() {
    if [ $# -eq 0 ]; then
        # 沒有參數，進入互動模式
        interactive_select
    elif [ "$1" = "-l" ] || [ "$1" = "--list" ]; then
        # 列出版本
        list_versions
    elif [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        # 顯示幫助
        echo "用法: ./deploy.sh [選項] [版本]"
        echo ""
        echo "選項:"
        echo "  -l, --list    列出所有可用版本"
        echo "  -h, --help    顯示此幫助訊息"
        echo ""
        echo "範例:"
        echo "  ./deploy.sh           # 互動式選擇版本"
        echo "  ./deploy.sh v2        # 直接部署 v2"
        echo "  ./deploy.sh --list    # 列出所有版本"
    else
        # 直接部署指定版本
        check_version "$1"
        deploy_version "$1"
    fi
}

main "$@"
