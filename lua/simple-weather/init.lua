local M = {}
local curl = require("plenary.curl")

M._config = {
  city = "Naples",
  lang = "it"
}

M.setup = function(opts)
  -- Merge user config with defaults
  if opts then
    M._config = vim.tbl_deep_extend("force", M._config, opts)
  end

  vim.api.nvim_create_user_command("Weather", function()
    M.get_weather()
  end, {})
end

M.get_weather = function()
  local city = M._config.city
  local lang = M._config.lang

  if city == "" then
    vim.notify("Please set a city in the configuration", vim.log.levels.ERROR)
    return
  end

  local url = string.format("https://wttr.in/%s?0&lang=%s&format=j1", city, lang)

  curl.get({
    url = url,
    accept = "text/plain",
    callback = function(response)
      if response.status == 200 then
        if response.body and response.body ~= "" then
          vim.schedule(function()
            -- get json data
            local json = vim.json.decode(response.body)
            local current = json["current_condition"][1]

            local formatted_data = string.format("%s (%s)\n%s,%s", M._config.city,
              current["lang_" .. M._config.lang][1].value,
              current["temp_C"] .. "°", "(" .. current["FeelsLikeC"] .. "°)")
            vim.notify(formatted_data, vim.log.levels.INFO)
          end)
        else
          vim.schedule(function()
            vim.notify("No weather data received", vim.log.levels.ERROR)
          end)
        end
      else
        vim.schedule(function()
          vim.notify(
            string.format("Failed to fetch weather data. Status: %d", response.status),
            vim.log.levels.ERROR
          )
        end)
      end
    end,
  })
end

return M
