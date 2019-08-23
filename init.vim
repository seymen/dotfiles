call plug#begin('~/.vim/plugged')
Plug 'w0rp/ale' "linting
Plug 'bronson/vim-trailing-whitespace' "unnecessary whitespaces at the end of lines
Plug 'scrooloose/nerdtree'
Plug 'mileszs/ack.vim' "searching
Plug 'airblade/vim-gitgutter'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-commentary'
Plug 'sukima/xmledit'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-dispatch'
Plug 'tmsvg/pear-tree'
Plug 'ap/vim-buftabline'
Plug 'sheerun/vim-polyglot' "lang specific syntax highlighting
Plug 'neoclide/coc.nvim', {'branch': 'release'} "auto completion
"Plug 'JamshedVesuna/vim-markdown-preview'
" Plug 'bigfish/vim-js-context-coloring'
call plug#end()

let mapleader="\<Space>"

syntax enable

set ts=2 "tab size"
set sw=2 "shift width which is the one used when >
set clipboard=unnamedplus "use OS clipboard for all operations
set mouse+=a
set hidden "hide a buffer instead of closing it
set splitbelow "open new split below which feels more natural
set expandtab "insert space characters whenever tab is pressed

"enter in normal mode to insert a new line after the current line
nmap <CR> o<Esc>
"close current buffer
nmap :bd :bp <BAR> bd #<CR>
"move between buffers
map <S-H> :bp<CR>
map <S-L> :bn<CR>
"close current buffer
nmap :bd :bp <BAR> bd #<CR>
"splits
nmap <C-i> :botright vnew<CR>
nmap <C-_> :split<CR>

" automatically create a file's folder if it doesn't exist
fun! <SID>AutoMakeDirectory()
	let s:directory = expand("<afile>:p:h")
	if !isdirectory(s:directory)
		call mkdir(s:directory, "p")
	endif
endfun
autocmd BufWritePre,FileWritePre * :call <SID>AutoMakeDirectory()


"line numbering
set number relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END


" Plugin configurations
" ---------------------
"
" ctrlp
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode=0
set wildignore+=*/node_modules/*,.git

" ack
nmap <leader>s :Ack! ""<Left>

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

" vim-dispatch
setl errorformat+=%+G%.%# "sets quickfix to stay open even though there are no errors
":Dispatch command is looking at b:dispatch variable for the command to run
autocmd FileType javascript let b:dispatch = 'node %' "setting node as the runner for js files

" vim-test
let test#strategy="vimterminal"

" pear-tree
" Smart pairs are disabled by default:
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1
let g:pear_tree_repeatable_expand = 0
