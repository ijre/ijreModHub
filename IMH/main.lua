---@diagnostic disable-next-line: lowercase-global
ijreMods = ijreMods or { }
ijreMods.Settings = { }
ijreMods.Consts =
{
  IsDevEnv = false,
  ShortPath = "",
  Path = ""
}

local readme = io.open(ModPath .. "README.md", "r")
if readme ~= nil then
  ijreMods.Consts.IsDevEnv = true
  ijreMods.Consts.ShortPath = "IMH/"
  ijreMods.Consts.Path = ModPath .. "IMH/"
  readme:close()
else
  ijreMods.Consts.Path = ModPath
end

function ijreMods:GetPathToMods()
  return self.Consts.ShortPath .. "Mods/"
end

function ijreMods:GetPath(suffix)
  if string.is_nil_or_empty(suffix) then
    return "" end

  return self.Consts.Path .. suffix
end

dofile(ijreMods:GetPath("Settings/Settings.lua"))