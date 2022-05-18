local origInit = SkillTreeTweakData.init
function SkillTreeTweakData:init()
  origInit(self)

  if not ijreMods.Settings.LowerSkills then
    return end

  self.costs =
  {
		unlock_tree = 0,
		default = 1,
		pro = 1,
		hightier = 2,
		hightierpro = 4
	}

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