















fx_version 'cerulean'
games { 'gta5' }



files {
	'UI/main.html',
    'UI/main.css'
}
server_scripts{
  "@vrp/lib/utils.lua",
  "server.lua"
}
client_script 'client.lua'


ui_page('UI/main.html')