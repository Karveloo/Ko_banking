local ESX = exports['es_extended']:getSharedObject()

local function avaaPankki()
    ESX.TriggerServerCallback('tiedot', function(playerData)
        local pankkissa = playerData.accounts.bank
        local kateinen = playerData.money

        lib.registerContext({
            id = 'pankki',
            title = 'Pankki',
            options = {
                {
                    title = 'Tililläsi: ' .. pankkissa .. '€',
                    icon = "fa-solid fa-money-check",
                    iconColor = '#a782e8'    
                },
                {
                    title = 'Käteistä: ' .. kateinen .. '€',
                    icon = "fa-solid fa-money-bill-wave",   
                    iconColor = 'green'
                },
                {
                    title = ''
            },
                {
                    title = 'Nosta rahaa',
                    description = 'Nosta rahaa tililtä',
                    icon = "fa-solid fa-money-bill-transfer",
                    iconColor = 'red',
                    event = 'ko:nosta'
                },
                {
                    title = 'Talleta rahaa',
                    description = 'Talleta rahaa tilille',
                    icon = "fa-solid fa-money-bill-transfer",
                    iconColor = 'green',
                    event = 'ko:talleta'
                },
                {
                    title = 'Siirrä rahaa',
                    description = 'Siirrä rahaa toiselle pelaajalle',
                    icon = "fa-solid fa-money-bill-transfer",
                    iconColor = '#e64545',
                    event = 'ko:siirra'
                },
            }
        })      

        lib.showContext('pankki')
    end)
end
if Config.debug then
RegisterCommand(Config.command, function()
    avaaPankki()
end, false)
end
RegisterNetEvent('ko:nosta', function()
    local input = lib.inputDialog('Nosta rahaa', {'Summa'})
    if input and tonumber(input[1]) then
        if lib.progressCircle({
            duration = 2000,
            label = 'Odotetaan rahoja...',
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
                move = true,
            },
        }) then
        TriggerServerEvent('ko:nosta', tonumber(input[1]))
    end
end
end)

RegisterNetEvent('ko:talleta', function()
    local input = lib.inputDialog('Talleta rahaa', {'Summa'})
    if input and tonumber(input[1]) then
        if lib.progressCircle({
            duration = 1000,
            label = 'Talletetaan rahoja...',
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
                move = true,
            },
            anim = {
                dict = 'mp_common',
                clip = 'givetake2_a'
            },

        }) then
        TriggerServerEvent('ko:talleta', tonumber(input[1]))
    end
end
end)

RegisterNetEvent('ko:siirra', function()
    local input = lib.inputDialog('Siirrä rahaa', {'Summa', 'Tavoitepelaajan ID'})
    if input and tonumber(input[1]) and tonumber(input[2]) then
        TriggerServerEvent('ko:siirra', tonumber(input[1]), tonumber(input[2]))
    end
end)
local ESX = exports['es_extended']:getSharedObject()
local function avaaPankki()
    ESX.TriggerServerCallback('tiedot', function(playerData)
        local pankkissa = playerData.accounts.bank
        local kateinen = playerData.money
        

        lib.registerContext({
            id = 'pankki',
            title = 'Pankki',
            options = {
                {
                    title = 'Tililläsi: ' .. pankkissa .. '€',
                    icon = "fa-solid fa-money-check",
                    iconColor = '#a782e8'    
                },
                {
                    title = 'Käteistä: ' .. kateinen .. '€',
                    icon = "fa-solid fa-money-bill-wave",   
                    iconColor = 'green'
                },
                {
                    title = ''
            },
                {
                    title = 'Nosta rahaa',
                    description = 'Nosta rahaa tililtä',
                    icon = "fa-solid fa-money-bill-transfer",
                    iconColor = 'red',
                    event = 'ko:nosta'
                },
                {
                    title = 'Talleta rahaa',
                    description = 'Talleta rahaa tilille',
                    icon = "fa-solid fa-money-bill-transfer",
                    iconColor = 'green',
                    event = 'ko:talleta'
                },
                {
                    title = 'Siirrä rahaa',
                    description = 'Siirrä rahaa toiselle pelaajalle',
                    icon = "fa-solid fa-money-bill-transfer",
                    iconColor = '#e64545',
                    event = 'ko:siirra'
                },
            }
        })      

        lib.showContext('pankki')
    end)
end
if Config.debug then
RegisterCommand(Config.command, function()
    avaaPankki()
end, false)
end
RegisterNetEvent('ko:nosta', function()
    local input = lib.inputDialog('Nosta rahaa', {'Summa'})
    if input and tonumber(input[1]) then
        if lib.progressCircle({
            duration = 2000,
            label = 'Odotetaan rahoja...',
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
                move = true,
            },
        }) then
        TriggerServerEvent('ko:nosta', tonumber(input[1]))
    end
end
end)

RegisterNetEvent('ko:talleta', function()
    local input = lib.inputDialog('Talleta rahaa', {'Summa'})
    if input and tonumber(input[1]) then
        if lib.progressCircle({
            duration = 1000,
            label = 'Talletetaan rahoja...',
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
                move = true,
            },
            anim = {
                dict = 'mp_common',
                clip = 'givetake2_a'
            },

        }) then
        TriggerServerEvent('ko:talleta', tonumber(input[1]))
    end
end
end)

RegisterNetEvent('ko:siirra', function()
    local input = lib.inputDialog('Siirrä rahaa', {'Summa', 'Tavoitepelaajan ID'})
    if input and tonumber(input[1]) and tonumber(input[2]) then
        TriggerServerEvent('ko:siirra', tonumber(input[1]), tonumber(input[2]))
    end
end)
CreateThread(function ()
    local odotus = 1000
    while true do
        Wait(odotus)
        local pelaaja = PlayerPedId()
        local pelaajacoordit = GetEntityCoords(pelaaja)
        for i=1, #Config.sijainti do
            local sijainti = Config.sijainti[i]
            local etaisyys = #(pelaajacoordit - sijainti)        
            if etaisyys < 1.5 then
                odotus = 2
                ESX.ShowHelpNotification('Paina ~INPUT_CONTEXT~ avaa pankki')
                if IsControlJustReleased(0, 38) then
                    avaaPankki()
                end
            end
        end
    end
end)
