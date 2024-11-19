" Basic settings
set number
syntax on
set showmode
set showcmd
set mouse=a
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
filetype plugin indent on
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set cursorline
set wrap
set linebreak
set cc=80
" set statusline=%F%m%r%h%w\ [%{&ff}]\[%Y]\[%04l,%04v][%p%%]\[TL=%L]
" set laststatus=1
set ruler
set showmatch
set hlsearch
set incsearch
set ignorecase
" set smartcase
" set autodir
" set spell spelllang=en_us
" set noerrorbells
" set visualbell
set history=1000
set autoread
set listchars=tab:»■,trail:■
" set list
set wildmenu
set wildmode=longest:list,full
set nofoldenable
set tabpagemax=128
set backspace=indent,eol,start
set textwidth=0
set clipboard+=unnamedplus

" PHP file recogization
au BufNewFile,BufRead *.php set ft=html

" ejs file recognization
au BufNewFile,BufRead *.ejs set ft=html

" HTML and PHP no indent
" au FileType html set indentexpr=

" /etc/bash_aliases grammar
au BufNewFile,BufRead /etc/bash_aliases set ft=sh

" /etc/xonshrc grammar
au BufNewFile,BufRead /etc/xonshrc set ft=sh

" Color scheme
command Colors !ls /usr/share/nvim/runtime/colors
" colorscheme detorte
" let g:detorte_theme_mode='dark'
" colorscheme amlight
" colorscheme morning
" colorscheme amdark
" colorscheme delek

" Key bindings
nnoremap <C-a> :w<Return>
inoremap <C-a> <Esc>:w<Return>i<Right>
inoremap <A-p> <Esc>p<Esc>i<Right>
inoremap <S-Esc> <Esc>i<Right>

" vim-plug settings
call plug#begin()

"Plug 'maxmx03/solarized.nvim', { 'mode': 'dark', 'theme': 'neovim' }
"Plug 'overcache/NeoSolarized'
Plug 'tanvirtin/monokai.nvim'
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
" Plug 'feline-nvim/feline.nvim'
" Plug 'rafamadriz/statusline'
Plug 'nvim-tree/nvim-web-devicons'
" Plug 'lewis6991/gitsigns.nvim'
" Plug 'https://github.com/adelarsq/neoline.vim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'lambdalisue/suda.vim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

call plug#end()

set completeopt=menu,menuone,noselect

lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['bashls'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['clangd'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['denols'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['html'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['jsonls'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['rust_analyzer'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['ts_ls'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['vimls'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['yamlls'].setup {
    capabilities = capabilities
  }

  -- Set up statusline.
  -- require('feline').setup()

  -- Set up lualine.nvim
  require('lualine').setup {
    options = { theme = 'horizon' }
  }

  -- Set up catppuccin theme
  require('catppuccin').setup({
    integrations = {
      treesitter = false,
      semantic_tokens = false
    }
  })
EOF

color catppuccin-mocha
