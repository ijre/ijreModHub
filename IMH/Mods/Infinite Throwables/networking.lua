if table.remove(RequiredScript:split("/")) == "hostnetworksession" then
  local origOnLoad = HostNetworkSession.on_load_complete
  function HostNetworkSession:on_load_complete(sim)
    InfThrows.HostHasMod = true
    origOnLoad(self, sim)
  end

  return
end

local printedTo = { }

local function ServPeer()
  return LuaNetworking:IsHost() and managers.network:session():local_peer() or managers.network:session():server_peer()
end

Hooks:Add("NetworkReceivedData", "InfThrows_OnNetReceived",
function(sender, id)
  local senderName = LuaNetworking:GetNameFromPeerID(sender)

  if id == InfThrows.RequestSTR then
    LuaNetworking:SendToPeer(sender, InfThrows.AuthorizeSTR, "")

    if printedTo[sender] ~= senderName then
      local str = string.format("%s has been authorized to use the Infinite Throwables mod.", senderName)
      managers.chat:_receive_message(ChatManager.GAME, managers.localization:to_upper_text("menu_system_message"), str, tweak_data.system_chat_color)
    end
  elseif id == InfThrows.AuthorizeSTR then
    if printedTo[sender] ~= senderName then
      InfThrows.HostHasMod = true
      printedTo[sender] = senderName

      managers.chat:feed_system_message(ChatManager.GAME, "The host has the Infinite Throwables mod, thus granting you access.")
    end
  end
end)

local origSend = NetworkPeer.send
local alreadyRequested = false
function NetworkPeer:send(func, ...)
  origSend(self, func, ...)

  if ServPeer() and self:id() ~= managers.network:session():local_peer() and not InfThrows.HostHasMod and not alreadyRequested and func == "lobby_info" then
    LuaNetworking:SendToPeer(ServPeer():id(), InfThrows.RequestSTR, "")
    alreadyRequested = true
  end
end

local origVerify = NetworkPeer.verify_grenade
function NetworkPeer:verify_grenade(val)
  local id = self:id()

  if not InfThrows.HostHasMod or not ijreMods.Settings.InfThrows then
    return origVerify(self, val)
  end

  self._grenades = managers.player:get_max_grenades_by_peer_id(id)
  return true
end