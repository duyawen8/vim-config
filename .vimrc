""""""""""""""""""""""""
"   Settings    "
""""""""""""""""""""""""
set nonu
set history=200
syntax on
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4

set hls
set showmatch
set ruler

"set autowrite
set expandtab
set smarttab

"indent 允许使用退格删除缩进
"eol    允许在行开头使用退格合并上下两行
"start  允许使用退格删除当前插入前的字符
set backspace=indent,eol,start

""""""""""""""""""""""""
"   Mappings    "
""""""""""""""""""""""""
let mapleader = ","
" Jump to next error with Ctrl-n and previous error with Ctrl-m. Close the
" quickfix window with <leader>a
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>

""""""""""""""""""""""""
"   Colorscheme   "
""""""""""""""""""""""""
set cursorline    " 设置高亮行
"set cursorcolumn " 设置高亮列
highlight CursorLine   cterm=NONE guibg=NONE guifg=NONE ctermbg=lightgray ctermfg=black
highlight CursorColumn cterm=NONE guibg=NONE guifg=NONE ctermbg=lightgray ctermfg=black

if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif


"molokai conf
"let g:rehash256 = 1
"let g:molokai_original = 1
"colorscheme molokai

""""""""""""""""""""""""
"   Vim-plug   "
""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'fatih/molokai'
Plug 'bronson/vim-trailing-whitespace'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Shougo/unite.vim'
Plug 'rking/ag.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'Valloric/YouCompleteMe'
Plug 'SirVer/ultisnips'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'nvie/vim-flake8'
call plug#end()

""""""""""""""""""""""""
"   vim-go   "
""""""""""""""""""""""""
let g:go_def_mode = 'guru'
"let g:go_addtags_transform = 'camelcase'
let g:go_autodetect_gopath = 1
let g:go_info_mode = 'guru'
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
let g:go_metalinter_enabled = ['vet', 'golint', 'deadcode', 'errcheck', 'dupl', 'goconst', 'gocyclo', 'gosec', 'gotype', 'gotypex', 'ineffassign', 'interfacer', 'maligned', 'megacheck', 'misspell', 'structcheck', 'unconvert', 'varcheck', 'vetshadow']

augroup go
    autocmd!
    "autocmd FileType go nmap <leader>b  <Plug>(go-build)
    autocmd FileType go nmap <leader>r   <Plug>(go-run)
    autocmd FileType go nmap <leader>m   <Plug>(go-metalinter)
    autocmd FileType go nmap <leader>in  <Plug>(go-info)
    autocmd FileType go nmap <leader>i   <Plug>(go-imports)
    autocmd FileType go nmap <leader>d   <Plug>(go-doc-vertical)
    autocmd FileType go nmap <leader>a   <Plug>(go-alternate-vertical)
    autocmd FileType go nmap <leader>t   <Plug>(go-test)
    autocmd FileType go nmap <Leader>v   <Plug>(go-def-vertical)
    autocmd FileType go nmap <leader>tf  <Plug>(go-test-func)
    autocmd FileType go nmap <leader>tc  <Plug>(go-test-compile)
    autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

    "autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
    "autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
    "autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
    "autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

nmap <C-g> :GoDeclsDir<cr>
imap <C-g> <esc>:<C-u>GoDeclsDir<cr>

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction


""""""""""""""""""""""""
"   python plugin    "
""""""""""""""""""""""""
let g:flake8_show_in_file=1
autocmd BufWritePost *.py call Flake8()
set makeprg=pylint\ --reports=n\ --output-format=parseable\ %:p
set errorformat=%f:%l:\ %m


""""""""""""""""""""""""
"   unite plugin    "
""""""""""""""""""""""""
let g:unite_source_history_yank_enable = 1
try
  let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
catch
endtry
" search a file in the filetree
nnoremap <space><space> :split<cr> :<C-u>Unite -start-insert file_rec/async<cr>
" reset not it is <C-l> normally,type <space>r to reset unite cache
:nnoremap <space>r <Plug>(unite_restart)

""""""""""""""""""""""""
"   ag plugin    "
""""""""""""""""""""""""
nmap & :Ag <c-r>=expand("<cword>")<cr><cr>
nnoremap <space>/ :Ag

""""""""""""""""""""""""
"   ultisnips plugin    "
""""""""""""""""""""""""
"let g:UltiSnipsExpandTrigger="<space>"
"let g:UltiSnipsExpandTrigger="<c-tab>"

" solarized conf
try
    colorscheme solarized
catch
endtry
