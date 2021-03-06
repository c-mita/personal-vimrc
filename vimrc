runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()
Helptags

let mapleader="\<space>"

set noerrorbells visualbell t_vb=
autocmd GUIEnter * set vb t_vb=

set encoding=utf-8

set backspace=2
set backspace=indent,eol,start

set hlsearch

set scrolloff=2

syntax enable
if has('gui_running')
    colorscheme lucius
    LuciusDarkLowContrast
    au VimEnter * wincmd p
else
    set t_Co=256
    colorscheme lucius
    LuciusDarkLowContrast
endif
au VimEnter * MBEOpen
au VimEnter * set splitbelow
au VimEnter * set splitright

set lcs=eol:↲,tab:>-,trail:·
set list

filetype plugin on
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
set foldmethod=syntax
set guifont=Inconsolata\ Medium\ 10

set number
set norelativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set foldnestmax=3

"au BufRead * :YAIFAMagic
au BufWinEnter * call SetWhitespaceHighlighting()

highlight ExtraWhiteSpace ctermbg=52

function! RelNumberToggle()
    if (&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunction

function! SetWhitespaceHighlighting()
    if &expandtab
        if exists('w:mspaceindent')
            call matchdelete(w:mspaceindent)
            unlet w:mspaceindent
        endif
        if !exists('w:mtabindent')
            let w:mtabindent = matchadd('ExtraWhiteSpace', '^\t\+')
        endif
    else
        if exists('w:mtabindent')
            call matchdelete(w:mtabindent)
            unlet w:mtabindent
        endif
        if !exists('w:mspaceindent')
            let w:mspaceindent = matchadd('ExtraWhiteSpace', '^ \+')
        endif
    endif
endfunction

inoremap jk <esc>
inoremap <Home> <esc>^i
nnoremap <Home> ^
inoremap <Home><Home> <esc> 0i
nnoremap <Home><Home> 0
nnoremap '# :let @/ = ""<CR>
nnoremap <C-Up> :m .-2<CR>
nnoremap <C-Down> :m .1<CR>
nnoremap <Leader><space> za
nnoremap rn :call RelNumberToggle()<CR>
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
nmap <Leader><Up> :wincmd k<CR>
nmap <Leader><Down> :wincmd j<CR>
nmap <Leader><Left> :wincmd h<CR>
nmap <Leader><Right> :wincmd l<CR>

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
elseif has("macunix")
    runtime vimrc_macosx
else
    runtime vimrc_linux
endif

"match columns > 120
au BufWinEnter * let w:mlength = matchadd('Error', '\%121v.\+', -2)
"match trailing whitespace and spaces before tabs
au BufWinEnter * let w:mtrailing = matchadd('Error', '\s\+$\| \+\ze\t , -2')

"Ignores
set wildignore+=*.swp,*.class,*.o,*~
let g:ctrlp_custom_ignore='\v[\/]\.(git|hg|svn)$'


"[CTRLP]"

let g:ctrlp_working_path_mode='rw'

command! -nargs=1 SD call CtrlPSpecificDirectory( <f-args> )
command! -nargs=1 Sd call CtrlPSpecificDirectory( <f-args> )

function! CtrlPSpecificDirectory( directory )
    let l:default = 'ra'
    if exists( "g:ctrlp_working_path_mode" )
        let l:default = g:ctrlp_working_path_mode
    endif
    let g:ctrlp_working_path_mode = 0
    exe 'cd' a:directory
    echo a:directory
    CtrlP
    let g:ctrlp_working_path_mode = l:default
endfunction

"[CLANG_COMPLETE]"
if has("win32")
    let g:clang_use_library = 1
    "let g:clang_library_path='C:\llvm\build\Release\bin'
    "May need to configure library path specifically
    let g:clang_user_options='|| exit 0' "magic setting to make
    set conceallevel=2
    set concealcursor=vin
    let g:clang_snippets=1
    let g:clang_conceal_snippets=1
    let g:clang_snippets_engine='clang_complete'
    set completeopt=menu,menuone
    let g:SuperTabDefaultCompletionType='<c-x><c-u><c-p>'
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
"au BufWritePre * :%s/\s\+$//e "strip spaces

"[JAVA]

function! ConfigureJava()
    set autoindent
    set smartindent
endfunction

au FileType java call ConfigureJava()

"[OPENCL]"

function! ConfigureForOpenCl()
    set ft=opencl
endfunction

au BufNewFile,BufRead *.cl call ConfigureForOpenCl()

"[GIT]
"
function ConfigureForGit()
    au! BufEnter * call setpos('.', [0, 1, 1, 0])
    setlocal spell textwidth=72
endfunction

au FileType gitcommit call ConfigureForGit()
au FileType hgcommit call ConfigureForGit()


if filereadable( $HOME . "/.vim/vimrc_specific" )
    runtime vimrc_specific
endif
