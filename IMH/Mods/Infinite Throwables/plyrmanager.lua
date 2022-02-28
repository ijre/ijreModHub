local origAddGrenade = PlayerManager.add_grenade_amount
function PlayerManager:add_grenade_amount(amount, sync)
  if InfThrows.HostHasMod and ijreMods.Settings.InfThrows and amount == -1 then
    amount = 0
    sync = true
  end

  origAddGrenade(self, amount, sync)
end