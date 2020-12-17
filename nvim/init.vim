
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

autocmd Filetype javascript setlocal sw=2 sts=2 expandtab
autocmd Filetype python setlocal sw=4 sts=4 expandtab
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType eruby setlocal expandtab shiftwidth=2 tabstop=2

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
" Plug 'morhetz/gruvbox'
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
Plug 'jaredgorski/SpaceCamp'
call plug#end()

colorscheme spacecamp
" Set colorscheme
" autocmd vimenter * ++nested colorscheme mountaineer

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
map <C-n> :NERDTreeToggle<CR>
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
