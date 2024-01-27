fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'B&T Scripts'
description 'Diving Job'
version '1.0.0'

escrow_ignore {
    'config.lua', 
}

client_scripts { 
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/*.lua',
    'locales/*.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/*.lua',
    'locales/*.lua'
}

shared_scripts {
    '@ox_lib/init.lua',   -- Uncomment if Using OX_Lib
    'config.lua'
}