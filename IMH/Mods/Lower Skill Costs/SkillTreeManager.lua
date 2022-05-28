local costs =
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

local oldCosts =
{
  {
    1,
    3
  },
  {
    2,
    4
  },
  {
    3,
    6
  },
  {
    4,
    8
  }
}

local origCost = SkillTreeManager.skill_cost
function SkillTreeManager:skill_cost(tier, skill_level, skill_cost)
	local t = skill_cost or costs
  if not ijreMods.Settings.LowerSkills then
    t = oldCosts
  end


	return t[tier][skill_level]
end

-- function SkillTreeManager:_points_spent_skill(tier, skill_id)
-- 	local points = 0
-- 	local skill_costs = costs
-- 	local skill_level = self._global.skills[skill_id].unlocked

-- 	if skill_level and skill_level >= 1 then
-- 		for j = skill_level, 1, -1 do
-- 			points = points + self:skill_cost(tier, j, skill_costs)
-- 		end
-- 	end

-- 	return points
-- end

-- function SkillTreeManager:get_points_spent_in_tier(tier, tier_idx)
-- 	local skills = self._global.skills
-- 	local skill_costs = costs
-- 	local points = 0

-- 	for i = 1, #tier do
-- 		local skill_level = skills[tier[i]].unlocked

-- 		if skill_level and skill_level >= 1 then
-- 			for j = skill_level, 1, -1 do
-- 				points = points + self:skill_cost(tier_idx, j, skill_costs)
-- 			end
-- 		end
-- 	end

-- 	return points
-- end

-- function SkillTreeManager:get_points_spent_until_tier(tiers, target_tier_idx)
-- 	local skills = self._global.skills
-- 	local skill_costs = costs
-- 	local points = 0

-- 	for i = 1, target_tier_idx do
-- 		for j = 1, #tiers[i] do
-- 			local skill_level = skills[tiers[i][j]].unlocked

-- 			if skill_level and skill_level >= 1 then
-- 				for k = skill_level, 1, -1 do
-- 					points = points + self:skill_cost(i, k, skill_costs)
-- 				end
-- 			end
-- 		end
-- 	end

-- 	return points
-- end