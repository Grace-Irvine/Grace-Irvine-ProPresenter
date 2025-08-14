#!/bin/bash

# ProPresenter Configuration Test Script
# Simplified version - Pure Git workflow

set -e  # Exit on any error

echo "🔍 ProPresenter Configuration Test"
echo "=================================="
echo "Testing simplified Git workflow setup"
echo ""

# Configuration
PROJECT_ROOT="$(pwd)"

echo "Project root: $PROJECT_ROOT"
echo ""

# Test 1: Git repository
echo "📋 Test 1: Git repository..."
if [ -d ".git" ]; then
    echo "✅ Git repository found"
    
    # Check Git status
    git_status=$(git status --porcelain)
    if [ -z "$git_status" ]; then
        echo "✅ Working directory is clean"
    else
        echo "⚠️  Working directory has changes:"
        echo "$git_status" | head -5
    fi
    
    # Check current branch
    current_branch=$(git branch --show-current)
    echo "✅ Current branch: $current_branch"
else
    echo "❌ Git repository not found"
    exit 1
fi

# Test 2: ProPresenter files
echo ""
echo "📋 Test 2: ProPresenter files..."

# Check Libraries folder
if [ -d "Libraries" ]; then
    pro_files=$(find Libraries -name "*.pro" -type f | wc -l)
    echo "✅ Libraries folder found with $pro_files .pro files"
    
    # Show some examples
    echo "   Examples:"
    find Libraries -name "*.pro" -type f | head -3 | while read file; do
        echo "   - $(basename "$file")"
    done
else
    echo "❌ Libraries folder not found"
fi

# Check Playlists folder
if [ -d "Playlists" ]; then
    playlist_files=$(find Playlists -name "*.pro*playlist" -type f | wc -l)
    echo "✅ Playlists folder found with $playlist_files playlist files"
else
    echo "❌ Playlists folder not found"
fi

# Check Themes folder
if [ -d "Themes" ]; then
    theme_files=$(find Themes -name "*.theme" -type f | wc -l)
    echo "✅ Themes folder found with $theme_files theme files"
else
    echo "❌ Themes folder not found"
fi

# Check Configuration folder
if [ -d "Configuration" ]; then
    config_files=$(find Configuration -type f | wc -l)
    echo "✅ Configuration folder found with $config_files files"
else
    echo "❌ Configuration folder not found"
fi

# Test 3: Media folders (local only)
echo ""
echo "📋 Test 3: Media folders (local storage)..."

# Check Media folder
if [ -d "Media" ]; then
    media_files=$(find Media -type f | wc -l)
    echo "✅ Media folder found with $media_files files"
    echo "   Note: Media files are stored locally, not version controlled"
else
    echo "⚠️  Media folder not found (will be created when needed)"
fi

# Check background music folder
if [ -d "background music" ]; then
    bg_music_files=$(find "background music" -type f | wc -l)
    echo "✅ background music folder found with $bg_music_files files"
    echo "   Note: Background music files are stored locally, not version controlled"
else
    echo "⚠️  background music folder not found (will be created when needed)"
fi

# Check logo folder
if [ -d "logo" ]; then
    logo_files=$(find logo -type f | wc -l)
    echo "✅ logo folder found with $logo_files files"
    echo "   Note: Logo files are stored locally, not version controlled"
else
    echo "⚠️  logo folder not found (will be created when needed)"
fi

# Test 4: Git ignore patterns
echo ""
echo "📋 Test 4: Git ignore patterns..."

# Check if media files are properly ignored
if git check-ignore Media/ > /dev/null 2>&1; then
    echo "✅ Media folder is properly ignored by Git"
else
    echo "⚠️  Media folder is not ignored by Git"
fi

if git check-ignore "background music/" > /dev/null 2>&1; then
    echo "✅ background music folder is properly ignored by Git"
else
    echo "⚠️  background music folder is not ignored by Git"
fi

if git check-ignore logo/ > /dev/null 2>&1; then
    echo "✅ logo folder is properly ignored by Git"
else
    echo "⚠️  logo folder is not ignored by Git"
fi

# Test 5: File counts
echo ""
echo "📋 Test 5: File counts..."

# Count version controlled files
vc_files=$(git ls-files | wc -l)
echo "✅ Version controlled files: $vc_files"

# Count .pro files specifically
pro_files_total=$(git ls-files | grep "\.pro" | wc -l)
echo "✅ Version controlled .pro files: $pro_files_total"

# Test 6: Recent activity
echo ""
echo "📋 Test 6: Recent activity..."

# Check recent commits
recent_commits=$(git log --oneline -5)
echo "✅ Recent commits:"
echo "$recent_commits"

# Test 7: Remote status
echo ""
echo "📋 Test 7: Remote status..."

# Check if remote is configured
if git remote -v | grep -q origin; then
    echo "✅ Remote origin is configured"
    
    # Check if we can fetch from remote
    if git fetch --dry-run origin > /dev/null 2>&1; then
        echo "✅ Can connect to remote repository"
    else
        echo "⚠️  Cannot connect to remote repository"
    fi
else
    echo "❌ Remote origin is not configured"
fi

# Summary
echo ""
echo "🎯 Summary:"
echo "==========="

# Count issues
issues=0
if [ ! -d "Libraries" ]; then ((issues++)); fi
if [ ! -d "Playlists" ]; then ((issues++)); fi
if [ ! -d "Themes" ]; then ((issues++)); fi
if [ ! -d "Configuration" ]; then ((issues++)); fi

if [ $issues -eq 0 ]; then
    echo "✅ All tests passed! Your ProPresenter setup is working correctly."
    echo ""
    echo "📝 Next steps:"
    echo "1. Open ProPresenter and load this workspace"
    echo "2. Test opening some .pro files"
    echo "3. Copy media files to Media/, background music/, and logo/ folders as needed"
    echo "4. Start creating and editing your presentations"
else
    echo "⚠️  Found $issues issue(s) that need attention."
    echo ""
    echo "🔧 To fix issues:"
    echo "1. Run './setup-new-computer.sh' to reinitialize the setup"
    echo "2. Check that all required folders exist"
    echo "3. Ensure Git repository is properly configured"
fi

echo ""
echo "💡 Tips:"
echo "- Use 'git status' to check file changes"
echo "- Use 'git pull origin main' to get latest updates"
echo "- Use 'git add . && git commit -m \"description\"' to save changes"
echo "- Use 'git push origin main' to upload changes"
echo ""
echo "✅ Configuration test complete!"
