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

`<leader>w` Save current buffer to file

`<leader>o` Open floating file explorer

`<leader>O` Toggle file explorer in sidebar

### File navigation

`<leader>f` Find files in cwd

`<leader>F` Grep files in cwd

`<leader>b` Search current buffer

`<leader>B` Search recent files

`<leader>p` Search registers

### Script commands

`<C-f>f` Open project in tmux
`<C-f>z` Open zettelkasten
