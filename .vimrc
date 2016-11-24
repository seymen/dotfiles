call plug#begin('~/.vim/plugged')
Plug 'bronson/vim-trailing-whitespace'
Plug 'shutnik/jshint2.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree' | Plug 'ryanoasis/vim-devicons'
Plug 'mileszs/ack.vim'
Plug 'airblade/vim-gitgutter'
Plug 'godlygeek/tabular'
Plug 'jszakmeister/vim-togglecursor'
Plug 'rbgrouleff/bclose.vim'
Plug 'SirVer/ultisnips'
Plug 'pangloss/vim-javascript'
Plug 'joshdick/onedark.vim'

Plug 'neomake/neomake'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'sukima/xmledit'
Plug 'junegunn/vim-emoji'
call plug#end()

let mapleader="\<Space>"

syntax on
filetype plugin on

set background=dark
colorscheme onedark

set encoding=utf8

" set guifont=Menlo:h12
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete:h14
set guioptions-=L " remove the left scrollbar in nerdtree
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
nmap <S-CR> O<Esc>
" enter in normal mode to insert a new line after the current line
nmap <CR> o<Esc>

" special pairing for {}
imap {{ {<CR>}<ESC>O
imap {{; {<CR>};<ESC>O
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

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

augroup my_commands
    autocmd!
    " autocmd BufWritePre,BufRead *.xml :normal gg=G
augroup END

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
let g:NERDTreeMouseMode=3 " single-click opens file

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
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" vim-emoji
let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
let g:gitgutter_sign_modified_removed = emoji#for('collision')

" vim-devicons
set ambiwidth=double
let g:airline_powerline_fonts = 1
let g:WebDevIconsUnicodeDecorateFolderNodes=1
let g:WebDevIconsNerdTreeAfterGlyphPadding=''
let g:WebDevIconsNerdTreeGitPluginForceVAlign=0

" mapping specific to apigee

" open policy file from proxy definition
map <leader>p vit<ESC>:CtrlP<CR><C-\>v<CR>
" create a policy file by extracting the name from inside tags
nmap aanp yit:e apiproxy/stepdefinitions/<C-R>".xml<CR>
" create a JavaScript policy definition for the current JS file
nmap aacp :e apiproxy/stepdefinitions/JavaScript.%:t:r.xml<CR>

augroup apigee_javascript_snippets
    " snippet#InsertSkeleton is under .vim/autoload/snippet.vim
    autocmd!
    " autocmd BufNewFile apiproxy/resources/jsc/*.js :w apiproxy/stepdefinitions/JavaScript.%:t:r.xml
    autocmd BufNewFile apiproxy/stepdefinitions/JavaScript.* silent! call snippet#InsertSkeleton('_javascript')
    autocmd BufNewFile apiproxy/stepdefinitions/AssignMessage.* silent! call snippet#InsertSkeleton('_assignmessage')
augroup END
