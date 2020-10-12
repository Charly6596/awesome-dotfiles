 "Specify a directory for plugins
call plug#begin('~/.vim/plugged')
" ===== Theme =====
Plug 'joshdick/onedark.vim' " Theme
Plug 'itchyny/lightline.vim' " Bottom status bar
Plug 'itchyny/vim-gitbranch'
Plug 'mengelbrecht/lightline-bufferline' " Lightline bufferline tabs

" ===== Lang  =====
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'HerringtonDarkholme/yats.vim' " TS Syntax
Plug 'maxmellon/vim-jsx-pretty'
Plug 'alvan/vim-closetag' " Close html tags
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'tpope/vim-commentary'
Plug 'sheerun/vim-polyglot'
Plug 'honza/vim-snippets'
Plug 'brennier/quicktex'
" ===== Other ====
Plug 'vimwiki/vimwiki'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'lambdalisue/nerdfont.vim'


" Initialize plugin system
call plug#end()

" ============== General Settings ============
set shell=/usr/bin/zsh
" Use system keyboard
set clipboard=unnamedplus
set nocursorline
:let mapleader = " "
" Highlight matching pairs of brackets. Use the '%' character to jump between them.
set matchpairs+=<:>
" Always show at least one line above/below the cursor.
set scrolloff=1
set relativenumber
set smarttab
set cindent
set tabstop=2
set shiftwidth=2
" always uses spaces instead of tab characters
set expandtab
set showtabline=2
set noshowmode

" ============== Theme ================
syntax on
colorscheme onedark

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" =============== Lightline ==================== lightline
let g:lightline = {
\  'colorscheme': 'onedark',
\  'tabline': {
\    'left': [ ['buffers'] ],
\    'right': [ ['close'] ]
\  },
\  'component_expand': {
\    'buffers': 'lightline#bufferline#buffers'
\  },
\  'component_type': {
\    'buffers': 'tabsel'
\  }
\ }

function! GitStatus()
  let [a, m, r] = GitGutterGetHunkSummary()
  let add = ''
  if a != 0
    let add = printf('%d  ', a) 
  endif
  let modified = ''
  if m != 0
    let modified = printf('%d  ', m)
  endif
  let removed = ''
  if r != 0
    let removed = printf('%d ', r)
  endif

  return printf('%s %s %s', add, modified, removed)
endfunction

function! LightlineBranch() 
  let b = gitbranch#name()
  return b !=# '' ? printf(" %s", b) : ''
endfunction 

let g:lightline.active = {
\    'left': [ [ 'mode', 'paste', 'sep1' ],
\              [ 'readonly', 'filename', 'gitbranch' ,'modified' ],
\              [  ] ],
\    'right': [ [ 'lineinfo', 'gitstatus'],
\               [ 'percent' ],
\               [ 'filetype' ],
\               ]
\}

let g:lightline.inactive = {
\    'left': [ [ 'mode', 'paste', 'sep1' ],
\              [ 'readonly', 'filename', 'modified' ] ],
\    'right': [ [ 'lineinfo' ],
\               [ 'percent' ],
\               [ 'filetype' ] ]
\    }

let g:lightline.tab = {
\    'active': [ 'tabnum', 'filename', 'tabnum', 'modified' ],
\    'inactive': [ 'tabnum', 'filename', 'modified' ] }

let g:lightline.component = {
\    'mode': '%{lightline#mode()}',
\    'absolutepath': '%F',
\    'relativepath': '%f',
\    'filename': '%t',
\    'modified': '%M',
\    'bufnum': '%n',
\    'paste': '%{&paste?"PASTE":""}',
\    'readonly': '%R',
\    'charvalue': '%b',
\    'charvaluehex': '%B',
\    'fileencoding': '%{&fenc!=#""?&fenc:&enc}',
\    'fileformat': '%{&ff}',
\    'filetype': '%{&ft!=#""?&ft:"no ft"}',
\    'percent': '%3p%%',
\    'percentwin': '%P',
\    'spell': '%{&spell?&spelllang:""}',
\    'lineinfo': '%3l:%-2v',
\    'line': '%l',
\    'column': '%c',
\    'close': '%999X X ',
\    'winnr': '%{winnr()}',
\    'sep1': ''
\}
            "\ 'sep1': ''
"
let g:lightline.component_function = {
      \   'gitbranch': 'LightlineBranch',
      \   'gitstatus': 'GitStatus',
\ }
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
            \   'left': '', 'right': ''
            \}

let g:lightline.subseparator = {
	\   'left': '', 'right': '' 
  \}
let g:lightline.enable = {
            \ 'statusline': 1,
            \ 'tabline': 1
            \ }

" ========== Lightline bufferline ============== lightline bufferline
"0: No numbers
"1: Buffer number as shown by the :ls command
"2: Ordinal number (buffers are numbered from 1 to n sequentially)
"3: Both buffer number and ordinal number next to each other
"4: Both buffer number and ordinal number next to each other, where the oridinal number is shown before buffer number
let g:lightline#bufferline#show_number = 2
let g:lightline#bufferline#unicode_symbols = 1

nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)

nmap <Leader>c1 <Plug>lightline#bufferline#delete(1)
nmap <Leader>c2 <Plug>lightline#bufferline#delete(2)
nmap <Leader>c3 <Plug>lightline#bufferline#delete(3)
nmap <Leader>c4 <Plug>lightline#bufferline#delete(4)
nmap <Leader>c5 <Plug>lightline#bufferline#delete(5)
nmap <Leader>c6 <Plug>lightline#bufferline#delete(6)
nmap <Leader>c7 <Plug>lightline#bufferline#delete(7)
nmap <Leader>c8 <Plug>lightline#bufferline#delete(8)
nmap <Leader>c9 <Plug>lightline#bufferline#delete(9)
nmap <Leader>c0 <Plug>lightline#bufferline#delete(10)


set guioptions-=e  " Don't use GUI tabline

" ========= Prettier ============= prettier
"let g:prettier#quickfix_enabled = 0
"let g:prettier#quickfix_auto_focus = 0
" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" run prettier on save
"let g:prettier#autoformat = 0
"autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
"
" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" ==================== CoC ========================
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-actions',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-graphql',
  \ 'coc-java',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ 'coc-todolist', 
  \ 'coc-clangd', 
  \ 'coc-explorer', 
  \ ]
" ========== CoC-Explorer ============= explorer
nnoremap <silent> <leader>t :CocCommand explorer<CR>

" ========= CoC-todolist =============== todolist
nnoremap <leader>tdc :CocCommand todolist.create<CR>
nnoremap <leader>tdU :CocCommand todolist.upload<CR>
nnoremap <leader>tdD :CocCommand todolist.download<CR>
nnoremap <leader>tdo :CocList todolist<CR>
" from readme
" if hidden is not set, TextEdit might fail.
set hidden " Some servers have issues with backup files, see #649 set nobackup set nowritebackup " Better display for messages set cmdheight=2 " You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_nfo()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>. :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>. :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

" Remap for do codeAction of current line
"nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>i

" Used for the format on type and improvement of brackets, ex: >
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
				\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" ============== FzF =================== fzf
nnoremap <leader>ff :Ctrlp<CR>
nnoremap <leader>ffs :GFiles?<CR>
nnoremap <leader>ffc :Files<CR>
nnoremap <leader>bb :Buffers<CR>
let g:fzf_preview_window = 'right:60%'

command! Ctrlp execute (len(system('git rev-parse'))) ? ':Files' : ':GFiles'
command! -bang -nargs=? -complete=dir Files
	\ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': []}), <bang>0)
command! -bang -nargs=? -complete=dir GFiles
	\ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview({'options': []}), <bang>0)

" ============ Closetag ========== closetag
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
let g:closetag_filenames = '*.html,*.xhtml,*.jsx,*.js,*.tsx'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filenames = '*.xml,*.xhtml,*.jsx,*.js,*.tsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
let g:closetag_filetypes = 'html,xhtml,jsx,js,tsx'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filetypes = 'xml,xhtml,jsx,js,tsx'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
let g:closetag_emptyTags_caseSensitive = 1

" Disables auto-close if not in a "valid" region (based on filetype)
let g:closetag_regions = {
		\ 'typescript.tsx': 'jsxRegion,tsxRegion',
		\ 'javascript.jsx': 'jsxRegion',
		\ }

" Shortcut for closing tags, default is '>'
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
let g:closetag_close_shortcut = '.>'

" ======== Quicktex ======= quicktex
let g:quicktex_tex = {
    \' '   : "\<ESC>:call search('<+.*+>')\<CR>\"_c/+>/e\<CR>",
    \'m'   : '\( <+++> \) <++>',
    \'prf' : "\\begin{proof}\<CR><+++>\<CR>\\end{proof}",
\}

let g:quicktex_math = {
    \' '    : "\<ESC>:call search('<+.*+>')\<CR>\"_c/+>/e\<CR>",
    \'fr'   : '\mathcal{R} ',
    \'eq'   : '= ',
    \'set'  : '\{ <+++> \} <++>',
    \'frac' : '\frac{<+++>}{<++>} <++>',
    \'one'  : '1 ',
    \'st'   : ': ',
    \'in'   : '\in ',
    \'bn'   : '\mathbb{N} ',
\}

" ============ Custom ============ custom
" Swap lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Switch to last buffer
nnoremap <leader><TAB> <C-^>
" Move 5 lines
nnoremap <C-j> 5j
vmap <C-j> 5j
nnoremap <C-k> 5k
vmap <C-k> 5k

" Edit dotfile
nnoremap <leader>fed :e ~/.config/nvim/init.vim<CR>
" Reload dotfile
nnoremap <leader>feR :source ~/.config/nvim/init.vim<CR>

" ================ Haskell ============= haskell
function CompileAndExecHS()
  let fileName = expand('%:t:r')
  let fileNameExtension = expand('%')
  let command = printf("!xst -e sh -c 'ghc %s; ./%s; read -p \"Press any key to continue...\"' &", fileNameExtension, fileName)
  execute command
endfunction

" Open a terminal with the haskell interpreter and load the current file
function OpenInterpreterHS()
  let filePath = expand('%:p:h')
  let file = expand('%:t')
  let command = printf("!xst -e sh -c 'cd %s; ghci %s' &", filePath, file)
  execute command
endfunction

autocmd FileType haskell nmap <silent> <leader>hcn :call CompileAndExecHS()<cr><cr>
autocmd FileType haskell nmap <silent> <leader>hri :call OpenInterpreterHS()<cr><cr>

function ToggleTexVimwiki()
  let tex = 'tex'
  let vimwiki = 'vimwiki'
  let newtype = vimwiki 
  if(&ft == vimwiki)
   let newtype = tex
   let g:texvimwiki_multiline = 1
   call append(line('.'), ['{{$', '', '}}$'])
   call cursor(line('.') + 1, 1)
   call nvim_input("i<TAB>")
  endif
  let command = printf(":set filetype=%s", newtype)
  execute command
endfunction

autocmd FileType vimwiki inoremap <C-a> <ESC>:call ToggleTexVimwiki()<CR><CR>

