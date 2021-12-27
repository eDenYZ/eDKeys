ESX = nil
local KeyShop = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(eDKeys.GetESX, function(obj) ESX = obj end)
        Citizen.Wait(10)
        InitMarkerKeyShop()
    end
end)

InitMarkerKeyShop = function()
    KeyShopZone = true
    Citizen.CreateThread(function()
        for _, v in pairs(eDKeys.Keys.Blips) do
        local blip = AddBlipForCoord(v.Position)
        SetBlipSprite(blip, v.Sprite)
        SetBlipScale(blip, v.Scale)
        SetBlipColour(blip, v.Colour)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.Name)
        EndTextCommandSetBlipName(blip)
    end
        while KeyShopZone do
            local InZone = false
            local playerPos = GetEntityCoords(PlayerPedId())
            for _, v in pairs(eDKeys.Keys.PositionKeys) do
                local dst1 = GetDistanceBetweenCoords(playerPos, v.pos, true)
                    if dst1 < 4.0 then
                    InZone = true
                    DrawMarker(20, v.pos, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 0, 180, 0, 255, true, true, p19, true) 
                    if dst1 < 2.0 then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_PICKUP~ pour intéragir Menu Shop ~b~Keys")
                        if IsControlJustReleased(1, 38) then
                            OpenMenuKeys()
                        end
                    end
                end
            end
            if not InZone then
                Wait(500)
            else
            Wait(1)
        end
    end
    end)
    print("Le Register Keys a Bien chargé !")
    print("By eDen and Aurezia")
end


