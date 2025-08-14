# ProPresenter 版本控制工作区

## 🎯 项目简介

这是一个为教会敬拜团队设计的 ProPresenter 版本控制系统，使用 Git 进行协作和版本管理。

## 📁 文件结构

```
ProPresenter/
├── Libraries/           # ProPresenter 演示文稿文件 (.pro) - 版本控制
├── Playlists/          # 播放列表文件 - 版本控制
├── Themes/             # 主题文件 - 版本控制
├── Configuration/      # ProPresenter 配置文件 - 版本控制
├── Media/              # 媒体文件 (视频、音频、图片) - 本地存储
├── background music/   # 背景音乐文件 - 本地存储
├── logo/               # Logo 和品牌文件 - 本地存储
├── Doc Sync/           # 文档同步文件夹 - 本地存储
└── 脚本文件/           # 自动化脚本和工具
```

## 🚀 快速开始

### 新电脑设置

1. **克隆仓库**
   ```bash
   git clone <repository-url>
   cd ProPresenter
   ```

2. **运行设置脚本**
   ```bash
   chmod +x setup-new-computer.sh
   ./setup-new-computer.sh
   ```

3. **验证设置**
   ```bash
   ./test-config.sh
   ```

### 日常使用

1. **获取最新更新**
   ```bash
   git pull origin main
   ```

2. **查看文件状态**
   ```bash
   git status
   ```

3. **保存更改**
   ```bash
   git add .
   git commit -m "描述你的更改"
   ```

4. **上传更改**
   ```bash
   git push origin main
   ```

## 📋 文件管理策略

### 通过 GitHub 同步的文件（版本控制）
- ✅ **Libraries/** 中的所有 `.pro` 文件
- ✅ **Playlists/** 中的所有播放列表文件
- ✅ **Themes/** 中的主题文件
- ✅ **Configuration/** 中的配置文件
- ✅ 所有脚本和文档文件

### 需要手动管理的文件（不上传）
- ⚠️ **Media/** 中的所有媒体文件
- ⚠️ **background music/** 中的音频文件
- ⚠️ **logo/** 中的图片文件
- ⚠️ **Doc Sync/** 中的文档文件

## 🔧 工具脚本

- `setup-new-computer.sh` - 新电脑自动设置
- `test-config.sh` - 配置验证和测试
- `verify-setup.sh` - 设置完整性检查

## 📖 详细文档

- [新电脑设置指南](NEW_COMPUTER_SETUP.md) - 完整的新电脑设置流程
- [工作流改进方案](ProPresenter%20制作工作流现状与改进方案.md) - 项目工作流程说明

## ⚠️ 重要提醒

### 媒体文件管理
由于媒体文件较大，不上传到 GitHub，需要：
1. **手动复制**：从其他电脑或备份中复制媒体文件
2. **云存储**：使用 Dropbox、Google Drive 等云存储服务
3. **定期备份**：确保媒体文件有备份

### 协作规范
1. **避免冲突**：不要同时编辑同一文件
2. **描述性提交**：清楚说明每次更改的内容
3. **定期同步**：经常拉取和推送更改

## 🆘 故障排除

### 常见问题

**Q: 媒体文件丢失怎么办？**
A: 从其他电脑或云存储备份中复制媒体文件到相应文件夹。

**Q: Git 操作出错怎么办？**
A: 运行 `./test-config.sh` 检查配置，或查看 [设置指南](NEW_COMPUTER_SETUP.md)。

**Q: 文件冲突怎么解决？**
A: 使用 `git status` 查看冲突，手动解决后重新提交。

## 📞 获取帮助

- 运行诊断脚本：`./test-config.sh`
- 查看详细文档：[新电脑设置指南](NEW_COMPUTER_SETUP.md)
- 联系管理员：jonathanjing@graceirvine.org

## 🎉 开始使用

设置完成后，您就可以：
- ✅ 在本地编辑 ProPresenter 文件
- ✅ 通过 Git 进行版本控制
- ✅ 与团队成员协作
- ✅ 安全备份所有重要文件

**祝您使用愉快！** 🎵
