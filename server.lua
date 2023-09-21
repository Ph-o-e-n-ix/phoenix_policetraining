ESX = exports["es_extended"]:getSharedObject()

local inmissionserver = false

RegisterServerEvent("phoenix:getreward")
AddEventHandler("phoenix:getreward", function()
   local xPlayer = ESX.GetPlayerFromId(source)
   if Config.Reward.item.enable then
      xPlayer.addInventoryItem(Config.Reward.item.itemname, Config.Reward.item.amount)
   end 
   if Config.Reward.money.enable then 
      xPlayer.addAccountMoney(Config.Reward.money.account, Config.Reward.money.amount)
   end
end)

if Config.UsableItem.enable then
   ESX.RegisterUsableItem(Config.UsableItem.itemname, function(source)
      local xPlayer = ESX.GetPlayerFromId(source)
      TriggerClientEvent("phoenix:startmission", source)
   end)
end

RegisterServerEvent("phoenix:start_mission_s")
AddEventHandler("phoenix:start_mission_s", function()
   TriggerClientEvent("phoenix:start_mission_c")
end)

RegisterServerEvent("phoenix:starttraining")
AddEventHandler("phoenix:starttraining", function()
   if not inmissionserver then
      inmissionserver = true
   else 
      inmissionserver = false 
   end
end)

ESX.RegisterServerCallback('inmissionserver', function(source, cb)
   if not inmissionserver then 
      cb(true)
   else 
      cb(false)
   end
end)

