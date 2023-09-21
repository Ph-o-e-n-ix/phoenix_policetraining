if Config.Framework == 'ESX' then
   if Config.useNewESX then
      ESX = exports["es_extended"]:getSharedObject()
   else 
      ESX = nil
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
   end
else 
   QBCore = exports['qb-core']:GetCoreObject()
end

local inmissionserver = false

RegisterServerEvent("phoenix:getreward")
AddEventHandler("phoenix:getreward", function()
   if Config.Framework == 'ESX' then
      local xPlayer = ESX.GetPlayerFromId(source)
      if Config.Reward.item.enable then
         xPlayer.addInventoryItem(Config.Reward.item.itemname, Config.Reward.item.amount)
      end 
      if Config.Reward.money.enable then 
         xPlayer.addAccountMoney(Config.Reward.money.account, Config.Reward.money.amount)
      end
   else 
      local xPlayer = QBCore.Functions.GetPlayer(source)
      if Config.Reward.item.enable then
         xPlayer.AddItem(Config.Reward.item.itemname, Config.Reward.item.amount)
      end 
      if Config.Reward.money.enable then 
         xPlayer.AddMoney(Config.Reward.money.amount)
      end
   end
end)

if Config.UsableItem.enable then
   if Config.Framework == 'ESX' then
      ESX.RegisterUsableItem(Config.UsableItem.itemname, function(source)
         local xPlayer = ESX.GetPlayerFromId(source)
         TriggerClientEvent("phoenix:startmission", source)
      end)
   else
      QBCore.Functions.CreateUseableItem(Config.UsableItem.itemname, function(source)
         local xPlayer = QBCore.Functions.GetPlayer(source)
         TriggerClientEvent("phoenix:startmission", source)
      end) 
   end
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
if Config.Framework == 'ESX' then
   ESX.RegisterServerCallback('inmissionserver', function(source, cb)
      if not inmissionserver then 
         cb(true)
      else 
         cb(false)
      end
   end)
else 
   QBCore.Functions.CreateCallback('inmissionserver', function(source, cb)
      if not inmissionserver then 
         cb(true)
      else 
         cb(false)
      end
   end)
end
