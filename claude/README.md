# Claude Code 設定

このディレクトリには Claude Code のユーザー設定ファイルを管理しています。

## ファイル構成

| ファイル | 説明 |
|---|---|
| `CLAUDE.md` | Claude へのユーザー指示・基本方針 |
| `settings.json` | Claude Code の設定（権限・プラグイン・フック等） |
| `statusline.sh` | ステータスラインにコンテキスト使用量を表示するスクリプト |
| `setup.sh` | 別PCへ設定を反映するセットアップスクリプト |

## 別PCへの移行手順

```bash
# 1. このリポジトリをクローン
git clone https://github.com/fendo181/dotfile.git ~/dotfile

# 2. セットアップスクリプトを実行
cd ~/dotfile/claude
bash setup.sh
```

## 同期されるファイル・されないファイル

### ✅ 同期する（このディレクトリで管理）
- `CLAUDE.md` - ユーザー設定・行動指針
- `settings.json` - パーミッション・プラグイン・フック設定
- `statusline.sh` - ステータスラインスクリプト

### ❌ 同期しない（機械固有 or 自動生成）
- `~/.claude/history.jsonl` - 会話履歴
- `~/.claude/plugins/cache/` - プラグインキャッシュ（起動時に自動生成）
- `~/.claude/sessions/` - セッションデータ
- `~/.claude/projects/` - プロジェクトメモリ
- `~/.claude/backups/` - バックアップ
- その他キャッシュ・ログ系

## 注意事項

### プラグインについて
`settings.json` の `enabledPlugins` と `extraKnownMarketplaces` を読み込んで
Claude Code 起動時にプラグインが自動インストールされます。

### 環境依存の設定
`settings.json` 内の以下は macOS 固有のため、他 OS では修正が必要です：
- `hooks` 内の `afplay` コマンド（macOS の音声再生）
  - Linux 代替: `paplay /usr/share/sounds/freedesktop/stereo/complete.oga`

### マシン固有のパーミッション
`settings.json` の `permissions.additionalDirectories` や
絶対パスを含む `Bash(...)` パーミッションは環境に合わせて編集してください。
