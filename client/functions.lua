Round = function(value, numDecimalPlaces)
    if numDecimalPlaces then
        local power = 10^numDecimalPlaces
        return math.floor((value * power) + 0.5) / (power)
    else
        return math.floor(value + 0.5)
    end
end

PlayerKilledByPlayer = function(killerServerId, killerClientId, deathCause)
    local victimCoords = GetEntityCoords(PlayerPedId())
    local killerCoords = GetEntityCoords(GetPlayerPed(killerClientId))
    local distance = #(victimCoords - killerCoords)

    local bone = table.pack(GetPedLastDamageBone(PlayerPedId()))[2]
    ClearPedLastDamageBone(PlayerPedId())

    local data = {
        victimCoords = {x = Round(victimCoords.x, 1), y = Round(victimCoords.y, 1), z = Round(victimCoords.z, 1)},
        killerCoords = {x = Round(killerCoords.x, 1), y = Round(killerCoords.y, 1), z = Round(killerCoords.z, 1)},

        killedByPlayer = true,
        deathCause = deathCause,
        bone = bone,
        distance = Round(distance, 1),

        killerServerId = killerServerId,
        killerClientId = killerClientId
    }

    TriggerServerEvent('esx:weaponDamageEvent', data)
end

PlayerKilled = function(deathCause)
	local playerPed = PlayerPedId()
	local victimCoords = GetEntityCoords(playerPed)

	local data = {
		victimCoords = {x = Round(victimCoords.x, 1), y = Round(victimCoords.y, 1), z = Round(victimCoords.z, 1)},

		killedByPlayer = false,
		deathCause = deathCause
	}

	TriggerServerEvent('esx:weaponDamageEvent', data)
end