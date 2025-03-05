return {
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', config = function()
      require('ibl').setup {
        enabled = true,
        indent = {
          char = '│', -- 缩进标识字符
        },
        scope = {
          enabled = true, -- 是否显示作用域信息
        },
      }
    end},
}
