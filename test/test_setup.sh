
echo "🔍 Running dotfiles integration tests..."

# Force load .bashrc/.zshrc
current_shell=$(ps -p $$ -o comm=)
case "$current_shell" in
  bash)
    source "$HOME/.bashrc"
    ;;
  zsh)
    source "$HOME/.zshrc"
    ;;
  *)
    echo "⚠️ Unknown shell '$current_shell' — not sourcing any rc file"
    ;;
esac

failures=0

fail() {
  echo "❌ $1"
  failures=$((failures + 1))
}

pass() {
  echo "✅ $1"
}

# 1. oh-my-zsh
if [ -d "$HOME/.oh-my-zsh" ]; then
  pass "oh-my-zsh directory found"
else
  fail "oh-my-zsh directory not found in \$HOME"
fi

# 2. oh-my-posh
if command -v oh-my-posh >/dev/null 2>&1; then
  pass "oh-my-posh is in PATH"
else
  fail "oh-my-posh command not found"
fi

# 3. JetBrainsMono Nerd Font
if fc-list | grep -qi "JetBrainsMono Nerd Font"; then
  pass "JetBrainsMono Nerd Font is installed"
else
  fail "JetBrainsMono Nerd Font not found (fc-list)"
fi

# 4. Papirus icons
if [ -d "$HOME/.icons/Papirus" ]; then
  pass "Papirus icons found in ~/.icons"
else
  fail "Papirus icons not found in ~/.icons"
fi

# 5. ipy function will run ipython with uv with an extra package
# Create a temporary Python script to test the `ipy` call
TMPFILE="$(mktemp)"
cat > "$TMPFILE" <<'EOF'
from icecream import ic
ic('ok')
exit()
EOF
# Run ipy in a subprocess, feeding in the script and capturing output
OUTPUT=$(echo "run $TMPFILE" | ipy --with icecream 2>&1)
EXIT_CODE=$?
# Clean up the temporary file
rm -f "$TMPFILE"
# Check the exit code and output
if [ $EXIT_CODE -ne 0 ]; then
  fail "'ipy --with icecream' failed to run"
elif echo "$OUTPUT" | grep -q "ic| 'ok'"; then
  pass "'ipy --with icecream' runs and has access to icecream"
else
  fail "'ipy --with icecream' did not print output from icecream"
fi

# Final summary
if [ "$failures" -eq 0 ]; then
  echo "🎉 All dotfiles integration tests passed!"
  exit 0
else
  echo "❌ $failures test(s) failed."
  exit 1
fi
