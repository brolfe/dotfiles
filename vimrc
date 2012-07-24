colorscheme desert              " Load color scheme {name}
                                " Set Font
if has("win32")
    set guifont=Consolas:h11:cANSI
elseif has("unix")
    set guifont=Bitstream\ Vera\ Sans\ Mono\ 10
endif

call pathogen#infect()

set nocompatible                " turn off vi compatibility
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
syntax on

" Copy
map <C-c> "+y
" Cut
map <C-x> "+x
" Paste
map <C-v> a<Space><Esc>"+gP
imap <C-v> <Space><ESC>"+gP
" Select all
map <C-a> ggVG
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>

" Perf edit current file (control pe)
function! P4Edit()
    if has("vms")
        return '!perf edit %'
    elseif has("unix")
        return '!p4 edit %'
    else
        return ''
    endif
endfunc

nmap <Leader>pe :exec P4Edit()<CR>

"Make curly braces lined up with this line and go into insert indented by 4
map Q o{<Esc>lxo}<Esc>ko
imap <C-U> <ESC>Q

"Make curly braces lined up with this line and go into insert indented by 4
map B A<Space>{<Esc>lxo}<Esc>ko
imap <C-Y> <ESC>B

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
    filetype plugin indent on

    " PLUGIN Preferences
    " VimWiki
    let g:vimwiki_folding=0
    let g:vimwiki_list=[{'path_html': '~/public_html/vimwiki/'}]
    call InitializeDirectories()
endif
if has("win32")
    set autochdir           " Always set the working directory to the current file
endif
