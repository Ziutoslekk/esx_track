Citizen.CreateThread(function()
	local isDead = false

	while true do
		local player = PlayerId()

		if NetworkIsPlayerActive(player) then
			local playerPed = PlayerPedId()

			if IsPedFatallyInjured(playerPed) and not isDead then
				isDead = true

				local killerEntity, deathCause = GetPedSourceOfDeath(playerPed), GetPedCauseOfDeath(playerPed)
				local killerClientId = NetworkGetPlayerIndexFromPed(killerEntity)

				if killerEntity ~= playerPed and killerClientId and NetworkIsPlayerActive(killerClientId) then
					PlayerKilledByPlayer(GetPlayerServerId(killerClientId), killerClientId, deathCause)
				else
					PlayerKilled(deathCause)
				end

			elseif not IsPedFatallyInjured(playerPed) then
				isDead = false
			end
		end
		
		Citizen.Wait(0)
	end
end)
