



fx_version 'cerulean'
games {  'gta5' }



description "RP module/framework"

ui_page "FGS-Core/gui/index.html"

shared_scripts {
  "FGS-Core/sharedcfg/*",
  "FGS-Core/cfg/*",
}

shared_script "FGS-Core/gundev/ammotypes.lua"

-- RageUI
client_scripts {
	"FGS-Core/rageui/RMenu.lua",
	"FGS-Core/rageui/menu/RageUI.lua",
	"FGS-Core/rageui/menu/Menu.lua",
	"FGS-Core/rageui/menu/MenuController.lua",
	"FGS-Core/rageui/components/*.lua",
	"FGS-Core/rageui/menu/elements/*.lua",
	"FGS-Core/rageui/menu/items/*.lua",
	"FGS-Core/rageui/menu/panels/*.lua",
	"FGS-Core/rageui/menu/panels/*.lua",
	"FGS-Core/rageui/menu/windows/*.lua"
}

-- server scripts
server_scripts{ 
  "FGS-Core/modules/serverplaysounds.net.dll",
  "lib/utils.lua",
  "base.lua",
  "modules/gui.lua",
  "modules/sv_groups.lua",
  "modules/sv_basicadmin.lua",
  "modules/survival.lua",
  "modules/sv_playerstate.lua",
  "modules/sv_blipmap.lua",
  "modules/sv_money.lua",
  "modules/sv_inventory.lua",
  "modules/sv_identity.lua",
  "modules/police.lua",
  "modules/sv_basicphone.lua",
  "modules/sv_garages.lua",
  "modules/sv_basicitems.lua",
  "modules/sv_paycheck.lua",
  "FGS-Core/modules/**/sv_*.lua",
}

-- client scripts
client_scripts{
  "FGS-Core/client/clientplaysounds.net.dll",
  "cfg/atms.lua",
  "cfg/skinshops.lua",
  "cfg/garages.lua",
  "cfg/admin_menu.lua",
  "lib/utils.lua",
  "client/Tunnel.lua",
  "client/Proxy.lua",
  "client/base.lua",
  "client/cl_iplloader.lua",
  "client/gui.lua",
  "FGS-Core/gundev/player_state.lua",
  "client/survival.lua",
  "client/cl_blipsmap.lua",
  "client/cl_identity.lua",
  "client/cl_garages.lua",
  "client/police.lua",
  "client/cl_admin.lua",
  "client/cl_enumerators.lua",
  "client/cl_inventory.lua",
  "FGS-Core/lib/*",
  "FGS-Core/client/**/cl_*.lua",
}

-- client files
files{
  'FGS-Core/gui/sounds/*',
  "cfg/client.lua",
  "FGS-Core/gui/index.html",
  "FGS-Core/gui/design.css",
  "FGS-Core/gui/main.js",
  "FGS-Core/gui/Menu.js",
  "FGS-Core/gui/ProgressBar.js",
  "FGS-Core/gui/WPrompt.js",
  "FGS-Core/gui/RequestManager.js",
  "FGS-Core/gui/AnnounceManager.js",
  "FGS-Core/gui/Div.js",
  "FGS-Core/ui/dynamic_classes.js",
  "FGS-Core/gui/fonts/Pdown.woff",
  "FGS-Core/gui/fonts/GTA.woff",
  'FGS-Core/gui/manager.js',
  'FGS-Core/gui/sounds.js',
}