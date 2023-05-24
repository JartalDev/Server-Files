fx_version 'adamant'

game 'gta5'
author 'Icmp'

client_scripts {
    
    "lib/Proxy.lua",
    "lib/Tunnel.lua",
    'client/main.lua',
    'config.lua',
}

server_scripts {

    "@vrp/lib/utils.lua",
    'server/main.lua',
    'config.lua',
}