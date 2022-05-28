local origInit = SkillTreeTweakData.init
function SkillTreeTweakData:init()
  origInit(self)

  if not ijreMods.Settings.LowerSkills then
    return end

  self.tier_cost =
  {
    {
      1,
      1
    },
    {
      1,
      2
    },
    {
      2,
      3
    },
    {
      2,
      4
    }
  }
end