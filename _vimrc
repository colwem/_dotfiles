" vim: foldmethod=marker foldlevel=0 foldenable
set nocompatible

"Needed sometimes in order to make BundleInstall work.
set noshellslash  


" Load bundles {{{
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif
"}}}

" Unsorted fold"{{{
let mapleader = ","
"Split an HTML line such that the tags are on seperate lines and are properly
"indented
vmap <leader>x :s/<[^>]*>/\r&/g<cr>v`<= 
"turn off search highlighting for this search only with ,/
"toggle search highlighting with F4
noremap <leader>/ :nohlsearch<cr>
noremap <F4> :set hlsearch! hlsearch?<CR>

"makes a 5 line margin at the bottom of the window so that you never scroll
"all the way down
set scrolloff=5
"set sidescroll=15

"toggle list mode with ,l
noremap <leader>sl :set list! list?<cr>

if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  if !has('win32') && (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8')
    let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u00b7"
  endif
endif


"for the cloze deletions of anki
vnoremap <leader>c <esc>`>a}}<esc>`<i{{c1::<esc>


"}}}

" Tagbar config"{{{
let g:tagbar_autoclose=0
let g:tagbar_left=0
noremap <leader>ta :TagbarOpenAutoClose<CR>
noremap <leader>tt :TagbarToggle<CR>
noremap <leader>to :TagbarOpen<CR>
noremap <leader>tc :TagbarClose<CR>
noremap <leader>tp :TagbarTogglePause<CR>
"}}}

" Unsorted fold"{{{
" auto documentation finding with latex
" possible completion library for python
" Bundle 'rkulla/pydiction' "https://github.com/rkulla/pydiction 


"set shellxquote=  
set noshellslash  "Needed sometimes in order to make BundleInstall work.
"Problem is that git clone doesn't like single quotes around the filename and for some reason this
"option makes the command use single quotes rather than double quotes
"set shellslash "Required for latex-suite 


set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
let &guioptions = substitute(&guioptions, "t", "", "g")
set go=
"set guioptions=eg
"make toggle button for menu

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch  
endif
"}}}

" autocmd stuff"{{{
if has('autocmd')

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")
"}}}

" Diff function for buffer vs. original file"{{{
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(':DiffOrig')
  command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif


set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
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
endfunction"}}}

"Display options"{{{
set background=dark
"solarized"{{{
"let g:solarized_contrast="high"
"let g:solarized_visibility="normal"
"let g:solarized_hitrail=1
"colorscheme solarized"}}}

"molokai"{{{
let g:molokai_original = 0
colorscheme molokai
"}}}

set cursorline
set relativenumber
set number
set laststatus=2  "By default vim doesn't seem to display the status line when
" only a single window is open 
"set guifont=Courier_New:h9:cANSI
set guifont=DeJaVu_Sans_Mono_for_Powerline:h9
"set guifont=Anonymice_Powerline:h9
"set guifont=Ubuntu_Mono_derivative_Powerline:h9

"}}}

" edit options"{{{
set hidden
set autoread
"}}}

"formatting options"{{{
set shiftwidth=2
set softtabstop=2
"}}}

" tab options "{{{
"set tabstop=8
set smarttab
set expandtab
set showmatch
set ignorecase 
set smartcase
set shiftround
set display+=lastline
set backspace=indent,eol,start
"}}}

" 3 tags"{{{
set tags=./tags,tags,~/_vimtags
""}}}

" 12 messages and info"{{{
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set visualbell	
set noerrorbells
""}}}

"19 reading and writing files"{{{
set fileformat=unix

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
  set backupdir=$HOME/.backup/,.
endif

"}}}

" 21 command line editing"{{{
set undofile
set undodir=$HOME/.undodir/,.
set directory=$TEMP/,.
 
if &history < 1000
  set history=200		" keep 200 lines of command line history
endif

set wildmode=longest,list,full
set wildmenu
""}}}

"26 multi-byte character options"{{{
set encoding=utf-8
"}}}

"Latex-Suite settings"{{{
let g:tex_flavor='latex'
"}}}

" Setting font size"{{{
command! -nargs=1 SetFontSize call SetFontSizefun(<args>)
command! -nargs=* IncFontSize call IncFontSizefun(<f-args>)

function! SetFontSizefun(new_size)
  let l:old_font = getfontname()
  let l:parts = split(old_font, ':')
  let l:parts[1] = 'h' . a:new_size
  let font = "set guifont=" . join(l:parts,':')
  execute l:font
endfunction

function! IncFontSizefun(...)
  if a:0 == 1
    let lcount = a:1
  else 
    let lcount = 1
  endif
  let old_font = getfontname()
  let parts = split(l:old_font, ':')
  let parts[1] = 'h' . ( l:parts[1][1:] + l:lcount )
  execute "set guifont=" . join(l:parts, ':')
endfunction
"}}}

" Python"{{{
" pymode config"{{{

"let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_lint_ignore = 'E501,E221,W'

set foldmethod=indent
set foldlevel=99
"}}}

let g:PyFlakeDisabledMessages = 'E501,E221' "E221 multiple spaces around operator.  It pops up when you try and line up a line by an operator 
"au FileType python set omnifunc=pythoncomplete#Complete "python completion 

"}}}

" Assorted customizations"{{{

"deletes buffer without removing window
map <leader>bd :Bclose<cr>

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction


map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

nmap <silent> gc :set opfunc=TitleCase<CR>g@
vmap <silent> gc :<C-U>call TitleCase(visualmode(), 1)<CR>

function! TitleCase(type, ...)
    if a:0  " Invoked from Visual mode, use '< and '> marks.
        silent  :`<,`>s/\<./\u&/g
    elseif a:type == 'line'
         :'[,']s/\<./\u&/g
    elseif a:type == 'block'
        silent :`[,`]s/\<./\u&/g
    else
        exe "normal! :'[,']s/\<./\u&/g"
    endif
endfunction
"}}}

" Gundo Setting"{{{
nnoremap <leader>gt :GundoToggle<CR>
"}}}

"supertab config"{{{
"let g:SuperTabDefaultCompletionType= "<c-p>" "default
"context will attempt to use preceding text to choose completion type
"let g:SuperTabDefaultCompletionType = "context"

"fallback for context mode
"let g:SuperTabContextDefaultCompletionType = "<c-p>"
"}}}

" YankRing config"{{{
"nnoremap <silent> <F11> :YRShow<CR>
"}}}

" Unite config"{{{
"call unite#filters#matcher_default#use(['matcher_fuzzy'])
"nnoremap <leader>r :<C-u>UniteWithBufferDir -start-insert file_rec<CR>
"}}}

" Airline config"{{{
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts=1
"}}}

" MiniBufExplorer config"{{{

""}}}

"Latex {{{
  " Latex-Box config"{{{
    let g:LatexBox_viewer="SumatraPDF.exe"
    let g:LatexBox_latexmk_preview_continuously=1
    let g:LatexBox_latexmk_async=1
  "}}}

  " Latexmk config {{{
    "map <leader>lmk :!start latexmk -pdf -pvc %<cr>
  " }}}
" }}}

" SQLUtilities config"{{{

let g:sqlutil_align_comma = 1

"}}}

" CTRLP config"{{{
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:10'
let g:ctrlp_mruf_exclude = '^.*\\doc\\.*'

let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn)|[\/](node_modules)$',
            \ 'file': '\v\.(exe|so|dll|pyc)$'
            \}

"'bundle' "\\.*\\doc' "\|\\vim\\.*\\doc'
map <leader>pm :CtrlPMRU<cr>
map <leader>pb :CtrlPBuffer<cr>
" map <leader>pf :CtrlP<cr>
nnoremap <silent> <leader>pf :exe 'CtrlP' ProjectRootGuess()<cr>
""}}}

" Sytastic config {{{
let g:syntastic_error_symbol = '▶'
let g:syntastic_style_error_symbol = '▷'
let g:syntastic_warning_symbol = '●'
let g:syntastic_style_warning_symbol = '○'

"for syntastic and python-mode integration
let g:syntastic_mode_map = { 'mode': 'active',
      \'active_filetypes': [],
      \'passive_filetypes': ['python', 'html'], }
"}}}

" Tab page"{{{
  map <S-H> gT
  map <S-L> gt
"}}}

" To be consistent with C and D
nnoremap Y y$

" Shortcuts
" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" window command mapped to ,w
map <Leader>w <C-w>
map <Leader>w- <C-w>_



" Easier horizontal scrolling
map zl zL
map zh zH

" don't know how to make this work in all situations, use C-[ instead
inoremap jk <Esc>
cnoremap jk <c-c>
"vnoremap jk <Esc>

" Pandoc"{{{
  let g:pandoc_use_hard_wraps = 1
  let g:pandoc_auto_format = 1
"}}}

" NerdTree
nnoremap <silent> <Leader>dt :ProjectRootExe NERDTree<cr>
let NERDTreeIgnore=['\~$', '.pyc$']
let NERDTreeShowLineNumbers=1

" NerdCommenter
let NERDSpaceDelims = 1

" command Ercs :e ~/_vimrc ~/.vimrc.bundles

nnoremap <Leader>pcd :ProdjectRootLCD<cr>
" au BufEnter * if &ft != 'help' | ProjectRootLCD | endif

" Grep
nnoremap <Leader>ag :ProjectRootExe Ag<space>


" :r !<cmd> redirects output of a shell command into the current buffer
" :redir @<reg> | <ex command> | redir END

" Fold text customization {{{
set foldtext=CustomFoldText()
fu! CustomFoldText()
    "get first non-blank line
    let fs = v:foldstart
    while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
    endwhile
    if fs > v:foldend
        let line = getline(v:foldstart)
    else
        let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
    endif

    let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
    let foldSize = 1 + v:foldend - v:foldstart
    let foldSizeStr = " " . foldSize . " lines "
    let foldLevelStr = repeat("+--", v:foldlevel)
    let lineCount = line("$")
    let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
    let expansionString = repeat(".", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
    return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endf
" }}}

" set fo -= 'o'
nnoremap <space> a 
nnoremap <backspace> hxi
