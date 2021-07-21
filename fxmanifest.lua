games { 'gta5' }
fx_version 'cerulean'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua'
}

client_scripts {
	'client/main.lua',
	'client/modules/death.lua',
	'client/functions.lua'
}

ui_page {
	'html/index.html'
}

files {
	'html/index.html',
	'html/style.css',
	'html/icon/hs.png',
	'html/icon/kd.png',
	'html/icon/kill.png',
	'html/icon/death.png'
}