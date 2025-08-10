#!/bin/bash

# ProPresenter Media Sync Setup Script
# This script sets up the Media folder to sync with Google Drive

# Configuration
PROJECT_ROOT="$(pwd)"
MEDIA_FOLDER="$PROJECT_ROOT/Media"
GOOGLE_DRIVE_MEDIA="/Users/jonathan_jing/Library/CloudStorage/GoogleDrive-jonathanjing@graceirvine.org/Shared drives/ProPresenter Sync/Media"

echo "Setting up ProPresenter Media synchronization with Google Drive..."
echo "Project root: $PROJECT_ROOT"
echo "Media folder: $MEDIA_FOLDER"
echo "Google Drive Media: $GOOGLE_DRIVE_MEDIA"

# Check if Google Drive path exists
if [ ! -d "$GOOGLE_DRIVE_MEDIA" ]; then
    echo "Creating Google Drive Media directory..."
    mkdir -p "$GOOGLE_DRIVE_MEDIA"
fi

# Backup existing Media folder if it exists and is not already a symlink
if [ -d "$MEDIA_FOLDER" ] && [ ! -L "$MEDIA_FOLDER" ]; then
    echo "Backing up existing Media folder..."
    mv "$MEDIA_FOLDER" "${MEDIA_FOLDER}.backup.$(date +%Y%m%d_%H%M%S)"
fi

# Remove existing symlink if it exists
if [ -L "$MEDIA_FOLDER" ]; then
    echo "Removing existing Media symlink..."
    rm "$MEDIA_FOLDER"
fi

# Create symlink from Media folder to Google Drive
echo "Creating symlink from Media folder to Google Drive..."
ln -s "$GOOGLE_DRIVE_MEDIA" "$MEDIA_FOLDER"

# Verify the symlink was created successfully
if [ -L "$MEDIA_FOLDER" ]; then
    echo "✅ Media folder symlink created successfully!"
    echo "Media folder now points to: $(readlink "$MEDIA_FOLDER")"
else
    echo "❌ Failed to create Media folder symlink"
    exit 1
fi

# Initialize Git LFS if not already initialized
if ! git lfs version > /dev/null 2>&1; then
    echo "Git LFS is not installed. Please install Git LFS first:"
    echo "  brew install git-lfs  # macOS with Homebrew"
    echo "  or visit: https://git-lfs.github.com/"
    exit 1
fi

# Initialize Git LFS in the repository
echo "Initializing Git LFS..."
git lfs install

# Track the media files with Git LFS
echo "Setting up Git LFS tracking for media files..."
git lfs track "Media/**/*.mp4"
git lfs track "Media/**/*.mov"
git lfs track "Media/**/*.avi"
git lfs track "Media/**/*.wmv"
git lfs track "Media/**/*.flv"
git lfs track "Media/**/*.mkv"
git lfs track "Media/**/*.m4v"
git lfs track "Media/**/*.3gp"
git lfs track "Media/**/*.webm"
git lfs track "Media/**/*.mp3"
git lfs track "Media/**/*.wav"
git lfs track "Media/**/*.aac"
git lfs track "Media/**/*.flac"
git lfs track "Media/**/*.ogg"
git lfs track "Media/**/*.wma"
git lfs track "Media/**/*.m4a"
git lfs track "Media/**/*.jpg"
git lfs track "Media/**/*.jpeg"
git lfs track "Media/**/*.png"
git lfs track "Media/**/*.gif"
git lfs track "Media/**/*.bmp"
git lfs track "Media/**/*.tiff"
git lfs track "Media/**/*.tga"
git lfs track "Media/**/*.psd"
git lfs track "Media/**/*.ai"
git lfs track "Media/**/*.eps"
git lfs track "Media/**/*.svg"
git lfs track "Media/**/*.pdf"

# Add .gitattributes to the repository
git add .gitattributes

echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Commit the changes: git add . && git commit -m 'Setup media sync with Google Drive'"
echo "2. Push to remote: git push"
echo "3. Make sure Google Drive is syncing the Media folder"
echo ""
echo "The Media folder is now synchronized with Google Drive at:"
echo "$GOOGLE_DRIVE_MEDIA"
echo ""
echo "Any files added to the Media folder will be automatically synced to Google Drive"
echo "and tracked by Git LFS for version control."
