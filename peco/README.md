### peco

[peco](https://github.com/peco/peco)はシンプルなフィルタリングツールです。
同様のフィルタリングツールに `grep`がありますがpecoは思いどおりに入力して現在の結果を確認できるため、ログのフィルタリング、統計の処理、ファイルの検索などに最適なツールになります。  
pecoはGoで制作されています。

>peco can be a great tool to filter stuff like logs, process stats, find files, because unlike grep, you can type as you think and look through the current results.
For basic usage, continue down below. For more cool elaborate usage samples, please see the wiki, and if you have any other tricks you want to share, please add to it!

### インストール方法

```sh
brew install peco
```

### 使い方

基本的にはgrep同様に`|`で繋げます。
以下のコマンドを実行するとディレクトリーを見やすくフィルタリングできます。

```sh
ls | peco
```

それ以外にも移動先のディレクターを簡単に表示してくれる事もできます。

```sh
cd "$(find . -type d | peco)" 
```
これらのコードを毎回ターミナルに打たなくても `.zshrc`に関数を定義して、コマンドで呼び出す事が可能です。

```sh
# 過去に実行したコマンドを選択
function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history
```

### 参考資料

- https://github.com/peco/peco