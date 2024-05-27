
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
local rescue = 0

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
                                        openmainmenu()
                                    else 
                                        Config.Notification(Translation[Config.Translation]["someone_already_started"])
                                    end
                                end)
                            else 
                                QBCore.Functions.TriggerCallback('inmissionserver', function(cb) 
                                    if cb then
                                        openmainmenu()
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

function openmainmenu()
    lib.registerContext({
        id = 'mainmenu',
        title = Translation[Config.Translation]["difficulty"],
        icon = 'user',
        options = {
            {
                title = Translation[Config.Translation]["choose_difficulty"],
            },
            {
                title = Translation[Config.Translation]["easy"],
                colorScheme = 'green',
                icon = 'fa-solid fa-bars',
                iconColor = 'green',
                progress = 100,
                colorScheme = 'green',
                onSelect = function()
                    startmission('easy')
                    TriggerServerEvent("phoenix:starttraining")
                end 
            }, 
            {
                title = Translation[Config.Translation]["normal"],
                colorScheme = 'orange', 
                icon = 'fa-solid fa-bars',
                iconColor = 'orange',
                progress = 100,
                colorScheme = 'orange',
                onSelect = function()
                    startmission('normal')
                    TriggerServerEvent("phoenix:starttraining")
                end
            },
            {
                title = Translation[Config.Translation]["hard"],
                colorScheme = 'red',
                icon = 'fa-solid fa-bars',
                iconColor = 'red',
                progress = 100,
                colorScheme = 'red',
                onSelect = function()
                    startmission('hard')
                    TriggerServerEvent("phoenix:starttraining")
                end
            },
        }
    })
    lib.showContext('mainmenu')
end

local enemies = {}
local hostages = {}

-- RegisterCommand('delped', function(source, args, RawCommand)
--     for k,peds in pairs(enemies) do
--         DeleteEntity(peds)
--     end    
-- end)

function startmission(diff)
    globaldiff = diff
    if Config.MaxEnemies == nil then
        for k,v in pairs(Config.Enemies) do
            RequestModel(GetHashKey(v.ped))
            while not HasModelLoaded(GetHashKey(v.ped)) do 
                Citizen.Wait(10)
            end
            local random = v.coords[math.random(#v.coords)]
            local ped = CreatePed(4, GetHashKey(v.ped), random.x, random.y, random.z, random.w, true, false)
            SetEntityAsMissionEntity(ped, true, true)
            NetworkRegisterEntityAsNetworked(ped)

            local netID = PedToNet(ped)
            NetworkSetNetworkIdDynamic(netID, false)
            SetNetworkIdExistsOnAllMachines(netID, true)

            SetPedCombatMovement(ped, 2 )   
            GiveWeaponToPed(ped, GetHashKey(Config.Weapon), 2, true, true)
            SetPedCombatAbility(ped, 100)

            if diff == 'easy' then 
            elseif diff == 'normal' then 
                SetPedArmour(ped, 50)
            elseif diff == 'hard' then 
                SetPedArmour(ped, 100)
            end

            if Config.EnableBlip then 
                local blip = AddBlipForEntity(ped) 
                SetBlipSprite(blip, 1)
                SetBlipScale(blip, 0.6)
                SetBlipColour(blip, 1)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentSubstringPlayerName(Translation[Config.Translation]["enemy"])
            end

            table.insert(enemies, ped)
        end 
    else 
        local maxenemies = 0
        for k,v in pairs(Config.Enemies) do
            if maxenemies < Config.MaxEnemies then
                RequestModel(GetHashKey(v.ped))
                while not HasModelLoaded(GetHashKey(v.ped)) do 
                    Citizen.Wait(10)
                end
                local random = v.coords[math.random(#v.coords)]
                local ped = CreatePed(4, GetHashKey(v.ped), random.x, random.y, random.z, random.w, true, false)
                SetEntityAsMissionEntity(ped, true, true)
                NetworkRegisterEntityAsNetworked(ped)

                local netID = PedToNet(ped)
                NetworkSetNetworkIdDynamic(netID, false)
                SetNetworkIdExistsOnAllMachines(netID, true)

                SetPedCombatMovement(ped, 2 )   
                GiveWeaponToPed(ped, GetHashKey(Config.Weapon), 2, true, true)
                SetPedCombatAbility(ped, 100)

                if Config.EnableBlip then 
                    local blip = AddBlipForEntity(ped) 
                    SetBlipSprite(blip, 1)
                    SetBlipScale(blip, 0.6)
                    SetBlipColour(blip, 1)
                    SetBlipAsShortRange(blip, true)
                    BeginTextCommandSetBlipName('STRING')
                    AddTextComponentSubstringPlayerName(Translation[Config.Translation]["enemy"])
                    EndTextCommandSetBlipName(blip)
                end
                maxenemies = maxenemies + 1
                table.insert(enemies, ped)
            else 
                --("SPAWNED "..tostring(maxenemies).." Enemies")
            end
        end 
    end

    for k,v in pairs(Config.Hostages) do
        RequestModel(GetHashKey(v.ped))
        while not HasModelLoaded(GetHashKey(v.ped)) do 
            Citizen.Wait(10)
        end
        local random = v.coords[math.random(#v.coords)]
        local ped = CreatePed(4, GetHashKey(v.ped), random.x, random.y, random.z - 1.0, random.w, true, false)
        SetEntityAsMissionEntity(ped, true, true)
        NetworkRegisterEntityAsNetworked(ped)
        local netID = PedToNet(ped)
        NetworkSetNetworkIdDynamic(netID, false)
        SetNetworkIdExistsOnAllMachines(netID, true)

        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskSetBlockingOfNonTemporaryEvents(ped, true)
        SetEveryoneIgnorePlayer(ped, true)        

        RequestAnimDict("random@arrests@busted")
        while not HasAnimDictLoaded("random@arrests@busted") do 
            Citizen.Wait(25)
        end  
        TaskPlayAnim(ped, 'random@arrests@busted', 'idle_a', 1.0, -1, -1, 3, 0, false, false, false)

        if Config.EnableBlip then 
            local blip = AddBlipForEntity(ped) 
            SetBlipSprite(blip, 1)
            SetBlipScale(blip, 0.6)
            SetBlipColour(blip, 2)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(Translation[Config.Translation]["hostage"])
            EndTextCommandSetBlipName(blip)
        end

        table.insert(hostages, ped)
    end

    Config.Notification(Translation[Config.Translation]["started_mission"])
    inmission = true
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if inmission then
            for k,ped in pairs(enemies) do
                if globaldiff == 'easy' then 

                elseif globaldiff == 'normal' then 
    
                elseif globaldiff == 'hard' then 
                    SetPedSuffersCriticalHits(ped, false)
                end 
            end
        end
    end
end)


local dead = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if inmission then
            local plcoords = GetEntityCoords(PlayerPedId())
            for _, ped in pairs(enemies) do
                
                local coords = GetEntityCoords(ped)
                local dist = Vdist(plcoords, coords)
                if dist < Config.DistanceAttack then 
                    TaskCombatPed(ped, PlayerPedId(), 0, 16)
                end
                if DoesEntityExist(ped) then
                    if IsPedBeingStunned(ped) or IsEntityDead(ped) then 
                        DeleteEntity(ped)
                        dead = dead + 1
                    end
                end
                if rescue == #Config.Hostages then
                    if dead >= #Config.Enemies then  
                        --("HOSTAGES DEAD")
                        inmission = false
                        --print("ALLE TOT")
                        endmission(false)
                    end
                end
            end     
            if Config.UseHostagePeds then   
                for m, host in pairs(hostages) do    
                    if IsEntityDead(host) or IsPedBeingStunned(host) then
                        if inmission then
                            inmission = false
                            for k, enem in pairs(enemies) do
                            DeleteEntity(enem)
                            end
                            for s, host in pairs(hostages) do
                                DeleteEntity(host)
                            end
                            endmission(true)
                        end
                    end
                    local hostcoords = GetEntityCoords(host)
                    local hdist = Vdist(plcoords, hostcoords)
                    
                    while not IsEntityPlayingAnim(host, 'random@arrests@busted', 'idle_a', 3) and not iscarry do
                        Citizen.Wait(5)
                        TaskPlayAnim(host, 'random@arrests@busted', 'idle_a', 1.0, -1, -1, 3, 0, false, false, false)
                    end  

                    if rescue < #Config.Hostages then
                        if hdist < 1 then 
                            if not iscarry then
                                DrawText3D(hostcoords.x, hostcoords.y, hostcoords.z, Translation[Config.Translation]["press_take_hostage"])
                            else 
                                DrawText3D(hostcoords.x, hostcoords.y, hostcoords.z, Translation[Config.Translation]["press_drop_hostage"])
                                local rdist = Vdist(plcoords, Config.RescueCoords)
                                if rdist < 10 then 
                                    DrawMarker(1, Config.RescueCoords.x, Config.RescueCoords.y, Config.RescueCoords.z - 1.0 , 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, 3.0, 0.5, 136, 0, 255, 50, 0, 0, 2, 0, 0, 0, false )
                                    DrawText3D(Config.RescueCoords.x, Config.RescueCoords.y, Config.RescueCoords.z, Translation[Config.Translation]["rescue"])
                                end
                            end
                            if IsControlJustReleased(0, 38) then 
                                if not iscarry then 
                                    iscarry = true
                                    RequestAnimDict('missfinale_c2mcs_1')
                                    RequestAnimDict('nm')

                                    while(not HasAnimDictLoaded('missfinale_c2mcs_1')) do
                                        RequestAnimDict('missfinale_c2mcs_1')
                                        Citizen.Wait(1)
                                    end
                                    while(not HasAnimDictLoaded('missfinale_c2mcs_1')) do
                                        RequestAnimDict('missfinale_c2mcs_1')
                                        Citizen.Wait(1)
                                    end
                                    
                                    TaskPlayAnim(PlayerPedId(), "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 8.0, -8, -1, 49, 0, 0, 40, 0)
                                    TaskPlayAnim(host, "nm", "firemans_carry", 8.0, -8, -1, 33, 0, 0, 40, 0)
                                    AttachEntityToEntity(host, PlayerPedId(), 0, 0.27, 0.15, 0.63, 0.5, 0.5, 180, false, false, false, false, 2, false)
                                    SetEntityInvincible(host, true)
                                    Config.Notification(Translation[Config.Translation]["take_hostage"])
                                else 
                                    iscarry = false
                                    ClearPedSecondaryTask(PlayerPedId())
                                    ClearPedSecondaryTask(host)
                                    SetEntityInvincible(host, false)
                                    DetachEntity(host, true, false)
                                    RequestAnimDict("random@arrests@busted")
                                    while not HasAnimDictLoaded("random@arrests@busted") do 
                                        Citizen.Wait(25)
                                    end  
                                    TaskPlayAnim(host, 'random@arrests@busted', 'idle_a', 1.0, -1, -1, 3, 0, false, false, false)

                                    local detachcoords = GetEntityCoords(host)
                                    local dist = Vdist(detachcoords, Config.RescueCoords)
                                    if dist < 3 then 
                                        rescue = rescue + 1
                                        --print(json.encode(host))
                                        table.remove(hostages, m)
                                        if rescue == #Config.Hostages then 
                                            Config.Notification(Translation[Config.Translation]["saved_all_hostages"])
                                            ClearPedTasksImmediately(host)
                                            TaskSmartFleePed(host, PlayerPedId(), 50.0, -1, false, false)
                                            Citizen.Wait(1500)
                                            DeleteEntity(host)
                                        else 
                                            Config.Notification(Translation[Config.Translation]["saved_hostage"])
                                            ClearPedTasksImmediately(host)
                                            TaskSmartFleePed(host, PlayerPedId(), 50.0, -1, false, false)
                                            Citizen.Wait(1500)
                                            DeleteEntity(host)

                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            if IsPedBeingStunned(PlayerPedId()) or IsEntityDead(PlayerPedId()) then -- Wenn Spieler verliert
                Citizen.Wait(200)
                inmission = false
                for k, enem in pairs(enemies) do
                   DeleteEntity(enem)
                end
                for s, host in pairs(hostages) do
                    DeleteEntity(host)
                end
                if Config.TeleportAfterLose then 
                    SetEntityCoords(PlayerPedId(), Config.TeleportCoords)
                end
                endmission(true)
            end
        end
    end
end)

function endmission(cancel)
    if not cancel then
        for k, enem in pairs(enemies) do
            DeleteEntity(enem)
        end
        for s, host in pairs(hostages) do
            DeleteEntity(host)
        end

        inmission = false  
        Config.Notification(Translation[Config.Translation]["mission_success"])
        TriggerServerEvent("phoenix:starttraining")
        TriggerServerEvent("phoenix:getreward")
    else 
        for k, enem in pairs(enemies) do
            DeleteEntity(enem)
        end
        for s, host in pairs(hostages) do
            DeleteEntity(host)
        end

        inmission = false
        Config.Notification(Translation[Config.Translation]["mission_failed"])
        TriggerServerEvent("phoenix:starttraining")
    end
    dead = 0
    rescue = 0
    enemies = {}
    hostages = {}
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
        end
    end)
    RegisterCommand('reward', function()
        endmission(false)
    end)
end

AddEventHandler('onResourceStop', function()
    for k, enem in pairs(enemies) do
        DeleteEntity(enem)
    end
    for s, host in pairs(hostages) do
        DeleteEntity(host)
    end
end)
