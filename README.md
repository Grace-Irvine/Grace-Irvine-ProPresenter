# ProPresenter 版本控制工作区

## 🎯 项目简介

这是恩典尔湾教会 ProPresenter 版本控制项目，专为敬拜团队设计。通过 Git 和 GitHub Desktop 实现多人协作、版本管理和工作流优化，解决传统制作流程中的痛点问题。

### 现状痛点

- **信息分散**：证道题目、歌词、串词分散在多个平台（Google Sheet、微信群、Google Doc）
- **单点故障**：只能在播放电脑制作，物理交接成本高，容易误覆盖
- **时间压力**：证道标题通常周六晚才确定，制作集中在最后一晚
- **无法并行**：同工不能各自完成部分内容后合并
- **样式不一致**：跨机字体主题不统一，媒体路径混乱

### 改进成果

- ✅ **分支管理**：library 基础分支 + production/日期 制作分支
- ✅ **协作友好**：支持 GitHub Desktop 图形化操作
- ✅ **版本可控**：每周制作内容独立分支，可追溯回滚
- ✅ **流程规范**：明确的时间节点和责任分工

## 📁 文件结构

```
ProPresenter/
├── Libraries/           # ProPresenter 演示文稿文件 (.pro) - 版本控制
│   ├── Library/         # 基础库文件
│   ├── 事项/            # 崇拜流程事项（宣召、读经、证道等）
│   └── 敬拜歌曲/        # 诗歌库
├── Playlists/          # 播放列表文件 - 版本控制
├── Themes/             # 主题文件 - 版本控制
├── Configuration/      # ProPresenter 配置文件 - 版本控制
├── Media/              # 媒体文件 (视频、音频、图片) - 本地存储
├── background music/   # 背景音乐文件 - 本地存储
├── logo/               # Logo 和品牌文件 - 本地存储
└── Doc Sync/           # 文档同步文件夹 - 本地存储
```

## 🚀 新电脑设置流程

### 步骤 1：软件准备

1. **注册 GitHub 账号**

   - 访问 [github.com](https://github.com) 注册账号
   - 联系管理员 (jonathanjing@graceirvine.org) 获取项目访问权限
2. **安装必要软件**

   - 下载并安装 [GitHub Desktop](https://desktop.github.com/)
   - 下载并安装 [ProPresenter]() 
   - 在 GitHub Desktop 中登录您的 GitHub 账号

### 步骤 2：项目设置

1. **克隆项目到本地**

   - 在 GitHub Desktop 中：File → Clone Repository
   - 选择 ProPresenter 项目
   - 选择本地存储位置（推荐：`/Users/用户名/Documents/ProPresenter`）
2. **配置 ProPresenter**

   - 打开 ProPresenter
   - 进入 Preferences → Support Files
   - **重要**：将支持文件目录更改为 GitHub 本地文件夹路径
3. **验证设置**

   - 确认能访问 Libraries、Playlists、Themes 文件夹
   - 测试打开现有的 .pro 文件
   - 验证媒体文件夹结构正确

## 📋 分支命名规范

### 基础分支

- **`library`**：项目基础分支，包含所有基础库和配置文件
- **`backup/library`**：（备用主分支）

### 制作分支

- **`production/YYYY-MM-DD`**：每周制作分支
  - 示例：`production/2025-08-17`
  - 用途：当周主日内容制作

### 测试分支

- **`create/YYYY-MM-DD`**：创建测试分支

## 🎭 ProPresenter 命名规范

### 播放列表命名

- **制作阶段**：`YYYY-MM-DD_主日崇拜.proPlaylist`
- **特殊场合**：`YYYY-MM-DD_特别聚会名称.proPlaylist`

### 播放库命名

- **播放端库**：按日期命名，如 `2025-08-17_主日`
- **导入规则**：每周在 ProPresenter 中新建库，按日期命名后导入播放列表

### 库文件分类

- **事项库**：包含崇拜流程固定项目
  - 宣召、问安、诗歌敬拜、律法宣读、认罪悔改
  - 恩典领受、公祷、读经、证道、圣餐
  - 信仰告白、回应诗歌、奉献祷告、祝祷等
- **敬拜歌曲库**：包含所有诗歌文件
  - 按歌名命名：如 `奇异恩典.pro`、`十字架.pro`

## 📅 制作流程规范

### 角色分工

- **制作端**：负责内容编辑和播放列表制作
- **播放端**：负责现场播放准备和执行
- **协调人**：统筹时间节点和版本管理

### 每周制作时间线

- **周二**：开始制作，创建 `production/YYYY-MM-DD` 分支
- **周三-周五**：内容制作和调整
- **周六 21:00**：最终版本提交，内容冻结
- **主日上午**：播放端准备和现场检查

### GitHub Desktop 操作流程

#### 制作端操作

1. **同步最新内容**

   - 打开 GitHub Desktop
   - 选择 “library" Branch
   - 点击 "Fetch origin" 检查更新
   - 如有更新，点击 "Pull origin"
2. **创建制作分支**

   - 点击 "Current branch" → "New branch"
   - 命名：`production/YYYY-MM-DD`
   - 点击 "Create branch"
3. **内容制作**

   - 在 ProPresenter 中编辑事项库和敬拜歌曲库
   - 创建播放列表：`YYYY-MM-DD_主日崇拜`
   - 按敬拜顺序添加项目
4. **提交更改**

   - 在 GitHub Desktop 中查看修改文件
   - 在 Summary 框输入提交消息：`完成 YYYY-MM-DD 主日内容制作`
   - 点击 "Commit to production/YYYY-MM-DD"
   - 点击 "Push origin"

#### 播放端操作

1. **获取制作内容**

   - 在 GitHub Desktop 中切换到制作分支
   - 点击 "Fetch origin" → "Pull origin"
2. **创建播放库**

   - 在 ProPresenter 中新建 Library
   - 命名：`YYYY-MM-DD_主日`
   - 导入播放列表文件
3. **现场验证**（播放前 ≥10分钟）

   - [ ] 内容完整性检查
   - [ ] 文字内容确认无误
   - [ ] 背景素材显示正常
   - [ ] 应急预案准备

## 📐 文件管理策略

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

### 媒体文件管理建议

1. **云存储备份**：使用 Dropbox、Google Drive 等
2. **手动同步**：新电脑设置时从云存储复制媒体文件
3. **保持结构**：确保文件夹结构一致
4. **定期备份**：重要媒体文件定期备份

## 🔧 工具脚本

- 📖 [新电脑设置指南](NEW_COMPUTER_SETUP.md) - 完整的新电脑设置流程
- 📋 [GitHub Desktop 制作流程规范](ProPresenter_制作流程规范_GitHub_Desktop.md) - 详细操作指南
- 📊 [工作流改进方案](ProPresenter%20制作工作流现状与改进方案.md) - 项目工作流程说明

## 🚨 应急处理

### GitHub Desktop 常见问题

- **推送失败**：点击 "Fetch origin" 检查更新，解决冲突后重新推送
- **找不到文件**：确认在正确分支，执行 "Pull origin"
- **分支混乱**：截图状态，联系协调人协助

### ProPresenter 问题

- **播放列表导入失败**：检查文件完整性，重新下载或手动创建
- **媒体文件缺失**：使用默认背景，从备份恢复媒体文件

## ⚠️ 重要提醒

### 协作规范

1. **避免冲突**：不要同时编辑同一文件
2. **描述性提交**：清楚说明每次更改内容
3. **定期同步**：工作前后及时拉取和推送更改
4. **时间节点**：严格遵守周六 20:00 内容冻结政策

### 质量控制

- **制作端**：确保库文件更新、播放列表顺序正确、命名规范
- **播放端**：验证内容完整性、测试播放效果、准备应急方案
- **协调人**：监督时间节点、审核版本质量、协调团队沟通

## 📞 获取帮助

- **技术支持**：jonathanjing@graceirvine.org
- **项目文档**：参见项目内相关 .md 文件
- **GitHub Desktop 帮助**：https://docs.github.com/desktop
- **ProPresenter 文档**：https://renewedvision.com/support

## 🎉 开始使用

设置完成后，您就可以：

- ✅ 在本地编辑 ProPresenter 文件
- ✅ 通过 GitHub Desktop 进行版本控制
- ✅ 与团队成员协作制作内容
- ✅ 按日期管理每周制作分支
- ✅ 安全备份所有重要文件

**祝您使用愉快！** 🎵
