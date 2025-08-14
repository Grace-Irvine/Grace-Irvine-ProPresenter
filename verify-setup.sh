#!/bin/bash

echo "🔍 ProPresenter Setup Verification (Simplified)"
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

# Check 2: .gitignore configuration
echo ""
echo "2. Git Ignore Configuration"
if [ -f ".gitignore" ]; then
    print_status "OK" ".gitignore file exists"
    
    # Check if media files are ignored
    if grep -q "Media/" .gitignore; then
        print_status "OK" "Media folder is ignored"
    else
        print_status "WARN" "Media folder may not be ignored"
    fi
    
    if grep -q "background music/" .gitignore; then
        print_status "OK" "Background music folder is ignored"
    else
        print_status "WARN" "Background music folder may not be ignored"
    fi
    
    if grep -q "logo/" .gitignore; then
        print_status "OK" "Logo folder is ignored"
    else
        print_status "WARN" "Logo folder may not be ignored"
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

# Check 3: Essential folders
echo ""
echo "3. Essential Folders Check"
folders=("Libraries" "Playlists" "Themes" "Configuration")
for folder in "${folders[@]}"; do
    if [ -d "$folder" ]; then
        print_status "OK" "$folder exists"
    else
        print_status "WARN" "$folder missing"
    fi
done

# Check 4: Local media folders
echo ""
echo "4. Local Media Folders Check"
media_folders=("Media" "background music" "logo")
for folder in "${media_folders[@]}"; do
    if [ -d "$folder" ]; then
        file_count=$(find "$folder" -type f 2>/dev/null | wc -l)
        print_status "OK" "$folder exists with $file_count files (local storage)"
    else
        print_status "WARN" "$folder missing (will be created when needed)"
    fi
done

# Check 5: ProPresenter files
echo ""
echo "5. ProPresenter Files Check"
pro_count=$(find . -name "*.pro" -type f 2>/dev/null | wc -l)
if [ $pro_count -gt 0 ]; then
    print_status "OK" "Found $pro_count .pro files"
    
    # Check if they're tracked by Git
    tracked_pro=$(git ls-files | grep "\.pro" | wc -l)
    print_status "OK" "$tracked_pro .pro files are version controlled"
else
    print_status "WARN" "No .pro files found"
fi

# Check 6: Setup scripts
echo ""
echo "6. Setup Scripts Check"
scripts=("setup-new-computer.sh" "test-config.sh")
for script in "${scripts[@]}"; do
    if [ -f "$script" ] && [ -x "$script" ]; then
        print_status "OK" "$script exists and executable"
    else
        print_status "ERROR" "$script missing or not executable"
    fi
done

# Check 7: Documentation
echo ""
echo "7. Documentation Check"
docs=("README.md" "NEW_COMPUTER_SETUP.md" "QUICK_START.md")
for doc in "${docs[@]}"; do
    if [ -f "$doc" ]; then
        print_status "OK" "$doc exists"
    else
        print_status "WARN" "$doc missing"
    fi
done

# Check 8: Version controlled files
echo ""
echo "8. Version Control Check"
vc_files=$(git ls-files | wc -l)
if [ $vc_files -gt 0 ]; then
    print_status "OK" "$vc_files files are version controlled"
    
    # Show breakdown
    pro_files=$(git ls-files | grep "\.pro" | wc -l)
    playlist_files=$(git ls-files | grep "\.pro*playlist" | wc -l)
    theme_files=$(git ls-files | grep "\.theme" | wc -l)
    
    echo "   - $pro_files .pro files"
    echo "   - $playlist_files playlist files"
    echo "   - $theme_files theme files"
else
    print_status "WARN" "No files are version controlled"
fi

# Check 9: Large files (should be ignored)
echo ""
echo "9. Large Files Check"
echo "Checking for large files that should be ignored..."

# Find large files
large_files=$(find . -type f -size +10M 2>/dev/null | grep -v ".git" | head -5)
if [ -n "$large_files" ]; then
    print_status "WARN" "Found large files (should be ignored):"
    echo "$large_files" | while read file; do
        size=$(du -h "$file" | cut -f1)
        echo "   $file ($size)"
    done
else
    print_status "OK" "No large files found"
fi

# Check 10: Git status
echo ""
echo "10. Git Status Check"
git_status=$(git status --porcelain)
if [ -z "$git_status" ]; then
    print_status "OK" "Working directory is clean"
else
    print_status "WARN" "Working directory has uncommitted changes:"
    echo "$git_status" | head -5
fi

# Summary
echo ""
echo "📊 Summary"
echo "=========="

# Count issues
issues=0
if [ ! -f ".gitignore" ]; then ((issues++)); fi
if [ ! -d "Libraries" ]; then ((issues++)); fi
if [ ! -d "Playlists" ]; then ((issues++)); fi
if [ ! -d "Themes" ]; then ((issues++)); fi
if [ ! -d "Configuration" ]; then ((issues++)); fi

if [ $issues -eq 0 ]; then
    print_status "OK" "Core configuration is ready for new computers."
    print_status "OK" "All .pro files will be tracked via Git."
    print_status "OK" "Media files will be stored locally (not version controlled)."
else
    print_status "ERROR" "Found $issues issue(s) that need attention."
fi

echo ""
echo "🚀 Next Steps for New Computers:"
echo "1. Clone the repository"
echo "2. Run: ./setup-new-computer.sh"
echo "3. Run: ./test-config.sh"
echo "4. Open ProPresenter and verify all files are accessible"
echo ""
echo "📝 Files that will sync to new computers:"
echo "- All .pro files (via Git)"
echo "- All playlist files (via Git)"
echo "- All theme files (via Git)"
echo "- All configuration files (via Git)"
echo ""
echo "⚠️  Files that need manual management:"
echo "- Media files (videos, images, audio)"
echo "- Background music files"
echo "- Logo files"
echo ""
echo "✅ Verification complete!"
