# ProPresenter Version Control & Google Drive Sync

This project provides version control for ProPresenter workspaces with Google Drive synchronization for media files.

## Features

- **Version Control**: Track changes to ProPresenter configurations, themes, and playlists
- **Git LFS**: Large file storage for media files, libraries, and presentations
- **Google Drive Sync**: Automatic synchronization of Media folder with Google Drive
- **Selective Tracking**: Only track essential files, exclude large media files from Git

## Project Structure

```
ProPresenter/
├── .gitignore              # Git ignore rules
├── .gitattributes          # Git LFS configuration
├── setup-media-sync.sh     # Setup script for Google Drive sync
├── README.md               # This file
├── Configuration/          # ProPresenter configuration files (tracked)
├── Libraries/              # ProPresenter libraries (tracked via Git LFS)
├── Media/                  # Media files (synced to Google Drive)
├── Playlists/              # Playlist files (tracked via Git LFS)
├── Themes/                 # Theme files (tracked via Git LFS)
├── background music/       # Background music (tracked via Git LFS)
├── logo/                   # Logo files (tracked via Git LFS)
└── Doc Sync/              # Document sync files (tracked via Git LFS)
```

## Setup Instructions

### Prerequisites

1. **Git LFS**: Install Git Large File Storage
   ```bash
   # macOS with Homebrew
   brew install git-lfs
   
   # Or download from: https://git-lfs.github.com/
   ```

2. **Google Drive**: Ensure Google Drive is installed and syncing to:
   ```
   /Users/jonathan_jing/Library/CloudStorage/GoogleDrive-jonathanjing@graceirvine.org/Shared drives/ProPresenter Sync/
   ```

### Initial Setup

#### For New Computers (First Time Setup)

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd ProPresenter
   ```

2. **Run the new computer setup script**:
   ```bash
   chmod +x setup-new-computer.sh
   ./setup-new-computer.sh
   ```

3. **Verify the setup**:
   ```bash
   ./test-config.sh
   ```

#### For Existing Setup

1. **Run the media sync setup script**:
   ```bash
   ./setup-media-sync.sh
   ```

2. **Commit the changes**:
   ```bash
   git add .
   git commit -m "Setup media sync with Google Drive"
   git push
   ```

## How It Works

### Git LFS Configuration

The `.gitattributes` file configures Git LFS to track:
- **Media files**: Videos, audio, images in the Media folder
- **ProPresenter files**: `.pro` files in Libraries and Playlists
- **Background music**: Audio files in the background music folder
- **Logo files**: Images in the logo folder
- **Theme files**: Theme assets and configurations

### Google Drive Synchronization

The Media folder is symbolically linked to:
```
/Users/jonathan_jing/Library/CloudStorage/GoogleDrive-jonathanjing@graceirvine.org/Shared drives/ProPresenter Sync/Media
```

This means:
- Files added to the Media folder are automatically synced to Google Drive
- Multiple users can access the same media files through Google Drive
- Git LFS handles version control of the media files

### File Tracking Strategy

| File Type | Git Tracking | Google Drive Sync | Purpose |
|-----------|--------------|-------------------|---------|
| Configuration files | ✅ Tracked | ❌ No | ProPresenter settings |
| Media files | ✅ Git LFS | ✅ Synced | Videos, images, audio |
| Library files (.pro) | ✅ Git LFS | ❌ No | Presentations and slides |
| Playlist files | ✅ Git LFS | ❌ No | Playlist configurations |
| Theme files | ✅ Git LFS | ❌ No | Visual themes |
| Background music | ✅ Git LFS | ❌ No | Background audio |
| Logo files | ✅ Git LFS | ❌ No | Branding assets |

**重要说明：**
- **`.pro`文件会被上传到GitHub**：这些是ProPresenter的核心文件，包含演示文稿内容
- **使用Git LFS管理**：由于文件较大，使用Git LFS进行高效存储
- **版本控制价值**：可以跟踪修改历史，回滚到之前的版本
- **团队协作**：多人可以查看和协作编辑演示文稿

## Usage

### Adding New Media Files

1. **Add files to Media folder**:
   ```bash
   cp /path/to/new/video.mp4 Media/
   ```

2. **Files are automatically**:
   - Synced to Google Drive
   - Tracked by Git LFS
   - Available for version control

### Committing Changes

```bash
# Add all changes
git add .

# Commit with descriptive message
git commit -m "Add new worship video and update playlist"

# Push to remote repository
git push
```

### Working with Large Files

Git LFS automatically handles large files:
- Files are stored in Git LFS storage
- Only pointers are stored in the Git repository
- Large files are downloaded on-demand when cloning

## Troubleshooting

### Media Folder Not Syncing

1. **Check Google Drive sync status**:
   - Open Google Drive app
   - Ensure the "ProPresenter Sync" folder is syncing

2. **Verify symlink**:
   ```bash
   ls -la Media
   # Should show: Media -> /Users/jonathan_jing/Library/CloudStorage/GoogleDrive-jonathanjing@graceirvine.org/Shared drives/ProPresenter Sync/Media
   ```

3. **Recreate symlink if needed**:
   ```bash
   rm Media
   ln -s "/Users/jonathan_jing/Library/CloudStorage/GoogleDrive-jonathanjing@graceirvine.org/Shared drives/ProPresenter Sync/Media" Media
   ```

### Git LFS Issues

1. **Check Git LFS installation**:
   ```bash
   git lfs version
   ```

2. **Reinitialize Git LFS**:
   ```bash
   git lfs install
   ```

3. **Track files manually**:
   ```bash
   git lfs track "*.mp4"
   git add .gitattributes
   ```

### Large Repository Size

If the repository becomes too large:

1. **Check LFS tracking**:
   ```bash
   git lfs ls-files
   ```

2. **Clean up old files**:
   ```bash
   git lfs prune
   ```

## Best Practices

1. **Regular commits**: Commit changes frequently with descriptive messages
2. **File organization**: Keep media files organized in appropriate subfolders
3. **Backup**: Regularly backup the Google Drive folder
4. **Collaboration**: Coordinate with team members when making major changes
5. **File naming**: Use descriptive, consistent file names

## Support

For issues or questions:
1. Check the troubleshooting section above
2. Review Git LFS documentation: https://git-lfs.github.com/
3. Contact the project maintainer

## License

This project is for internal use by Grace Irvine Church.

