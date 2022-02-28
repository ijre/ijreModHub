local origInit = BlackMarketTweakData._init_projectiles
function BlackMarketTweakData:_init_projectiles(data)
  origInit(self, data)

  local projectiles =
  {
    self.projectiles.frag,
    self.projectiles.frag_com,
    self.projectiles.fir_com,
    self.projectiles.concussion,
    self.projectiles.molotov,
    self.projectiles.dynamite,
    self.projectiles.wpn_prj_four,
    self.projectiles.wpn_prj_ace,
    self.projectiles.wpn_prj_jav,
    self.projectiles.wpn_prj_hur,
    self.projectiles.wpn_prj_target,
    self.projectiles.dada_com,
    self.projectiles.wpn_gre_electric,
  }

  local newProps =
  {
    no_cheat_count = false
  }

  for _, proj in pairs(projectiles) do
    for key, val in pairs(newProps) do
      proj[key] = val
    end
  end
end