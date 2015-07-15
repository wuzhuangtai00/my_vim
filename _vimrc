
syntax on
set nocompatible
set ai!
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | letf opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {<CR>}<ESC>O
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i

function! ClosePair(char)
 if getline('.')[col('.') - 1] == a:char
     return "\<Right>"
 else
     return a:char
 endif
endfunction

function CloseBracket()
 if match(getline(line('.') + 1), '\s*}') < 0
 return "\<CR>}"
 else
 return "\<Esc>j0f}a"
 endif
endf
 
function QuoteDelim(char)
 let line = getline('.')
 let col = col('.')
 if line[col - 2] == "\\"
 "Inserting a quoted quotation mark into the string
 return a:char
 else if line[col - 1] == a:char
 "Escaping out of the string
 return "\<Right>"
 else
 "Starting a string
 return a:char.a:char."\<Esc>i"
 endif
endf

colo jellybeans
set guifont=Consolas:h12:cANSI

set nu
set cursorline

source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set cmdheight=1   
set guioptions-=T

set updatetime=60000

set shortmess=atI

set shiftwidth=4
set sts=4
set tabstop=4

autocmd BufNewFile *.cpp exec ":call SetTitle()"
func SetTitle()
call setline(1, "#include<bits/stdc++.h>")
call append(line("."), "#define fortodo(i,a,b) for(int i=(a);i<=(b);i++)")
call append(line(".")+1, "#define fordownto(i,a,b) for(int i=(a);i>=(b);i--)")
call append(line(".")+2, "using namespace std;")
call append(line(".")+3, "const int maxn=")
call append(line(".")+4, "inline void read(int &x){")
call append(line(".")+5, "	x=0;int f=1;char ch=getchar();")
call append(line(".")+6 , "	while(ch<'0'||ch>'9'){if(ch=='-')f=-1;ch=getchar();}")
call append(line(".")+7, "	while(ch>='0'&&ch<='9'){x=x*10+ch-'0';ch=getchar();}")
call append(line(".")+8, "	x*=f;")
call append(line(".")+9, "}")
call append(line(".")+10, "")
call append(line(".")+11, "inline void judge(){")
call append(line(".")+12, "    freopen(\"in.txt\",\"r\",stdin);")
call append(line(".")+13, "    freopen(\"out.txt\",\"w\",stdout);")
call append(line(".")+14, "}")
call append(line(".")+15, "")
call append(line(".")+16, "int main(){")
call append(line(".")+17, "    judge();")
call append(line(".")+18, "")
call append(line(".")+19, "    return 0;")
call append(line(".")+20, "}")
endfunc

set tags=tags; 
set autochdir

let Tlist_Show_One_File=1 
let Tlist_Exit_OnlyWindow=1

let g:winManagerWindowLayout='FileExplorer|TagList' 
nmap wm :WMToggle<cr>

let g:miniBufExplMapCTabSwitchBufs=1 
let g:miniBufExplMapWindowsNavVim=1 
let g:miniBufExplMapWindowNavArrows=1 

:silent !<command>

nnoremap <silent> <F3> :Grep<CR>

func! CompileGpp()
    exec "w"
    let compilecmd="!g++ "
    let compileflag="-o %< -g -Wall -O0"
    exec compilecmd." % ".compileflag
endfunc

func! CompileCode()
        exec "w"
        if &filetype == "cpp"
                exec "call CompileGpp()"
		endif
endfunc

map <F9> call CompileCode()<CR>
imap <F9> <ESC>:call CompileCode()<CR>
vmap <F9> <ESC>:call CompileCode()<CR>

func! RunCode()
	exec "! %<"
endfunc

map <F11> call RunCode()<CR>
imap <F11> <ESC>:call RunCode()<CR>
vmap <F11> <ESC>:call RunCode()<CR>

func! Debug()
    let compilecmd="!gdb "
    let compileflag="%<"
    exec compilecmd.compileflag
endfunc

map <F8> call Debug()<CR>
imap <F8> <ESC>:call Debug()<CR>
vmap <F8> <ESC>:call Debug()<CR>


set nobackup " do not keep a backup file, use versions instead
" else
" set backup " keep a backup file
