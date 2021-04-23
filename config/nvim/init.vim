
"         _
"  __   _(_)_ __ ___  _ __ ___
"  \ \ / / | '_ ` _ \| '__/ __|
"   \ V /| | | | | | | | | (__
"    \_/ |_|_| |_| |_|_|  \___|
"

" Spelling Right

map <F8> :setlocal spell! spelllang=en_gb<CR>
set title
set ruler
set showmatch
set ignorecase
set incsearch
set hlsearch
set bs=2
set nobackup
set noswapfile
set nowritebackup

set number
set shell=bash
" set mouse=a
set mouse=a
set backspace=indent,eol,start
set laststatus=2
syntax on
filetype plugin indent on
set nofoldenable
set t_Co=256

" Set Leader
let mapleader = ','

set encoding=utf-8
set background=dark
set undofile
set undodir=/tmp
set clipboard=unnamedplus

" size of a hard tabstop
" set tabstop=2
" set ts=2
" set sts=2
" always uses spaces instead of tab characters
" set expandtab
" size of an "indent"
" set shiftwidth=2

set shiftwidth=2
set tabstop=2
set expandtab

autocmd Filetype javascript setlocal sw=2 sts=2 expandtab
autocmd Filetype python setlocal sw=4 sts=4 expandtab
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType eruby setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType rust setlocal expandtab shiftwidth=2 tabstop=2
autocmd Filetype go setlocal ts=4

" max text length
au BufRead,BufNewFile *.rb setlocal textwidth=120

" get rid of trailing whitespace on :w
autocmd BufWritePre * %s/\s\+$//e

" Ignore whitespace whilst diffing
set diffopt+=iwhite

" Show Tab
set list listchars=nbsp:¬,tab:»·,trail:·,extends:>

" Install Plugins
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf'
Plug 'morhetz/gruvbox'
Plug 'Shougo/neocomplete.vim'
Plug 'tpope/vim-commentary'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'airblade/vim-gitgutter'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
Plug 'w0rp/ale'
Plug 'jremmen/vim-ripgrep'
Plug 'suan/vim-instant-markdown', {'rtp': 'after'}
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'ap/vim-css-color'
Plug 'junegunn/vim-emoji'
Plug 'jreybert/vimagit'
Plug 'co1ncidence/mountaineer.vim'
Plug 'AlessandroYorba/Sierra'
" Colorscheme SpaceCamp
Plug 'jaredgorski/SpaceCamp'
Plug 'vim-pandoc/vim-pandoc'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'LnL7/vim-nix'
Plug 'rust-lang/rust.vim'
call plug#end()

" colorscheme spacecamp
" Set colorscheme
" autocmd vimenter * ++nested colorscheme mountaineer
colorscheme gruvbox
let g:gruvbox_transparent_bg=1
hi Normal ctermbg=NONE " for transparent background
hi SpellBad ctermbg=red " for transparent background
hi SpellRare ctermbg=red
hi Special ctermfg=cyan

"  Lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

" Autorun nerdtree when vim starts without any files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && v:this_session == "" | NERDTree | endif


" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" C-n for nerdTree
" map <C-n> :NERDTreeToggle<CR>

" Ripgrep
let g:rg_highligh = 1

" open/close nerdtree window
map <leader>n :NERDTreeToggle<CR>
map <leader>r :NERDTreeFind<cr>
" autocmd BufWinEnter * NERDTreeFind
map ] :NERDTreeFind<CR>
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
let NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1

let g:instant_markdown_autostart = 0         " Turns off auto preview
let g:instant_markdown_browser = "surf"      " Uses surf for preview
map <Leader>md :InstantMarkdownPreview<CR>   " Previews .md file
map <Leader>ms :InstantMarkdownStop<CR

nmap <leader>2 :set paste<CR>i

" remap envoke key
nnoremap <silent> <C-z> :FZF<CR>
nnoremap <silent> <C-x> :Buffers<CR>

" remap splits
nmap :vs :vsplit
nmap :s :split

" " remap splitting windows
set splitbelow splitright
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Make adjusing split sizes a bit more friendly
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>

" clear whitespace
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" C-Backspace to clear a word
inoremap <C-H> <C-W>

" Better page down and page up
noremap <C-n> <C-d>
noremap <C-p> <C-b>

set rtp+=/usr/local/bin/fzf

" allow vim to jump through directories for ctags
set tags=tags;/

" To comment out
noremap \ :Commentary<CR>
autocmd FileType ruby setlocal commentstring=#\ %s

" Rg command with smartcase
" let g:rg_command = 'rg --vimgrep -S'

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" ALE
nmap <LEADER>af :ALEFix<CR>
let g:ale_lint_on_text_changed = 1
let g:ale_lint_on_save = 1
let g:ale_set_loclist = 1

let g:ale_fixers = {
\  'ruby': [
\    'remove_trailing_lines',
\    'trim_whitespace',
\    'rubocop'
\  ]
\}
let g:ale_linters = {'ruby': ['rubocop', 'ruby']}
let g:ale_ruby_rubocop_executable = 'bin/rubocop'
let g:ruby_indent_assignment_style = 'variable'

" vim-ruby
let g:ruby_indent_access_modifier_style = 'normal'
let g:ruby_indent_assignment_style = 'variable'
let g:ruby_indent_block_style = 'do'
set shell=/bin/zsh

" Language specific configs

" Rust
" Rust
let g:racer_cmd = '~/.cargo/bin/racer'
let g:racer_experimental_completer = 1
let g:rustfmt_autosave = 1
augroup rust
    autocmd FileType rust setlocal textwidth=80
    autocmd FileType rust map <buffer> <leader>rt :RustTest<CR>
augroup END

" Line movement
" Normal mode
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==

" Insert mode
inoremap <C-j> <ESC>:m .+1<CR>==gi
inoremap <C-k> <ESC>:m .-2<CR>==gi

" Visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
