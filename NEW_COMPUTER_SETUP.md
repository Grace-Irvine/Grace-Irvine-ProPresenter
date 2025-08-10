# 新电脑 ProPresenter 完整设置指南

## 🎯 目标
确保在新电脑上克隆仓库后，能够完整同步所有 ProPresenter 文件，包括：
- 所有 `.pro` 文件（演示文稿）
- 所有媒体文件（视频、音频、图片）
- 所有配置文件和主题
- 所有播放列表

## 📋 前置要求

### 1. 安装必要软件
```bash
# 安装 Git
# macOS 通常已预装

# 安装 Git LFS
brew install git-lfs

# 安装 Google Drive
# 从 App Store 或官网下载
```

### 2. 配置 Google Drive
- 登录 Google Drive 账户：`jonathanjing@graceirvine.org`
- 确保 "ProPresenter Sync" 共享文件夹已同步到本地

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

### 步骤 1: 初始化 Git LFS
```bash
git lfs install
git lfs pull --include="*" --exclude=""
```

### 步骤 2: 设置 Google Drive 同步
```bash
# 创建 Google Drive 文件夹结构
mkdir -p "/Users/$(whoami)/Library/CloudStorage/GoogleDrive-jonathanjing@graceirvine.org/Shared drives/ProPresenter Sync/Media"

# 创建 Media 文件夹链接
ln -s "/Users/$(whoami)/Library/CloudStorage/GoogleDrive-jonathanjing@graceirvine.org/Shared drives/ProPresenter Sync/Media" Media
```

### 步骤 3: 下载所有文件
```bash
# 下载 Git LFS 文件
git lfs pull

# 检查文件状态
git lfs ls-files
```

## ✅ 验证清单

设置完成后，请确认以下项目：

### Git 和 Git LFS
- [ ] Git 已安装
- [ ] Git LFS 已安装并初始化
- [ ] 所有 `.pro` 文件都可以访问
- [ ] 运行 `git lfs ls-files` 显示文件列表

### Google Drive 同步
- [ ] Google Drive 已安装并登录
- [ ] "ProPresenter Sync" 文件夹已同步
- [ ] Media 文件夹链接到 Google Drive
- [ ] 媒体文件在 Google Drive 中可见

### ProPresenter 文件
- [ ] Libraries 文件夹包含 `.pro` 文件
- [ ] Playlists 文件夹包含播放列表
- [ ] Themes 文件夹包含主题文件
- [ ] Configuration 文件夹包含配置文件

### 测试功能
- [ ] 可以打开 ProPresenter
- [ ] 可以加载演示文稿文件
- [ ] 可以播放媒体文件
- [ ] 可以访问背景音乐

## 🔍 故障排除

### 问题 1: Media 文件夹为空
**解决方案：**
```bash
# 检查 Google Drive 同步状态
ls -la "/Users/$(whoami)/Library/CloudStorage/GoogleDrive-jonathanjing@graceirvine.org/Shared drives/ProPresenter Sync/Media"

# 重新创建链接
rm Media
ln -s "/Users/$(whoami)/Library/CloudStorage/GoogleDrive-jonathanjing@graceirvine.org/Shared drives/ProPresenter Sync/Media" Media
```

### 问题 2: .pro 文件无法打开
**解决方案：**
```bash
# 下载所有 LFS 文件
git lfs pull --include="*" --exclude=""

# 检查 LFS 状态
git lfs ls-files
```

### 问题 3: Google Drive 路径不存在
**解决方案：**
1. 确保 Google Drive 已安装
2. 登录正确的 Google 账户
3. 确保 "ProPresenter Sync" 文件夹已共享
4. 等待 Google Drive 同步完成

### 问题 4: Git LFS 未安装
**解决方案：**
```bash
# macOS
brew install git-lfs

# 或从官网下载
# https://git-lfs.github.com/
```

## 📁 文件同步说明

### 通过 Git LFS 同步的文件
- **Libraries/** 中的所有 `.pro` 文件
- **Playlists/** 中的所有播放列表文件
- **Themes/** 中的主题文件
- **background music/** 中的音频文件
- **logo/** 中的图片文件

### 通过 Google Drive 同步的文件
- **Media/** 中的所有媒体文件
  - 视频文件 (.mp4, .mov, .avi 等)
  - 音频文件 (.mp3, .wav, .aac 等)
  - 图片文件 (.jpg, .png, .gif 等)

### 通过 Git 直接同步的文件
- 配置文件
- 脚本文件
- 文档文件

## 🎯 最佳实践

### 日常使用
1. **定期提交**：制作过程中经常保存版本
2. **描述性提交**：清楚说明修改内容
3. **测试同步**：添加新文件后测试同步

### 团队协作
1. **协调工作**：避免同时编辑同一文件
2. **沟通变更**：重大修改前通知团队
3. **备份重要文件**：关键文件额外备份

### 维护
1. **定期清理**：删除不需要的文件
2. **检查同步**：定期验证文件同步状态
3. **更新文档**：保持文档最新

## 📞 获取帮助

如果遇到问题：

1. **运行诊断脚本**：
   ```bash
   ./test-config.sh
   ./verify-setup.sh
   ```

2. **检查日志**：
   ```bash
   git lfs logs
   ```

3. **联系管理员**：jonathanjing@graceirvine.org

## ✅ 完成确认

设置完成后，您应该能够：
- ✅ 在新电脑上完整访问所有 ProPresenter 文件
- ✅ 通过 Git 进行版本控制
- ✅ 通过 Google Drive 同步媒体文件
- ✅ 与团队成员协作编辑文件
- ✅ 安全备份所有重要文件

🎉 **恭喜！您的 ProPresenter 工作区已准备就绪！**
