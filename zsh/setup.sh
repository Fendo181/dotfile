#!/bin/bash

# Homebrew で zsh をインストール
brew install zsh

# zinit をインストール（既にあればスキップ）
ZINIT_HOME="${HOME}/.local/share/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
  sh -c "$(curl -fsSL https://git.io/zinit-install)"
fi

# .zshrc をコピー（スクリプトと同じディレクトリから）
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cp "${SCRIPT_DIR}/.zshrc" ~/

echo "セットアップ完了。新しいターミナルを開くか、以下を実行してください:"
echo "  source ~/.zshrc"
