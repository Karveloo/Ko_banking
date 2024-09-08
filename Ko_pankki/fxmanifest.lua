fx_version 'adamant'
game 'gta5'
lua54 'yes'

description 'Ko banking'
author 'Karveloo'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'sv.lua'
}

client_scripts {
    'cl.lua'
}

shared_script {
    '@es_extended/imports.lua',
    'config.lua',
    '@ox_lib/init.lua',
    '@es_extended/locale.lua',

}