return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    picker = {
      hidden = true,
      ignored = true,

      win = {
        list = {
          keys = {
            ["<F3>"] = { "draw_pathcopy", mode = { "n", "i" }, desc = "Path Copy" },
          },
        },
      },
      actions = {
        draw_pathcopy = function(picker)
          local object = picker:current({ resolve = false })
          if object then
            local filepath = Snacks.picker.util.path(object)
            local modify = vim.fn.fnamemodify

            if filepath then
              local results = {
                filepath,
                modify(filepath, ":."),
                modify(filepath, ":~"),
                modify(filepath, ":t"),
                modify(filepath, ":t:r"),
                modify(filepath, ":e"),
              }

              vim.ui.select({
                "Absolute path: " .. results[1],
                "Path relative to CWD: " .. results[2],
                "Path relative to HOME: " .. results[3],
                "Filename: " .. results[4],
                "Filename without extension: " .. results[5],
                "Extension of the filename: " .. results[6],
              }, { prompt = "Choose to copy to clipboard:" }, function(item, choice)
                if choice then
                  local i = tonumber(choice)
                  if i then
                    local result = results[i]
                    vim.fn.setreg('"', result)
                    vim.notify("Copied: " .. result)
                  else
                    vim.notify("Invalid selection :", item)
                  end
                else
                  vim.notify("Selection cancelled")
                end
              end)
            end
          end
        end,
      },
    },
  },
}
