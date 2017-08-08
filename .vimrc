call plug#begin('~/.vim/plugged')
Plug 'bronson/vim-trailing-whitespace'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ap/vim-buftabline'
Plug 'scrooloose/nerdtree'
Plug 'mileszs/ack.vim'
Plug 'airblade/vim-gitgutter'
Plug 'godlygeek/tabular'
Plug 'jszakmeister/vim-togglecursor'
Plug 'rbgrouleff/bclose.vim'
Plug 'SirVer/ultisnips'
Plug 'pangloss/vim-javascript'
Plug 'w0rp/ale'
Plug 'Townk/vim-autoclose'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'sukima/xmledit'
call plug#end()

let mapleader="\<Space>"

syntax on
filetype plugin indent on

if has("gui_running")
    set guifont=Andale\ Mono:h14
    colorscheme desert
endif

set encoding=utf8

set guioptions-=L " remove the left scrollbar in nerdtree
set guioptions-=r "remove right scrollbar
set hidden
set autoindent
set confirm
set number " show line numbers
set ts=4 " set tab size to 4
set sw=4 " set shift width which is the one used when >
set noswapfile " disable vim creating swp files
" set cursorline " display the cursor line
set updatetime=750 " setting vim ui update to 750ms for gitgutter updates
set laststatus=2 "The default setting of 'laststatus' is for the statusline to not appear until a split is created. this is to set it to appear all the time
set undolevels=1000
set hlsearch " this will highlight all occurances of the search term on the file. In order to clear highlight, do :noh
set incsearch " do search as you type
set showcmd " displays commands you type in normal mode
set clipboard=unnamed " use OS clipboard for all operations
set expandtab
set nocompatible " enable backspace in insert mode
set backspace=2
set linespace=4
" cursor shape - bar in insert mode, block in normal mode
:let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" smooth scrolling of mouse
set mouse=a

" fix fat-fingers
map :W :w
map :Q :q

nnoremap <C-U> :call SmoothScroll(1)<Enter>
nnoremap <C-D> :call SmoothScroll(0)<Enter>
inoremap <C-U> <Esc>:call SmoothScroll(1)<Enter>i
inoremap <C-D> <Esc>:call SmoothScroll(0)<Enter>i

" line numbering
autocmd InsertEnter * set relativenumber!
autocmd InsertLeave * set relativenumber

" move between windows
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

" move between buffers
map <S-H> :bp<CR>
map <S-L> :bn<CR>

" enter in normal mode to insert a new line after the current line
nmap <CR> o<Esc>

" special pairing for {}
imap {{ {<CR>}<ESC>O
imap {{; {<CR>};<ESC>O
imap {{{ {<CR>});<ESC>O

" close current buffer
nmap :bd :bp <BAR> bd #<CR>

" statusline settings
set statusline=%f%=%{ALEGetStatusLine()}

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
nmap <C-i> :botright vnew<CR>
nmap <C-_> :split<CR>

" toggle comment
nmap cc <leader>c<space>

" automatically jump to end of text you pasted
nnoremap <silent> y y`]
nnoremap <silent> p p`]
nnoremap <silent> p p`]

" replace operation - yank something first and then
" replace in tag
nmap rit "_cit<ESC>p
nmap ri" "_ci"<ESC>p
nmap raw "_caw<ESC>p

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Plugin configurations
" ---------------------------------------------------------------------------

" Ale
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_set_quickfix = 1

" airline
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" this will feed the current word under cursor to CtrlP plugin
map <leader>w :CtrlP<CR><C-\>w
" CtrlP plugin to use the directory you started vim as root
let g:ctrlp_working_path_mode = 0
" find hidden dotfiles with CtrlP
let g:ctrlp_show_hidden = 1

" ack
" open a new tab and search for something
nmap <leader>s :Ack! ""<Left>
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
let g:UltiSnipsExpandTrigger="<c-r>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories="~/.vim/UltiSnips"
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
set rtp+=~/.vim/UltiSnips

" automatically create a file's folder if it doesn't exist
fun! <SID>AutoMakeDirectory()
    let s:directory = expand("<afile>:p:h")
    if !isdirectory(s:directory)
        call mkdir(s:directory, "p")
    endif
endfun
autocmd BufWritePre,FileWritePre * :call <SID>AutoMakeDirectory()

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
