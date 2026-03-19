#!/usr/bin/env bash
# Claude Code 設定セットアップスクリプト
# 別PCでこのスクリプトを実行すると ~/.claude/ に設定が反映されます

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "================================================"
echo " Claude Code 設定セットアップ"
echo "================================================"

# --- 1. Claude Code のインストール確認 ---
if ! command -v claude &>/dev/null; then
  echo ""
  echo "[1/4] Claude Code が未インストールです。インストールします..."
  if command -v npm &>/dev/null; then
    npm install -g @anthropic-ai/claude-code
  else
    echo "ERROR: npm が見つかりません。Node.js をインストールしてから再実行してください。"
    echo "  Homebrew: brew install node"
    echo "  公式サイト: https://nodejs.org/"
    exit 1
  fi
else
  echo "[1/4] Claude Code はすでにインストール済みです: $(claude --version 2>/dev/null || echo '(version不明)')"
fi

# --- 2. ~/.claude ディレクトリの作成 ---
echo ""
echo "[2/4] ~/.claude ディレクトリを確認します..."
mkdir -p "$CLAUDE_DIR"

# --- 3. 既存ファイルのバックアップ ---
echo ""
echo "[3/4] 既存の設定ファイルをバックアップします..."
BACKUP_DIR="$CLAUDE_DIR/backups/setup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

for file in CLAUDE.md settings.json statusline.sh; do
  if [[ -f "$CLAUDE_DIR/$file" ]]; then
    cp "$CLAUDE_DIR/$file" "$BACKUP_DIR/$file"
    echo "  バックアップ: $file -> $BACKUP_DIR/"
  fi
done

# --- 4. 設定ファイルのコピー ---
echo ""
echo "[4/4] 設定ファイルをコピーします..."

cp "$SCRIPT_DIR/CLAUDE.md"     "$CLAUDE_DIR/CLAUDE.md"
echo "  コピー完了: CLAUDE.md"

cp "$SCRIPT_DIR/settings.json" "$CLAUDE_DIR/settings.json"
echo "  コピー完了: settings.json"

cp "$SCRIPT_DIR/statusline.sh" "$CLAUDE_DIR/statusline.sh"
chmod +x "$CLAUDE_DIR/statusline.sh"
echo "  コピー完了: statusline.sh (実行権限付与)"

# --- 完了メッセージ ---
echo ""
echo "================================================"
echo " セットアップ完了!"
echo "================================================"
echo ""
echo "次のステップ:"
echo "  1. claude を起動すると、settings.json の enabledPlugins に基づいて"
echo "     プラグインが自動インストールされます。"
echo ""
echo "  2. macOS 以外の環境では hooks の afplay コマンドが動作しません。"
echo "     settings.json の hooks セクションを環境に合わせて修正してください。"
echo "     例(Linux): \"afplay ...\" -> \"paplay /usr/share/sounds/freedesktop/stereo/complete.oga\""
echo ""
echo "  3. settings.json 内の以下のパスは環境依存のため確認してください:"
echo "     - permissions.additionalDirectories"
echo "     - 絶対パスを含む Bash パーミッション"
echo ""
