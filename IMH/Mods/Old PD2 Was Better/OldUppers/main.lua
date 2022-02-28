local function PocoHudDrawUppers(uppersCD)
  if not AdditionalPocoHudTrackers then
    return
  end

  -- this code taken from AdditionalPocoHudTrackers in lua/playerdamage.lua in its _check_bleed_out hook (vers. 22 in mod.txt)

  local PocoHud3Class = _G.PocoHud3Class
  local PocoHud3 = _G.PocoHud3

  if PocoHud3Class == nil or type(PocoHud3) ~= "table" then
    return
  end

  if not AdditionalPocoHudTrackers.Prefs.ShowUppersCooldown then
    return
  end

  local playertime = managers.player:player_timer():time()

  AdditionalPocoHudTrackers:Buff(PocoHud3, PocoHud3Class, {
    key = "UppersCooldown",
    good = false,
    icon = AdditionalPocoHudTrackers.U100SkillIcons,
    iconRect = {(2 * 80) + 10, (11 * 80) + 8, 64, 64},
    text = tostring(AdditionalPocoHudTrackers.TrackerNames.UppersCooldown),
    st = playertime,
    et = playertime + (uppersCD or 20)
  })

  PocoHud3:RemoveBuff("UppersRangeGauge")
end

local origUpdate = PlayerDamage.update
function PlayerDamage:update(unit, time, dt)
  if not ijreMods.Settings.OldPD2 or not self._block_medkit_auto_revive or self:is_downed() then
    origUpdate(self, unit, time, dt)
    return
  end

  if managers.player:get_activate_temporary_expire_time("temporary", "berserker_damage_multiplier") <= time then
    if time > self._uppers_elapsed + self._UPPERS_COOLDOWN then
      local auto_recovery_kit = FirstAidKitBase.GetFirstAidKit(self._unit:position())

      if auto_recovery_kit then
        auto_recovery_kit:take(self._unit)
        self._unit:sound():play("pickup_fak_skill")

        self._uppers_elapsed = Application:time()

        self:disable_berserker()

        origUpdate(self, unit, time, dt)

        self:revive(false)
        self:_on_exit_swansong_event()
        self:set_health(self:_max_health())
        self:set_armor(0)
        self:set_regenerate_timer_to_max()

        PocoHudDrawUppers(self._UPPERS_COOLDOWN)

        return
      end
    end
  end

  origUpdate(self, unit, time, dt)
end