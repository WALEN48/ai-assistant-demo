# 版本管理快速参考

## 🚀 常用命令

### 查看状态
```bash
./version-manager.sh status
```

### 创建修复并提交
```bash
# 创建修复分支
./version-manager.sh fix "修复按钮样式"

# 进行代码修改...

# 提交更改
./version-manager.sh commit "fix: 修复按钮样式问题"

# 合并到 main 并推送
./version-manager.sh push
```

### 发布新版本
```bash
# 一键发布（提交 + 标签 + 推送）
./version-manager.sh release
```

### 回滚版本
```bash
# 查看历史
./version-manager.sh log

# 回滚到上一个版本
./version-manager.sh rollback HEAD~1

# 回滚到指定标签
./version-manager.sh rollback v1.2.0
```

---

## 📋 完整命令列表

| 命令 | 说明 | 示例 |
|------|------|------|
| `status` | 查看当前版本状态 | `./version-manager.sh status` |
| `log` | 查看提交历史 | `./version-manager.sh log` |
| `fix` | 创建修复分支 | `./version-manager.sh fix "修复描述"` |
| `feature` | 创建功能分支 | `./version-manager.sh feature "新增功能"` |
| `commit` | 提交当前更改 | `./version-manager.sh commit "提交信息"` |
| `tag` | 创建版本标签 | `./version-manager.sh tag v1.3.0 "描述"` |
| `push` | 推送到远程 | `./version-manager.sh push` |
| `rollback` | 回滚版本 | `./version-manager.sh rollback v1.2.0` |
| `release` | 发布新版本 | `./version-manager.sh release` |
| `sync` | 同步远程代码 | `./version-manager.sh sync` |

---

## 🔄 工作流程示例

### 场景1：修复一个 Bug
```bash
# 1. 创建修复分支
./version-manager.sh fix "修复移动端显示问题"

# 2. 修改代码...
# 编辑 index.html

# 3. 提交更改
./version-manager.sh commit "fix: 修复移动端按钮显示错位"

# 4. 切换回 main 并合并
./version-manager.sh sync
git merge fix/20260412-修复移动端显示问题

# 5. 创建标签并推送
./version-manager.sh tag v1.2.1 "修复移动端显示问题"
./version-manager.sh push
```

### 场景2：新增功能
```bash
# 1. 创建功能分支
./version-manager.sh feature "新增暗黑模式"

# 2. 开发功能...

# 3. 提交
./version-manager.sh commit "feat: 新增暗黑模式切换"

# 4. 发布
./version-manager.sh release
# 输入版本号: v1.3.0
# 输入提交信息: 新增暗黑模式功能
```

### 场景3：紧急回滚
```bash
# 查看历史
./version-manager.sh log

# 回滚到上一个版本
./version-manager.sh rollback HEAD~1

# 强制推送（谨慎使用）
git push -f origin main
```

---

## 🏷️ 版本号规范

采用 [语义化版本](https://semver.org/lang/zh-CN/)：

- `v1.0.0` - 主版本号（重大更新）
- `v1.1.0` - 次版本号（新增功能）
- `v1.1.1` - 修订号（Bug 修复）

### 提交信息规范

| 类型 | 说明 | 示例 |
|------|------|------|
| `feat` | 新功能 | `feat: 新增主题切换` |
| `fix` | 修复 | `fix: 修复按钮样式` |
| `docs` | 文档 | `docs: 更新 README` |
| `style` | 格式 | `style: 调整缩进` |
| `refactor` | 重构 | `refactor: 优化代码结构` |
| `perf` | 性能 | `perf: 提升加载速度` |

---

## 🔗 相关链接

- **演示地址**: https://walen48.github.io/ai-assistant-demo/
- **GitHub 仓库**: https://github.com/WALEN48/ai-assistant-demo
- **更新日志**: [CHANGELOG.md](./CHANGELOG.md)
