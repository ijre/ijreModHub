local origUnlocked = SkillTreeManager.tier_unlocked
function SkillTreeManager:tier_unlocked(tree, tier, switch)
  return ijreMods.Settings.NoTiers or origUnlocked(self, tree, tier, switch)
end

local origCanBeRemoved = SkillTreeManager.skill_can_be_removed
function SkillTreeManager:skill_can_be_removed(a, b, id)
  return (ijreMods.Settings.NoTiers and self:skill_step(id) > 0) or origCanBeRemoved(self, a, b, id)
end