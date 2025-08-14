#!/bin/bash

# ProPresenter New Computer Setup Script
# Simplified version - Pure Git workflow without LFS

set -e  # Exit on any error

echo "🚀 ProPresenter New Computer Setup (Simplified)"
echo "==============================================="
echo "This script sets up everything needed for ProPresenter version control"
echo "All files will be managed through GitHub (no LFS, no Google Drive)"
echo ""

# Configuration
PROJECT_ROOT="$(pwd)"

echo "Project root: $PROJECT_ROOT"
echo ""

# Step 1: Check prerequisites
echo "📋 Step 1: Checking prerequisites..."

# Check if Git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed. Please install Git first."
    exit 1
fi
echo "✅ Git is installed"

# Check if this is a Git repository
if [ ! -d ".git" ]; then
    echo "❌ This is not a Git repository. Please clone the repository first."
    exit 1
fi
echo "✅ Git repository detected"

# Step 2: Pull latest changes
echo ""
echo "📋 Step 2: Pulling latest changes from GitHub..."
git pull origin main
echo "✅ Latest changes pulled"

# Step 3: Verify ProPresenter files
echo ""
echo "📋 Step 3: Verifying ProPresenter files..."

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

# Step 4: Create local media folders
echo ""
echo "📋 Step 4: Creating local media folders..."

# Create Media folder if it doesn't exist
if [ ! -d "Media" ]; then
    echo "Creating Media folder..."
    mkdir -p Media
    echo "✅ Media folder created"
else
    echo "✅ Media folder already exists"
fi

# Create background music folder if it doesn't exist
if [ ! -d "background music" ]; then
    echo "Creating background music folder..."
    mkdir -p "background music"
    echo "✅ background music folder created"
else
    echo "✅ background music folder already exists"
fi

# Create logo folder if it doesn't exist
if [ ! -d "logo" ]; then
    echo "Creating logo folder..."
    mkdir -p "logo"
    echo "✅ logo folder created"
else
    echo "✅ logo folder already exists"
fi

# Step 5: Create ProPresenter workspace file
echo ""
echo "📋 Step 5: Creating ProPresenter workspace configuration..."

# Create a workspace file that ProPresenter can recognize
cat > "ProPresenter.workspace" << EOF
# ProPresenter Workspace Configuration
# Generated on $(date)
# 
# This workspace is configured for version control with Git
# Media files are stored locally and managed manually
# 
# Folders:
# - Libraries/: ProPresenter library files (.pro) - VERSION CONTROLLED
# - Media/: Media files (stored locally) - NOT VERSION CONTROLLED
# - Playlists/: Playlist files - VERSION CONTROLLED
# - Themes/: Theme files - VERSION CONTROLLED
# - Configuration/: ProPresenter configuration - VERSION CONTROLLED
# - background music/: Background music files (stored locally) - NOT VERSION CONTROLLED
# - logo/: Logo and branding files (stored locally) - NOT VERSION CONTROLLED
# 
# Setup completed: $(date)
# 
# IMPORTANT: Media files are NOT automatically synced
# You need to manually copy media files between computers
EOF

echo "✅ Created ProPresenter.workspace file"

# Step 6: Final verification
echo ""
echo "📋 Step 6: Final verification..."

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
echo "- Git repository is ready for version control"
echo "- All .pro files are tracked and synced via GitHub"
echo "- Media folders created locally (not version controlled)"
echo "- No LFS or Google Drive dependencies"
echo ""
echo "🚀 Next steps:"
echo "1. Open ProPresenter and load this workspace"
echo "2. Verify that all your .pro files are accessible"
echo "3. Manually copy media files to Media/, background music/, and logo/ folders"
echo "4. Test creating and editing .pro files"
echo ""
echo "💡 Tips:"
echo "- Run './test-config.sh' to verify the setup anytime"
echo "- Media files need to be manually copied between computers"
echo "- Only .pro files, playlists, themes, and configs are version controlled"
echo "- Use 'git status' to see what files are tracked"
echo ""
echo "⚠️  Important Notes:"
echo "- Media files (videos, images, audio) are NOT automatically synced"
echo "- You need to manually copy media files when setting up on new computers"
echo "- Consider using cloud storage (Dropbox, Google Drive) for media files"
echo ""
echo "✅ Your ProPresenter workspace is now ready for simplified version control!"
