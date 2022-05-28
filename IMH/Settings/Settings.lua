local menuLocPath = ijreMods:GetPath("Settings/Menu/")
local savePath = SavePath .. "ijreModHub.txt"
local instance = ModInstance

ijreMods.Consts.Defaults =
{
  InfThrows = true,
  LowerSkills = true,
  NoTiers = false,
  OldPD2 = true,
  Overwint = true
}

Hooks:Add("LocalizationManagerPostInit", "IMH_OnLocalizeInit", function(LM)
  LM:load_localization_file(menuLocPath .. "en.txt")
end)

function ijreMods:AddMissingVariables()
  local defaultSize = table.size(ijreMods.Consts.Defaults)
  local savedSize = table.size(self.Settings)

  if savedSize == 0 then
    self.Settings = ijreMods.Consts.Defaults
    return false
  elseif defaultSize == savedSize then
    return false
  end

  local ret = false

  for defK, val in pairs(ijreMods.Consts.Defaults) do
    if not table.has(self.Settings, defK) then
      self.Settings["defK"] = val
      ret = true
    end
  end

  return ret
end

function ijreMods:Load()
  local file = io.open(savePath, "r")

  if file then
    for k, v in pairs(json.decode(file:read("*all"))) do
      self.Settings[k] = v
    end

    file:close()
  else
    self:Save(true)
  end
end

function ijreMods:Save(defaults)
  local file = io.open(savePath, "w+")

  if defaults then
    self.Settings = self.Consts.Defaults
  end

  file:write(json.encode(self.Settings))
  file:close()
end

local function LoadCustomBinds()
  local file = io.open(menuLocPath .. "keybinds.json")

  if file == nil then
    return end

  for modName, binds in pairs(json.decode(file:read("*all"))) do
    for _, bind in pairs(binds) do
      bind.script_path = string.format("%s%s/%s", ijreMods:GetPathToMods(), modName, bind.script_path)
      BLT.Keybinds:register_keybind_json(instance, bind)
    end
  end
end

Hooks:Add("MenuManagerInitialize", "IMH_OnMenuInit", function(MM)
  MenuCallbackHandler.IMH_OnInfThrows = function(self, option)
    ijreMods.Settings.InfThrows = option:value() == "on"
    ijreMods:Save()
  end

  MenuCallbackHandler.IMH_OnLowerSkills = function(self, option)
    ijreMods.Settings.LowerSkills = option:value() == "on"
    -- ijreMods.Settings.NoTiers = false
    ijreMods:Save()
  end

  MenuCallbackHandler.IMH_OnNoTiers = function(self, option)
    ijreMods.Settings.NoTiers = option:value() == "on"
    -- ijreMods.Settings.LowerSkills = false
    ijreMods:Save()
  end

  MenuCallbackHandler.IMH_OnOldPD2 = function(self, option)
    ijreMods.Settings.OldPD2 = option:value() == "on"
    ijreMods:Save()
  end

  MenuCallbackHandler.IMH_OnOverwint = function(self, option)
    ijreMods.Settings.Overwint = option:value() == "on"
    ijreMods:Save()
  end

  ijreMods:Load()
  MenuHelper:LoadFromJsonFile(menuLocPath .. "menu.txt", ijreMods, ijreMods.Settings)
  LoadCustomBinds()
end)

if ijreMods:AddMissingVariables() then
  ijreMods:Save()
else
  ijreMods:Load()
end