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
Plug 'tpope/vim-dispatch'
Plug 'vim-airline/vim-airline'
Plug 'tomasiser/vim-code-dark'
Plug 'janko-m/vim-test'
Plug 'tmsvg/pear-tree'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'bigfish/vim-js-context-coloring'
call plug#end()

let mapleader="\<Space>"

colorscheme codedark

syntax on
filetype plugin indent on
set encoding=utf8
set hidden
filetype indent on
set nowrap
set confirm
set autoindent
set ts=2 "tab size"
set sw=2 "shift width which is the one used when >
set expandtab
set smartindent
set autoindent
set noswapfile "disable vim creating swp files
set updatetime=750 "ui to update in 750ms for gitgutter renderings"
set undolevels=1000
set history=100
set showcmd "displays commands you type in normal mode
set clipboard=unnamedplus "use OS clipboard for all operations
set splitbelow "open new split below which feels more natural
set showmatch "highlight matching paranthesis
set nocompatible
set backspace=2

"line numbering
set number relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

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

" easy switching between buffers
nmap <leader>b :buffers<CR>:b

" automatically create a file's folder if it doesn't exist
fun! <SID>AutoMakeDirectory()
    let s:directory = expand("<afile>:p:h")
    if !isdirectory(s:directory)
        call mkdir(s:directory, "p")
    endif
endfun
autocmd BufWritePre,FileWritePre * :call <SID>AutoMakeDirectory()

" inoremap " ""<left>
" inoremap ' ''<left>
" inoremap ( ()<left>
" inoremap [ []<left>
" inoremap { {}<left>
" inoremap {<CR> {<CR>}<ESC>O
" inoremap {;<CR> {<CR>};<ESC>O

" Plugin configurations
" ---------------------------------------------------------------------------
"
" ctrlp
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode=0
set wildignore+=*/node_modules/*,.git

" ack
nmap <leader>s :Ack! ""<Left>

" markdown-preview
let vim_markdown_preview_github=1

" ale
let g:ale_linters = {'javascript': ['eslint']}
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_fix_on_save = 1

" nerdtree
nmap <leader>n :NERDTreeFind<CR>
nmap <leader>/ :NERDTreeToggle<CR>
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

" vim-dispatch
setl errorformat+=%+G%.%# "sets quickfix to stay open even though there are no errors
":Dispatch command is looking at b:dispatch variable for the command to run
autocmd FileType javascript let b:dispatch = 'node %' "setting node as the runner for js files

" airline
let g:airline#extensions#tabline#enabled = 1

" vim-test
let test#strategy="vimterminal"

" pear-tree
" Smart pairs are disabled by default:
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

let g:pear_tree_repeatable_expand = 0

" apigee
" open policy file from proxy definition
map <leader>p vity<ESC>:CtrlP<CR><C-\>c<CR>
map <leader>pp vity<ESC>:vsplit<CR><C-l>:CtrlP<CR><C-\>c<CR>
map <leader>np :e apiproxy/policies/.xml<Left><Left><Left><Left>
