### setup dein.vim

deinvimの設定をコマンド一発で実行するスクリプトと`.vimrc`の設定が記述されています。

### 前準備

vimをinstallする。

```
sudo apt-get intstall vim
```

luaのオプションを入れる為にgvim(GUI)をinstallする。

```
sudo apt-get install vim-gnome
```

### .vimrcの内容

```.vim

f &compatible
    set nocompatible
endif

"dein.vim本体をランタイムパスに追加
set runtimepath+=$HOME/.vim/dein/repos/github.com/Shougo/dein.vim
"必須
if dein#load_state("$HOME/.vim/dein")
  call dein#begin("$HOME/.vim/dein")

"Plugins
call dein#add('Shougo/dein.vim')
"molokaiのカラーテーマ"
call dein#add('tomasr/molokai')
"構文チェックを行う。
call dein#add('scrooloose/syntastic')
"()を補間する。
call dein#add('Townk/vim-autoclose')
"() 色付け:
call dein#add('itchyny/lightline.vim')
"インデントの色付け
call dein#add('Yggdroot/indentLine')
" 末尾の全角と半角の空白文字を赤くハイライト
call dein#add('bronson/vim-trailing-whitespace')

" 末尾の全角と半角の空白文字を赤くハイライト
call dein#add('bronson/vim-trailing-whitespace')
" コードの自動補間(neocomplete・neosnippet・neosnippet-snippets)
if has('lua')
   "自動補間
   call dein#add('Shougo/neocomplete.vim')
    " スニペットの補完機能
     call dein#add('Shougo/neosnippet')
    " スニペット集
   call dein#add('Shougo/neosnippet-snippets')
endif


call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

"pluginのインストール
if dein#check_install()
  call dein#install()
endif

"molokai
let g:molokai_original = 1

" indentLine
set list lcs=tab:\|\
let g:indentLine_char = 'c'
let g:indentLine_color_term = 239

" neocomplete.vim
"----------------------------------------------------------
" neocomplete・neosnippetの設定
"----------------------------------------------------------
" Vim起動時にneocompleteを有効にする
let g:neocomplete#enable_at_startup = 1
" smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplete#enable_smart_case = 1
" 3文字以上の単語に対して補完を有効にする
let g:neocomplete#min_keyword_length = 3
" 区切り文字まで補完する
let g:neocomplete#enable_auto_delimiter = 1
" 1文字目の入力から補完のポップアップを表示
let g:neocomplete#auto_completion_start_length = 1
" バックスペースで補完のポップアップを閉じる
inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"

" エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定
imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
" タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ
imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"

"基本設定
"
"" ####Encode####
" 下記の指定は環境によって文字化けする可能性があるので適宜変更する
set encoding=UTF-8 "文字コードをUTF-8にする
set fileencoding=UTF-8 "文字コードをUTF-8にする
set termencoding=UTF-8 "文字コードをUTF-8にする

" #####表示設定#####"
set number "行番号を表示する
set title "編集中のファイル名を表示
set showmatch "括弧入力時の対応する括弧を表示
syntax on "コードの色分け
set tabstop=4 "インデントをスペース4つ分に設定
set smartindent "オートインデント
set list listchars=tab:>- " 不可視文字を標示

" ###molokai表示設定###
colorscheme molokai
set t_Co=256
"### lightlineの設定
set laststatus=2
" #####検索設定#####
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る


" #####コマンド設定####
inoremap <silent> jj <ESC>
"バックスペース
set backspace=2"

" ####画面分割設定####
nnoremap s <Nop>
"縦に分割
nnoremap ss :<C-u>sp<CR>
"横に分割
nnoremap sv :<C-u>vs<CR>
"画面移動
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H

"###ペースト設定
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

"###F8を押して外部にコピーをするようにする。
"
nnoremap <silent><F8> :<C-u>call <SID>CopipeTerm()<CR>
function! s:CopipeTerm()
    if !exists('b:copipe_term_save')
        " 値が保存されていなければ保存後に各オプションをコピペ用に設定
        let b:copipe_term_save = {
        \     'number': &l:number,
        \     'relativenumber': &relativenumber,
        \     'foldcolumn': &foldcolumn,
        \     'wrap': &wrap,
        \     'list': &list,
        \     'showbreak': &showbreak
        \ }
        setlocal foldcolumn=0     " 折りたたみ情報表示幅
        setlocal nonumber         " 行番号
        setlocal norelativenumber " 相対行番号
        setlocal wrap             " 折り返し
        setlocal nolist           " 行末やタブ文字の可視化
        set showbreak=            " 折り返し行の先頭に表示されるマーク（こいつだけグローバル設定しかない）
    else
        " 保存されている場合は復元
        let &l:foldcolumn = b:copipe_term_save['foldcolumn']
        let &l:number = b:copipe_term_save['number']
        let &l:relativenumber = b:copipe_term_save['relativenumber']
        let &l:wrap = b:copipe_term_save['wrap']
        let &l:list = b:copipe_term_save['list']
        let &showbreak = b:copipe_term_save['showbreak']
        " 削除
        unlet b:copipe_term_save
    endif
endfunction


```
