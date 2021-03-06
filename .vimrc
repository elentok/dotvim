" vim: foldmethod=marker
" OS Specific {{{1

function! IdentifyOS()
  if system('uname -s') == "Darwin\n"
    return 'mac'
  elseif has('gui_win32')
    return 'windows'
  else
    return 'linux'
  end
endfunc

let g:os = IdentifyOS()

if g:os == 'windows'
  let $temp_dir=$TEMP . '\\vim'
  let $vimrc=$VIMRUNTIME . '/../.vimrc'
  let $vimfiles=$VIMRUNTIME . '/../vimfiles'
  let $session='D:/AppData/session.vim'
  let $delimiter='\\'
  let $defaultfont="Consolas:h12:cANSI"
  let $alternatefont="Courier_New:h12:cHEBREW"
  let g:ruby_path='C:/ruby187'
  set grepprg="findstr /nI"
  let g:Powerline_symbols='compatible'
  let $opener='start'
else
  let $temp_dir='/tmp/vim-' . $USER
  let $vimrc=expand('~/.vimrc')
  let $vimfiles=expand('~/.vim')
  let $session=expand('~/.session.vim')
  let $delimiter = '/'
  let $defaultfont='Monaco\ for\ Powerline:h13'
  let $alternatefont='Ubuntu\ Mono\ 13'
  let g:Powerline_symbols='fancy'
  " the 'wildignorecase' option is not available for windows
  set wildignorecase
  
  if file_readable('/usr/local/bin/ctags')
    let g:ctags='/usr/local/bin/ctags'
  else
    let g:ctags='ctags'
  end

  let $opener='open'
  if g:os == 'linux'
    let $opener='/usr/bin/xdg-open'
  end

endif


exec "set guifont=" . $defaultfont

if getftype($temp_dir) != 'dir'
  exec 'silent !mkdir ' . $temp_dir
endif

" Vundle {{{1
set nocompatible " disable vi compatibility
filetype off
let &rtp .= ',' . $vimfiles . "/bundle/vundle"
let bundle_root = $vimfiles . "/bundle"
call vundle#rc(bundle_root)
Bundle 'gmarik/vundle'

" Bundles {{{1

"Bundle 'L9'
"Bundle 'FuzzyFinder'
"
let g:ctrlp_dotfiles = 0
let g:ctrlp_root_markers = ['Gemfile', 'package.json', '.git']
let g:ctrlp_switch_buffer = 0
let g:ctrlp_by_filename = 1
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/](tmp)$',
  \ }
Bundle 'kien/ctrlp.vim'

let g:run_with_vimux=1
Bundle 'elentok/mailr.vim'
Bundle 'elentok/run.vim'
Bundle 'elentok/plaintasks.vim'
Bundle 'elentok/alternate-spec.vim'
Bundle 'elentok/supertagger'
map <f8> :SuperTagger<cr>

Bundle 'elentok/spec-runner.vim'
let g:spec_runner_use_vimux=1
let g:user_spec_runners = {
  \ 'ruby': { 'command': 'sp {file}' },
  \ 'java': { 'command': 'make test' }
  \}

let g:VimuxOrientation = "h"
let g:VimuxHeight = "40"
Bundle 'benmills/vimux'
let g:ScreenImpl = 'Tmux'
Bundle 'ervandew/screen'

Bundle 'sickill/vim-monokai'
Bundle 'guns/xterm-color-table.vim'

Bundle 'Lokaltog/vim-powerline'
"Bundle 'YankRing.vim'
Bundle 'scrooloose/nerdtree'
let NERDTreeIgnore=['\.zeus\.sock$', '\~$']
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-unimpaired'
Bundle 'danro/rename.vim'
Bundle 'godlygeek/tabular'

Bundle 'applescript.vim'

Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'

"Bundle 'Valloric/YouCompleteMe'

" SuperTab
"let g:SuperTabDefaultCompletionType = "context"
Bundle "ervandew/supertab"

"Snipmate (+ dependencies)
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "snipmate-snippets"
Bundle "garbas/vim-snipmate"
"let g:snips_trigger_key="<c-x>,"
"let g:snips_trigger_key_backwards="<c-x>."

"Rails
Bundle 'tpope/vim-rails.git'
Bundle 'tpope/vim-haml'
Bundle 'elentok/vim-rails-extra'
Bundle 'kchmck/vim-coffee-script'
Bundle 'pangloss/vim-javascript'

"Bundle 'kikijump/tslime.vim'

"Bundle 'rson/vim-conque'

  " YAML colors
Bundle 'yaml.vim'
  " YAML indentation
Bundle 'avakhov/vim-yaml'

Bundle 'groenewege/vim-less'

"NodeJS
Bundle 'digitaltoad/vim-jade'
Bundle 'wavded/vim-stylus'

Bundle 'scrooloose/syntastic.git'

let g:ackprg = 'ag --nogroup --nocolor --column'
Bundle 'mileszs/ack.vim'

Bundle 'airblade/vim-gitgutter'
Bundle 'rodjek/vim-puppet'

"Bundle 'jnwhiteh/vim-golang'
"Bundle 'go-vim'
"set rtp+=$GOROOT/misc/vim
"set rtp+=/usr/local/Cellar/go/1.0.3/misc/vim
"Bundle 'nsf/gocode', {'rtp': 'vim/'}

" Core {{{1 

syntax enable
"call pathogen#infect()

" Colors {{{1

set background=dark

if has('gui_running')
  color ir_black
  "color Monokai
  hi Normal guibg=#121212
else
  " enable 256 colors in the terminal
  set t_Co=256
  "color molokai
  color Monokai
  "hi Normal ctermbg=233
  "hi NonText ctermbg=232
  "hi Folded ctermbg=232
  
  hi Normal ctermbg=None
  hi Folded ctermbg=233
  hi NonText ctermbg=None

  "color ir_black
  "hi Normal ctermbg=none
  "hi NonText ctermbg=none
  "hi Visual ctermbg=238
  "hi SpellBad ctermbg=160
endif

" Settings {{{1
behave mswin
set guioptions=gt " use 'e' for gui tabs
set number            " show line numbers
set mouse=a
set scrolloff=3
set iskeyword=@,48-57,_,192-255,$,#,-
set switchbuf=useopen

" makes sure the active window will always be at least 80 characters
set winwidth=84

set undolevels=1000
set history=300       " remember 300 commands
set visualbell t_vb=

"set showmatch                  " briefly jump to matching parenthesis
let loaded_matchparen=1 " do not show highlight matching parenthesis automatically
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set whichwrap=<,>,[,]
set expandtab
set nowrap
set linebreak
set showbreak=>>

" Wild mode:
set wildmenu
set wildmode=full
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o,*.obj,*/node_modules/*,*/tmp/*

" Formatting
set formatoptions=qro
"set fillchars=vert:\|,fold:-
set fillchars=
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Rulers
set ruler             " enable ruler
set laststatus=2      " always show the statusline
set titlestring=0\ %t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)

"not necessary when using the powerline plugin:
"set rulerformat=%40(%3*[B:%n]%1*[L:%03l/%L]%2*[C:%02c]%4*[P:%03p/%P]%6*%m%r%)
"set statusline=%f\ %y\%=[B:%n][L:%03l/%L][C:%02c%V]\ %p/%P

" Search
set incsearch   " incremental search
set ignorecase  " ignore case when search
set smartcase   " ignore case if search pattern is all lowercase, case-sensitive otherwise
set hlsearch    " highlight search terms

" Highlight Current Line
"set cursorline
"highlight CursorLine guibg=black cterm=none term=none ctermbg=black

set tags=./tags,tags,./coffee.tags,coffee.tags

" Backup
set backup writebackup
set backupdir=$temp_dir
set dir=$temp_dir

" Folding
set foldtext=getline(v:foldstart)
let php_folding=1
let g:xml_syntax_folding=1

" Ruby
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
let g:rubycomplete_include_object = 1
let g:rubycomplete_include_objectspace = 1

" Fuzzyfinder tweaks
"let g:fuf_file_exclude='\v\~$|\.(o|exe|dll|bak|orig|sw[po])$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|node_modules|tmp'

"if $TMUX == ''
  "set clipboard+=unnamed
"endif

" Settings: Unicode:{{{1
" With the following settings Vim's UTF-8 behaves as follows:
" - new files with no nonascii chars (>1byte) will be saved as ANSI (no BOM)
" - new files with nonascii chars will be saved as UTF-8 (with BOM)
set encoding=utf-8
" create Unicode files with B.O.M. by default
"setglobal fileencoding=utf-8 bomb
setglobal fileencoding=utf-8
" define the heuristics to recognize file encodings
setglobal fileencodings=ucs-bom,utf-8,default


" Commands {{{1
command! AutoWrap set formatoptions+=c formatoptions+=t
command! AutoWrapOff set formatoptions-=c formatoptions-=t
command! W :w


" Key Mappings {{{1

map `b :!scripts/build.sh<cr>

vnoremap ,/ "9y/<c-r>9<cr>
vnoremap ,! "9y:<c-r>9<cr>


" Basics
map \s :set spell!<cr>
map <space> 20j
vmap <space> 20j
map - 20k
map <backspace> zc
imap <c-s> <c-o>:w<cr>
" super yank (yank to * and + registers)
vmap \y "*ygv"+y

imap <f2> <c-o>:call ToggleHebrew()<cr>
map <f2> :call ToggleHebrew()<cr>
imap <c-_> <c-o>:call ToggleHebrew()<cr>

map <F3> :TagbarToggle<cr>

func! ToggleHebrew()
  if &rl
    set norl
    set keymap=
  else
    set rl
    set keymap=hebrew
  end
endfunc


" File navigation
map ,t :tabe <C-R>=expand("%:p:h") . $delimiter <cr>
map ,e :e <C-R>=expand("%:p:h") . $delimiter <cr>
map ,E :read <C-R>=expand("%:p:h") . $delimiter <cr>
map ,d :cd <C-R>=expand("%:p:h")<cr><cr>
"map ,c :silent !start cmd.exe /k cd /d "<C-R>=expand("%:p:h")<cr>"<cr>
map ,v :tabe $vimrc<cr>
map ,V :tabe $vimfiles/bundle/vim-rails-extra/plugin/rails-extra.vim<cr>
map ,f :NERDTreeToggle<cr>
map ,F :NERDTreeFind<cr>
map ,b :CtrlPBuffer<cr>
map ,t :CtrlPTag<cr>
map `` :CtrlPBufTag<cr>
map ,m :CtrlPMRUFiles<cr>
map ,c :CtrlPChange<cr>
map \z :ConqueTermSplit zsh<cr>

nnoremap <silent> <Leader>] :exe "resize " . (&lines * 2/3)<CR>
nnoremap <silent> <Leader>[ :exe "resize " . (&lines * 1/3)<CR>

map <c-f12> :setlocal foldexpr=MyFoldingExpr(v:lnum)<cr>:setlocal foldmethod=expr<cr>
map <c-s-f12> :setlocal foldmethod=manual<cr>zE
map <c-f11> :vimgrep /^\*/ %<cr>:copen<cr>

map `f :exec "set guifont=" . $defaultfont<cr>
map `F :exec "set guifont=" . $alternatefont<cr>

map <m-space> :simalt ~<cr>
imap <m-space> <c-o>:simalt ~<cr>
map <m-f10> :simalt ~x<cr>
map <m-s-f10> :simalt ~r<cr>

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap \l :silent !tput clear<cr>:redraw!<cr>

" select a link and press "gx"
vmap gx "xy:call netrw#NetrwBrowseX(@x, 0)<cr>

command! Rspec :!clear; rspec --drb --color --format d spec<cr>

"map \r :RunRspecCurrentFileConque<cr>
"map \R :RunRspecCurrentLineConque<cr>
"map \\ :RunLastConqueCommand<cr>

 
" add symbols to the end of the lines:
map `1 :exec ":normal A <c-v><esc>" . (79 - strlen(getline("."))) . "A#"<cr>
map `2 :exec ":normal A <c-v><esc>" . (69 - strlen(getline("."))) . "A="<cr>
map `3 :exec ":normal A <c-v><esc>" . (59 - strlen(getline("."))) . "A-"<cr>
 
" run the selected text:
nmap <c-s-cr> 0v$"xy:silent exec ":!cmd /c start \"VimCmd\" " . @x<cr>
"vmap <c-cr> "xy:silent exec ":!cmd /c start \"VimCmd\" " . @x<cr>
"nmap <c-cr> :silent exec ":!start cmd /k " . expand("<cword>")<cr>

" Tabular
noremap \t= :Tab /=<cr>
noremap \t: :Tab /:\zs<cr>

map \gs :Gstatus<cr>
map \gd :call GitDiff()<cr>

function! GitDiff()
  let filename = buffer_name('%')
  if &filetype == 'gitcommit'
    let filename = expand("<cWORD>")
  endif
  exec "ConqueTermSplit git diff --color " . filename
  nnoremap q :bd!<cr>
  inoremap q <esc>:bd!<cr>
endfunc

function! CloseDiff()
  let diff_buffers = []
  for buffer_number in tabpagebuflist()
    let win_number = bufwinnr(buffer_number)
    if getwinvar(win_number, '&diff') == 1
      call add(diff_buffers, buffer_number)
    endif
  endfor
  diffoff!
  for buffer_number in diff_buffers
    exec ":bd! " . buffer_number
  endfor
  return diff_buffers
endfunc

" Auto Commands {{{1
augroup Elentok_Misc
  autocmd!
  autocmd FileType xml setlocal foldmethod=syntax
  autocmd VimEnter * set t_vb=
  "autocmd BufRead,BufEnter *.txt setlocal syntax=dtxt
  autocmd BufRead,BufEnter *.autoSetup setlocal syntax=xml
  autocmd BufRead,BufEnter *.xaml setlocal syntax=xml
  autocmd BufRead,BufEnter *.py setlocal ts=4 softtabstop=4 shiftwidth=4
  autocmd BufRead,BufEnter *.css setlocal foldmethod=marker
  autocmd BufRead,BufEnter *.scss setlocal foldmethod=marker
  autocmd BufRead,BufEnter *.applescript set filetype=applescript
  autocmd BufRead,BufEnter *.rxls setlocal filetype=ruby
  autocmd BufRead,BufEnter *.md setlocal filetype=markdown
  autocmd BufRead,BufEnter gitconfig setlocal filetype=gitconfig
  autocmd BufRead,BufEnter .gitconfig* setlocal filetype=gitconfig

  " Javascript
  autocmd BufRead,BufEnter *.js setlocal nocindent smartindent
  autocmd BufRead,BufEnter *.json setlocal filetype=javascript
  autocmd BufRead,BufEnter Brewfile setlocal filetype=coffee
  autocmd BufRead,BufNewFile *.hamlc set ft=haml
  autocmd BufRead,BufNewFile *.hamljs set ft=haml

  " Autocomplete
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType html setlocal autoindent omnifunc=htmlcomplete#CompleteTags
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType smarty setlocal autoindent
  autocmd FileType java setlocal foldmethod=syntax noexpandtab

  " UTF8
  autocmd FileType vim setlocal nobomb

  ".vimrc
  "autocmd BufWritePost .vimrc source %

  "snippets
  "autocmd BufWritePost *.snippets call ReloadAllSnippets()

  " Home file
  autocmd BufRead,BufEnter home.txt map <buffer> <c-cr> :call HomeExecute()<cr>

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  autocmd VimEnter * call PostStartupStuff()
augroup END

func! PostStartupStuff()
  vmap <tab> >gv
  vmap <s-tab> <gv
endfunc

" Map <cr> to hide search highlight {{{1

map <cr> :nohls<cr>

" remap <cr> in quickfix buffers
func! RemapCrInQuickFixBuffers()
  if &buftype == 'quickfix'
    nnoremap <buffer> <cr> <cr>
  end
endfunc

augroup RemapCrInQuickFixBuffers
  autocmd!
  autocmd BufRead * call RemapCrInQuickFixBuffers()
augroup END

" Extra: JSLint {{{1
"func! JSLint()
  "if has("win32")
    "let jsl = $vimfiles . "/bin/win32/jsl/jsl.exe"
  "else
    "let jsl = $vimfiles . "/bin/linux/jsl/jsl"
  "endif
  "cexpr system(jsl . ' -nofilelisting -nocontext -nologo -nosummary -process "' . expand("%:p") . '"')
"endfun
"map <Leader>j :call JSLint()<cr>

" Extra: CoffeeScript {{{1
func! CoffeeMake()
  if getline(1) =~ 'autocompile'
    silent make
    redraw!
    cw
  end
endfunc
augroup Elentok_CoffeeScript
  autocmd!
  autocmd BufWritePost *.coffee call CoffeeMake()
augroup END
func! MyCoffeeLint()
  CoffeeLint
  if len(getqflist()) > 0
    copen
    wincmd w
  else
    cclose
  endif
endfunc
map \j :call MyCoffeeLint()<cr>

" Extra: Folding Expression {{{1
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

" Extra: Home Execute {{{1
func! HomeExecute()
  let line = getline('.')
  let line = substitute(line, '^ \+', '', '')
  let line = substitute(line, ' \+$', '', '')
  if isdirectory(line)
    execute 'cd ' . line
    execute 'e ' . line
  elseif filereadable(line)
    execute 'e ' . line
  endif
endfunc

" Extra: Search google {{{1

func! WebSearch(url)
  let searchterm = input('Search: ', expand("<cword>"))
  if searchterm != ''
    let url = substitute(a:url, "%query%", searchterm, '')
    call Browse(url)
  end
endfunc

func! Browse(url)
  if has('gui_win32')
    call system("start " . a:url)
  else
    call system($opener . " '" . a:url . "' &")
  end
endfunc

map ,g :call WebSearch("https://google.com/search?q=%query%")<cr>

" Extra: Calc {{{1

if has('python')
  :command! -nargs=+ Calc :py print <args>
  :py from math import *
end

" Misc Notes {{{1
"
" - for some reason 'showcmd' causes a delay after pressing <Escape> in insert
"   mode, so I'm disabling it for now:
"     set showcmd
"
" - to enable autowrap: set formatoptions+=ct
" - show the ascii value of a char: "ga"

" Post Init {{{1
filetype plugin indent on

function! MyCloseDiff()
  if (&diff == 0 || getbufvar('#', '&diff') == 0)
        \ && (bufname('%') !~ '^fugitive:' && bufname('#') !~ '^fugitive:')
    echom "Not in diff view."
    return
  endif

  " close current buffer if alternate is not fugitive but current one is
  while bufname('%') =~ '^fugitive:'
    bd
  endwhile
  "if bufname('#') !~ '^fugitive:' && bufname('%') =~ '^fugitive:'
    "if bufwinnr("#") == -1
      "b #
      "bd #
    "else
      "bd
    "endif
  "else
    "bd #
  "endif
endfunction
nnoremap <Leader>gD :call MyCloseDiff()<cr>

" Extra: Ack {{{1

"function! Ack(text)
  "call AddOriginalEfmIfMissing()
  "let cmd = "ack --nogroup --nocolor --column --nopager --flush " . a:text . " > /tmp/ack-output"
  ""let cmd = "ag --nogroup --nocolor --column --nopager " . a:text . " > /tmp/ack-output"
  "call system(cmd)
  "lget /tmp/ack-output
  "lw
"endfunc

"let g:original_efm=&efm

"function! AddOriginalEfmIfMissing()
  "" this fixes a problem where custom errorformat mess up Ack
  "if stridx(&efm, g:original_efm) == -1
    "let &efm = &efm . g:original_efm
  "end
"endfunc

":command! -nargs=+ Ack :call Ack("<args>")
nnoremap \a :Ack! <c-r>=expand("<cword>")<cr><cr>
vnoremap \a "9y:Ack! '<c-r>9'<cr>

"command! -nargs=+ Ag Ack! "<nargs>"

cnoreabbrev Ag Ack!

" Extra: Vimux-RailsTests {{{1

"command! RailsConsole :call VimuxRunCommand('RAILS_ENV=test rails c')
"command! W :w | :call VimuxRunCommand("load '" . @% ."';")
"map \R :call VimuxRunCommand(".clear\nrspec " . @%)<cr>
"map \r :call VimuxRunCommand(".clear\nrspec " . @% . ':' . line('.'))<cr>

" NERDTree fix
function! FixNERDTreeWidth()
  let winwidth = winwidth(".")
  if winwidth < g:NERDTreeWinSize
    exec("silent vertical resize " . g:NERDTreeWinSize)
  endif
endfunc

autocmd BufEnter * if exists("b:NERDTreeType") | call FixNERDTreeWidth() | endif
