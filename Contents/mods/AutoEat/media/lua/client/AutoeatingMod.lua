local function AutoEating()
  local player = getPlayer()
  local p_h = player:getStats():getHunger()
  --print("AUTO EAT (onevery10minutes)","hunger:",p_h)
  if p_h > 0.15 then

    local playerInv = player:getInventory():getItems()
    local mmfood
    --print("HUNGRY")
    for i=0, playerInv:size()-1 do
      local item = playerInv:get(i)
      if item:IsFood() and item:isFavorite() and item:getHungerChange() < 0 and p_h>=math.abs(item:getHungerChange()) then
          --print("food found:",item)
          mmfood = item
          break
      end
    end

    if mmfood then
      --print("BEST choice is:",mmfood:getName(),"(",mmfood:getHungerChange() / 4,")")
      ISTimedActionQueue.add(ISEatFoodAction:new(player, mmfood, 1))
    end
  end
end

Events.OnPlayerUpdate.Add(AutoEating)
