call plug#begin('~/.vim/plugged')
Plug 'w0rp/ale'
Plug 'bronson/vim-trailing-whitespace'
Plug 'scrooloose/nerdtree'
Plug 'mileszs/ack.vim'
Plug 'airblade/vim-gitgutter'
Plug 'godlygeek/tabular'
Plug 'jszakmeister/vim-togglecursor'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-commentary'
Plug 'sukima/xmledit'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

let mapleader="\<Space>"

syntax on
filetype plugin indent on
set encoding=utf8
set hidden
filetype indent on
set nowrap
set confirm
set autoindent
set number "show line numbers
set ts=4 "tab size"
set sw=4 "shift width which is the one used when >
set expandtab
set smartindent
set autoindent
set noswapfile "disable vim creating swp files
set updatetime=750 "ui to update in 750ms for gitgutter renderings"
set undolevels=1000
set history=100
set showcmd "displays commands you type in normal mode
set clipboard=unnamed "use OS clipboard for all operations
set splitbelow "open new split below which feels more natural
set showmatch "highlight matching paranthesis
set nocompatible
set backspace=2

"mouse support
set mouse+=a
if &term =~ '^screen'
    set ttymouse=xterm2
endif

"file searching
"highlight all occurances of the search term on the file
set hlsearch
"ability to cancel a search with Escape
" nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[
"do search as you type
set incsearch

"fat fingers
map :W :w
map :Q :q

"move between windows
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

"move between buffers
map <S-H> :bp<CR>
map <S-L> :bn<CR>

"ability to select autocomplete (CtrlP in insert mode) with enter key
inoremap <expr> <silent> <cr> pumvisible() ? "<c-y>" : "<cr>"

"enter in normal mode to insert a new line after the current line
nmap <CR> o<Esc>

"close current buffer
nmap :bd :bp <BAR> bd #<CR>

"splits
nmap <C-i> :botright vnew<CR>
nmap <C-_> :split<CR>

" automatically jump to end of text you pasted
" nnoremap <silent> y y`]
" nnoremap <silent> p p`]
" nnoremap <silent> p `]

" yy is broken for some reason
nmap yy Y

" easy switching between buffers
nmap <leader>b :buffers<CR>:b

" Plugin configurations
" ---------------------------------------------------------------------------
"
" ctrlp
let g:ctrlp_custom_ignore = {
            \ 'dir': 'node_modules'
            \ }

" ack
nmap <leader>s :Ack! ""<Left>

" ale
let g:ale_linters = {'javascript': ['eslint']}

" nerdtree
nmap <leader>n :NERDTreeFind<CR>
let NERDTreeShowHidden=1

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
let g:UltiSnipsExpandTrigger="<F6>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
let g:UltiSnipsEditSplit="vertical"
set rtp+=~/.vim/UltiSnips

" automatically create a file's folder if it doesn't exist
fun! <SID>AutoMakeDirectory()
    let s:directory = expand("<afile>:p:h")
    if !isdirectory(s:directory)
        call mkdir(s:directory, "p")
    endif
endfun
autocmd BufWritePre,FileWritePre * :call <SID>AutoMakeDirectory()

" apigee
" open policy file from proxy definition
map <leader>p vity<ESC>:CtrlP<CR><C-\>c<CR>
map <leader>np :e apiproxy/policies/.xml<Left><Left><Left><Left>
