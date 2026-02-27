-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- emmet-vim plugin configuration
return {
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
  {
    'okuuva/auto-save.nvim',
    cmd = 'ASToggle', -- optional for lazy loading on command
    event = { 'InsertLeave', 'TextChanged' }, -- optional for lazy loading on trigger events
    opts = {
      -- your config goes here
      -- or just leave it empty :)
    },
  },
  {
    'craftzdog/solarized-osaka.nvim',
    lazy = true,
    priority = 1000,
    opts = function()
      return {
        transparent = true,
      }
    end,
  },
  {
    'echasnovski/mini.hipatterns',
    event = 'BufReadPre',
    opts = {
      highlighters = {
        hsl_color = {
          pattern = 'hsl%(%d+,? %d+%%?,? %d+%%?%)',
          group = function(_, match)
            local utils = require 'solarized-osaka.hsl'
            --- @type string, string, string
            local nh, ns, nl = match:match 'hsl%((%d+),? (%d+)%%?,? (%d+)%%?%)'
            --- @type number?, number?, number?
            local h, s, l = tonumber(nh), tonumber(ns), tonumber(nl)
            --- @type string
            local hex_color = utils.hslToHex(h, s, l)
            return MiniHipatterns.compute_hex_color_group(hex_color, 'bg')
          end,
        },
        hex_color = {
          pattern = '#%x%x%x%x%x%x',
          group = function(_, match)
            return MiniHipatterns.compute_hex_color_group(match, 'bg')
          end,
        },
      },
    },
  },
}
