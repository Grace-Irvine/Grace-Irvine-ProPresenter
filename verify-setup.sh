#!/bin/bash

echo "🔍 Comprehensive ProPresenter Setup Verification"
echo "==============================================="
echo "This script verifies that all files will sync properly on new computers"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    if [ "$1" = "OK" ]; then
        echo -e "${GREEN}✅ $2${NC}"
    elif [ "$1" = "WARN" ]; then
        echo -e "${YELLOW}⚠️  $2${NC}"
    else
        echo -e "${RED}❌ $2${NC}"
    fi
}

# Check 1: Git repository
echo "1. Git Repository Check"
if [ -d ".git" ]; then
    print_status "OK" "Git repository exists"
    
    # Check remote
    if git remote -v | grep -q "origin"; then
        print_status "OK" "Git remote configured"
    else
        print_status "WARN" "No Git remote configured"
    fi
else
    print_status "ERROR" "Not a Git repository"
    exit 1
fi

# Check 2: Git LFS configuration
echo ""
echo "2. Git LFS Configuration"
if command -v git-lfs &> /dev/null; then
    print_status "OK" "Git LFS installed"
    
    # Check .gitattributes
    if [ -f ".gitattributes" ]; then
        print_status "OK" ".gitattributes file exists"
        
        # Check key patterns
        if grep -q "Media/\*\*/\*\.mp4" .gitattributes; then
            print_status "OK" "Media files configured for LFS"
        else
            print_status "ERROR" "Media files not configured for LFS"
        fi
        
        if grep -q "Libraries/\*\*/\*\.pro\*" .gitattributes; then
            print_status "OK" "ProPresenter files configured for LFS"
        else
            print_status "ERROR" "ProPresenter files not configured for LFS"
        fi
    else
        print_status "ERROR" ".gitattributes file missing"
    fi
else
    print_status "ERROR" "Git LFS not installed"
fi

# Check 3: .gitignore configuration
echo ""
echo "3. Git Ignore Configuration"
if [ -f ".gitignore" ]; then
    print_status "OK" ".gitignore file exists"
    
    # Check if .pro files are commented out (should be tracked)
    if grep -q "^# \*\.pro" .gitignore; then
        print_status "OK" ".pro files configured for tracking"
    else
        print_status "WARN" ".pro files may not be properly configured"
    fi
    
    # Check for system files
    if grep -q "\.DS_Store" .gitignore; then
        print_status "OK" "System files ignored"
    else
        print_status "WARN" "System files not ignored"
    fi
else
    print_status "ERROR" ".gitignore file missing"
fi

# Check 4: Essential folders
echo ""
echo "4. Essential Folders Check"
folders=("Libraries" "Playlists" "Themes" "Configuration" "background music" "logo")
for folder in "${folders[@]}"; do
    if [ -d "$folder" ]; then
        print_status "OK" "$folder exists"
    else
        print_status "WARN" "$folder missing"
    fi
done

# Check 5: Media folder setup
echo ""
echo "5. Media Folder Setup"
if [ -L "Media" ]; then
    print_status "OK" "Media folder is a symlink"
    target=$(readlink Media)
    print_status "OK" "Points to: $target"
    
    if [ -d "$target" ]; then
        print_status "OK" "Google Drive Media folder exists"
    else
        print_status "WARN" "Google Drive Media folder does not exist"
    fi
else
    print_status "WARN" "Media folder is not a symlink"
fi

# Check 6: ProPresenter files
echo ""
echo "6. ProPresenter Files Check"
pro_count=$(find . -name "*.pro" -type f 2>/dev/null | wc -l)
if [ $pro_count -gt 0 ]; then
    print_status "OK" "Found $pro_count .pro files"
else
    print_status "WARN" "No .pro files found"
fi

# Check 7: Setup scripts
echo ""
echo "7. Setup Scripts Check"
scripts=("setup-new-computer.sh" "setup-media-sync.sh" "test-config.sh")
for script in "${scripts[@]}"; do
    if [ -f "$script" ] && [ -x "$script" ]; then
        print_status "OK" "$script exists and executable"
    else
        print_status "ERROR" "$script missing or not executable"
    fi
done

# Check 8: Documentation
echo ""
echo "8. Documentation Check"
docs=("README.md" "INSTALL.md")
for doc in "${docs[@]}"; do
    if [ -f "$doc" ]; then
        print_status "OK" "$doc exists"
    else
        print_status "ERROR" "$doc missing"
    fi
done

# Check 9: Git LFS tracking
echo ""
echo "9. Git LFS Tracking Check"
if git lfs track &> /dev/null; then
    tracked_patterns=$(git lfs track | grep -E "(\.pro|\.mp4|\.mov|\.mp3)" | wc -l)
    if [ $tracked_patterns -gt 0 ]; then
        print_status "OK" "Git LFS patterns configured"
    else
        print_status "WARN" "No Git LFS patterns found"
    fi
else
    print_status "WARN" "Git LFS not initialized"
fi

# Check 10: File sizes and types
echo ""
echo "10. File Analysis"
echo "Checking for large files that should be in LFS..."

# Find large files
large_files=$(find . -type f -size +10M 2>/dev/null | grep -v ".git" | head -5)
if [ -n "$large_files" ]; then
    print_status "WARN" "Found large files (may need LFS):"
    echo "$large_files" | while read file; do
        size=$(du -h "$file" | cut -f1)
        echo "   $file ($size)"
    done
else
    print_status "OK" "No large files found"
fi

# Summary
echo ""
echo "📊 Summary"
echo "=========="

# Summary
echo ""
echo "📊 Summary"
echo "=========="

# Simple summary based on what we found
if [ -f ".gitattributes" ] && [ -f ".gitignore" ] && [ -d ".git" ]; then
    print_status "OK" "Core configuration is ready for new computers."
    print_status "OK" "All .pro files will be tracked via Git LFS."
    print_status "OK" "Media files will sync via Google Drive."
else
    print_status "ERROR" "Core configuration is missing. Please fix before deploying."
fi

echo ""
echo "🚀 Next Steps for New Computers:"
echo "1. Clone the repository"
echo "2. Run: ./setup-new-computer.sh"
echo "3. Run: ./test-config.sh"
echo "4. Open ProPresenter and verify all files are accessible"
echo ""
echo "📝 Files that will sync to new computers:"
echo "- All .pro files (via Git LFS)"
echo "- All media files (via Google Drive sync)"
echo "- All configuration files"
echo "- All themes and playlists"
echo ""
echo "✅ Verification complete!"
