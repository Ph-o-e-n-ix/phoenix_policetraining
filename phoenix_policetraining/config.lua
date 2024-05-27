Config = {}

Config.Debug = false -- if true you can cancel the mission with "/cancel"

Config.Translation = "en" -- "de" or "en"

Config.Framework = 'ESX' -- "ESX" , "QB"
--IMPORTANT -> For QB Core you need to uncomment the es_extended line in the fxmanifest.lua
--Special Thanks to JimGordon for the QB Support[https://github.com/jimgordon20/]

Config.useNewESX = true -- You can ignore this if you use QB Core

Config.Notification = function(text, time)
    ESX.ShowNotification(text, time) -- You can setup your own Notification Script, just paste your export notification and replace text and time variable
    --QBCore.Functions.Notify(text, "success", time)
end

Config.EnableBlip = true -- If you want to enable blips for the Enemies

Config.Weapon = "WEAPON_STUNGUN" -- The Weapon for the Peds they have 
--IMPORTANT!: For the best Experience you also have to do the Training with a Stungun. (Optional)

Config.DistanceAttack = 10.0 -- if you in this Distance the Peds will going to attack you. You should leave it to 10.0

Config.UsableItem = { -- Start the Mission with an Item
    enable = true,  
    itemname = 'training_tablet'
}

Config.Command = { -- Start the Mission with a Command
    enable = true, 
    commandname = 'trainingstart',
}

Config.Coords = { -- Start the Mission on a specific Location (With draw3dtext)
    enable = true, 
    coords = vector3(-2005.7891, 3157.9822, 32.8105)
}

Config.Reward = { -- Get a Reward after complete the Mission.
    money = {enable = true, account = 'money' , amount = 100},
    item = {enable = true, itemname = 'bread', amount = 1}
}

Config.requiredJob = { -- You can set a required Job to get only access to specific Jobs
    enable = false,
    jobname= 'police'
}

Config.MaxEnemies = nil -- set to nil if you want all of the peds otherwise write a number
Config.Enemies = {
    { -- This is only 1 Ped. It has other Spots to spawn so it dont always spawn at the same coords
        ped = 's_m_y_armymech_01', 
        coords = {
            vector4(-2009.06, 3176.89, 32.81, 84.53),
            vector4(-1996.83, 3193.64, 32.81, 58.69),
            vector4(-1983.65, 3197.5, 32.81, 38.89),
			vector4(-1992.92, 3214.14, 32.81, 234.31),
			vector4(-1981.13, 3213.64, 32.81, 69.9),
			vector4(-1986.35, 3205.05, 32.81, 299.11),
			vector4(-1976.84, 3200.4, 32.81, 51.42),
			vector4(-1988.53, 3225.52, 32.81, 190.05),
			vector4(-2001.63, 3217.87, 32.81, 58.99),
			vector4(-2005.44, 3210.31, 32.81, 58.99),
			vector4(-1979.61, 3191.88, 32.81, 193.28),
			vector4(-1981.8, 3166.52, 32.81, 155.22),
			vector4(-2000.14, 3199.88, 161.33, 155.22),
        },
    },
    {
        ped = 's_m_y_armymech_01', 
        coords = {
            vector4(-2009.06, 3176.89, 32.81, 84.53),
            vector4(-1996.83, 3193.64, 32.81, 58.69),
            vector4(-1983.65, 3197.5, 32.81, 38.89),
			vector4(-1992.92, 3214.14, 32.81, 234.31),
			vector4(-1981.13, 3213.64, 32.81, 69.9),
			vector4(-1986.35, 3205.05, 32.81, 299.11),
			vector4(-1976.84, 3200.4, 32.81, 51.42),
			vector4(-1988.53, 3225.52, 32.81, 190.05),
			vector4(-2001.63, 3217.87, 32.81, 58.99),
			vector4(-2005.44, 3210.31, 32.81, 58.99),
			vector4(-1979.61, 3191.88, 32.81, 193.28),
			vector4(-1981.8, 3166.52, 32.81, 155.22),
			vector4(-2000.14, 3199.88, 161.33, 155.22),
        },
    },
    {
        ped = 's_m_y_armymech_01', 
        coords = {
            vector4(-2009.06, 3176.89, 32.81, 84.53),
            vector4(-1996.83, 3193.64, 32.81, 58.69),
            vector4(-1983.65, 3197.5, 32.81, 38.89),
			vector4(-1992.92, 3214.14, 32.81, 234.31),
			vector4(-1981.13, 3213.64, 32.81, 69.9),
			vector4(-1986.35, 3205.05, 32.81, 299.11),
			vector4(-1976.84, 3200.4, 32.81, 51.42),
			vector4(-1988.53, 3225.52, 32.81, 190.05),
			vector4(-2001.63, 3217.87, 32.81, 58.99),
			vector4(-2005.44, 3210.31, 32.81, 58.99),
			vector4(-1979.61, 3191.88, 32.81, 193.28),
			vector4(-1981.8, 3166.52, 32.81, 155.22),
			vector4(-2000.14, 3199.88, 161.33, 155.22),
        },
    },
}


Config.UseHostagePeds = true
Config.RescueCoords = vector3(-2013.9646, 3161.7129, 32.8106) -- Where you need to bring the Hostages (Entrance)
Config.Hostages = {
    { -- You can create as many Hostages as you want. This is only 1 Hostage at the moment
        ped = 'cs_andreas', 
        coords = {
            vector4(-1971.26, 3201.67, 32.81, 238.25),
            vector4(-2027.0438, 3194.6499, 32.8106, 238.4872),
            vector4(-1998.9568, 3216.2544, 37.9121, 148.8237),
            vector4(-1992.2976, 3181.1311, 38.0014, 51.5147),
        },
    },
    -- { -- Second Hostage
    --     ped = 'cs_andreas', 
    --     coords = {
    --         vector4(-1971.26, 3201.67, 32.81, 238.25),
    --     },
    -- },
    
}


Config.TeleportAfterLose = true -- Get Teleported Back if you loose
Config.TeleportCoords = vector3(-2010.9874, 3158.9895, 32.8106)

Translation = {
    ['de'] = {
        ["started_mission"] = 'Das Training hat begonnen. Erledige alle Täter und rette die Geiseln',
        ["already_started"] = 'Du bist bereits im Training',
        ["not_right_job"]   = 'Du hast nicht den richtigen Job dafür',
        ["mission_failed"]  = 'Training fehlgeschlagen. Die Übung ist Vorbei',
        ["mission_success"] = 'Du hast alle ausgeschaltet. Glückwunsch',
        ["someone_already_started"] = 'Es hat bereits jemand das Training gestartet',
        ["press_e_to_start"] = 'Drücke ~p~[E] ~w~um das Training zu starten',
        

        ["difficulty"] = 'Schwierigkeitsgrad',
        ["choose_difficulty"] = 'Wähle einen Schwierigkeitsgrad aus',
        ["easy"] = 'Einfach',
        ["normal"] = 'Normal',
        ["hard"] = 'Schwer',
        ["enemy"] = 'Gegner',
        ["hostage"] = 'Geisel',

        ["saved_all_hostages"] = 'Du hast alle Geiseln gerettet.' ,
        ["saved_hostage"] = 'Du hast eine Geisel gerettet.',
        ["take_hostage"] = 'Bring die Geisel zum Eingang.',
        ["press_take_hostage"] = 'Drücke ~g~[E]~s~ um die Geisel zu retten',
        ["press_drop_hostage"] = 'Drücke ~g~[E]~s~ um die Geisel runterzulassen',
        ["rescue"] = 'Geiselrettung',

    },
    ['en'] = {
        ["started_mission"] = 'The Training begins. Eleminate all Enemies and rescue the Hostages',
        ["already_started"] = 'The Training already started',
        ["not_right_job"]   = 'You dont have the right Job',
        ["mission_failed"]  = 'Training failed. Its over',
        ["mission_success"] = 'You eleminated all Enemies. Training passed',
        ["someone_already_started"] = 'Someone already started the Training',
        ["press_e_to_start"] = 'Press ~p~[E] ~w~to start the Training',

        ["difficulty"] = 'Difficulty',
        ["choose_difficulty"] = 'Choose a Difficulty',
        ["easy"] = 'Easy',
        ["normal"] = 'Normal',
        ["hard"] = 'Hard',
        ["enemy"] = 'Enemy',
        ["hostage"] = 'Hostage',

        ["saved_all_hostages"] = 'You saved all Hostages.' ,
        ["saved_hostage"] = 'You saved a Hostage.',
        ["take_hostage"] = 'Take the Hostage to the Entrance.',
        ["press_take_hostage"] = 'Press ~g~[E]~s~ to carry the Hostage',
        ["press_drop_hostage"] = 'Press ~g~[E]~s~ to drop the Hostage',
        ["rescue"] = 'Hostage Rescue',
    },
}
