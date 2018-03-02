source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

"プラグイン
if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
"if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
"endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  "let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = '~/.toml'
  "let s:lazy_toml = '~/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  "call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif


"--------------------------------------
"FilteType毎のインデント設定
"--------------------------------------
augroup fielTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.cs setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.cpp setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END


"--------------------------------------
"Basic setting
"--------------------------------------
"文字コードをUFT-8に設定
set encoding=utf-8
scriptencoding utf-8
set fenc=utf-8
set fileencodings=utf-8,cp932
"IMEをDefaultでoff
set iminsert=0
set imsearch=-1
"インサートからノーマル移行時にIMEをOff
inoremap <ESC> <ESC>:set iminsert=0<CR>
"colorscheme
syntax on
set background=dark
colorscheme solarized
let g:solarized_terminal=1
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
"補完を有効化
set wildmenu
"undofileの保存先変更
set undodir=~/AppData/Local/Temp
" 行番号を表示
set number
" 現在の行を強調表示(横)
"set cursorline
" 現在の行を強調表示(縦)
"set cursorcolumn
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデント関連
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent
" 不可視文字を可視化(タブが「>-」と表示される)
set list listchars=tab:»-,trail:_,eol:~,extends:>,precedes:<,nbsp:%
"全角スペースをハイライト表示
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
"文字コードと改行コードステータスバーに表示
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
"折り返ししない
set nowrap
" 新しいウィンドウを下に開く
set splitbelow
" 新しいウィンドウを右に開く
set splitright
" スクロール時のoffset
set scrolloff=5

"--------------------------------------
" Search
"--------------------------------------
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nnoremap <ESC><ESC> :nohlsearch<CR>

"--------------------------------------
"keymap
"--------------------------------------
"コロンセミコロン入れ替え
noremap ; :
noremap : ;
"Quickfix
nnoremap cn :cn<CR>
nnoremap cp :cp<CR>
"画面移動のリマップ
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
"nomal mode C-vで矩形選択
nmap <C-v> <C-v>
"command mode C-vでペースト
cmap <C-v> <C-v>
"nomal mode C-aでインクリメント
nmap <C-a> <C-a>
"nomal mode C-fで1ページ上へ
nmap <C-f> <C-f>
"0で改行を挿入
nnoremap 0 :<C-u>call append(expand('.'), '')<Cr>j

"--------------------------------------
"Vaffle
"--------------------------------------
let g:vaffle_auto_cd=1
let g:vaffle_show_hidden_files=1

"--------------------------------------
"auto ctag
"--------------------------------------
let g:auto_ctags=0
let g:auto_ctags_directory_list=['.git']
let g:auto_ctags_tags_name='tags'
let g:auto_ctags_tags_args='--tag-relative --recurse --sort=yes'

"--------------------------------------
"WinResizer
"--------------------------------------
let g:winresizer_start_key='<C-w>'

"--------------------------------------
"Unite
"--------------------------------------
"prefix key
nnoremap [unite] <Nop>
nmap <Space>u [unite]
"挿入モードで開始
let g:unite_enable_start_insert=1
"大文字小文字を区別しない
let g:unite_enable_ignore_case=1
let g:unite_enable_smart_case=1
"history/yankの有効化
let g:unite_source_history_yank_enable=1
"ESC2回で終了
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
"unite unitekeymap
nnoremap [unite]fn :<C-u>Unite file/new<CR>
nnoremap [unite]dn :<C-u>Unite directory/new<CR>
nnoremap [unite]b :<C-u>Unite buffer<CR>
nnoremap [unite]m :<C-u>Unite file_mru<CR>
nnoremap [unite]l :<C-u>Unite line<CR>
nnoremap [unite]h :<C-u>Unite history/yank<CR>
nnoremap [unite]u :<C-u>Unite file_mru buffer<CR>
nnoremap [unite]cf ;<C-u>Unite file<CR>
