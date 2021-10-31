Values = {
    ["kills"] = 0,
    ["deaths"] = 0,
    ["headshots"] = 0,
    ["kd"] = 0
}

Citizen.CreateThread(function ()
    local isPauseMenu = false
    
    while true do
        if IsPauseMenuActive() then
            if not isPauseMenu then
                SendNUIMessage({ action = 'visible', isVisible = false })

                isPauseMenu = true
            end
        else
            if isPauseMenu then
                SendNUIMessage({ action = 'visible', isVisible = true })

                isPauseMenu = false
            end
        end

        Citizen.Wait(0)
    end
end)

RegisterNetEvent("esx_track:setData")
AddEventHandler("esx_track:setData", function(kills, deaths, headshots)
    if kills then
        Values["kills"] = kills
    end

    if deaths then
        Values["deaths"] = deaths
    end

    if headshots then
        Values["headshots"] = headshots
    end

    if Values["kills"] ~= 0 and Values["deaths"] ~= 0 then
        Values["kd"] = Round(Values["kills"] / Values["deaths"], 2)
    else
        Values["kd"] = 0
    end

    SendNUIMessage({
        action = "update",

        kills = Values["kills"],
        deaths = Values["deaths"],
        headshots = Values["headshots"],
        kd = Values["kd"]
    })
end)