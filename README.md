# bnto.nvim

## Installation

Just copy & paste this line in your terminal:

```sh
git clone https://github.com/bnto/bnto.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

## (possible) Requirements

- a True Color Terminal
- Neovim (version 0.9+)
- make
- gcc
- ripgrep
- unzip

## Some useful Keymaps

`Space` Leader key

### Window navigation

`<leader>s` Save current buffer to file
`<leader>q` Close current buffer
`<leader>Q` Force close current buffer

`<leader>o` Open current buffer in window
`<leader>O` Toggle files explorer in sidebar

### File navigation

`<leader>6` Toggle between current and previous file

`<leader>f` Find files in cwd
`<leader>F` Grep files in cwd

`<leader>b` Search current buffer
`<leader>B` Search recent files

`<leader>p` Search registers
