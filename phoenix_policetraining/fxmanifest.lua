fx_version 'adamant'

game 'gta5'

version '1.0' 

lua54 'yes'

shared_scripts{
    '@es_extended/imports.lua', -- Uncomment this if you using QB Core
	'@ox_lib/init.lua',
    'config.lua',
} 

server_scripts {
	'server.lua',
    'config.lua'
}

client_scripts {
	'client.lua',
    'config.lua'
}
