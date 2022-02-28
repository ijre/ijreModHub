local origInit = WeaponTweakData.init
function WeaponTweakData:init(data)
  origInit(self, data)

  if not ijreMods.Settings.OldPD2 then
    return end

  self.arblast.stats.damage = 40
  table.insert(self.arblast.categories, "snp")
  self.arblast.can_shoot_through_enemy = true
  self.arblast.can_shoot_through_shield = true
  self.arblast.can_shoot_through_wall = true

  self.frankish.stats.damage = 150
end