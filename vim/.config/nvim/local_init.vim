let g:python3_host_prog = '~/.pyenv/versions/neovim3/bin/python'
let g:python_host_prog = '~/.pyenv/versions/neovim2/bin/python'

" CtrlP stuff
let g:ctrlp_mruf_exclude = 'vim/runtime/doc/.*'
let g:ctrlp_prompt_mappings = { 'ToggleMRURelative()': ['<F2>'] }
let g:ctrlp_show_hidden = 1
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
let g:ctrlp_cmd = 'CtrlPMRU'

" turn off hlsearch with ,/
noremap <leader>/ :set hlsearch! hlsearch?<CR>


" highlight the line the cursor is on
set cursorline

" Show the relative line number above and below but the actual line number for
" current line
set relativenumber
set number


" Set vim to not keep the backup files in the current dir
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
  set backupdir=$HOME/.backup/,.
endif


