-- Theme handling library
local beautiful = require("beautiful")

-- Default notification library
local naughty = require("naughty")

local theme_manager = {}
theme_manager.default_theme = "skyfall"
theme_manager.default_bartheme = "skyfall"

theme_collection = {
    "manta",        -- 1 --
    "lovelace",     -- 2 --
    "skyfall",      -- 3 --
    "lovelace-modified" -- 4 --
}

bartheme_collection = {
    "lovelace",        -- 1 -- taglist, client counter, date, time, layout
    "manta",     -- 2 -- start button, taglist, layout
    "skyfall",      -- 3 -- weather, taglist, window buttons, pop-up tray
}


local themes_dir = os.getenv("HOME") .. "/.config/awesome/themes/"

local active_theme_file = os.getenv("HOME") .. "/.config/awesome/theme_manager/active-theme"

local active_bartheme_file = os.getenv("HOME") .. "/.config/awesome/theme_manager/active-bartheme"

function theme_manager.get_themes()
    return theme_collection
end

function theme_manager.get_barthemes()
    return bartheme_collection
end

function theme_manager.get_active_bartheme()
    local f = io.open(active_bartheme_file, "r")
    if f == nil then
        return theme_manager.default_bartheme
    end

    local content = f:read("*all")
    f:close()	
    return content
end

function theme_manager.set_active_bartheme(t)
    local f = io.open(active_bartheme_file, "w")
    f:write(t)
    f:close()
end


local function build_theme_path(theme_name)
   return themes_dir .. theme_name .. "/theme.lua"
end

function theme_manager.get_active_theme()
    local f = io.open(active_theme_file, "r")
    if f == nil then
        return build_theme_path(theme_manager.default_theme)
    end

    local content = f:read("*all")
    f:close()	
    return content
end

function theme_manager.set_active_theme(t)
    local f = io.open(active_theme_file, "w")
    f:write(t)
    f:close()
end

function theme_manager.set_random_theme()
    local theme = theme_collection[math.random(tablelength(theme_collection))]
    theme_manager.set_active_theme(theme)

    local bartheme = bartheme_collection[math.random(tablelength(bartheme_collection))]
    theme_manager.set_active_bartheme(bartheme)
end

function theme_manager.initialize()
    beautiful.init(build_theme_path(theme_manager.get_active_theme()))
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

return theme_manager
