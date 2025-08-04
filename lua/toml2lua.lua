-- Save the original package.path
local original_path = package.path

-- Get the absolute path to this script
local function get_script_dir()
    local info = debug.getinfo(1, "S")
    local script_path = info.source:sub(2) -- remove '@'
    return vim.fn.fnamemodify(script_path, ":p:h") .. "/"
end

-- Go one directory up from the script directory
local parent_dir = vim.fn.fnamemodify(get_script_dir() .. "..", ":p") .. "/"

-- Add the parent directory to package.path
package.path = package.path .. ";" .. parent_dir .. "?.lua"

-- Try requiring toml.lua
local ok, toml = pcall(require, "toml")
if not ok then
    package.path = original_path
    error("Failed to load toml: " .. tostring(toml))
end

-- 🧹 Full cleanup
package.loaded["toml"] = nil
package.path = original_path

-- ✅ Return the toml module
return toml
