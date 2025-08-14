# 🚀 ProPresenter 快速开始指南

## 新同工必读（5分钟）

### 第一步：克隆项目
```bash
git clone <仓库地址>
cd ProPresenter
```

### 第二步：运行自动设置
```bash
chmod +x setup-new-computer.sh
./setup-new-computer.sh
```

### 第三步：验证设置
```bash
./test-config.sh
```

## 日常使用（3个命令）

### 1. 获取最新文件
```bash
git pull origin main
```

### 2. 保存你的更改
```bash
git add .
git commit -m "我做了什么修改"
```

### 3. 上传到团队
```bash
git push origin main
```

## 📁 重要文件夹说明

### ✅ 自动同步的文件夹（GitHub管理）
- **Libraries/** - 你的演示文稿文件 (.pro)
- **Playlists/** - 播放列表
- **Themes/** - 主题样式
- **Configuration/** - 软件设置

### ⚠️ 需要手动管理的文件夹（不上传GitHub）
- **Media/** - 视频、图片、音频文件
- **background music/** - 背景音乐
- **logo/** - Logo图片

## 🔄 工作流程

### 开始工作前
```bash
git pull origin main  # 获取最新文件
```

### 工作过程中
```bash
git status  # 查看哪些文件有修改
```

### 完成工作后
```bash
git add .
git commit -m "完成了什么工作"
git push origin main
```

## ⚠️ 重要提醒

1. **不要同时编辑同一个文件** - 避免冲突
2. **媒体文件要手动复制** - 不会自动同步
3. **经常保存和上传** - 避免丢失工作

## 🆘 遇到问题？

1. **运行测试**：`./test-config.sh`
2. **查看状态**：`git status`
3. **联系管理员**：jonathanjing@graceirvine.org

## 🎯 新手检查清单

- [ ] 成功克隆了仓库
- [ ] 运行了设置脚本
- [ ] 测试脚本显示"✅ All tests passed"
- [ ] 能打开 ProPresenter 软件
- [ ] 能看到 Libraries 文件夹中的 .pro 文件
- [ ] 学会了基本的 git pull/push 操作

**恭喜！你已经准备好开始工作了！** 🎉
