local present, ts_config = pcall(require, "nvim-treesitter.configs")
if not present then
   return
end

ts_config.setup {
   ensure_installed = {
      "lua",
      "bash",
      "lua",
      "go",
      "gomod",
      "rust",
      "json",
      "c_sharp",
      "dockerfile",
      "yaml",
   },
   highlight = {
      enable = true,
      use_languagetree = true,
   },
}
