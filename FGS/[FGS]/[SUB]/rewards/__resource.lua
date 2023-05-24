resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

files {
	"html/index.html",
	"html/jquery.countdown.min.js",
	"html/config.js",
	"html/script.js",
	"html/style.css"
}

ui_page 'html/index.html'

server_scripts {
	"@vrp/lib/utils.lua",
	"config.lua",
	"server.lua"
}
client_scripts {
	"client.lua"
}
