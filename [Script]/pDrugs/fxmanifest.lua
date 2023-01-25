fx_version 'cerulean'
games { 'gta5' };

client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",
    '@es_extended/locale.lua',
    "client/meth.lua",
    "client/tenue.lua",
    "client/weed.lua",
    "client/teleportation.lua",
    "client/coke.lua",
    "client/opium.lua",
    "client/vente.lua",
    "client/blanchiment.lua",
    "config.lua",
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'server/server.lua',
    'server/sv_vente.lua'
}

dependencies {
	'es_extended'
}