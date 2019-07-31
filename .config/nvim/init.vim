" ~~~ Plugins ~~~
call plug#begin('~/.local/share/nvim/plugged')
Plug 'shougo/deoplete.nvim' " Autocomplete
Plug 'ctrlpvim/ctrlp.vim' " Fuzzy file finder
Plug 'itchyny/lightline.vim' " Bottom status bar
Plug 'tpope/vim-commentary' " Comment
Plug 'scrooloose/nerdtree' " File explorer
Plug 'tpope/vim-surround'  " Edit surrounding tags
Plug 'lambdalisue/suda.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'machakann/vim-highlightedyank'
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-markdown'
Plug 'nelstrom/vim-markdown-folding'
Plug 'blueyed/smarty.vim' " PHP smarty support
Plug 'junegunn/fzf.vim' " Fuzzy search files
Plug 'alvan/vim-closetag' " Close html tags
" Plug 'neoclide/coc.nvim' " Autocompletion support
Plug 'scrooloose/syntastic' " Syntax check
call plug#end()

" Highlight the line on which the cursor lives.
set nocursorline

" Always show at least one line above/below the cursor.
set scrolloff=1
" Always show at least one line left/right of the cursor.
set sidescrolloff=5

" Relative line numbers
set number relativenumber

" Highlight matching pairs of brackets. Use the '%' character to jump between them.
set matchpairs+=<:>

" Display different types of white spaces.
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

" Use system clipboard
set clipboard=unnamedplus

" Remove timeout for partially typed commands
set notimeout

" F keys
" Quick write session with F2
map <F2> :mksession! ~/.vim_session<cr>
" And load session with F3
map <F3> :source ~/.vim_session<cr>

" Fix indentation
map <F7> gg=G<C-o><C-o>
" Toggle auto change directory
map <F8> :set autochdir! autochdir?<CR>

" Toggle vertical line
set colorcolumn=
fun! ToggleCC()
    if &cc == ''
        " set cc=1,4,21
        set cc=80
    else
        set cc=
    endif
endfun
nnoremap <silent> <F9> :call ToggleCC()<CR>

" Beginning and end of line
imap <C-a> <home>
imap <C-e> <end>
cmap <C-a> <home>
cmap <C-e> <end>

" Control-S Save
nmap <C-S> :w<cr>
vmap <C-S> <esc>:w<cr>
imap <C-S> <esc>:w<cr>
" Save + back into insert
" imap <C-S> <esc>:w<cr>a

" Control-C Copy in visual mode
vmap <C-C> y

" Control-V Paste in insert and command mode
imap <C-V> <esc>pa
cmap <C-V> <C-r>0

" Window Movement
nmap <M-h> <C-w>h
nmap <M-j> <C-w>j
nmap <M-k> <C-w>k
nmap <M-l> <C-w>l

" Resizing
nmap <C-M-H> 2<C-w><
nmap <C-M-L> 2<C-w>>
nmap <C-M-K> <C-w>-
nmap <C-M-J> <C-w>+

" Insert mode movement
imap <M-h> <left>
imap <M-j> <down>
imap <M-k> <up>
imap <M-l> <right>
imap <M-f> <C-right>
imap <M-b> <C-left>

" Spacemacs-like keybinds
" Change <leader> bind from default \
nnoremap <space> <nop>
let mapleader="\ "

" Make ci( work like quotes do
function! New_cib()
    if search("(","bn") == line(".")
        sil exe "normal! f)ci("
        sil exe "normal! l"
        startinsert
    else
        sil exe "normal! f(ci("
        sil exe "normal! l"
        startinsert
    endif
endfunction

" And for curly brackets
function! New_ciB()
    if search("{","bn") == line(".")
        sil exe "normal! f}ci{"
        sil exe "normal! l"
        startinsert
    else
        sil exe "normal! f{ci{"
        sil exe "normal! l"
        startinsert
    endif
endfunction

nnoremap ci( :call New_cib()<CR>
nnoremap cib :call New_cib()<CR>
nnoremap ci{ :call New_ciB()<CR>
nnoremap ciB :call New_ciB()<CR>

" Alt-m for creating a new line in insert mode
imap <M-m> <esc>o

" netrw configuration
let g:netrw_browse_split = 0
let g:netrw_altfile = 1

" Cycle windows
nmap <M-o> <C-W>w
vmap <M-o> <C-W>w
tmap <M-o> <esc><C-W>w
imap <M-o> <esc><C-W>w

" Command mode history
cmap <M-p> <up>
cmap <M-n> <down>
cmap <M-k> <up>
cmap <M-j> <down>

" Back to normal mode from insert
" inoremap jk <esc>
" inoremap JK <esc>

" Manually refresh file
nmap <F5> :e!<cr>

" Indentation
set smarttab
set expandtab
set tabstop=8
set softtabstop=4
set shiftwidth=4

"set smartindent
set autoindent
"set cindent

set nocompatible
filetype plugin indent on

" Write buffer through sudo (works on vim but not neovim)
" cnoreabbrev w!! w !sudo -S tee % >/dev/null
" Neovim: suda plugin
cnoreabbrev w!! w suda://%

" Allow switching between buffers without saving
set hidden

" Mouse support
set mouse=a

"Case insensitive searching
set ignorecase

"Will automatically switch to case sensitive if you use any capitals
set smartcase

" Auto toggle smart case of for ex commands
" Assumes 'set ignorecase smartcase'
augroup dynamic_smartcase
    autocmd!
    autocmd CmdLineEnter : set nosmartcase
    autocmd CmdLineLeave : set smartcase
augroup END

" Substitute live preview
set inccommand=nosplit

" Markdown Folding
let g:markdown_fold_style = 'nested'

" Vimwiki
" let g:vimwiki_list = [{'path': '~/dox/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext=0
let g:vimwiki_table_mappings=0
let g:vimwiki_folding='expr'
nmap <leader>vv <Plug>VimwikiIndex
nmap <leader>vV <Plug>VimwikiTabIndex
nmap <leader>vs <Plug>VimwikiUISelect
nmap <leader>vi <Plug>VimwikiDiaryIndex
nmap <leader>vdd <Plug>VimwikiMakeDiaryNote
nmap <leader>vDD <Plug>VimwikiTabMakeDiaryNote
nmap <leader>vdy <Plug>VimwikiMakeYesterdayDiaryNote
nmap <leader>vdt <Plug>VimwikiMakeTomorrowDiaryNote
nmap <M-space> <Plug>VimwikiToggleListItem

" Highlighted yank (-1 for persistent)
let g:highlightedyank_highlight_duration = 400

" If lightline/airline is enabled, don't show mode under it
set noshowmode

" Shell
set shell=/usr/bin/zsh

" Ctrlp
let g:ctrlp_switch_buffer = '0'
" Useful for large projects
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=10
" So that it does not only index starting from current directory
let g:ctrlp_working_path_mode = ""
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
" Use ag AKA the_silver_searcher for indexing. Faster!!!
" TIP: Use ~/.ignore to ignore directories/files
" set grepprg=ag\ --nogroup\ --nocolor
" let g:ctrlp_user_command = 'ag %s -l --hidden --nocolor -g ""'
""if executable('ag')
""  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
""endif
let g:ctrlp_show_hidden =1
let g:ctrlp_clear_cache_on_exit = 0

" Lightline
" Get default from :h lightline
let g:lightline = {
            \ 'colorscheme': 'lena',
            \ }

let g:lightline.active = {
            \ 'left': [ [ 'mode', 'paste', 'sep1' ],
            \           [ 'readonly', 'filename', 'modified' ],
            \           [ ] ],
            \ 'right': [ [ 'lineinfo' ],
            \            [ 'percent' ],
            \            [ 'filetype' ] ]
            \ }

let g:lightline.inactive = {
            \ 'left': [ [ 'mode', 'paste', 'sep1' ],
            \           [ 'readonly', 'filename', 'modified' ] ],
            \ 'right': [ [ 'lineinfo' ],
            \            [ 'percent' ],
            \            [ 'filetype' ] ]
            \ }

let g:lightline.tabline = {
            \ 'left': [ [ 'tabs' ] ],
            \ 'right': [ ] }

let g:lightline.tab = {
            \ 'active': [ 'tabnum', 'filename', 'modified' ],
            \ 'inactive': [ 'tabnum', 'filename', 'modified' ] }

let g:lightline.component = {
            \ 'mode': '%{lightline#mode()}',
            \ 'absolutepath': '%F',
            \ 'relativepath': '%f',
            \ 'filename': '%t',
            \ 'modified': '%M',
            \ 'bufnum': '%n',
            \ 'paste': '%{&paste?"PASTE":""}',
            \ 'readonly': '%R',
            \ 'charvalue': '%b',
            \ 'charvaluehex': '%B',
            \ 'fileencoding': '%{&fenc!=#""?&fenc:&enc}',
            \ 'fileformat': '%{&ff}',
            \ 'filetype': '%{&ft!=#""?&ft:"no ft"}',
            \ 'percent': '%3p%%',
            \ 'percentwin': '%P',
            \ 'spell': '%{&spell?&spelllang:""}',
            \ 'lineinfo': '%3l:%-2v',
            \ 'line': '%l',
            \ 'column': '%c',
            \ 'close': '%999X X ',
            \ 'winnr': '%{winnr()}',
            \ 'sep1': ''
            \}

"    \ 'sep1': ''
let g:lightline.mode_map = {
            \ 'n' : 'N',
            \ 'i' : 'I',
            \ 'R' : 'R',
            \ 'v' : 'V',
            \ 'V' : 'L',
            \ "\<C-v>": 'B',
            \ 'c' : 'C',
            \ 's' : 'S',
            \ 'S' : 'S-LINE',
            \ "\<C-s>": 'S-BLOCK',
            \ 't': 'T',
            \ }


let g:lightline.separator = {
            \   'left': '', 'right': ''
            \}
let g:lightline.subseparator = {
            \   'left': '', 'right': '' 
            \}

let g:lightline.tabline_separator = g:lightline.separator
let g:lightline.tabline_subseparator = g:lightline.subseparator

let g:lightline.enable = {
            \ 'statusline': 1,
            \ 'tabline': 1
            \ }

" deoplete
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Clear search highlighting with Escape key
nnoremap <silent><esc> :noh<return><esc>

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
    set t_Co=16
endif

set wildmenu

set encoding=utf8
scriptencoding utf-8

" Colorscheme
colorscheme lena
set fillchars=vert::

" Restore last cursor position and marks on open
au BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit' 
            \ |   exe "normal! g`\""
            \ | endif

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Spacemacs keybinds
" Move to window
nnoremap wh <C-w>h
nnoremap wj <C-w>j
nnoremap wk <C-w>k
nnoremap wl <C-w>l


" Fix single line indent
nnoremap <TAB> =<CR>
" Fix visual mode indent
vnoremap <TAB> =<CR>
" Switch to last buffer
nnoremap <leader><TAB> <C-^>
" Find file
" nnoremap <leader>ff :e <C-R>=substitute(expand("%:p:h"), $HOME, "~", "")<CR>
nnoremap <leader>ff :CtrlPCurFile<CR>
nnoremap <leader>pf :CtrlPRoot<CR>
" Recent files
nnoremap <leader>fr :CtrlPMRU<CR>
"List buffers
" nnoremap <leader>bb :buffers<CR>:buffer<Space>
" Delete buffer
nnoremap <leader>bd :bdelete
" Next buffer
nnoremap <leader>bn :bn<CR>
" Previous buffer
nnoremap <leader>bp :bp<CR>
" Split window below
nnoremap <leader>w- :sp<CR>
" Split window right
nnoremap <leader>w/ :vsp<CR>
" Window delete
nnoremap <leader>wd :q<CR>
" Indent buffer
nnoremap <leader>j= mzgg=G`z
" Edit dotfile
nnoremap <leader>fed :e ~/.config/nvim/init.vim
" Reload dotfile
nnoremap <leader>feR :source ~/.config/nvim/init.vim<CR>
" NERDTree toggle
nnoremap <leader>pt :call NERDTreeToggleInCurDir()<CR>
" Commentary
nmap <leader>; <Plug>Commentary
vmap <leader>; <Plug>Commentary
omap <leader>; <Plug>Commentary
nmap <leader>;; <Plug>CommentaryLine

"fzf
nnoremap <leader>bb :Buffers<CR>
nnoremap <leader>gfh :BCommits<CR>
nnoremap <leader>gs :GFiles?<CR>
nnoremap <leader>pf :Files<CR>
nnoremap <leader>sp :Ag<CR>

" Open NERDTree in the directory of the current file (or /home if no file is open)
function! NERDTreeToggleInCurDir()
  " If NERDTree is open in the current buffer
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    exe ":NERDTreeToggle"
  else
    exe ":NERDTree %"
  endif
endfunction
" NERDTree
let NERDTreeShowHidden=1

