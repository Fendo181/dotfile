# ailiasの設定
alias -g g='git'
alias -g d='docker'
alias -g d-c='docker compose'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g cl='claude'


# zinitの設定
## https://github.com/zdharma-continuum/zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

source "${ZINIT_HOME}/zinit.zsh"
## zintコマンドを補完する設定
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# zinitのプラグインの読み込み
zinit load zsh-users/zsh-autosuggestions
zinit load zsh-users/zsh-completions
zinit load zsh-users/zsh-syntax-highlighting

# prompt設定
## Load the pure theme, with zsh-async library that's bundled with it.
## https://github.com/sindresorhus/pure
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

# promptinit
autoload -U promptinit
## git stash status
zstyle :prompt:pure:git:stash show yes
## prompt color
zstyle :prompt:pure:path color blue

autoload -U promptinit
promptinit
function toon {
  echo -n ""
}
PROMPT='%D %T:%F{green}%c%f $(toon)[%n]# '

# 色を使用出来るようにする
autoload -Uz colors
colors

# コマンド履歴の設定
## 履歴ファイルの保存先
export HISTFILE=${HOME}/.zhistory
## メモリに保存される履歴の件数
export HISTSIZE=1000
## 履歴ファイルに保存される履歴の件数
export SAVEHIST=100000
## 重複を記録しない
setopt hist_ignore_dups
## 開始と終了を記録
setopt EXTENDED_HISTORY
## historyを共有
setopt share_history
## ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups
## スペースで始まるコマンド行はヒストリリストから削除
setopt hist_ignore_space
## ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_verify
## 余分な空白は詰めて記録
setopt hist_reduce_blanks
## 古いコマンドと同じものは無視
setopt hist_save_no_dups
## historyコマンドは履歴に登録しない
setopt hist_no_store
## 補完時にヒストリを自動的に展開
setopt hist_expand
## 履歴をインクリメンタルに追加
setopt inc_append_history
## その他
setopt no_beep  # 補完候補がないときなどにビープ音を鳴らさない。
setopt prompt_subst  # PROMPT内で変数展開・コマンド置換・算術演算を実行

## 実行したプロセスの消費時間が3秒以上かかったら
REPORTTIME=3

# もしかして機能(suggest)
setopt correct
## もしかして時のプロンプト指定
SPROMPT="%{$fg[red]%}%{$suggest%}(*'~'%)? < もしかして %B%r%b %{$fg[red]%}かな? [そう!(y), 違う!(n)]:${reset_color} "

## プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

# git
RPROMPT="%{${fg[white]}%}[%~]%{${reset_color}%}"

## git info
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

# zshの補完を強化する
autoload -U compinit
compinit

zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true

# peco
## ctrl + x でディレクトリ移動を行う
function peco-cd-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-cd-src
bindkey '^x' peco-cd-src

## ctrl + r で過去に実行したコマンドを選択できるようにする。
function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# PATH setting
## brew
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(/opt/homebrew/bin/brew shellenv)"

## nodenv
eval "$(nodenv init -)"

## go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

## pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
