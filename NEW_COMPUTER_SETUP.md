# 新电脑 ProPresenter 完整设置指南 (简化版)

## 🎯 目标
确保在新电脑上克隆仓库后，能够完整同步所有 ProPresenter 文件，包括：
- 所有 `.pro` 文件（演示文稿）- 通过GitHub同步
- 所有播放列表和主题文件 - 通过GitHub同步
- 所有配置文件 - 通过GitHub同步
- 媒体文件需要手动复制（不上传到GitHub）

## 📋 前置要求

### 1. 安装必要软件
```bash
# 安装 Git
# macOS 通常已预装

# 确保有GitHub账户和访问权限
```

## 🚀 快速设置（推荐）

### 步骤 1: 克隆仓库
```bash
git clone <your-repository-url>
cd ProPresenter
```

### 步骤 2: 运行自动设置脚本
```bash
chmod +x setup-new-computer.sh
./setup-new-computer.sh
```

### 步骤 3: 验证设置
```bash
./test-config.sh
```

## 🔧 手动设置（如果自动脚本失败）

### 步骤 1: 拉取最新代码
```bash
git pull origin main
```

### 步骤 2: 创建本地媒体文件夹
```bash
# 创建必要的文件夹
mkdir -p Media
mkdir -p "background music"
mkdir -p logo
```

### 步骤 3: 验证文件
```bash
# 检查.pro文件
find Libraries -name "*.pro" | wc -l

# 检查播放列表
find Playlists -name "*.pro*playlist" | wc -l
```

## ✅ 验证清单

设置完成后，请确认以下项目：

### Git 仓库
- [ ] Git 已安装
- [ ] 仓库已克隆
- [ ] 所有 `.pro` 文件都可以访问
- [ ] 运行 `git status` 显示正常状态

### ProPresenter 文件
- [ ] Libraries 文件夹包含 `.pro` 文件
- [ ] Playlists 文件夹包含播放列表
- [ ] Themes 文件夹包含主题文件
- [ ] Configuration 文件夹包含配置文件

### 本地文件夹
- [ ] Media 文件夹已创建
- [ ] background music 文件夹已创建
- [ ] logo 文件夹已创建

### 测试功能
- [ ] 可以打开 ProPresenter
- [ ] 可以加载演示文稿文件
- [ ] 可以访问播放列表

## 🔍 故障排除

### 问题 1: .pro 文件无法打开
**解决方案：**
```bash
# 重新拉取最新代码
git pull origin main

# 检查文件是否存在
find . -name "*.pro" -type f
```

### 问题 2: 缺少媒体文件
**解决方案：**
1. 这是正常情况 - 媒体文件不上传到GitHub
2. 需要手动从其他电脑复制媒体文件到相应文件夹
3. 或者从备份中恢复媒体文件

### 问题 3: Git 未安装
**解决方案：**
```bash
# macOS
# Git 通常已预装，如果没有：
# 从 https://git-scm.com/ 下载安装
```

## 📁 文件同步说明

### 通过 GitHub 同步的文件（版本控制）
- **Libraries/** 中的所有 `.pro` 文件
- **Playlists/** 中的所有播放列表文件
- **Themes/** 中的主题文件
- **Configuration/** 中的配置文件
- 所有脚本和文档文件

### 需要手动管理的文件（不上传）
- **Media/** 中的所有媒体文件
  - 视频文件 (.mp4, .mov, .avi 等)
  - 音频文件 (.mp3, .wav, .aac 等)
  - 图片文件 (.jpg, .png, .gif 等)
- **background music/** 中的音频文件
- **logo/** 中的图片文件
- **Doc Sync/** 中的文档文件

## 🎯 最佳实践

### 日常使用
1. **定期提交**：制作过程中经常保存版本
2. **描述性提交**：清楚说明修改内容
3. **测试同步**：添加新文件后测试同步

### 团队协作
1. **协调工作**：避免同时编辑同一文件
2. **沟通变更**：重大修改前通知团队
3. **备份媒体文件**：定期备份媒体文件到云存储

### 媒体文件管理
1. **使用云存储**：将媒体文件存储在Dropbox、Google Drive等
2. **定期同步**：新电脑设置时从云存储下载媒体文件
3. **保持结构**：保持文件夹结构一致

## 📞 获取帮助

如果遇到问题：

1. **运行诊断脚本**：
   ```bash
   ./test-config.sh
   ./verify-setup.sh
   ```

2. **检查Git状态**：
   ```bash
   git status
   git log --oneline -10
   ```

3. **联系管理员**：jonathanjing@graceirvine.org

## ✅ 完成确认

设置完成后，您应该能够：
- ✅ 在新电脑上访问所有 .pro 文件
- ✅ 通过 Git 进行版本控制
- ✅ 与团队成员协作编辑文件
- ✅ 安全备份所有重要文件
- ⚠️ 媒体文件需要手动管理

## 📝 重要提醒

### 媒体文件管理
由于媒体文件较大，不上传到GitHub，需要：
1. **手动复制**：从其他电脑或备份中复制媒体文件
2. **云存储**：使用Dropbox、Google Drive等云存储服务
3. **定期备份**：确保媒体文件有备份

### 工作流程
1. **制作阶段**：在本地编辑 .pro 文件
2. **提交阶段**：使用 `git add` 和 `git commit` 保存更改
3. **同步阶段**：使用 `git push` 上传到GitHub
4. **协作阶段**：其他同工使用 `git pull` 获取最新版本

🎉 **恭喜！您的 ProPresenter 工作区已准备就绪！**
