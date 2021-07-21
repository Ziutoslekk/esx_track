ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Kills = {}
Deaths = {}
Headshots = {}

RegisterServerEvent("esx:weaponDamageEvent")
AddEventHandler("esx:weaponDamageEvent", function(deathData)
    local _source = source

    if deathData.killedByPlayer then
        --[[ Track source deaths ]]--
        local xPlayer = ESX.GetPlayerFromId(_source)
        if xPlayer then
            if not Deaths[xPlayer.identifier] then
                Deaths[xPlayer.identifier] = 0
            end

            Deaths[xPlayer.identifier] = Deaths[xPlayer.identifier]+1

            TriggerClientEvent("esx_track:setData", xPlayer.source, false, Deaths[xPlayer.identifier])
        end

        --[[ Track killer kills ]]--
        local killerXPlayer = ESX.GetPlayerFromId(deathData.killerServerId)
        if killerXPlayer then
            if not Kills[killerXPlayer.identifier] then
                Kills[killerXPlayer.identifier] = 0
            end

            Kills[killerXPlayer.identifier] = Kills[killerXPlayer.identifier]+1

            if deathData.bone == 31086 then
                if not Headshots[killerXPlayer.identifier] then
                    Headshots[killerXPlayer.identifier] = 0
                end

                Headshots[killerXPlayer.identifier] = Headshots[killerXPlayer.identifier]+1
            end

            TriggerClientEvent("esx_track:setData", killerXPlayer.source, Kills[killerXPlayer.identifier], false, Headshots[killerXPlayer.identifier])
        end
    end
end)

AddEventHandler('esx:playerDropped', function(source, reason, identifier)
    MySQL.Async.execute("INSERT INTO `user_kills` (`identifier`) VALUES (@identifier) ON DUPLICATE KEY UPDATE `kills` = @kills, `deaths` = @deaths, `headshots` = @headshots", {
        ["@identifier"] = identifier,
        ["@kills"] = Kills[identifier],
        ["@deaths"] = Deaths[identifier],
        ["@headshots"] = Headshots[identifier]
    }, function(playerUpdated)
        if playerUpdated then
            Kills[identifier] = nil
            Deaths[identifier] = nil
            Headshots[identifier] = nil
        end
    end)
end)

AddEventHandler('esx:playerLoaded', function(source, xPlayer)
    MySQL.Async.fetchAll("SELECT `kills`,`deaths`,`headshots` FROM `user_kills` WHERE `identifier` = @identifier", { ["@identifier"] = xPlayer.identifier }, function(result)
        if result and result[1] then
            TriggerClientEvent("esx_track:setData", xPlayer.source, result[1].kills, result[1].deaths, result[1].headshots)

            Kills[xPlayer.identifier] = result[1].kills
            Deaths[xPlayer.identifier] = result[1].deaths
            Headshots[xPlayer.identifier] = result[1].headshots
        end
    end)
end)

--[[ Commands ]]--
RegisterCommand('resetstats', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        Kills[xPlayer.identifier] = 0
        Deaths[xPlayer.identifier] = 0
        Headshots[xPlayer.identifier] = 0

        TriggerClientEvent("esx_track:setData", xPlayer.source, Kills[xPlayer.identifier], Deaths[xPlayer.identifier], Headshots[xPlayer.identifier])
    end
end, false)