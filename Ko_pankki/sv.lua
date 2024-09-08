local discordWebhook = "WEBHOOK HERE"

local function sendToDiscord(title, description, color)
    local embed = {
        {
            ["title"] = title,
            ["description"] = description,
            ["color"] = color,
            ["footer"] = {
                ["text"] = os.date("%Y-%m-%d %H:%M:%S")
            }
        }
    }

    PerformHttpRequest(discordWebhook, function(err, text, headers) end, 'POST', json.encode({username = "Ko pankki", embeds = embed}), { ['Content-Type'] = 'application/json' })
end
ESX.RegisterServerCallback('tiedot', function(source, cb)
    local pelaaja = ESX.GetPlayerFromId(source)
    if pelaaja then
        local playerData = {
            accounts = {
                bank = pelaaja.getAccount('bank').money
            },
            money = pelaaja.getMoney()
        }
        cb(playerData)
    else
        cb(nil)
    end
end)

RegisterNetEvent('ko:nosta', function(amount)
    local pelaaja = ESX.GetPlayerFromId(source)
    if pelaaja then
        local bankBalance = pelaaja.getAccount('bank').money
        if bankBalance >= amount then
            pelaaja.removeAccountMoney('bank', amount)
            pelaaja.addMoney(amount)
            TriggerClientEvent('ox_lib:notify', source, {
                type = 'success', 
                title = 'Nostit $' .. amount .. ' tililtäsi.',
                icon = "fa-solid fa-money-check",
                iconColor = 'green'
            })
            sendToDiscord("Nosto", "Pelaaja **" .. GetPlayerName(source) .. "** nosti" .. amount .. '€' .. " tililtä.", 3066993)
        else
            TriggerClientEvent('ox_lib:notify', source, {
            type = 'error', 
            title = 'Sinulla ei ole tarpeeksi rahaa tilillä.',      
            icon = "fa-solid fa-money-check",
            iconColor = 'orange'
        })
        end
    end
end)

RegisterNetEvent('ko:talleta', function(amount)
    local pelaaja = ESX.GetPlayerFromId(source)
    if pelaaja then
        local cashBalance = pelaaja.getMoney()
        if cashBalance >= amount then
            pelaaja.removeMoney(amount)
            pelaaja.addAccountMoney('bank', amount)
            TriggerClientEvent('ox_lib:notify', source, {
                type = 'success', 
                title = 'Talletit $' .. amount .. ' pankkitilillesi.',
                icon = "fa-solid fa-money-bill-wave",   
                iconColor = 'green'
            })

            sendToDiscord("Talletus", "Pelaaja **" .. GetPlayerName(source) .. "** talletti" .. amount .. '€' .. " pankkitililleen.", 3066993)  
        else
            TriggerClientEvent('ox_lib:notify', source, {
                type = 'error', 
                title = 'Sinulla ei ole tarpeeksi käteistä.',
                icon = "fa-solid fa-money-bill-wave",
                iconColor = 'green'
            })
        end
    end
end)

RegisterNetEvent('ko:siirra', function(amount, targetId)
    local pelaaja = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(targetId)
    if pelaaja and targetPlayer then
        local bankBalance = pelaaja.getAccount('bank').money
        if bankBalance >= amount then
            pelaaja.removeAccountMoney('bank', amount)
            targetPlayer.addAccountMoney('bank', amount)
            
            TriggerClientEvent('ox_lib:notify', source, {
                type = 'success', 
                title = 'Siirsit $' .. amount .. ' pelaajalle ID: ' .. targetId,
                icon = "fa-solid fa-money-bill-transfer",
                iconColor = 'orange',
            })
            TriggerClientEvent('ox_lib:notify', targetId, {
                type = 'success', 
                title = 'Sait $' .. amount .. ' pelaajalta ID: ' .. source,
                icon = "fa-solid fa-money-bill-transfer",
                iconColor = 'green',
            })

           
            sendToDiscord("Siirto", "Pelaaja **" .. GetPlayerName(source) .. "** siirsi " .. amount .. '€ ' .. "Pelaajalle " .. GetPlayerName(source) .. ".", 15105570)
        else
           
            TriggerClientEvent('ox_lib:notify', source, {
               -- type = 'error',
                title = 'Sinulla ei ole tarpeeksi rahaa tilillä.',
                icon = "fa-solid fa-money-check",
                iconColor = 'orange'    
            })
        end
    else
        
        TriggerClientEvent('ox_lib:notify', source, {
            type = 'error', 
            title = 'Pelaajaa ei löytynyt.',
            icon = "fa-solid fa-person",
            iconColor = 'orange'
        })
    end
end)
