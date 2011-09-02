syntax enable
"color koehler
"color wombat
color molokai

set nocompatible


filetype plugin on
filetype indent on

if has('gui_win32')
  let $temp='t:/vim'
  let $vimrc=$VIMRUNTIME . '/../.vimrc'
  let $session='D:/AppData/session.vim'
  set guifont=Consolas:h12:cANSI
  "set guifont=Monaco:h10:cANSI
else
  let $temp='/tmp/vim-' . $USER
  let $vimrc=expand('~/.vimrc')
  let $session=expand('~/.session.vim')
  "set guifont=Consolas\ 10
  set guifont=Bitstream\ Vera\ Sans\ Mono\ 12
endif

map `f :set guifont=Consolas:h10<cr>
map `F :set guifont=Courier_New:h10:cHEBREW<cr>

if getftype($temp) != 'dir'
  exec '!mkdir ' . $temp
endif

" if getftype($session) != 'file'
"   mksession! $session 
" endif



" misc
set number
set wildmenu wildmode=full
set grepprg="findstr /nI"
set showcmd undolevels=1000 history=300
set incsearch ignorecase hlsearch
set backspace=2 whichwrap=<,>,[,] expandtab
set nowrap linebreak showbreak=>>
set formatoptions=qro
"to enable autowrap: set formatoptions+=ct
set fillchars="vert:|"
set vb t_vb=
set ruler laststatus=2 " enable ruler + always show the statusline
set rulerformat=%40(%3*[B:%n]%1*[L:%03l/%L]%2*[C:%02c]%4*[P:%03p/%P]%6*%m%r%)
set statusline=%f\%=[B:%n][L:%03l/%L][C:%02c%V]\ %p/%P
set ts=2 softtabstop=2 shiftwidth=2
set titlestring=0\ %t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
set t_vb=

" backup
set backup writebackup
set backupdir=$temp
set dir=$temp

" commands
command! AutoWrap set formatoptions+=c formatoptions+=t
command! AutoWrapOff set formatoptions-=c formatoptions-=t

map `0 :e $vimrc<cr>
map ,e          :e <C-R>=expand("%:p:h") . "\\" <cr>
map ,d          :cd <C-R>=expand("%:p:h")<cr><cr>
map ,c          :silent !start cmd.exe /k cd /d "<C-R>=expand("%:p:h")<cr>"<cr>
map ,t          :e d:/documents/todo.txt<cr>
map `d          :E d:<cr>


map `` :tabnew<cr>

map <space> <PageDown>
map - <PageUp>
map <backspace> zc

imap <c-s> <c-o>:w<cr>
imap <c-space> <c-x><c-n>

"autocmd VimLeave * mksession! $session
"autocmd VimEnter * so $session
autocmd VimEnter * set t_vb=

let g:xml_syntax_folding=1
autocmd FileType xml setlocal foldmethod=syntax


autocmd BufRead,BufEnter *.txt setlocal syntax=dtxt
autocmd BufRead,BufEnter *.autoSetup setlocal syntax=xml
autocmd BufRead,BufEnter *.xaml setlocal syntax=xml
autocmd BufRead,BufEnter *.json setlocal syntax=javascript
autocmd BufRead,BufEnter *.py setlocal ts=4 softtabstop=4 shiftwidth=4

"map <c-f12> :setlocal foldmethod=syntax<cr>
"map <c-f12> :setlocal foldexpr=getline(v:lnum)=~'^\*'?'>1':1<cr>:setlocal foldmethod=expr<cr>
map <c-f12> :setlocal foldexpr=MyFoldingExpr(v:lnum)<cr>:setlocal foldmethod=expr<cr>
map <c-s-f12> :setlocal foldmethod=manual<cr>zE
map <c-f11> :vimgrep /^\*/ %<cr>:copen<cr>

imap <f12> <c-r>=strftime("%d/%m/%Y %H:%M")<cr>

function! MyFoldingExpr(lnum)
    let line=getline(a:lnum)
    if line[0] == '*'
        if line[1] == '*'
            return '>2'
        else
            return '>1'
        endif
    else
        return '='
    endif
endfunction

map ,, :nohls<cr>
"set guioptions=egmrLtT
"set guioptions=egmrLt
set guioptions=egmrLt

behave mswin

map <m-space> :simalt ~<cr>
imap <m-space> <c-o>:simalt ~<cr>
map <m-f10> :simalt ~x<cr>
map <m-s-f10> :simalt ~r<cr>

"*open link ==========================================================
" select a link and press "gx"
vmap gx "xy:call netrw#NetrwBrowseX(@x, 0)<cr>
 
"*add symbols to the end of the lines ================================
map `1 :exec ":normal A <c-v><esc>" . (79 - strlen(getline("."))) . "A#"<cr>
map `2 :exec ":normal A <c-v><esc>" . (69 - strlen(getline("."))) . "A="<cr>
map `3 :exec ":normal A <c-v><esc>" . (59 - strlen(getline("."))) . "A-"<cr>
 
"*run the selected text ==============================================
nmap <c-s-cr> 0v$"xy:silent exec ":!cmd /c start \"VimCmd\" " . @x<cr>
vmap <c-cr> "xy:silent exec ":!cmd /c start \"VimCmd\" " . @x<cr>
"nmap <c-cr> :silent exec ":!start cmd /k " . expand("<cword>")<cr>
nmap <c-cr> :Utl<cr>

" Unicode Settings #############################################################
" With the following settings Vim's UTF-8 behaves as follows:
" - new files with no nonascii chars (>1byte) will be saved as ANSI (no BOM)
" - new files with nonascii chars will be saved as UTF-8 (with BOM)
set encoding=utf-8
" create Unicode files with B.O.M. by default
setglobal fileencoding=utf-8 bomb
" define the heuristics to recognize file encodings
setglobal fileencodings=ucs-bom,utf-8,default

function! ReplaceStuff()
  %s/-//g
  %s/M21/-M21/g
  %s/Neg/Negative/g
  %s/Pos/Positive/g
  %s/\.GIF/Volt/g
endfunction

nnoremap <silent> <F8> :TlistToggle<CR>


let g:miniBufExplMapWindowNavVim = 1 
let g:miniBufExplMapWindowNavArrows = 1 
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTarget = 1 

let g:SuperTabDefaultCompletionType = "<c-o>"

function! ShowSidebars()
  copen
  TagbarOpen
  NERDTree
  wincmd l
endfunction

function! HideSidebars()
  cclose
  TagbarClose
  NERDTreeClose
endfunction

map <f11> :call HideSidebars()<cr>
map <f12> :call ShowSidebars()<cr>


func! JSLint()
  cexpr system('jsl -nofilelisting -nocontext -nologo -nosummary -process "' . expand("%:p") . '"')
endfun

augroup Dudi
  autocmd!
  autocmd BufRead,BufEnter *.js map <buffer> `j :call JSLint()<cr>
  autocmd BufRead,BufEnter *.js setlocal nocindent smartindent
augroup END

