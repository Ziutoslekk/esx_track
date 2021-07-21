Values = {
    ["kills"] = 0,
    ["deaths"] = 0,
    ["headshots"] = 0,
    ["kd"] = 0
}

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