runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

if has('gui_running')
    colorscheme lucius
    LuciusDarkLowContrast
    au VimEnter * NERDTree
    au VimEnter * wincmd p
else
    colorscheme ron
endif
au VimEnter * MBEOpen
au VimEnter * set splitbelow 
au VimEnter * set splitright

filetype plugin on
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
set foldmethod=syntax
set guifont=Inconsolata\ Medium\ 10

set number
set tabstop=4
set shiftwidth=4
set expandtab
syntax on

inoremap jk <esc>
inoremap <Home> <esc>^i
nnoremap <Home> ^
inoremap <Home><Home> <esc> 0i
nnoremap <Home><Home> 0
nnoremap '# :let @/ = ""<CR>
nnoremap <C-Up> :m .-2<CR>
nnoremap <C-Down> :m .1<CR>
nnoremap <space> za
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

command Q :q
command Qa :qa
command QA :qa
command W :w
command Wq :wq
command WQ :wq
command WQA :wqa
command Wqa :wqa
command WQa :wqa

if has("win32")
    runtime vimrc_win
else
    runtime vimrc_linux
endif

"[PYTHON]"

"Setup basic python stuff
function! ConfigureForPython()
    nnoremap <F5> :w<CR> :RPy<CR>
    command! -nargs=* R RPy <args>
    set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
    set foldmethod=indent
    set omnifunc=pythoncomplete#Complete
endfunction

"lucius
let python_highlight_all=1 
let python_version_2 = 1
let g:xml_syntax_folding=1

au FileType python call ConfigureForPython() 
au BufWritePre *.py :%s/\s\+$//e "strip spaces


"[OPENCL]"

function! ConfigureForOpenCl()
    set ft=opencl
endfunction

au BufNewFile,BufRead *.cl call ConfigureForOpenCl()

"[GIT]

au FileType gitcommit au! BufEnter call setpos('.', [0, 1, 1, 0])


