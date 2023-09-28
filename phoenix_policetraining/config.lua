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

Config.EnableBlip = false -- If you want to enable blips for the Enemies

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

Config.Pedname1 = "s_m_y_armymech_01" -- Setup any Ped you want -> https://wiki.rage.mp/index.php?title=Peds
Config.Pedname1coords = { -- You can set up more coords. 1 Random coord will be chosen after start, so its not always the same position
    {x =  -1962.2983,  y = 3197.2800,  z = 38.0401, h = 239.2150},
    {x = -1977.9225,  y = 3168.1230,  z = 38.2638, h = 55.8916},
    {x = -1988.3062,  y = 3184.7302,  z = 38.0014, h = 185.6300},
    {x = -1984.3462,  y = 3216.7783,  z = 38.0014, h = 126.4631},
}

Config.Pedname2 = "s_m_y_blackops_03"
Config.Pedname2coords = { 
    {x = -1998.6176,  y = 3235.7686,  z = 38.0014, h = 168.8320},
    {x = -2029.3575,  y = 3195.8103,  z = 38.0017, h = 241.0792},
    {x = -2001.1733,  y = 3174.6606,  z = 38.0013, h = 326.7062},
    {x = -2010.1771,  y = 3214.7678,  z = 38.0547, h = 318.5367},
}

Config.Pedname3 = "a_m_m_eastsa_01"
Config.Pedname3coords = { 
    {x = -2012.5645,  y = 3217.1465,  z = 32.8103, h = 217.6776},
    {x = -1962.2429,  y = 3213.7698,  z = 32.8103, h = 340.4951},
    {x = -1985.8763,  y = 3205.7654,  z = 32.8103, h = 117.0211},
    {x = -1998.2723,  y = 3210.8071,  z = 32.8103, h = 332.5581},
}

Config.Pedname4 = "csb_grove_str_dlr"
Config.Pedname4coords = {
    {x = -2031.6343,  y = 3200.8286,  z = 32.8105, h = 184.2043},
    {x = -2009.9430,  y = 3194.1582,  z = 33.3436, h = 79.2662},
    {x = -2031.8915,  y = 3188.9685,  z = 32.8106, h = 249.5531},
    {x = -2036.1180,  y = 3191.5747,  z = 32.8105, h = 146.8275},
}

Config.Pedname5 = "a_m_y_juggalo_01"
Config.Pedname5coords = { 
    {x = -2010.2466,  y = 3231.4116,  z = 38.0014, h = 136.4215},
    {x = -2007.8856,  y = 3229.8926,  z = 38.0014, h = 132.6785},
    {x = -1999.0039,  y = 3230.6577,  z = 38.0014, h = 58.2632},
    {x = -2024.4708,  y = 3206.9324,  z = 38.0013, h = 324.2229},
}



Config.UseHostagePeds = true

Config.Pednamehostage1 = "cs_andreas"
Config.Pednamehostage1coords = {
    {x = -2010.8058,  y = 3207.6309,  z = 32.8102, h = 150.6501},
    {x = -2025.8547,  y = 3198.5039,  z = 32.8105, h = 237.8466},
    {x = -1998.4739,  y = 3214.4351,  z = 32.8103, h = 18.4048},
    {x = -2004.3707,  y = 3235.8281,  z = 32.8102, h = 128.1694},
}

Config.Pednamehostage2 = "mp_f_boatstaff_01"
Config.Pednamehostage2coords = { 
    {x = -1974.7866,  y = 3188.6563,  z = 38.0014, h = 137.4261},
    {x = -1970.4963,  y = 3207.1379,  z = 38.0401, h = 166.6918},
    {x = -1985.3978,  y = 3173.3806,  z = 38.0014, h = 170.7296},
    {x = -1979.7488,  y = 3165.6909,  z = 38.0014, h =81.4993},
}

Config.Pednamehostage3 = "ig_chrisformage"
Config.Pednamehostage3coords = { 
    {x = -2010.9626,  y = 3186.5999,  z = 38.0014, h = 60.5957},
    {x = -2023.1929,  y = 3209.3369,  z = 38.0014, h = 326.0790},
    {x = -1996.3296,  y = 3183.9968,  z = 38.0014, h = 34.8396},
    {x = -1996.7281,  y = 3194.5981,  z = 38.0014, h = 57.2371},
}


Translation = {
    ['de'] = {
        ["started_mission"] = 'Das Training hat begonnen',
        ["already_started"] = 'Du bist bereits im Training',
        ["not_right_job"]   = 'Du hast nicht den richtigen Job dafür',
        ["mission_failed"]  = 'Training fehlgeschlagen. Die Übung ist Vorbei',
        ["mission_success"] = 'Du hast alle ausgeschaltet. Glückwunsch',
        ["someone_already_started"] = 'Es hat bereits jemand das Training gestartet',
        ["press_e_to_start"] = 'Drücke ~p~[E] ~w~um das Training zu starten'
    },
    ['en'] = {
        ["started_mission"] = 'The Training begins. Eleminate all 5 Enemies',
        ["already_started"] = 'The Training already started',
        ["not_right_job"]   = 'You dont have the right Job',
        ["mission_failed"]  = 'Training failed. Its over',
        ["mission_success"] = 'You eleminated all Enemies. Training passed',
        ["someone_already_started"] = 'Someone already started the Training',
        ["press_e_to_start"] = 'Press ~p~[E] ~w~to start the Training'
    },
}

