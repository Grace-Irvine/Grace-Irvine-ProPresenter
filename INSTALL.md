# ProPresenter 新电脑安装指南

## 快速安装步骤

### 1. 克隆仓库
```bash
git clone <your-repository-url>
cd ProPresenter
```

### 2. 运行自动安装脚本
```bash
chmod +x setup-new-computer.sh
./setup-new-computer.sh
```

### 3. 验证安装
```bash
./test-config.sh
```

## 手动安装步骤（如果自动脚本失败）

### 1. 安装 Git LFS
```bash
# macOS
brew install git-lfs

# 或从官网下载
# https://git-lfs.github.com/
```

### 2. 初始化 Git LFS
```bash
git lfs install
git lfs pull
```

### 3. 设置 Google Drive 同步
```bash
# 创建 Google Drive 文件夹
mkdir -p "/Users/$(whoami)/Library/CloudStorage/GoogleDrive-jonathanjing@graceirvine.org/Shared drives/ProPresenter Sync/Media"

# 创建 Media 文件夹链接
ln -s "/Users/$(whoami)/Library/CloudStorage/GoogleDrive-jonathanjing@graceirvine.org/Shared drives/ProPresenter Sync/Media" Media
```

### 4. 下载所有文件
```bash
git lfs pull --include="*" --exclude=""
```

## 验证清单

安装完成后，请确认：

- [ ] Git LFS 已安装并初始化
- [ ] Media 文件夹链接到 Google Drive
- [ ] 所有 .pro 文件都可以访问
- [ ] 媒体文件在 Google Drive 中同步
- [ ] ProPresenter 可以正常打开工作区

## 常见问题

### Q: Media 文件夹显示为空
A: 检查 Google Drive 同步状态，确保文件夹已同步

### Q: .pro 文件无法打开
A: 运行 `git lfs pull` 下载所有 LFS 文件

### Q: Google Drive 路径不存在
A: 确保 Google Drive 已安装并登录正确的账户

## 获取帮助

如果遇到问题，请运行：
```bash
./test-config.sh
```

这将显示详细的诊断信息。
