#!/bin/bash

echo "🔍 Testing ProPresenter Version Control Configuration"
echo "=================================================="

# Test Git LFS installation
echo "1. Checking Git LFS installation..."
if git lfs version > /dev/null 2>&1; then
    echo "✅ Git LFS is installed"
    git lfs version | head -1
else
    echo "❌ Git LFS is not installed"
    echo "   Install with: brew install git-lfs"
    exit 1
fi

# Test Git LFS initialization
echo ""
echo "2. Checking Git LFS initialization..."
if git lfs install > /dev/null 2>&1; then
    echo "✅ Git LFS is initialized in this repository"
else
    echo "❌ Git LFS is not initialized"
    exit 1
fi

# Test .gitattributes configuration
echo ""
echo "3. Checking .gitattributes configuration..."
if [ -f ".gitattributes" ]; then
    echo "✅ .gitattributes file exists"
    
    # Check for key patterns
    if grep -q "Media/\*\*/\*\.mp4" .gitattributes; then
        echo "✅ Media files are configured for Git LFS"
    else
        echo "❌ Media files are not configured for Git LFS"
    fi
    
    if grep -q "Libraries/\*\*/\*\.pro\*" .gitattributes; then
        echo "✅ ProPresenter files are configured for Git LFS"
    else
        echo "❌ ProPresenter files are not configured for Git LFS"
    fi
else
    echo "❌ .gitattributes file does not exist"
    exit 1
fi

# Test Media folder symlink
echo ""
echo "4. Checking Media folder symlink..."
if [ -L "Media" ]; then
    echo "✅ Media folder is a symlink"
    echo "   Points to: $(readlink Media)"
    
    # Check if target exists
    if [ -d "$(readlink Media)" ]; then
        echo "✅ Google Drive Media folder exists"
    else
        echo "⚠️  Google Drive Media folder does not exist"
        echo "   Creating it..."
        mkdir -p "$(readlink Media)"
    fi
else
    echo "❌ Media folder is not a symlink"
    echo "   Run ./setup-media-sync.sh to create it"
fi

# Test .gitignore configuration
echo ""
echo "5. Checking .gitignore configuration..."
if [ -f ".gitignore" ]; then
    echo "✅ .gitignore file exists"
    
    # Check if .pro files are commented out (should be tracked)
    if grep -q "^# \*\.pro" .gitignore; then
        echo "✅ .pro files are configured for tracking (commented out in .gitignore)"
    else
        echo "⚠️  .pro files may not be properly configured"
    fi
else
    echo "❌ .gitignore file does not exist"
fi

# Test current Git status
echo ""
echo "6. Checking Git repository status..."
if git status > /dev/null 2>&1; then
    echo "✅ Git repository is initialized"
    
    # Check for untracked files
    untracked=$(git status --porcelain | grep "^??" | wc -l)
    if [ $untracked -gt 0 ]; then
        echo "⚠️  Found $untracked untracked files"
        echo "   Consider running: git add . && git commit -m 'Initial commit'"
    else
        echo "✅ No untracked files"
    fi
else
    echo "❌ Not a Git repository"
    echo "   Initialize with: git init"
fi

echo ""
echo "🎉 Configuration test complete!"
echo ""
echo "Next steps:"
echo "1. If Media symlink is missing, run: ./setup-media-sync.sh"
echo "2. Add files to Git: git add ."
echo "3. Commit changes: git commit -m 'Initial setup'"
echo "4. Push to remote: git push"
echo ""
echo "Your .pro files will be tracked by Git LFS and uploaded to GitHub!"
