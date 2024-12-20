" (N)Vim Configuration File
" vim  : place in $HOME/.vimrc
" nvim : place in $HOME/.config/nvim/init.vim
" $ ln -s $HOME/.config/nvim/init.vim $HOME/.vimrc
" General settings
" https://learnvimscriptthehardway.stevelosh.com/
" ---------------------------------------------------------------------------
" drop vi support - kept for vim compatibility but not needed for nvim
" Probably not needed with Vim 8+
"set nocompatible

" Search recursively downward from CWD; provides TAB completion for filenames
" e.g., `:find vim* <TAB>`
set path+=**

" number of lines at the beginning and end of files checked for file-specific vars
set modelines=0

" reload files changed outside of Vim not currently modified in Vim (needs below)
set autoread

" http://stackoverflow.com/questions/2490227/how-does-vims-autoread-work#20418591
au FocusGained,BufEnter * :silent! !

" use Unicode
set encoding=utf-8

" errors flash screen rather than emit beep
set visualbell

" make Backspace work like Delete
set backspace=indent,eol,start

" don't create `filename~` backups
set nobackup

" don't create temp files
set noswapfile

" line numbers and distances
set norelativenumber 
set number 

" number of lines offset when jumping
set scrolloff=2

" Tab key enters 2 spaces
" To enter a TAB character when `expandtab` is in effect,
" CTRL-v-TAB
set expandtab tabstop=2 shiftwidth=2 softtabstop=2 

" Indent new line the same as the preceding line
set autoindent

" statusline indicates insert or normal mode
set showmode showcmd

" make scrolling and painting fast
" ttyfast kept for vim compatibility but not needed for nvim
set ttyfast lazyredraw

" highlight matching parens, braces, brackets, etc
set showmatch

" http://vim.wikia.com/wiki/Searching
set hlsearch incsearch ignorecase smartcase

" As opposed to `wrap`
"set nowrap

" http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
set autochdir

" open new buffers without saving current modifications (buffer remains open)
set hidden

" http://stackoverflow.com/questions/9511253/how-to-effectively-use-vim-wildmenu
set wildmenu wildmode=list:longest,full

" StatusLine always visible, display full path
" http://learnvimscriptthehardway.stevelosh.com/chapters/17.html
set laststatus=2 statusline=%F

" Use system clipboard
" http://vim.wikia.com/wiki/Accessing_the_system_clipboard
" for linux
"set clipboard=unnamedplus
" for macOS
set clipboard=unnamed

" Folding
" https://vim.fandom.com/wiki/Folding
" https://vim.fandom.com/wiki/All_folds_open_when_opening_a_file
" https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
set foldmethod=indent
set foldnestmax=1
set foldlevelstart=1

" netrw and vim-vinegar
let g:netrw_browse_split = 3
" let g:coc_disable_startup_warning = 1
" Plugins, syntax, and colors
" ---------------------------------------------------------------------------
" vim-plug
" https://github.com/junegunn/vim-plug
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
"*************** Plugins ********************
call plug#begin('~/.local/share/nvim/plugged')

" Make sure to use single quotes
" Install with `:PlugInstall`

" https://github.com/itchyny/lightline.vim
Plug 'itchyny/lightline.vim'

" https://github.com/tpope/vim-commentary
Plug 'tpope/vim-commentary'

" https://github.com/tpope/vim-surround
Plug 'tpope/vim-surround'

" https://github.com/tpope/vim-vinegar
Plug 'tpope/vim-vinegar'

" https://github.com/APZelos/blamer.nvim
Plug 'APZelos/blamer.nvim'

" https://github.com/fenetikm/falcon/wiki/Installation
Plug 'fenetikm/falcon'

" https://github.com/macguirerintoul/night_owl_light.vim
Plug 'macguirerintoul/night_owl_light.vim'

" nerdtree
Plug 'preservim/nerdtree'

"coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"identation
Plug 'nathanaelkane/vim-indent-guides'


" mejora el syntax highlight
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" para los iconos
Plug 'ryanoasis/vim-devicons'


"fuzzy Search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

"para ver las identaciones
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1

" recomendaciones el nvim. health
let g:loaded_node_provider = 0
"
" ********** funciones ***********
"
" abre la busqueda fuzzy siempre en el folder con un .git
function! OpenLeaderfInGitDir()
    " Cambiar al directorio del repositorio git
    let l:git_dir = system('git rev-parse --show-toplevel')
    if v:shell_error
        echo "No es un repositorio Git"
        return
    endif
    " Eliminar el salto de línea al final
    let l:git_dir = substitute(l:git_dir, '\n', '', 'g')
    execute 'cd ' . l:git_dir
    " Abrir Leaderf file
    Files
endfunction

" hace que nerdtree siempre abra en la raiz del proyecto
function! OpenNERDTreeInGitDir()
    " Cambiar al directorio del repositorio git
    let l:git_dir = system('git rev-parse --show-toplevel')
    if v:shell_error
        echo "No es un repositorio Git"
        return
    endif
    " Eliminar el salto de línea al final
    let l:git_dir = substitute(l:git_dir, '\n', '', 'g')
    execute 'cd ' . l:git_dir
    " Abrir NERDTreeToggle
    NERDTreeToggle
endfunction

" ********** atajos de teclas *************

" busca una palbra hacia adelante
nnoremap <C-f> :/
" ctrl + p para abrir el Leaderf
nnoremap <C-p> :call OpenLeaderfInGitDir()<CR>
" abre el nerdtree
nnoremap <C-b> :call OpenNERDTreeInGitDir()<CR>
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"************* otras configuraciones ************
syntax enable
" Neovim only
set termguicolors 

" Light scheme
colorscheme sorbet

" Dark scheme
"colorscheme falcon
"set background=dark

" Show character column
set colorcolumn=80

" lightline config - add file 'absolutepath'
" Delete colorscheme line below if using Dark scheme

"*************** variables ***************

let g:lightline = {
      \ 'colorscheme': 'PaperColor_light',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'absolutepath', 'modified' ] ]
      \ }
      \ }

let g:blamer_enabled = 1
" %a is the day of week, in case it's needed
let g:blamer_date_format = '%e %b %Y'
highlight Blamer guifg=darkorange
