return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      ensure_installed = { "bash", "c", "cpp", "dockerfile", "go", "html", "java", "javascript", "json", "kotlin", "lua",
        "python", "toml", "typescript", "vim", "vimdoc", "yaml"
      },
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          node_incremental = "v",
          node_decremental = "<A-v>",
        },
      },
    })
  end
}
