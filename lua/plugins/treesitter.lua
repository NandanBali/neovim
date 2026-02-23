return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    -- Ensure these parsers are installed (idempotent: skips already-installed ones)
    local parsers_to_install = { "c", "cpp", "cmake", "make", "lua", "vim", "vimdoc", "bash" }
    local installed = require("nvim-treesitter.config").get_installed("parsers")
    local installed_set = {}
    for _, p in ipairs(installed) do
      installed_set[p] = true
    end
    local missing = {}
    for _, p in ipairs(parsers_to_install) do
      if not installed_set[p] then
        table.insert(missing, p)
      end
    end
    if #missing > 0 then
      require("nvim-treesitter.install").install(missing)
    end

    -- Enable treesitter highlighting and indentation for supported filetypes
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
      callback = function(args)
        local ok = pcall(vim.treesitter.start, args.buf)
        if ok then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
