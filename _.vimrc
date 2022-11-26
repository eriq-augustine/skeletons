" Enable user overrides.
set nocompatible

"""
""" Functionality
"""

" Indentation
set autoindent
set expandtab
set smarttab
set shiftround
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Use the mouse using the xterm defaults.
behave xterm

" Remember up-to 1000 lines (') for the last 50 (") files opened.
" Also jump back to where we last opened a file (%).
set viminfo='50,\"1000,%

" Keep 5000 lines of command history.
set history=5000

" Reset the cursor to the last position when we re-open a file.
function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

" Make backspace work like most other applications.
set backspace=indent,eol,start

" Make the autocomplete menu like bash.
set wildmenu
set wildmode=longest,list

" Prevent some security issues by ignoring modelines.
" I don't want to use modelines anyways.
" https://lwn.net/Vulnerabilities/20249/
set modelines=0

"""
""" Visual
"""

" Colors on.
syntax on

colorscheme default
" colorscheme desert

" Hilight search results,
" but use control-/ (defined below) to disable the highlight until the next search.
set hlsearch

" Start searching as we type (only really matters with hlsearch).
set incsearch

" Wrap lines by default.
set wrap

" Make lines breaks more obvious.
set showbreak=+++\ \

" Show matching bookends.
set showmatch

" Show which mode (insert, replace, visual).
set showmode

" Show line/char number on the bottom right.
set ruler

" Show the filename in the window.
set title

" Show commands in the status line when typing.
set showcmd

" Highlight whitespace at the end of lines.
highlight ExtraWhitespace ctermbg=yellow guibg=yellow
match ExtraWhitespace /\s\+$/

"""
""" Mappings
"""

" Map ctrl-f to insert/leave insert mode.
:nmap <c-f> i
:imap <c-f> <esc>

" For some reason, vim sees c-_ as c-/
" c-/ seems like it never really works.
:map <c-_> :noh<cr>

" If syntax break (or filetype changes), use F12 to redo coloring.
noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

" Use F7 to put a visual bar at 80 characters, use F8 to clear.
:map <F7> :set colorcolumn=80<cr>
:map <F8> :set colorcolumn=0<cr>

" Use <shift>-F7 to put a visual bar at 100 characters, use <shift>-F8 to clear.
:map <S-F7> :set colorcolumn=100<cr>
:map <S-F8> :set colorcolumn=0<cr>

" Use F9 to toggle underline on the cursor's line.
:map <F9> :set cul!<cr>

" Tab Changers
" Soft tabs use and undercase 't' with the desired tabstop (eg 't4').
" Whereas hard tabs use a capital 'T'.

" Soft tabs
map t1 :set shiftwidth=1 softtabstop=1 tabstop=1 expandtab<cr>
map t2 :set shiftwidth=2 softtabstop=2 tabstop=2 expandtab<cr>
map t3 :set shiftwidth=3 softtabstop=3 tabstop=3 expandtab<cr>
map t4 :set shiftwidth=4 softtabstop=4 tabstop=4 expandtab<cr>
map t5 :set shiftwidth=5 softtabstop=5 tabstop=5 expandtab<cr>
map t6 :set shiftwidth=6 softtabstop=6 tabstop=6 expandtab<cr>
map t7 :set shiftwidth=7 softtabstop=7 tabstop=7 expandtab<cr>
map t8 :set shiftwidth=8 softtabstop=8 tabstop=8 expandtab<cr>

" Hard tabs
map T1 :set shiftwidth=1 softtabstop=1 tabstop=1 noexpandtab<cr>
map T2 :set shiftwidth=2 softtabstop=2 tabstop=2 noexpandtab<cr>
map T3 :set shiftwidth=3 softtabstop=3 tabstop=3 noexpandtab<cr>
map T4 :set shiftwidth=4 softtabstop=4 tabstop=4 noexpandtab<cr>
map T5 :set shiftwidth=5 softtabstop=5 tabstop=5 noexpandtab<cr>
map T6 :set shiftwidth=6 softtabstop=6 tabstop=6 noexpandtab<cr>
map T7 :set shiftwidth=7 softtabstop=7 tabstop=7 noexpandtab<cr>
map T8 :set shiftwidth=8 softtabstop=8 tabstop=8 noexpandtab<cr>

" Make page up/down better
:map <PageUp> <C-U>
:map <PageDown> <C-D>

" Toggle paste mode.
:map <F3> :set paste!<cr>

" Spell check!
:map <F4> :set spell!<cr>

" Clean up whitespace.
:map <F5> :windo %s/\s\+$//ge<cr>

" Swap between hex viewer.
" This does not transparently edit the hex, you have to swap back to non-hex mode and save.
map <F6> :%!xxd <cr> :set syntax=xxd <cr>
map <S-F6> :%!xxd -r <cr> :filetype detect <cr> :syntax sync fromstart <cr>

" Don't highlight line comments in JSON.
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd FileType json syntax match Comment +#.\+$+
