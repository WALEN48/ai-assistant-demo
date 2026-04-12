#!/bin/bash

# AI Assistant Demo 版本管理脚本
# 使用方法: ./version-manager.sh [命令] [参数]

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 显示帮助信息
show_help() {
    echo -e "${BLUE}AI Assistant Demo 版本管理工具${NC}"
    echo ""
    echo "用法: ./version-manager.sh [命令] [选项]"
    echo ""
    echo "命令:"
    echo "  status              查看当前版本状态"
    echo "  log                 查看提交历史"
    echo "  fix [描述]          创建修复分支并提交 (例如: ./version-manager.sh fix '修复按钮样式')"
    echo "  feature [描述]      创建功能分支并提交"
    echo "  commit [描述]       直接提交当前更改"
    echo "  tag [版本号] [描述] 创建版本标签 (例如: ./version-manager.sh tag v1.3.0 '新增功能')"
    echo "  push                推送到远程仓库"
    echo "  rollback [版本]     回滚到指定版本 (例如: ./version-manager.sh rollback v1.2.0)"
    echo "  release             发布新版本 (提交+标签+推送)"
    echo "  sync                从远程同步最新代码"
    echo ""
    echo "示例:"
    echo "  ./version-manager.sh fix '修复移动端显示问题'"
    echo "  ./version-manager.sh tag v1.3.0 '新增主题切换功能'"
    echo "  ./version-manager.sh release"
    echo ""
}

# 显示当前状态
show_status() {
    echo -e "${BLUE}=== 当前版本状态 ===${NC}"
    echo ""
    
    # 当前分支
    echo -e "${YELLOW}当前分支:${NC}"
    git branch --show-current
    echo ""
    
    # 最新标签
    echo -e "${YELLOW}最新版本标签:${NC}"
    git describe --tags --abbrev=0 2>/dev/null || echo "无标签"
    echo ""
    
    # 最近提交
    echo -e "${YELLOW}最近5次提交:${NC}"
    git log --oneline -5
    echo ""
    
    # 文件状态
    echo -e "${YELLOW}文件变更状态:${NC}"
    git status -s
    echo ""
}

# 查看提交历史
show_log() {
    echo -e "${BLUE}=== 提交历史 ===${NC}"
    git log --oneline --graph --decorate -20
}

# 创建修复分支
create_fix() {
    local desc=$1
    if [ -z "$desc" ]; then
        echo -e "${RED}错误: 请提供修复描述${NC}"
        echo "用法: ./version-manager.sh fix '修复描述'"
        exit 1
    fi
    
    # 生成分支名
    local branch_name="fix/$(date +%Y%m%d)-$(echo $desc | tr ' ' '-' | tr '[:upper:]' '[:lower:]' | cut -c1-30)"
    
    echo -e "${BLUE}=== 创建修复分支: $branch_name ===${NC}"
    
    # 确保在 main 分支
    git checkout main
    
    # 创建并切换到新分支
    git checkout -b "$branch_name"
    
    echo -e "${GREEN}✓ 已创建并切换到分支: $branch_name${NC}"
    echo -e "${YELLOW}提示: 进行修复后，运行 ./version-manager.sh commit 'fix: $desc' 提交更改${NC}"
}

# 创建功能分支
create_feature() {
    local desc=$1
    if [ -z "$desc" ]; then
        echo -e "${RED}错误: 请提供功能描述${NC}"
        echo "用法: ./version-manager.sh feature '功能描述'"
        exit 1
    fi
    
    local branch_name="feature/$(date +%Y%m%d)-$(echo $desc | tr ' ' '-' | tr '[:upper:]' '[:lower:]' | cut -c1-30)"
    
    echo -e "${BLUE}=== 创建功能分支: $branch_name ===${NC}"
    
    git checkout main
    git checkout -b "$branch_name"
    
    echo -e "${GREEN}✓ 已创建并切换到分支: $branch_name${NC}"
}

# 提交更改
commit_changes() {
    local message=$1
    
    if [ -z "$message" ]; then
        echo -e "${RED}错误: 请提供提交信息${NC}"
        echo "用法: ./version-manager.sh commit '提交信息'"
        exit 1
    fi
    
    echo -e "${BLUE}=== 提交更改 ===${NC}"
    
    # 检查是否有更改
    if [ -z "$(git status -s)" ]; then
        echo -e "${YELLOW}没有要提交的更改${NC}"
        exit 0
    fi
    
    git add -A
    git commit -m "$message"
    
    echo -e "${GREEN}✓ 已提交: $message${NC}"
}

# 创建标签
create_tag() {
    local version=$1
    local desc=$2
    
    if [ -z "$version" ]; then
        echo -e "${RED}错误: 请提供版本号${NC}"
        echo "用法: ./version-manager.sh tag v1.3.0 '版本描述'"
        exit 1
    fi
    
    if [ -z "$desc" ]; then
        desc="版本 $version"
    fi
    
    echo -e "${BLUE}=== 创建版本标签: $version ===${NC}"
    
    git tag -a "$version" -m "$desc"
    
    echo -e "${GREEN}✓ 已创建标签: $version${NC}"
}

# 推送到远程
push_to_remote() {
    echo -e "${BLUE}=== 推送到远程仓库 ===${NC}"
    
    local current_branch=$(git branch --show-current)
    
    git push origin "$current_branch"
    git push origin --tags
    
    echo -e "${GREEN}✓ 已推送到远程${NC}"
}

# 回滚版本
rollback() {
    local target=$1
    
    if [ -z "$target" ]; then
        echo -e "${RED}错误: 请提供回滚目标${NC}"
        echo "用法: ./version-manager.sh rollback v1.2.0"
        echo "      ./version-manager.sh rollback HEAD~1"
        exit 1
    fi
    
    echo -e "${YELLOW}警告: 这将回滚到 $target，之后的更改将丢失！${NC}"
    read -p "确定要继续吗? (y/N): " confirm
    
    if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
        echo "已取消"
        exit 0
    fi
    
    echo -e "${BLUE}=== 回滚到: $target ===${NC}"
    
    git reset --hard "$target"
    
    echo -e "${GREEN}✓ 已回滚到: $target${NC}"
    echo -e "${YELLOW}提示: 如需推送回滚，请运行 ./version-manager.sh push${NC}"
}

# 发布新版本
release() {
    echo -e "${BLUE}=== 发布新版本 ===${NC}"
    
    # 检查是否有更改
    if [ -z "$(git status -s)" ]; then
        echo -e "${YELLOW}没有要提交的更改${NC}"
        show_status
        exit 0
    fi
    
    # 询问版本号
    read -p "请输入版本号 (例如: v1.3.0): " version
    
    if [ -z "$version" ]; then
        echo -e "${RED}错误: 版本号不能为空${NC}"
        exit 1
    fi
    
    # 询问提交信息
    read -p "请输入提交信息: " message
    
    if [ -z "$message" ]; then
        message="版本 $version"
    fi
    
    # 提交更改
    git add -A
    git commit -m "$message"
    
    # 创建标签
    git tag -a "$version" -m "$message"
    
    # 推送
    git push origin main
    git push origin --tags
    
    echo ""
    echo -e "${GREEN}✓ 版本 $version 发布成功！${NC}"
    echo -e "${BLUE}演示链接: https://walen48.github.io/ai-assistant-demo/${NC}"
}

# 同步远程代码
sync_remote() {
    echo -e "${BLUE}=== 同步远程代码 ===${NC}"
    
    git checkout main
    git pull origin main
    
    echo -e "${GREEN}✓ 已同步最新代码${NC}"
}

# 主命令处理
case "${1:-}" in
    status)
        show_status
        ;;
    log)
        show_log
        ;;
    fix)
        create_fix "$2"
        ;;
    feature)
        create_feature "$2"
        ;;
    commit)
        commit_changes "$2"
        ;;
    tag)
        create_tag "$2" "$3"
        ;;
    push)
        push_to_remote
        ;;
    rollback)
        rollback "$2"
        ;;
    release)
        release
        ;;
    sync)
        sync_remote
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        show_help
        ;;
esac
