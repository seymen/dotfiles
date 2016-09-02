" call plug#begin('~/.config/nvim/plugged')
call plug#begin('~/.vim/plugged')
Plug 'bronson/vim-trailing-whitespace'
Plug 'neomake/neomake'
Plug 'shutnik/jshint2.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree', {'on':'NERDTreeToggle'}
Plug 'mileszs/ack.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tomtom/tcomment_vim'
Plug 'pangloss/vim-javascript'
Plug 'godlygeek/tabular'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'rstacruz/sparkup'
Plug 'jszakmeister/vim-togglecursor'
Plug 'vim-airline/vim-airline-themes'
Plug 'rbgrouleff/bclose.vim'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'joshdick/onedark.vim'
Plug 'ddrscott/vim-side-search'
Plug 'SirVer/ultisnips'
call plug#end()

let mapleader="\<Space>"

syntax on
filetype plugin on

set background=dark
colorscheme onedark

set guifont=Menlo:h12
set hidden
set autoindent
set confirm
set number " show line numbers
set ts=4 " set tab size to 4
set sw=4 " set shift width which is the one used when >
set noswapfile " disable vim creating swp files
set cursorline " display the cursor line
set updatetime=750 " setting vim ui update to 750ms for gitgutter updates
set laststatus=2 "The default setting of 'laststatus' is for the statusline to not appear until a split is created. this is to set it to appear all the time
set undolevels=1000
set hlsearch " this will highlight all occurances of the search term on the file. In order to clear highlight, do :noh
set incsearch " do search as you type
set showcmd " displays commands you type in normal mode
set clipboard=unnamed " use OS clipboard for all operations
" colorcolumn
set textwidth=80
set colorcolumn=+1
" always use space - force it!. Especially useful for markdown editing
set expandtab
" hi ColorColumn guibg=#2d2d2d ctermbg=246
" enable backspace in insert mode
set nocompatible
set backspace=2
" line spacing
set linespace=4
" cursor shape - bar in insert mode, block in normal mode
:let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
" for tmux mouse to work
set mouse=a
" remove right scrollbar
set guioptions-=r

" line numbering
autocmd InsertEnter * set relativenumber!
autocmd InsertLeave * set relativenumber

" disable arrow keys
nmap <Up> <Nop>
nmap <Down> <Nop>
nmap <Right> <Nop>
nmap <Left> <Nop>
imap <Up> <Nop>
imap <Down> <Nop>
imap <Right> <Nop>
imap <Left> <Nop>
vmap <Up> <Nop>
vmap <Down> <Nop>
vmap <Right> <Nop>
vmap <Left> <Nop>

" move between windows
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

" jump to previous window (for buffer :bp<CR>, for tab :tabp<CR>)
map <S-H> :bp<CR>
" jump to next window (for buffer :bn<CR>, for tab :tabn<CR>)
map <S-L> :bn<CR>

" shift-enter in normal mode to insert a new-line before the current line
nmap <S-Enter> O<Esc>
" enter in normal mode to insert a new line after the current line
nmap <CR> o<Esc>

" special pairing for {}
imap {{ {<CR>}<ESC>O
imap {{{ {<CR>});<ESC>O

" ability to go to the end of the file in insert mode
inoremap <C-e> <C-o>$

" close current buffer
nmap :bd :bp <BAR> bd #<CR>

" close current buffer
nmap <D-w> :Bclose<CR>

" my surround mappings using vim-surround
nmap "" ysiw"
nmap '' ysiw'
nmap `` ysiw`

" mapping for :noh - clears search highlight and also clears the screen
nnoremap <C-c> :nohlsearch<CR><C-l>

" for tmux extended mouse mode
set mouse+=a
if &term =~ '^screen'
	set ttymouse=xterm2
endif

" new vertical split
nmap <leader>vs :botright vnew<CR>

" automatically jump to end of text you pasted
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" replace operation - yank something first and then
" replace in tag
nmap rit "_cit<ESC>p
nmap raw "_caw<ESC>p

" Plugin configurations
" ---------------------------------------------------------------------------

" airline
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" vim-javascript
set conceallevel=1
let g:javascript_conceal_function       = "ƒ"
let g:javascript_conceal_null           = "ø"
let g:javascript_conceal_this           = "@"
let g:javascript_conceal_return         = "⇚"
let g:javascript_conceal_undefined      = "¿"
let g:javascript_conceal_NaN            = "ℕ"
let g:javascript_conceal_prototype      = "¶"
let g:javascript_conceal_static         = "•"
let g:javascript_conceal_super          = "Ω"
let g:javascript_conceal_arrow_function = "⇒"

" neomake
autocmd! BufWritePost * Neomake " run neomake on each save
let g:neomake_open_list = 2 " neomake to open quick window to list errors
let g:neomake_javascript_enabled_makers = ['jshint']

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" this will feed the current word under cursor to CtrlP plugin
map <leader>w :CtrlP<CR><C-\>w
" CtrlP plugin to use the directory you started vim as root
let g:ctrlp_working_path_mode = 0
" rmap to Cmd+T
nmap <D-t> <C-p>
" find hidden dotfiles with CtrlP
let g:ctrlp_show_hidden = 1

" ack
" open a new tab and search for something
nmap <leader>s :Ack! ""<Left>
nmap <D-f> :Ack! ""<Left>
" search for word under cursor
nmap <leader>f :Ack!<CR><C-\>w

" nerdtree
map <silent> <F5> :NERDTreeToggle<CR>
map <silent> <C-n> :NERDTreeFocus<CR>

" tabularize
" run Tabularize each time I press | character
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
function! s:align()
	let p = '^\s*|\s.*\s|\s*$'
	if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
		let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
		let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
		Tabularize/|/l1
		normal! 0
		call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
	endif
endfunction

" ultisnip
let g:UltiSnipsExpandTrigger="<Enter>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" mapping specific to apigee

" open policy file from proxy
map <leader>p vit<ESC>:CtrlP<CR><C-\>v<CR>

" create a policy file by extracting the name from inside tags
nmap aanp yit:e apiproxy/stepdefinitions/<C-R>".xml<CR>
