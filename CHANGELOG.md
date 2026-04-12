# 更新日志 (Changelog)

所有项目的显著变更都将记录在此文件中。

格式基于 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.0.0/)。

## [未发布]

## [1.2.0] - 2026-04-12

### 修复
- 修复"指标解读"按钮无反应的问题
- 添加模糊匹配逻辑，支持简化指标名匹配
- 补充缺失的指标解读数据（注册、创角、活跃、充值人数等）

### 新增
- 新增 11 个指标解读数据项
- 添加错误提示：当找不到指标数据时显示 Toast

## [1.1.0] - 2026-04-12

### 修复
- 修复"推荐提问"显示位置问题，从输入框上方移至对话界面中

### 变更
- `showPromptSuggestions()` 重命名为 `showPromptSuggestionsInChat()`
- 推荐提示词现在作为 AI 消息展示在聊天记录中

### 新增
- 新增 `sendSuggestionMessage()` 函数处理推荐问题点击
- 添加对话界面推荐样式（蓝色渐变背景）

## [1.0.0] - 2026-04-12

### 新增
- 实现"问问AI"核心功能
- 点击指标后自动打开AI助手窗口
- 自动创建新会话并发送指标询问
- AI自动回复指标详细说明（定义、公式、示例、重要性、正常范围）
- 显示5个推荐提示词供用户快速提问
- 添加推荐提示词CSS样式（滑入动画、悬停效果）

---

## Git 版本管理指南

### 查看版本历史
```bash
git log --oneline
```

### 回滚到指定版本
```bash
# 查看历史
git log --oneline

# 回滚到某个提交（保留更改）
git reset --soft HEAD~1

# 回滚到某个提交（丢弃更改）
git reset --hard <commit-hash>

# 回滚后强制推送（谨慎使用）
git push -f origin main
```

### 创建版本标签
```bash
# 创建标签
git tag -a v1.0.0 -m "版本 1.0.0 - 初始功能"

# 推送标签到远程
git push origin v1.0.0

# 推送所有标签
git push origin --tags
```

### 分支管理
```bash
# 创建功能分支
git checkout -b feature/xxx

# 创建修复分支
git checkout -b fix/xxx

# 合并分支
git checkout main
git merge feature/xxx
```
