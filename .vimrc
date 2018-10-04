set nocompatible
set encoding=utf-8
set sessionoptions=curdir,folds,tabpages,winsize

" ============================================================================
" behavior
" ============================================================================

" https://sw.kovidgoyal.net/kitty/faq.html#using-a-color-theme-with-a-background-color-does-not-work-well-in-vim
let &t_ut=''

" https://askubuntu.com/questions/60200/how-to-copy-data-between-different-instances-of-vim
set clipboard=unnamedplus

set scrolloff=5
set cursorline

set copyindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround

set wildmenu
set wildmode=list:longest
set wildignore=*.swp,*/public_html/assets/*,*/www/assets/*,*/old/*

set ignorecase
set smartcase

set splitbelow
set splitright

set foldmethod=indent
set foldlevelstart=99

 " If you prefer the Omni-Completion tip window to close when a selection is
 " made, these lines close it on movement in insert mode or when leaving
 " insert mode
autocmd CursorMovedI * if pumvisible() == 0|silent! pclose|endif
autocmd InsertLeave * if pumvisible() == 0|silent! pclose|endif

" Mark similar words
"nmap <F12> :exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))<CR>

" Mark variables and function calls
"autocmd CursorMoved * exe printf('match IncSearch /\V\($\|->\|::\)\<%s\>/', escape(expand('<cword>'), '/\'))

" ============================================================================
" keymapping
" ============================================================================

inoremap jj <ESC>

let mapleader="\<Space>"
map <leader>r :!ranger<CR>
map <leader>n :NERDTreeToggle<CR>
map <leader>t :TlistToggle<CR>
map <leader>w :w<CR>:SyntasticCheck<CR>
map <leader>f :FZF<CR>
map <leader>s :SyntasticCheck<CR>
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <Tab> :tabnext<CR>
nmap <S-Tab> :tabprevious<CR>

let g:user_zen_leader_key = '<leader>z'
let g:vebugger_leader = '<leader>d'

" Mark similar words
nmap <F12> :exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))<CR>

" Automatically jump to end of pasted text
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Do not skip wrapped lines (unless count is given)
" Also support relative numbers
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

nmap <leader>1 1gt
nmap <leader>2 2gt
nmap <leader>3 3gt
nmap <leader>4 4gt
nmap <leader>5 5gt
nmap <leader>6 6gt
nmap <leader>7 7gt
nmap <leader>8 8gt
nmap <leader>9 9gt

" ============================================================================
" airline
" ============================================================================

let g:airline_powerline_fonts = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#whitespace#trailing_format = 't[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = 'i[%s]'

" Fix glitch at startup
"autocmd VimEnter * AirlineRefresh

" ============================================================================
" git-gutter
" ============================================================================

let g:gitgutter_realtime = 1000
let g:gitgutter_eager = 0
let g:gitgutter_override_sign_column_highlight = 0
autocmd ColorScheme * highlight clear SignColumn
"autocmd ColorScheme * highlight link SignColumn NONE
"autocmd ColorScheme * highlight link SignColumn LineNr

" ============================================================================
" Tlist
" ============================================================================

let tlist_php_settings = 'php;c:class;f:function;d:constant'
let Tlist_File_Fold_Auto_Close = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_WinWidth = 40
let Tlist_Close_On_Select = 1

" ============================================================================
" ctrlp
" ============================================================================

let g:ctrlp_max_height = 20
let g:ctrlp_regexp = 1
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_lazy_update = 0
let g:ctrlp_prompt_mappings = {
    \ 'PrtBS()':      ['<bs>', '<c-]>', '<c-h>'],
    \ 'PrtCurLeft()': ['<left>', '<c-^>'],
    \ }

" ============================================================================
" syntastic
" ============================================================================

set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_asm_compiler = "nasm"
let g:syntastic_asm_compiler_options = "-f elf -F dwarf"

" ============================================================================
" ctrlspace
" ============================================================================

let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
let g:CtrlSpaceSaveWorkspaceOnExit = 1

" ============================================================================
" lightline
" ============================================================================


let g:lightline = {
    \ 'enable': { 'tabline': 0 },
    \ 'colorscheme': 'jellybeans',
    \ 'active': {
    \     'left': [ [ 'mode', 'paste' ],
    \               [ 'readonly', 'relativepath', 'modified' ] ],
    \     'right': [ [ 'lineinfo' ],
    \                [ 'percent' ],
    \                [ 'fileencoding' ] ]
    \ } }
let g:lightline.inactive = {
    \ 'left': [ [ 'relativepath', 'modified' ] ],
    \ 'right': [ [ 'percent' ] ] }

" ============================================================================
" other plugins
" ============================================================================

let g:NERDTreeQuitOnOpen = 1
"let g:NERDTreeDirArrows = 0
let NERDTreeIgnore=['\.class$']

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

let g:vdebug_options = {
    \ 'break_on_open': 0
    \ }

" Use Ag instead of Ack
let g:ackprg = 'ag --nogroup --nocolor --column'

" Use markdown syntax on *.md files
au BufRead,BufNewFile *.md set filetype=markdown

" ============================================================================
" old settings, for vim
" ============================================================================

if !has('nvim')
    filetype plugin indent on
    syntax enable

    set linespace=0
    set lazyredraw
    set ttyfast
    set hidden

    set laststatus=2
    set ruler
    set nocursorcolumn
    set numberwidth=4

    " consistent background for git-gutter
    highlight clear SignColumn

    set nostartofline
    set wrap
    set backspace=indent,eol,start

    set nosmartindent
    set autoindent

    set wrapscan
    set incsearch

    set history=1000
    set undolevels=1000
    set backup
    set backupdir=~/.vim/.backup//
    set directory=~/.vim/.swap//
    set undodir=~/.vim/.undo//
    set undofile

    silent execute '!mkdir -p ~/.vim/.backup'
    silent execute '!mkdir -p ~/.vim/.swap'

endif

" Ctrl+h is not always working with xterm and nvim
" https://github.com/neovim/neovim/issues/2048

" ============================================================================
" plugins
" ============================================================================

call g:plug#begin('~/.local/share/nvim/plugged')

" Color schemes
"Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'

""Plug 'nathanaelkane/vim-indent-guides' " A Vim plugin for visually displaying indent levels in code
Plug 'junegunn/vim-easy-align' " A Vim alignment plugin
Plug 'edsono/vim-matchit' " Configure % to match more than just single characters.
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
"
""Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " A tree explorer plugin for vim.
""Plug 'Xuyuanp/nerdtree-git-plugin' " A plugin of NERDTree showing git status
""Plug 'Mizuchi/vim-ranger'
Plug 'vim-scripts/Ranger.vim'
"
""Plug 'ctrlpvim/ctrlp.vim' " Fuzzy file, buffer, mru, tag, etc finder
"Plug 'mileszs/ack.vim' " Vim plugin for the Perl module / CLI script 'ack'
Plug 'junegunn/fzf', { 'on': 'FZF', 'dir': '~/.fzf', 'do': './install --all' } " A command-line fuzzy finder written in Go
""Plug 'vim-ctrlspace/vim-ctrlspace' " Vim Space Controller
"
""Plug 'joonty/vdebug' " Multi-language DBGP debugger client for Vim
Plug 'scrooloose/syntastic', { 'on': 'SyntasticCheck' } " Syntax checking hacks for vim
Plug 'Shougo/vimproc.vim', { 'do': 'make' } " Interactive command execution in Vim
Plug 'idanarye/vim-vebugger' " Interactive shell debugger
"
"Plug 'terryma/vim-multiple-cursors'
Plug 'roman/golden-ratio'
""Plug 'elmcast/elm-vim'
"
Plug 'Valloric/YouCompleteMe', { 'on': [] }
Plug 'saltstack/salt-vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'mdempsky/gocode', { 'rtp': 'vim', 'do': '~/.config/nvim/plugins/gocode/vim/symlink.sh' }

Plug 'junegunn/goyo.vim'

call plug#end()

" https://github.com/junegunn/vim-plug/wiki/tips#loading-plugins-manually
augroup load_ycm
  autocmd!
  autocmd InsertEnter * call plug#load('YouCompleteMe')
                     \| autocmd! load_ycm
augroup END

" ============================================================================
" looks
" ============================================================================

set termguicolors

"let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"set background=light
set background=dark

"let g:solarized_visibility="low"
"let g:solarized_termcolors=256
"let g:solarized_termtrans="1"
"colorscheme solarized

"let g:base16_hide_special=1
"let base16colorspace=256
"colorscheme base16-default

let g:gruvbox_contrast_dark="hard"
let g:gruvbox_contrast_light="soft"
let g:gruvbox_sign_column="bg0"
let g:gruvbox_invert_tabline=0
"let g:gruvbox_vert_split="bg0"
colorscheme gruvbox

set list
"set listchars=tab:▸\ ,trail:⋅,nbsp:⋅,eol:¬
set listchars=tab:▸\ ,trail:·,nbsp:·,eol:¬
"autocmd InsertEnter * set list
"autocmd InsertLeave * set nolist

" Highlight trailing whitespace
highlight link ExtraWhitespace CursorLine
autocmd ColorScheme * highlight link ExtraWhitespace CursorLine
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
"autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
"autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"autocmd BufEnter,BufNew * setlocal number relativenumber
"autocmd BufLeave * setlocal nonumber norelativenumber

" Run :FixWhitespace to remove end of line white space
function! s:FixWhitespace(line1,line2)
    let l:save_cursor = getpos(".")
    silent! execute ':' . a:line1 . ',' . a:line2 . 's/\s\+$//'
    call setpos('.', l:save_cursor)
endfunction
command! -range=% FixWhitespace call <SID>FixWhitespace(<line1>,<line2>)

" Use markdown syntax on *.md files
au BufRead,BufNewFile *.md set filetype=markdown

" Spell checking
autocmd FileType markdown setlocal spell spelllang=en_us
hi SpellBad cterm=underline ctermfg=red

" ============================================================================
" Golang settings
" ============================================================================

autocmd FileType go setlocal noexpandtab nosr sts=0 shiftwidth=4 tabstop=4
"autocmd FileType go setlocal listchars=tab:▸\ ,trail:⋅,nbsp:⋅,eol:¬

" ============================================================================
" project-based settings
" ============================================================================

autocmd BufNewFile,BufRead ~/workspace/study/INF102/* set noexpandtab softtabstop=0
