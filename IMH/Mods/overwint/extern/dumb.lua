Overwint.wisdoms = Overwint.wisdoms or { }
local pastWisdoms = Overwint.StupidZone .. "yeaj"

function Overwint:PopulateWisdoms()
  if not io.file_is_readable(pastWisdoms) then
    os.execute("cmd /c start mods/overwint/extern/Dumbie.exe")

    while not io.file_is_readable(pastWisdoms) do
    end
  end

  local rawWisdoms = io.load_as_json(pastWisdoms)["statuses"]

  for i, v in ipairs(rawWisdoms) do
    self.wisdoms[i] = v.text
  end

  io.save_as_json(self.wisdoms, pastWisdoms)
end

function Overwint:GetWisdom()
  local wisdom = "@dril: "
  local addWoW = function(WoW) -- Words of Wisdom
    wisdom = wisdom .. WoW
    return wisdom
  end

  if not io.file_is_readable(self.StupidZone .. "Dumbie.exe") then
    return addWoW("no")
  end

  local pastWisdomsFile = io.load_as_json(pastWisdoms)

  if not self.wisdoms or table.empty(self.wisdoms) or not pastWisdomsFile then
    self:PopulateWisdoms()
  else
    if not pastWisdomsFile["statuses"] then
      self.wisdoms = pastWisdomsFile
    else
      self:PopulateWisdoms()
    end
  end

  return not table.empty(self.wisdoms) and addWoW(self.wisdoms[math.random(1, table.size(self.wisdoms))]) or addWoW("no")
end