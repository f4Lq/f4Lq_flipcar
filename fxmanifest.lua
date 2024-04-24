fx_version 'adamant'
lua54 'yes'
game 'gta5'

name 'f4lq_flipcar'
author 'f4Lq'
version '1.1.0'
description 'Use the E key to flip the vehicle. Used progressBar ox_lib.'


client_script {
    'flipcar.lua',
    'config.lua',
}

shared_script {
    '@ox_lib/init.lua',
}
