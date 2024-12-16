#!/bin/bash

PREFS_DIR="$HOME/.dotfiles/macos"

backup_domain() {
    local domain=$1
    local output_file=$2
    
    if defaults read "$domain" >/dev/null 2>&1; then
        defaults read "$domain" > "$output_file"
        echo "✓ Backed up $domain"
    else
        echo "ℹ Skipping $domain (not configured)"
    fi
}

backup_preferences() {
    echo "Backing up macOS system preferences..."
    
    mkdir -p "$PREFS_DIR"
    
    backup_domain "." "$PREFS_DIR/system_preferences.plist"
    backup_domain "com.apple.finder" "$PREFS_DIR/finder_preferences.plist"
    backup_domain "com.apple.dock" "$PREFS_DIR/dock_preferences.plist"
    backup_domain "com.apple.spaces" "$PREFS_DIR/mission_control_preferences.plist"
    
    echo "#!/bin/bash" > "$PREFS_DIR/setup.sh"
    echo "" >> "$PREFS_DIR/setup.sh"
    
    cat << 'EOF' >> "$PREFS_DIR/setup.sh"
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true
    defaults write com.apple.finder AppleShowAllFiles -bool true
    defaults write com.apple.finder _FXSortFoldersFirst -bool true
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
    defaults write NSGlobalDomain KeyRepeat -int 2
    defaults write NSGlobalDomain InitialKeyRepeat -int 15
EOF
    
    chmod +x "$PREFS_DIR/setup.sh"
    
    echo "Backup completed! Files saved to $PREFS_DIR"
}

restore_preferences() {
    echo "Restoring macOS system preferences..."
    
    if [ ! -d "$PREFS_DIR" ]; then
        echo "Error: Backup directory not found!"
        exit 1
    fi
    
    if [ -f "$PREFS_DIR/setup.sh" ]; then
        source "$PREFS_DIR/setup.sh"
        echo "✓ Applied system settings"
    fi
    
    for plist in "$PREFS_DIR"/*.plist; do
        if [ -f "$plist" ]; then
            domain=$(basename "$plist" | sed 's/_preferences.plist//')
            if [ "$domain" = "system" ]; then
                defaults import . "$plist"
            else
                defaults import "com.apple.$domain" "$plist"
            fi
            echo "✓ Restored $(basename "$plist")"
        fi
    done
    
    echo "Restarting affected services..."
    killall Finder >/dev/null 2>&1
    killall Dock >/dev/null 2>&1
    
    echo "Restore completed! You may need to logout or restart for all changes to take effect."
}

case "$1" in
    "backup")
        backup_preferences
        ;;
    "restore")
        restore_preferences
        ;;
    *)
        echo "Usage: $0 {backup|restore}"
        exit 1
        ;;
esac

