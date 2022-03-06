""""""""""""""""
"""""""" Plugins
""""""""""""""""
call plug#begin()
    " Appearance
    Plug 'vim-airline/vim-airline'
    Plug 'ryanoasis/vim-devicons'
    Plug 'vim-airline/vim-airline-themes'
"    Plug 'navarasu/onedark.nvim'
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
    Plug 'xiyaowong/nvim-transparent'

    " Utilities
    Plug 'sheerun/vim-polyglot'
    Plug 'jiangmiao/auto-pairs'
    Plug 'ap/vim-css-color'
    Plug 'preservim/nerdtree'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'


    " Completion / linters / formatters
    Plug 'plasticboy/vim-markdown'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Git
    Plug 'airblade/vim-gitgutter'
call plug#end()


""""""""""""""""""""""
"""""""" Plugin Setup
""""""""""""""""""""""

""""""""""""
"""""" Theme
""""""""""""
colorscheme tokyonight

" transparent bg
" autocmd vimenter * hi Normal guibg=000000 ctermbg=000000
let g:transparent_enabled = v:true

" Enable theming support
if (has("termguicolors"))
 set termguicolors
endif


""""""""""""""
"""""" Airline
""""""""""""""
let g:airline_theme="base16_material_palenight""
let g:airline_powerline_fonts = 1


""""""""""""""""
"""""" NerdTree
""""""""""""""""
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>


""""""""""""""""""""""""""
"""""" Integrated Terminal
""""""""""""""""""""""""""
" open new split panes to right and below
set splitright
set splitbelow
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://zsh
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>


""""""""""""""""""""""
"""""""" Panels Switch
""""""""""""""""""""""
" use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l


"""""""""""""""""""""
"""""" File Searching
""""""""""""""""""""""
nnoremap <C-p> :FZF<CR>
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}


""""""""""""
"""""" CTRLP
""""""""""""
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Disable math tex conceal feature
let g:tex_conceal = ''
let g:vim_markdown_math = 1


""""""""""""""""""
"""""""" Markdown
""""""""""""""""""
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_fenced_languages = ['tsx=typescriptreact']


""""""""""""
"""""" COC
""""""""""""
let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver']


""""""""""""""
"""""""" Keymaps
""""""""""""""""
" Normal mode remappings
nnoremap <C-q> :q!<CR>
nnoremap <F4> :bd<CR>


""""""""""""
"""""" Tabs
""""""""""""
nnoremap <S-Tab> gT
nnoremap <Tab> gt
nnoremap <silent> <S-t> :tabnew<CR>

""""""""""""
"""""" KEYS
""""""""""""
nmap <M-Right> :vertical resize +1<CR>
nmap <M-Left> :vertical resize -1<CR>
nmap <M-Down> :resize +1<CR>
nmap <M-Up> :resize -1<CR>


""""""""""""""""
"""""" General
""""""""""""""""
set number
set tabstop=2
set expandtab
set smartindent
set shiftwidth
syntax enable
syntax on
set list
set ignorecase
set smartcase
set incsearch
