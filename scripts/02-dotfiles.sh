# This script will symlink the dotfiles from the `.dotfiles/home` directory to `~` using
# GNU Stow.
# If any dotfiles exist already in `~` and differ from the source files, they will be
# archived to a timestamped tarball inside `~/.archived_dotfiles` before creating the
# symlinks.

# Check if stow is installed
if ! command -v stow >/dev/null 2>&1; then
    echo "❌ GNU Stow is not installed. Please install it before running this script."
    return 1
fi

DOTFILES_SOURCE_DIR="$DOTFILES_DIR/home"
DOTFILES_TARGET_DIR="$HOME"
ARCHIVE_DIR="$HOME/.archived_dotfiles"
TMP_ARCHIVE_DIR="$(mktemp -d)"

# Find all files in DOTFILES_SOURCE_DIR
find "$DOTFILES_SOURCE_DIR" -type f | while read -r src_file; do
    rel_path="${src_file#$DOTFILES_SOURCE_DIR/}"
    tgt_file="$DOTFILES_TARGET_DIR/$rel_path"
    tgt_dir="$(dirname "$tgt_file")"

    mkdir -p "$tgt_dir"

    if [ -e "$tgt_file" ] && ! cmp -s "$src_file" "$tgt_file"; then
        echo "  🗄️ Archiving $tgt_file"
        mkdir -p "$TMP_ARCHIVE_DIR/$(dirname "$rel_path")"
        mv "$tgt_file" "$TMP_ARCHIVE_DIR/$rel_path"
    fi
done

# Only create archive if there are files to archive
if [ "$(ls -A "$TMP_ARCHIVE_DIR")" ]; then
    mkdir -p "$ARCHIVE_DIR"
    archive_name="dotfiles-archive-$(date +%Y%m%d-%H%M%S).tar.gz"
    tar -czf "$ARCHIVE_DIR/$archive_name" -C "$TMP_ARCHIVE_DIR" .
    echo "  📦 Archived old dotfiles to $ARCHIVE_DIR/$archive_name"
fi

rm -rf "$TMP_ARCHIVE_DIR"

# Symlink the dotfiles using GNU Stow
stow -d "$DOTFILES_DIR" -t "$DOTFILES_TARGET_DIR" home
