"编码设置
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,gb18030,gbk,gb2312,cp936,default,latin1
set fileformat=unix
set ambiwidth=double

"基础设置
set nocompatible
set number
set showmatch
set showcmd
set hlsearch
set incsearch
set tabstop=4
au BufReadPost * if line("'\"") > 0 | if line("'\"") <= line("$") | exe("norm '\"") | else |exe "norm $"| endif | endif

"文件检测
syntax on
filetype on
filetype plugin on
filetype indent on

colorscheme desert
set softtabstop=4
set shiftwidth=4
set noexpandtab

"备份设置
set nobackup
set nowritebackup

"中文编码支持
set encoding=utf-8
set fileencoding=chinese
set fileencodings=ucs-bom,utf-8,chinese
set ambiwidth=double
set autoindent

"leader key
let mapleader = " "

"状态栏
set laststatus=2
set ruler
set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]

"折叠
:set cursorline
:set nofoldenable
:set foldmethod=indent

"标签页
map <leader>n :tabn<CR>
map <leader>p :tabp<CR>
map <leader>c :tabc<CR>
map <leader>w :sp<CR>

"补全背景
hi Pmenu ctermfg=black ctermbg=gray  guibg=#444444
hi PmenuSel ctermfg=7 ctermbg=4 guibg=#555555 guifg=#ffffff

set cscopequickfix=s-,c-,d-,i-,t-,e-

"版本控制器
nmap <leader>hj <plug>(signify-next-hunk)
nmap <leader>hk <plug>(signify-prev-hunk)
let g:signify_vcs_list = [ 'svn' ]
let g:signify_sign_show_text = 1
autocmd User SignifyHunk call s:show_current_hunk()
function! s:show_current_hunk() abort
	let h = sy#util#get_hunk_stats()
	if !empty(h)
	echo printf('[Hunk %d/%d]', h.current_hunk, h.total_hunks)
	endif
endfunction

"---------------------------------------------------------------------------------------
"fzf
set rtp+=/home/sjm/software/fzf
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
endif
let $FZF_DEFAULT_OPTS = '--border --height 40% --preview-window=right:50%'
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>l :exe 'Rg' expand("<cword>")<CR>
nnoremap <Leader>" viw<Esc>a"<Esc>bi"<Esc>lel"
"---------------------------------------------------------------------------------------
"ctags
let g:ctags_regenerate = 0
"---------------------------------------------------------------------------------------
"tlist
set ut=1000
noremap <F4> :Tlist<CR>:set nu<CR>
let Tlist_Auto_Update=1
let Tlist_Auto_Highlight_Tag = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Show_One_File = 1
let Tlist_Highlight_Tag_On_BufEnter = 1
let Tlist_Sort_Type = "name"
let Tlist_OnlyWindow=1
let Tlist_Use_Right_Window=0
let Tlist_Exit_OnlyWindow=1
let Tlist_Show_Menu=1
let Tlist_Max_Tag_length=10
let Tlist_Use_SingleClick=0
let Tlist_Auto_Open=1
let Tlist_Close_On_Select=0
let Tlist_GainFocus_On_ToggleOpen=0
let Tlist_Process_File_Always=1
let Tlist_WinHeight=5
let Tlist_WinWidth=29
let Tlist_Use_Horiz_Window=0

"---------------------------------------------------------------------------------------
"bufexplorer
let g:bufExplorerShowRelativePath=1
let g:bufExplorerSortBy='mru'
map q :BufExplorer<CR>
"---------------------------------------------------------------------------------------
"Rg
nnoremap <silent> <Leader>r :Rg <cword><CR>
"---------------------------------------------------------------------------------------
"vimdiff
if &diff
	"syntax enable
	set background=dark
	"colorscheme evening
	let Tlist_Auto_Open = 0
endif
"---------------------------------------------------------------------------------------
"rainbow
let g:rainbow_active = 1

"---------------------------------------------------------------------------------------
"vimGrep
let Grep_Default_Filelist = '*.lua *.cpp *.c *.py *.php *.pto'
map f :Rgrep  \b<cword>\b<CR><CR><CR>
"---------------------------------------------------------------------------------------
"nerd tree
let NERDTreeMouseMode=2
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1
let NERDTreeShowLineNumbers=1
let NERDTreeWinPos='right'
let NERDTreeWinSize=25
let NERDTreeShowHidden=1
let NERDTreeAutoCenter=1
let NERDTreeIgnore=['\.o','\.d','\.pyc','\.svn','\.socket']
map <leader>` :NERDTreeToggle <CR>
map <leader>s :NERDTreeFocus<CR>
autocmd vimenter * NERDTree
autocmd InsertEnter * se cul
autocmd bufenter * if winnr("$") == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
"---------------------------------------------------------------------------------------
"ctags
set tag=/home/sjm/skynet/tags
"---------------------------------------------------------------------------------------
"neocomplcache
let g:neocomplcache_enable_at_startup = 1
"---------------------------------------------------------------------------------------
"ale
let g:ale_enabled = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_set_quickfix = 1
let g:ale_fix_on_save = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {
\   'lua': ['luacheck'],
\}
let g:ale_fixers = {
\   'lua': ['lua-format', 'stylua'],
\}
set updatetime=500

function! ToggleQuickfix()
    if len(getqflist()) == 0
        echo "Null"
        return
    endif

    let l:qf_winid = getqflist({'winid' : 0}).winid
    if l:qf_winid != 0
        cclose
        echo "Close"
    else
		silent! rightbelow copen 10
        echo "Open"
    endif
endfunction
nnoremap <silent> <Leader>al :call ToggleQuickfix()<CR>

"---------------------------------------------------------------------------------------
inoremap <expr> <CR>       pumvisible()?"\<C-Y>":"\<CR>"
inoremap <expr> <C-J>      pumvisible()?"\<Down>\<C-N>\<C-P>":"\<C-X><C-O>"
inoremap <expr> <C-K>      pumvisible()?"\<Up>\<C-P>\<C-N>":"\<C-K>"
"---------------------------------------------------------------------------------------
call plug#begin()
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-signify'
Plug 'preservim/nerdtree'
Plug 'jlanzarotta/bufexplorer'
Plug 'yegappan/taglist'
Plug 'luochen1990/rainbow'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/grep.vim'
Plug 'tpope/vim-surround'
Plug 'Shougo/neocomplcache.vim'
Plug 'garbas/vim-snipmate'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
call plug#end()
