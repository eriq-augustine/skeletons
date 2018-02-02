" GENERAL OPTIONS
set nocompatible
behave xterm

colorscheme default
" colorscheme desert

" set regexpengine=1

filetype plugin on

" Hilight search results, but use control-/ to disable the highlight until the next search.
set hlsearch
" For some reason, vim sees c-_ as c-/
" c-/ seems like it never really works.
:map <c-_> :noh<cr>

" Map ctrl-f to insert/leave insert mode.
:nmap <c-f> i
:imap <c-f> <esc>

" If syntax break (or filetype changes), use F12 to redo coloring.
noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/
" set colorcolumn=80
:map <F7> :set colorcolumn=80<cr>
:map <F8> :set colorcolumn=0<cr>

" Need 100 col too.
" Use <shift>-<F*>
:map <S-F7> :set colorcolumn=100<cr>
:map <S-F8> :set colorcolumn=0<cr>

:map <F9> :set cul!<cr>

" Tab Changers
" TODO(eriq): Use variable input.

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

" make page up/down better
:map <PageUp> <C-U>
:map <PageDown> <C-D>

" Extra whitespace
highlight ExtraWhitespace ctermbg=yellow
" match ExtraWhitespace /\s\+$/
" match ExtraWhitespace /\s\+\%#\@<!$/
match ExtraWhitespace /\s\+$/

set viminfo='20,\"500,% " ' Maximum number of previously edited files for which
                        "   the marks are remembered.
                        " " Maximum number of lines saved for each register.
                        " % When included, save and restore the buffer list.
                        "   If Vim is started with a file name argument, the
                        "   buffer list is not restored.  If Vim is started
                        "   without a file name argument, the buffer list is
                        "   restored from the viminfo file.  Buffers without a
                        "   file name and buffers for help files are not written
                        "   to the viminfo file.
set history=500         " keep {number} lines of command line history

" TAB HANDLING, C program formatting:
set tabstop=3           " ts, number of spaces that a tab *in an input file* is
                        "   equivalent to.
set shiftwidth=3        " sw, number of spaces shifted left and right when
                        "   issuing << and >> commands
set smarttab            " a <Tab> in an indent inserts 'shiftwidth' spaces
set softtabstop=3       " number of spaces that a tab *pressed by the user*
                        "   is equivalent to
set shiftround          " round to 'shiftwidth' for "<<" and ">>"
set expandtab           " don't input tabs; replace with spaces. <local to
                        "   buffer>

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" Let you go left and right in SQL files (overrides default sql ftplugin)
let g:omni_sql_no_default_maps = 1

" see Vim book p 71 for this
filetype on
autocmd FileType * set formatoptions=tcql
    \ nocindent comments&
" Formatoptions: 'q' allows formatting with "gq".  'r' automates the middle of
"    a comment.  'o' automates comment formatting with the 'o' or 'O'
"    commands.  'c' wrap comments.  'l' do not break lines in insert mode.
autocmd FileType c,cpp :set formatoptions=clqro
    \ cindent comments=s1:/*,mb:*,ex:*/,://
set autoindent          " automatically set the indent of a new line (local to
                        "   buffer)
set nosmartindent       " no clever autoindenting (local to buffer); let cindent
                        "   do it

" if filetype is recognized as c or cpp, these inform cindent
set cinoptions=:0,p0,t0
set cinwords=if,unless,else,while,until,do,for,switch,case
set cinkeys=0{,0},0),:,0#,!^F,o,O,e
                        " keys that trigger C-indenting in Insert mode
                        "   (local to buffer)

set wrap                " whether to wrap lines
" Make breaks more obvious
set showbreak=+++\ \
" set number            " number lines
set incsearch
set showmatch
set backspace=2

syntax on               " colorize

" VIM DISPLAY OPTIONS
set showmode            " show which mode (insert, replace, visual)
set ruler
set title
set showcmd             " show commands in status line when typing
set wildmenu
set wildmode=longest,list

" KEY MAPPINGS
"   depending on your terminal software, you may have to fiddle with a few
"   things to make it look right for you.  It works for me logged in through
"   SSH.

:map <F3> :set paste!<cr>

" Spell check!
:map <F4> :set spell!<cr>

" Linqs-style whitespacing on all windows.
:map <F5> :windo %s/\s\+$//e \| %s/   /\t/ge<cr>

"" http://vim.wikia.com/wiki/Improved_Hex_editing
nnoremap <C-H> :Hexmode<CR>
inoremap <C-H> <Esc>:Hexmode<CR>
vnoremap <C-H> :<C-U>Hexmode<CR>

" JSON
au! BufRead,BufNewFile *.json setfiletype json

"" From http://stevelosh.com/blog/2010/09/coming-home-to-vim/#using-the-leader
" The modelines bit prevents some security exploits having to do with modelines
" in files. I never use modelines so I don't miss any functionality here.
set modelines=0

" Eriq Specifics

" Classic 101 mapping. Sets up a main c file.
:map <F2> :set filetype=c<cr>i/**<cr> @author Eric Augustine<cr>/<cr><cr>#include <stdio.h><cr>#include <stdlib.h><cr>#include <unistd.h><cr>#include <math.h><cr><cr>int main(int argc, char *argv[]) {<cr><cr>return EXIT_SUCCESS;<cr><bs>}<esc>kka<tab>
