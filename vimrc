if has("win32")
    set guifont=Consolas:h11:cANSI
elseif has("unix")
    set guifont=Bitstream\ Vera\ Sans\ Mono\ 10
endif

set nocompatible                " turn off vi compatibility
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#begin()

" let Vundle manage Vundle, required (yo dawg)
Plugin 'gmarik/vundle'

Plugin 'scrooloose/nerdtree'
Plugin 'altercation/vim-colors-solarized'
Plugin 'pangloss/vim-javascript'
"Plugin 'tpope/vim-commentary'
"Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'
Plugin 'kien/ctrlp.vim'
Plugin 'rking/ag.vim'

call vundle#end()
filetype plugin indent on

set background=dark
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
let g:solarized_termcolors = 256
colorscheme solarized              " Load color scheme {name}

set guioptions-=T               " Turn off toolbar in gvim
set ruler                       " Show the line and column number
                                " of the cursor position
set number                      " Print the line number in front of each line
set list                        " Show tabs
set listchars=tab:>-
set showmatch                   " When a bracket is inserted,
                                " briefly jump to the matching one
"set noswf                       " Do not use a swapfile for the buffer

set path=.,ref:,vms_include:,,  " This is a list of directories
                                " which will be searched
set matchpairs=(:),{:},[:],<:>  " Characters that form pairs
set backspace=2                 " :set backspace=indent,eol,start
set tabstop=4                   " Number of spaces that a <Tab> in the file
                                " counts for
set softtabstop=4               " Number of spaces that a <Tab> counts for
                                " while performing editing operations
set smarttab                    " A <Tab> in front of a line inserts
                                " blanks according to 'shiftwidth'
set expandtab                   " Use the appropriate number of spaces
                                " to insert a <Tab>
set autoindent                  " Copy indent from current line
                                " when starting a new lineauto indent
set shiftwidth=4                " Number of spaces to use for each step
                                " of (auto)indent
"set smartindent                 " Do smart autoindenting
                                " when starting a new line

set hlsearch                    " When there is a previous search pattern,
                                " highlight all its matches
set ignorecase                  " Ignore case in search patterns
set smartcase                   " Override the 'ignorecase' option
                                " if the search pattern contains
                                " upper case characters
set encoding=utf-8              " UTF-8 character encoding
set nowrap                      " No line wrapping
set hidden                      " Allow modified buffers to be hidden
set switchbuf=usetab            " If a buffer is already open in an existing tab, switch to it
set iskeyword+=-                " Treat dashes - as part of the word
syntax on

" Copy
map <C-c> "+y
" Cut
map <C-x> "+x
" Paste
"map <C-v> a<Space><Esc>"+gP
imap <C-v> <Space><ESC>"+gPxi
" Select all
map <C-a> ggVG
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>

" Automatically close parenthesis, square brackets, curly braces, and angle brackets.
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>

function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=ClosePair('}')<CR>

" Delete empty pairs
function! InAnEmptyPair()
    let cur = strpart(getline('.'),getpos('.')[2]-2,2)
    for pair in (split(&matchpairs,',') + ['":"',"':'"])
        if cur == join(split(pair,':'),'')
            return 1
        endif
    endfor
    return 0
endfunc

func! DeleteEmptyPairs()
    if InAnEmptyPair()
        return "\<Left>\<Del>\<Del>"
    else
        return "\<BS>"
    endif
endfunc

inoremap <expr> <BS> DeleteEmptyPairs()

"auto indent after pressing return in an empty pair.
func! IndentEmptyPair()
  if InAnEmptyPair()
    return "\<CR>\<CR>\<Up>\<Tab>"
  else
    return "\<CR>"
  endif
endfunc

inoremap <expr> <CR> IndentEmptyPair()

"when changing indentation in visual mode, reselect the same text
vnoremap > >gv
vnoremap < <gv

" Put all hidden tmp files in one place
function! InitializeDirectories()
    let parent = $HOME 
    let prefix = '.vim'
    let dir_list = { 
        \ 'backup': 'backupdir', 
        \ 'views': 'viewdir', 
        \ 'swap': 'directory' }
        "\ 'undo': 'undodir' }

    for [dirname, settingname] in items(dir_list)
        let directory = parent . '/' . prefix . dirname . "/"
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else  
            let directory = substitute(directory, " ", "\\\\ ", "")
            " Extra slash forces swp file name to use full path thus 
            " avoiding collisions
            exec "set " . settingname . "=" . directory . "/"
        endif
    endfor
endfunction

if has("unix")
    source ~/.vim/abbrev.vim

    " PLUGIN Preferences
    " VimWiki
    let g:vimwiki_folding=0
    let g:vimwiki_list=[{'path_html': '~/vimwiki_html/'}]
    call InitializeDirectories()
endif
if has("win32")
    set noautochdir           " Always set the working directory to the current file
    set noswapfile            " No swap files on windows cuz they annoyin'
endif
