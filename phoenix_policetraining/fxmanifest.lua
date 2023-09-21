fx_version 'adamant'

game 'gta5'

version '1.0' 

shared_scripts{
    '@es_extended/imports.lua', -- Uncomment this if you using QB Core
    'config.lua'
} 

server_scripts {
	'server.lua',
    'config.lua'
}

client_scripts {
	'client.lua',
    'config.lua'
}
