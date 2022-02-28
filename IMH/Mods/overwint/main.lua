Overwint.Toggle = not Overwint.Toggle or false

dofile(Overwint.StupidZone .. "dumb.lua")

if Overwint.Toggle then
  local rightHeist = managers.job:current_level_id() == "red2"
  local isHost = LuaNetworking:IsHost() or Global.game_settings.singleplayer

  if not rightHeist or not isHost then
    managers.chat:_receive_message(1, "Overwint", "Conditions are not met!", tweak_data.system_chat_color)

    if not rightHeist then
      managers.chat:_receive_message(1, "Requirements", "men va fan jag kan ju inte Overska på " .. managers.localization:text(managers.job:current_job_data().name_id), Color.red)
    elseif not isHost then
      managers.chat:_receive_message(1, "Requirements", "men va fan jag kan ju inte Overska som client", Color.red)
    end

    Overwint.Toggle = false
    return
  end

  for _, script in pairs(managers.mission:scripts()) do
    for _, element in pairs(script:elements()) do
      for _, trigger in pairs(element:values().trigger_list or {}) do
        if trigger.notify_unit_sequence == "light_on" then
          element:on_executed()
          managers.chat:_receive_message(1, "Overwint", Overwint:GetWisdom(), tweak_data.system_chat_color)
        end
      end
    end
  end
else
  managers.chat:_receive_message(1, "Overwint", "Deactivated", Color.red)
end