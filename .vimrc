" should be first becuase it changes other options as side effects
set nocompatible

runtime bundle/vim-pathogen/autoload/pathogen.vim

call pathogen#infect()
filetype plugin indent on

" Used as beginning of other commands
let mapleader = ","

" Hides buffers instead of closing them.  This means that you can have
" unwritten changes to a file and open a new file using :e, without being
" forced to write or undo your changes first. Also, undo buffers and marks are
" preserved while the buffer is open.
set hidden

set nowrap         " don't wrap lines
set tabstop=4      " a tab is four spaces
set softtabstop=4
set expandtab
set backspace=indent,eol,start
                   " allow backspacing over everything in insert mode
set autoindent     " always set autoindenting on
set copyindent     " copy the previous indentation on autoindenting
" set number          " always show line numbers
set shiftwidth=4   " number of spaces to use for autoindenting
set shiftround     " use multiple of shiftwidth when indenting
                   " with '<' and '>'
set showmatch      " show matching parentheses
set ignorecase     " ignore case when searching
set smartcase      " ignore case if search pattern is all lowercase,
                   "   case-sensitive otherwise
set smarttab       " insert tabs on the start of the line according to
                   "   shiftwidth, not tabstop
set hlsearch       " highlight search terms
set incsearch      " show search matches as you type
set nolist         " don't show invisible characters by default
set pastetoggle=<F2>
                   " when in insert mode, press <F2> to go to
                   "   paste mode, where you can paste mass data that
                   "   won't be auto indented
" set mouse a        "enable using the mouth if the terminal emulator
                   " supports it (xterm does not)
set fileformats="unix,mac,dos"
set formatoptions+=1
                   " when wrapping paragraphs, don't end lones with
                   " 1-letter words (looks dumb)
set history=1000
set undolevels=1000
set wildignore=*.swp,*.bak
set title
set visualbell     " don't beep
set noerrorbells   " don't beep

set nobackup
set noswapfile

" <C-e> and C-y> scroll the viewpoint a single line. Let's speed this up
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" At the bottom right hand corner of the status line info for how far in
" the file you are ex) 529, 35, 68% line, column, % towards to the end
set ruler

" Turn off C-style indentation (which adds indentation after lines which ends
" with { character, for example).
set nocindent

" Turn off the two 'formatoptions' ('fo' for short) which automatically
" insert comment characters for the current filetype when Vim thinks you
" want to add a line to a comment.
set fo-=r fo-=o

" Should turnn off the automatic indentation options set by filetype=specific
" 'indent' plugins, but does't.
filetype indent off

" File-type highlighting and configuration.
" Run :filetype (without args) to see what you may have
syntax on
filetype on
filetype plugin on

" This works, and overrides the options for any filetype.
autocmd FileType * set fo-=r fo-=o nocindent noautoindent

" Catch trailing whitespaces 
set listchars=tab:>-,trail:.,eol:$
nmap <silent> <leader>s :set nolist!<CR>

" Better tab completion when looking for files
set wildmode=longest,list,full
set wildmenu

autocmd BufRead,BufNewFile *.psql setfiletype php

" Put in an insertion point
function! PutInsertion(type)
    if a:type == 'newline'
        normal oecho "\n", print_r('insert here', 1), "\n"; exit;
    endif
    if a:type == 'pre'
        normal oecho "<pre>", print_r('insert here', 1), "</pre>"; exit;
    endif
    normal ^5wl
endfunction

" Replace insert point of above items, but only deletes up to next comma
function! ReplaceInsertion()
    normal ^5wlvt,d
    startinsert
endfunction

" Combine the above two into one action
function! AddInsertion(type)
    call PutInsertion(a:type)
    call ReplaceInsertion()
endfunction
" shortcuts for the insertion functions
nnoremap <leader>cm :call AddInsertion('newline')<CR>
nnoremap <leader>ch :call AddInsertion('pre')<CR>
nnoremap <leader>im :call PutInsertion('newline')<CR>
nnoremap <leader>ih :call PutInsertion('pre')<CR>
nnoremap <leader>cr :call ReplaceInsertion()<CR>

let g:comment = '//'
function AC()
    let curr_line = getline('.')
    let replacement = substitute(curr_line, '^', g:comment, '')
    call setline('.', replacement)
endfunction
function RC()
    let curr_line = getline('.')
    let replacement = substitute(curr_line, '^' . g:comment, '', '')
    call setline('.', replacement)
endfunction
nnoremap <leader>ac :call AC()<CR>
nnoremap <leader>rc :call RC()<CR>

" Aligner of = signs
function AlignAssignments ()
    "Patterns needed to locate assignment operators...
    let ASSIGN_OP   = '[-+*/%|&]\?=\@<!=[=~]\@!'
    let ASSIGN_LINE = '^\(.\{-}\)\s*\(' . ASSIGN_OP . '\)'

    "Locate block of code to be considered (same indentation, no blanks)
    let indent_pat = '^' . matchstr(getline('.'), '^\s*') . '\S'
    let firstline  = search('^\%('. indent_pat . '\)\@!','bnW') + 1
    let lastline   = search('^\%('. indent_pat . '\)\@!', 'nW') - 1
    if lastline < 0
        let lastline = line('$')
    endif

    "Find the column at which the operators should be aligned...
    let max_align_col = 0
    let max_op_width  = 0
    for linetext in getline(firstline, lastline)
        "Does this line have an assignment in it?
        let left_width = match(linetext, '\s*' . ASSIGN_OP)

        "If so, track the maximal assignment column and operator width...
        if left_width >= 0
            let max_align_col = max([max_align_col, left_width])

            let op_width      = strlen(matchstr(linetext, ASSIGN_OP))
            let max_op_width  = max([max_op_width, op_width+1])
         endif
    endfor

    "Code needed to reformat lines so as to align operators...
    let FORMATTER = '\=printf("%-*s%*s", max_align_col, submatch(1),
    \                                    max_op_width,  submatch(2))'

    " Reformat lines with operators aligned in the appropriate column...
    for linenum in range(firstline, lastline)
        let oldline = getline(linenum)
        let newline = substitute(oldline, ASSIGN_LINE, FORMATTER, "")
        call setline(linenum, newline)
    endfor
endfunction

nnoremap <leader>ll  :call AlignAssignments()<CR>

" Make it so that current dir follows files that are opened
set autochdir

" Add line numbers
set number

syntax enable
let g:solarized_termtrans = 1
colorscheme solarized
call togglebg#map("<F5>")

set clipboard=unnamed

set textwidth=80
set colorcolumn=+1
hi ColorColumn guibg=#2d2d2d ctermbg=246

" Display end of line and extra whitespace
set list
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
hi NonText ctermfg=gray guifg=gray ctermbg=lightgray guibg=lightgray

" Mappings for handling unwanted whitespace
nnoremap <leader>ss :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
nnoremap <leader>st :let _s=@/<Bar>:%retab<Bar>:let @/=_s<Bar>:nohl<CR>

" Include text insertions
source $HOME/.myvimfiles/src/text-insertions
