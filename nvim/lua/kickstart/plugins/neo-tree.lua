-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    enable_git_status = true,
    default_component_configs = {
      git_status = {
        symbols = {
          ignored = '󰷈',
        },
      },
    },
    filesystem = {
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = true,
        hide_gitignored = true,
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
  config = function(_, opts)
    require('neo-tree').setup(opts)
    local function apply_hl()
      -- bright red so we can confirm the mechanism works at all
      vim.api.nvim_set_hl(0, 'NeoTreeDimText', { fg = '#ff0000', italic = true })
    end
    apply_hl()
    -- re-apply after colorscheme changes, which would otherwise reset it
    vim.api.nvim_create_autocmd('ColorScheme', { callback = apply_hl })
  end,
}
