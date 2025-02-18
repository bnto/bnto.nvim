return {
  "MeanderingProgrammer/render-markdown.nvim",
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    heading = {
      icons = { "󰲡  ", "󰲣  ", "󰲥  ", "󰲧  ", "󰲩  ", "󰲫  " },
    },
    code = {
      width = "block",
      -- highlight = "RenderMarkdownH1Bg",
      highlight_inline = "RenderMarkdownH1Bg",
    },
  },
}
