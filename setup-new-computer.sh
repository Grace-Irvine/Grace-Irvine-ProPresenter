#!/bin/bash

# ProPresenter New Computer Setup Script
# This script sets up everything needed on a new computer after cloning the repository

set -e  # Exit on any error

echo "🚀 ProPresenter New Computer Setup"
echo "=================================="
echo "This script will set up everything needed for ProPresenter version control"
echo ""

# Configuration
PROJECT_ROOT="$(pwd)"
GOOGLE_DRIVE_BASE="/Users/$(whoami)/Library/CloudStorage/GoogleDrive-jonathanjing@graceirvine.org/Shared drives/ProPresenter Sync"
GOOGLE_DRIVE_MEDIA="$GOOGLE_DRIVE_BASE/Media"

echo "Project root: $PROJECT_ROOT"
echo "Google Drive base: $GOOGLE_DRIVE_BASE"
echo "Google Drive Media: $GOOGLE_DRIVE_MEDIA"
echo ""

# Step 1: Check prerequisites
echo "📋 Step 1: Checking prerequisites..."

# Check if Git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed. Please install Git first."
    exit 1
fi
echo "✅ Git is installed"

# Check if Git LFS is installed
if ! command -v git-lfs &> /dev/null; then
    echo "❌ Git LFS is not installed."
    echo "Installing Git LFS..."
    if command -v brew &> /dev/null; then
        brew install git-lfs
    else
        echo "Please install Git LFS manually: https://git-lfs.github.com/"
        exit 1
    fi
fi
echo "✅ Git LFS is installed"

# Check if this is a Git repository
if [ ! -d ".git" ]; then
    echo "❌ This is not a Git repository. Please clone the repository first."
    exit 1
fi
echo "✅ Git repository detected"

# Step 2: Initialize Git LFS
echo ""
echo "📋 Step 2: Initializing Git LFS..."
git lfs install
echo "✅ Git LFS initialized"

# Step 3: Check Google Drive setup
echo ""
echo "📋 Step 3: Setting up Google Drive synchronization..."

# Check if Google Drive folder exists
if [ ! -d "$GOOGLE_DRIVE_BASE" ]; then
    echo "⚠️  Google Drive folder not found at: $GOOGLE_DRIVE_BASE"
    echo "Creating Google Drive folder structure..."
    mkdir -p "$GOOGLE_DRIVE_BASE"
    echo "✅ Created Google Drive base folder"
fi

# Create Media folder in Google Drive
if [ ! -d "$GOOGLE_DRIVE_MEDIA" ]; then
    echo "Creating Media folder in Google Drive..."
    mkdir -p "$GOOGLE_DRIVE_MEDIA"
    echo "✅ Created Google Drive Media folder"
fi

# Step 4: Setup Media folder symlink
echo ""
echo "📋 Step 4: Setting up Media folder symlink..."

# Backup existing Media folder if it exists and is not a symlink
if [ -d "Media" ] && [ ! -L "Media" ]; then
    echo "Backing up existing Media folder..."
    mv Media "Media.backup.$(date +%Y%m%d_%H%M%S)"
    echo "✅ Media folder backed up"
fi

# Remove existing symlink if it exists
if [ -L "Media" ]; then
    echo "Removing existing Media symlink..."
    rm Media
fi

# Create symlink
echo "Creating symlink from Media folder to Google Drive..."
ln -s "$GOOGLE_DRIVE_MEDIA" Media

# Verify symlink
if [ -L "Media" ]; then
    echo "✅ Media folder symlink created successfully"
    echo "   Points to: $(readlink Media)"
else
    echo "❌ Failed to create Media folder symlink"
    exit 1
fi

# Step 5: Pull Git LFS files
echo ""
echo "📋 Step 5: Downloading Git LFS files..."
echo "This may take a while depending on the size of your files..."

# Pull all LFS files
git lfs pull --include="*" --exclude=""

# Check LFS status
echo ""
echo "Git LFS files status:"
git lfs ls-files | wc -l | xargs echo "Total LFS files:"

# Step 6: Verify ProPresenter files
echo ""
echo "📋 Step 6: Verifying ProPresenter files..."

# Check for .pro files
pro_files=$(find . -name "*.pro" -type f | wc -l)
echo "Found $pro_files .pro files"

# Check for Libraries
if [ -d "Libraries" ]; then
    lib_files=$(find Libraries -name "*.pro" -type f | wc -l)
    echo "Found $lib_files .pro files in Libraries folder"
else
    echo "⚠️  Libraries folder not found"
fi

# Check for Playlists
if [ -d "Playlists" ]; then
    playlist_files=$(find Playlists -name "*.pro*playlist" -type f | wc -l)
    echo "Found $playlist_files playlist files"
else
    echo "⚠️  Playlists folder not found"
fi

# Step 7: Check Media files
echo ""
echo "📋 Step 7: Checking Media files..."

# Check Media folder
if [ -L "Media" ]; then
    media_target=$(readlink Media)
    if [ -d "$media_target" ]; then
        media_files=$(find "$media_target" -type f \( -name "*.mp4" -o -name "*.mov" -o -name "*.mp3" -o -name "*.wav" -o -name "*.jpg" -o -name "*.png" \) | wc -l)
        echo "Found $media_files media files in Google Drive Media folder"
    else
        echo "⚠️  Google Drive Media folder is empty or not accessible"
    fi
else
    echo "❌ Media folder is not properly linked"
fi

# Step 8: Create ProPresenter workspace file
echo ""
echo "📋 Step 8: Creating ProPresenter workspace configuration..."

# Create a workspace file that ProPresenter can recognize
cat > "ProPresenter.workspace" << EOF
# ProPresenter Workspace Configuration
# Generated on $(date)
# 
# This workspace is configured for version control with Git LFS
# Media files are synced via Google Drive
# 
# Folders:
# - Libraries/: ProPresenter library files (.pro)
# - Media/: Media files (synced to Google Drive)
# - Playlists/: Playlist files
# - Themes/: Theme files
# - Configuration/: ProPresenter configuration
# - background music/: Background music files
# - logo/: Logo and branding files
# 
# Setup completed: $(date)
EOF

echo "✅ Created ProPresenter.workspace file"

# Step 9: Final verification
echo ""
echo "📋 Step 9: Final verification..."

# Check if all key folders exist
folders=("Libraries" "Media" "Playlists" "Themes" "Configuration" "background music" "logo")
for folder in "${folders[@]}"; do
    if [ -e "$folder" ]; then
        echo "✅ $folder exists"
    else
        echo "⚠️  $folder missing"
    fi
done

# Check Git status
echo ""
echo "Git repository status:"
git status --porcelain | head -10

echo ""
echo "🎉 Setup complete!"
echo ""
echo "📝 Summary:"
echo "- Git LFS is configured and initialized"
echo "- Media folder is linked to Google Drive"
echo "- All .pro files are tracked for version control"
echo "- Media files are synced via Google Drive"
echo ""
echo "🚀 Next steps:"
echo "1. Open ProPresenter and load this workspace"
echo "2. Verify that all your files are accessible"
echo "3. Test adding new media files to the Media folder"
echo "4. Make sure Google Drive is syncing properly"
echo ""
echo "💡 Tips:"
echo "- Run './test-config.sh' to verify the setup anytime"
echo "- Use 'git lfs pull' to download LFS files if needed"
echo "- Check Google Drive sync status in the Google Drive app"
echo ""
echo "✅ Your ProPresenter workspace is now ready for version control!"
