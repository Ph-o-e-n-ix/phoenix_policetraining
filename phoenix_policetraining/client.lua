
if Config.Framework == 'ESX' then
    if Config.useNewESX then
        ESX = exports["es_extended"]:getSharedObject()
    else 
        Citizen.CreateThread(function()
            while ESX == nil do
                TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
                Citizen.Wait(0)
            end
        end)
    end
end  
if Config.Framework == 'QB' then
    QBCore = exports['qb-core']:GetCoreObject()
end

local inmission = false

AddEventHandler('onClientResourceStart', function(ressourceName)
    if(GetCurrentResourceName() ~= ressourceName) then 
        return 
    end 
    print("" ..ressourceName.." started sucessfully")
end)

if Config.Framework == 'ESX' then
    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded', function(xPlayer)
        PlayerData = xPlayer
    end)

    RegisterNetEvent('esx:setJob')
    AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
    end)
end

if Config.Framework == 'QB' then
    RegisterNetEvent('qb-core:client:OnPlayerLoaded')
    AddEventHandler('qb-core:client:OnPlayerLoaded', function()
        PlayerData = QBCore.Functions.GetPlayerData()
    end)
    
    RegisterNetEvent('qb-core:client:setJob')
    AddEventHandler('qb-core:client:setJob', function(job)
        PlayerData.job = job
    end)
end

if Config.Command.enable then
    RegisterCommand(Config.Command.commandname, function()
        if Config.requiredJob.enable then 
            if ESX.PlayerData.job.name == Config.requiredJob.jobname then 
                if not inmission then
                    if Config.Framework == 'ESX' then
                        ESX.TriggerServerCallback('inmissionserver', function(cb) 
                            if cb then
                                startmission()
                                TriggerServerEvent("phoenix:starttraining")
                            else 
                                Config.Notification(Translation[Config.Translation]["someone_already_started"])
                            end
                        end)
                    else 
                        QBCore.Functions.TriggerCallback('inmissionserver', function(cb) 
                            if cb then
                                startmission()
                                TriggerServerEvent("phoenix:starttraining")
                            else 
                                Config.Notification(Translation[Config.Translation]["someone_already_started"])
                            end
                        end)
                    end
                else 
                    Config.Notification(Translation[Config.Translation]["already_started"])
                end
            else 
                Config.Notification(Translation[Config.Translation]["not_right_job"])
            end
        else
            if not inmission then
                if Config.Framework == 'ESX' then
                    ESX.TriggerServerCallback('inmissionserver', function(cb) 
                        if cb then
                            startmission()
                            TriggerServerEvent("phoenix:starttraining")
                        else 
                            Config.Notification(Translation[Config.Translation]["someone_already_started"])
                        end
                    end)
                else 
                    QBCore.Functions.TriggerCallback('inmissionserver', function(cb) 
                        if cb then
                            startmission()
                            TriggerServerEvent("phoenix:starttraining")
                        else 
                            Config.Notification(Translation[Config.Translation]["someone_already_started"])
                        end
                    end)
                end
            else 
                Config.Notification(Translation[Config.Translation]["already_started"])
            end
        end
    end)
end

RegisterNetEvent("phoenix:startmission")
AddEventHandler("phoenix:startmission", function()
    if Config.requiredJob.enable then 
        if ESX.PlayerData.job.name == Config.requiredJob.jobname then 
            if not inmission then
                if Config.Framework == 'ESX' then
                    ESX.TriggerServerCallback('inmissionserver', function(cb) 
                        if cb then
                            startmission()
                            TriggerServerEvent("phoenix:starttraining")
                        else 
                            Config.Notification(Translation[Config.Translation]["someone_already_started"])
                        end
                    end)
                else 
                    QBCore.Functions.TriggerCallback('inmissionserver', function(cb) 
                        if cb then
                            startmission()
                            TriggerServerEvent("phoenix:starttraining")
                        else 
                            Config.Notification(Translation[Config.Translation]["someone_already_started"])
                        end
                    end)
                end
            else 
                Config.Notification(Translation[Config.Translation]["already_started"])
            end
        else 
            Config.Notification(Translation[Config.Translation]["not_right_job"])
        end
    else
        if not inmission then
            if Config.Framework == 'ESX' then
                ESX.TriggerServerCallback('inmissionserver', function(cb) 
                    if cb then
                        startmission()
                        TriggerServerEvent("phoenix:starttraining")
                    else 
                        Config.Notification(Translation[Config.Translation]["someone_already_started"])
                    end
                end)
            else 
                QBCore.Functions.TriggerCallback('inmissionserver', function(cb) 
                    if cb then
                        startmission()
                        TriggerServerEvent("phoenix:starttraining")
                    else 
                        Config.Notification(Translation[Config.Translation]["someone_already_started"])
                    end
                end)
            end
        else 
            Config.Notification(Translation[Config.Translation]["already_started"])
        end
    end
end)

if Config.Coords.enable then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1)
            local PlayerPed = PlayerPedId()
            local coords = GetEntityCoords(PlayerPed)
            local pos = Config.Coords.coords
            local dist = Vdist(coords, pos)
            if dist < 15 then 
                DrawMarker(20, pos.x, pos.y, pos.z , 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0.5, 136, 0, 255, 50, 0, 0, 2, 1, 0, 0, false )
                if dist < 1.5 then 
                    if not inmission then
                        DrawText3D(pos.x, pos.y, pos.z, Translation[Config.Translation]["press_e_to_start"])
                    end
                    if IsControlJustReleased(0, 38) then
                        if not inmission then 
                            if Config.Framework == 'ESX' then
                                ESX.TriggerServerCallback('inmissionserver', function(cb) 
                                    if cb then
                                        startmission()
                                        TriggerServerEvent("phoenix:starttraining")
                                    else 
                                        Config.Notification(Translation[Config.Translation]["someone_already_started"])
                                    end
                                end)
                            else 
                                QBCore.Functions.TriggerCallback('inmissionserver', function(cb) 
                                    if cb then
                                        startmission()
                                        TriggerServerEvent("phoenix:starttraining")
                                    else 
                                        Config.Notification(Translation[Config.Translation]["someone_already_started"])
                                    end
                                end)
                            end
                        else 
                            Config.Notification(Translation[Config.Translation]["already_started"])
                        end
                    end  
                end
            end
        end
    end)
end

function startmission()
    local results1 = Config.Pedname1coords[math.random(#Config.Pedname1coords)]
    local results2 = Config.Pedname2coords[math.random(#Config.Pedname2coords)]
    local results3 = Config.Pedname3coords[math.random(#Config.Pedname3coords)]
    local results4 = Config.Pedname4coords[math.random(#Config.Pedname4coords)]
    local results5 = Config.Pedname5coords[math.random(#Config.Pedname5coords)]
    if Config.UseHostagePeds then 
        resulth1 = Config.Pednamehostage1coords[math.random(#Config.Pednamehostage1coords)]
        resulth2 = Config.Pednamehostage2coords[math.random(#Config.Pednamehostage2coords)]
        resulth3 = Config.Pednamehostage3coords[math.random(#Config.Pednamehostage3coords)]
        hashh1 = GetHashKey(Config.Pednamehostage1)
        while not HasModelLoaded(hashh1) do
            RequestModel(hashh1)
            Wait(20)
        end
        hashh2 = GetHashKey(Config.Pednamehostage2)
        while not HasModelLoaded(hashh2) do
            RequestModel(hashh2)
            Wait(20)
        end
        hashh3 = GetHashKey(Config.Pednamehostage3)
        while not HasModelLoaded(hashh3) do
            RequestModel(hashh3)
            Wait(20)
        end
    end
    local PlayerPed = PlayerPedId()
    local hash1 = GetHashKey(Config.Pedname1)
    while not HasModelLoaded(hash1) do
        RequestModel(hash1)
        Wait(20)
    end
    local hash2 = GetHashKey(Config.Pedname2)
    while not HasModelLoaded(hash2) do
        RequestModel(hash2)
        Wait(20)
    end
    local hash3 = GetHashKey(Config.Pedname3)
    while not HasModelLoaded(hash3) do
        RequestModel(hash3)
        Wait(20)
    end
    local hash4 = GetHashKey(Config.Pedname4)
    while not HasModelLoaded(hash4) do
        RequestModel(hash4)
        Wait(20)
    end
    local hash5 = GetHashKey(Config.Pedname5)
    while not HasModelLoaded(hash5) do
        RequestModel(hash5)
        Wait(20)
    end
    if Config.UseHostagePeds then
        pedh1 = CreatePed(4, hashh1, resulth1.x, resulth1.y, resulth1.z, resulth1.h, true, false)
        pedh2 = CreatePed(4, hashh2, resulth2.x, resulth2.y, resulth2.z, resulth2.h, true, false)
        pedh3 = CreatePed(4, hashh3, resulth3.x, resulth3.y, resulth3.z, resulth3.h, true, false)
        SetBlockingOfNonTemporaryEvents(pedh1, true)
        SetBlockingOfNonTemporaryEvents(pedh2, true)
        SetBlockingOfNonTemporaryEvents(pedh3, true)
    end
    ped1 = CreatePed(4, hash1, results1.x, results1.y, results1.z, results1.h, true, false)
    ped2 = CreatePed(4, hash2, results2.x, results2.y, results2.z, results2.h, true, false)
    ped3 = CreatePed(4, hash3, results3.x, results3.y, results3.z, results3.h, true, false)
    ped4 = CreatePed(4, hash4, results4.x, results4.y, results4.z, results4.h, true, false)
    ped5 = CreatePed(4, hash5, results5.x, results5.y, results5.z, results5.h, true, false)
    SetEntityAsMissionEntity(ped1, true, true)
    NetworkRegisterEntityAsNetworked(ped1)
    local netID1 = PedToNet(ped1)
    NetworkSetNetworkIdDynamic(netID1, false)
    SetNetworkIdCanMigrate(netID1, true)
    SetNetworkIdExistsOnAllMachines(netID1, true)

    SetEntityAsMissionEntity(ped2, true, true)
    NetworkRegisterEntityAsNetworked(ped2)
    local netID2 = PedToNet(ped2)
    NetworkSetNetworkIdDynamic(netID2, false)
    SetNetworkIdCanMigrate(netID2, true)
    SetNetworkIdExistsOnAllMachines(netID2, true)

    SetEntityAsMissionEntity(ped3, true, true)
    NetworkRegisterEntityAsNetworked(ped3)
    local netID3 = PedToNet(ped3)
    NetworkSetNetworkIdDynamic(netID3, false)
    SetNetworkIdCanMigrate(netID3, true)
    SetNetworkIdExistsOnAllMachines(netID3, true)

    SetEntityAsMissionEntity(ped4, true, true)
    NetworkRegisterEntityAsNetworked(ped4)
    local netID4 = PedToNet(ped4)
    NetworkSetNetworkIdDynamic(netID4, false)
    SetNetworkIdCanMigrate(netID4, true)
    SetNetworkIdExistsOnAllMachines(netID4, true)

    SetEntityAsMissionEntity(ped5, true, true)
    NetworkRegisterEntityAsNetworked(ped5)
    local netID5 = PedToNet(ped5)
    NetworkSetNetworkIdDynamic(netID5, false)
    SetNetworkIdCanMigrate(netID5, true)
    SetNetworkIdExistsOnAllMachines(netID5, true)
    if Config.UseHostagePeds then
        SetEntityAsMissionEntity(pedh1, true, true)
        NetworkRegisterEntityAsNetworked(pedh1)
        local netpedh1 = PedToNet(pedh1)
        NetworkSetNetworkIdDynamic(netpedh1, false)
        SetNetworkIdCanMigrate(netpedh1, true)
        SetNetworkIdExistsOnAllMachines(netpedh1, true)

        SetEntityAsMissionEntity(pedh2, true, true)
        NetworkRegisterEntityAsNetworked(pedh2)
        local netpedh2 = PedToNet(pedh2)
        NetworkSetNetworkIdDynamic(netpedh2, false)
        SetNetworkIdCanMigrate(netpedh2, true)
        SetNetworkIdExistsOnAllMachines(netpedh2, true)

        SetEntityAsMissionEntity(pedh3, true, true)
        NetworkRegisterEntityAsNetworked(pedh3)
        local netpedh3 = PedToNet(pedh3)
        NetworkSetNetworkIdDynamic(netpedh3, false)
        SetNetworkIdCanMigrate(netpedh3, true)
        SetNetworkIdExistsOnAllMachines(netpedh3, true)

        RequestAnimDict("random@arrests@busted")
        while not HasAnimDictLoaded("random@arrests@busted") do 
            Citizen.Wait(25)
        end  
        TaskPlayAnim(pedh1, 'random@arrests@busted', 'idle_a', 1.0, -1, -1, 3, 0, false, false, false)
        TaskPlayAnim(pedh2, 'random@arrests@busted', 'idle_a', 1.0, -1, -1, 3, 0, false, false, false)
        TaskPlayAnim(pedh3, 'random@arrests@busted', 'idle_a', 1.0, -1, -1, 3, 0, false, false, false)
    end

    

    weaponhash = GetHashKey(Config.Weapon)
    SetPedCombatMovement(ped1, 2 )
    SetPedCombatMovement(ped2, 2 )
    SetPedCombatMovement(ped3, 2 )
    SetPedCombatMovement(ped4, 2 )
    SetPedCombatMovement(ped5, 2 )

    GiveWeaponToPed(ped1, weaponhash, 2, true, true)
    GiveWeaponToPed(ped2, weaponhash, 2, true, true)
    GiveWeaponToPed(ped3, weaponhash, 2, true, true)
    GiveWeaponToPed(ped4, weaponhash, 2, true, true)
    GiveWeaponToPed(ped5, weaponhash, 2, true, true)

    SetPedCombatAbility(ped1, 100)
    SetPedCombatAbility(ped2, 100)
    SetPedCombatAbility(ped3, 100)
    SetPedCombatAbility(ped4, 100)
    SetPedCombatAbility(ped5, 100)


    Config.Notification(Translation[Config.Translation]["started_mission"])
    inmission = true
    if Config.EnableBlip then 
        blip1 = AddBlipForEntity(ped1) 
        SetBlipSprite(blip1, 1)
        SetBlipScale(blip1, 0.6)
        SetBlipColour(blip1, 1)
        SetBlipAsShortRange(blip1, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Target')
        EndTextCommandSetBlipName(blip1)

        blip2 = AddBlipForEntity(ped2) 
        SetBlipSprite(blip2, 1)
        SetBlipScale(blip2, 0.6)
        SetBlipColour(blip2, 1)
        SetBlipAsShortRange(blip2, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Target')
        EndTextCommandSetBlipName(blip2)

        blip3 = AddBlipForEntity(ped3) 
        SetBlipSprite(blip3, 1)
        SetBlipScale(blip3, 0.6)
        SetBlipColour(blip3, 1)
        SetBlipAsShortRange(blip3, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Target')
        EndTextCommandSetBlipName(blip3)

        blip4 = AddBlipForEntity(ped4) 
        SetBlipSprite(blip4, 1)
        SetBlipScale(blip4, 0.6)
        SetBlipColour(blip4, 1)
        SetBlipAsShortRange(blip4, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Target')
        EndTextCommandSetBlipName(blip4)

        blip5 = AddBlipForEntity(ped5) 
        SetBlipSprite(blip5, 1)
        SetBlipScale(blip5, 0.6)
        SetBlipColour(blip5, 1)
        SetBlipAsShortRange(blip5, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Target')
        EndTextCommandSetBlipName(blip5)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if inmission then
            local playercoords = GetEntityCoords(PlayerPedId())
            local ped1coords = GetEntityCoords(ped1)
            local ped2coords = GetEntityCoords(ped2)
            local ped3coords = GetEntityCoords(ped3)
            local ped4coords = GetEntityCoords(ped4)
            local ped5coords = GetEntityCoords(ped5)
            local distance1 = Vdist(playercoords,ped1coords) 
            local distance2 = Vdist(playercoords,ped2coords) 
            local distance3 = Vdist(playercoords,ped3coords) 
            local distance4 = Vdist(playercoords,ped4coords) 
            local distance5 = Vdist(playercoords,ped5coords) 
            if distance1 < Config.DistanceAttack then 
                TaskCombatPed(ped1, PlayerPedId(), 0, 16)
            end
            if distance2 < Config.DistanceAttack then 
                TaskCombatPed(ped2, PlayerPedId(), 0, 16)
            end
            if distance3 < Config.DistanceAttack then 
                TaskCombatPed(ped3, PlayerPedId(), 0, 16)
            end
            if distance4 < Config.DistanceAttack then 
                TaskCombatPed(ped4, PlayerPedId(), 0, 16)
            end
            if distance5 < Config.DistanceAttack then 
                TaskCombatPed(ped5, PlayerPedId(), 0, 16)
            end
            if IsPedBeingStunned(ped1) or IsEntityDead(ped1) then 
                DeleteEntity(ped1)
            end
            if IsPedBeingStunned(ped2) or IsEntityDead(ped2) then 
                DeleteEntity(ped2)
            end
            if IsPedBeingStunned(ped3) or IsEntityDead(ped3) then 
                DeleteEntity(ped3)
            end
            if IsPedBeingStunned(ped4) or IsEntityDead(ped4) then 
                DeleteEntity(ped4)
            end
            if IsPedBeingStunned(ped5) or IsEntityDead(ped5) then 
                DeleteEntity(ped5)
            end
            if IsPedBeingStunned(PlayerPedId()) then
                Citizen.Wait(200)
                inmission = false
                DeleteEntity(ped1)
                DeleteEntity(ped2)
                DeleteEntity(ped3)
                DeleteEntity(ped4)
                DeleteEntity(ped5)
                endmission(true)
            end
            if IsEntityDead(ped1) and IsEntityDead(ped2) and IsEntityDead(ped3) and IsEntityDead(ped4) and IsEntityDead(ped5) and inmission then 
                endmission(false)
            end
            if Config.UseHostagePeds then
                if IsEntityDead(pedh1) or IsEntityDead(pedh2) or IsEntityDead(pedh2) then
                    inmission = false
                    DeleteEntity(pedh1)
                    DeleteEntity(pedh2)
                    DeleteEntity(pedh3)
                    endmission(true)
                end
            end
        end
    end
end)

function endmission(cancel)
    if not cancel then
        DeleteEntity(ped1)
        DeleteEntity(ped2)
        DeleteEntity(ped3)
        DeleteEntity(ped4)
        DeleteEntity(ped5)
	DeleteEntity(pedh1)
        DeleteEntity(pedh2)
        DeleteEntity(pedh3)
        inmission = false  
        Config.Notification(Translation[Config.Translation]["mission_success"])
        TriggerServerEvent("phoenix:starttraining")
        TriggerServerEvent("phoenix:getreward")
    else 
	DeleteEntity(pedh1)
        DeleteEntity(pedh2)
        DeleteEntity(pedh3)
        DeleteEntity(ped1)
        DeleteEntity(ped2)
        DeleteEntity(ped3)
        DeleteEntity(ped4)
        DeleteEntity(ped5)
        inmission = false
        Config.Notification(Translation[Config.Translation]["mission_failed"])
        TriggerServerEvent("phoenix:starttraining")
    end
    if Config.EnableBlip then 
        RemoveBlip(blip1)
        RemoveBlip(blip2)
        RemoveBlip(blip3)
        RemoveBlip(blip4)
        RemoveBlip(blip5)
    end
end

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(true)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z, 0)
	DrawText(0.0, 0.0)
	local factor = (string.len(text)) / 370
	DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
	ClearDrawOrigin()
end

AddEventHandler('playerDropped', function(source, reason)
	endmission(true)
end)

if Config.Debug then
    RegisterCommand('cancel', function()
        if inmission then
            endmission(true)
        else 
            print("jaja")
        end
    end)
    RegisterCommand('reward', function()
        endmission(false)
    end)
end

AddEventHandler('onResourceStop', function()
    DeleteEntity(ped1)
    DeleteEntity(ped2)
    DeleteEntity(ped3)
    DeleteEntity(ped4)
    DeleteEntity(ped5)
    if Config.UseHostagePeds then
        DeleteEntity(pedh1)
        DeleteEntity(pedh2)
        DeleteEntity(pedh3)
    end
end)
