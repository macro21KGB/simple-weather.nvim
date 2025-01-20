# simple-weather.nvim

A minimal Neovim plugin to check weather conditions right from your editor using [wttr.in](https://wttr.in).

## Features

- Get current weather conditions for any city
- Temperature display in Celsius
- Feels-like temperature
- Weather description in your preferred language
- Asynchronous API calls using plenary.nvim

## Requirements

- Neovim >= 0.5.0
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):
```lua
{
  'macro21KGB/simple-weather.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('simple-weather').setup({
      city = "London",  -- your city
      lang = "en"      -- preferred language
    })
  end
}
```

Using [packer.nvim](https://github.com/wbthomason/packer.nvim):
```lua
use {
  'macro21KGB/simple-weather.nvim',
  requires = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('simple-weather').setup({
      city = "London",  -- your city
      lang = "en"      -- preferred language
    })
  end
}
```

## Configuration

The plugin can be configured with the following options:

```lua
require('simple-weather').setup({
  -- Default configuration
  city = "London",     -- Your city name
  lang = "en"         -- Language for weather descriptions
                      -- Supported languages: en, fr, de, it, es, etc.
})
```

## Usage

After installation, you can use the `:Weather` command to display current weather conditions.

The plugin will show:
- City name
- Weather description in your configured language
- Current temperature
- Feels-like temperature

Example output:
```
London (Partly cloudy)
18°(16°)
```

## License

MIT

## Credits

- Weather data provided by [wttr.in](https://wttr.in)
- HTTP requests handled by [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
```
