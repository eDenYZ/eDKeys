OpenMenuKeys = function()
    local main = RageUI.CreateMenu(("Menu %s"):format(eDKeys.Keys.NameMenu), eDKeys.Keys.NameMenu);
    local keys = RageUI.CreateSubMenu(main,"Mes Keys", "Keys")
    local keyselected = RageUI.CreateSubMenu(keys, "Mes Keys", "Keys")
    local ergkeys = RageUI.CreateSubMenu(main, "Eregister Keys", "Keys")
    RageUI.Visible(main, not RageUI.Visible(main))
    while main do
        Citizen.Wait(0)
        RageUI.IsVisible(main, function()

        RageUI.Button("Mes Keys", nil, {RightLabel = "→"}, true,{
            onSelected = function()
                KeysOpen()
            end
        },keys) 

        RageUI.Button("Enregister Keys", nil, {RightLabel = "→"}, true,{
            onSelected = function()
                NewKeys()
            end
        },ergkeys)

    end)
    RageUI.IsVisible(keys,function()
        if #KeysSql >= 1 then
			for Keys = 1, #KeysSql, 1 do
                RageUI.Button(KeysSql[Keys].value, nil, {RightLabel = "→"}, true,{
                    onSelected = function()
                        KeySelected = KeysSql[Keys].value
                        IdSelected = KeysSql[Keys].id
                        KeysOpen()
                    end
                },keyselected)
			end
		else
			RageUI.Separator("")
			RageUI.Separator("Aucune Keys")
			RageUI.Separator("")
		end
    end)
    RageUI.IsVisible(keyselected,function()
        RageUI.Separator("↓ ~b~Ma Keys~s~ ↓")
        
        RageUI.Button("Numéro : ", nil, {RightLabel = IdSelected}, true,{})
        RageUI.Button("Plauqe : ", nil, {RightLabel = KeySelected}, true,{})

        RageUI.Separator("↓ ~b~Action Keys~s~ ↓")

        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        RageUI.Button("Préter", nil, {RightLabel = "→"}, closestPlayer ~= -1 and closestDistance <= 3.0,{
            onActive = function()
                PlayerMarker();
            end,
            onSelected = function()
                RageUI.Visible(main, true)
                TriggerServerEvent(eDKeys.Keys.TriggerVehiculeLock..':preterkey', GetPlayerServerId(closestPlayer), KeySelected)
            end
        })

        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        RageUI.Button("Donner", nil, {RightLabel = "→"}, closestPlayer ~= -1 and closestDistance <= 3.0,{
            onActive = function()
                PlayerMarker();
            end,
            onSelected = function()
                RageUI.Visible(main, true)
                TriggerServerEvent(eDKeys.Keys.TriggerVehiculeLock..':donnerkey', GetPlayerServerId(closestPlayer), KeySelected)
                TriggerServerEvent(eDKeys.Keys.TriggerVehiculeLock..':deletekey', KeySelected)
            end
        })

        RageUI.Button("Supprimer", nil, {RightLabel = "→"}, true,{
            onSelected = function()
                RageUI.Visible(main, true)
                TriggerServerEvent(eDKeys.Keys.TriggerVehiculeLock..':deletekey', KeySelected)
            end
        })
    end)
    RageUI.IsVisible(ergkeys,function()
        if #VehNoKeys >= 1 then

        for Vehicles2 = 1, #VehNoKeys, 1 do
            RageUI.Button(VehNoKeys[Vehicles2].plate,nil, {RightLabel = ""}, true, {
                onSelected = function()
                    RageUI.GoBack()
                    TriggerServerEvent(eDKeys.Keys.TriggerVehiculeLock..':registerkey', VehNoKeys[Vehicles2].plate, 'no')
                end
            })
        end
        else
            RageUI.Separator("")
			RageUI.Separator("Aucune Keys")
			RageUI.Separator("")
        end
    end)
        if not RageUI.Visible(main) and not RageUI.Visible(keys) and not RageUI.Visible(keyselected) and not RageUI.Visible(ergkeys) then main = RMenu:DeleteType('main', true) keys = RMenu:DeleteType("keys", true) keyselected = RMenu:DeleteType("keyselected", true) ergkeys = RMenu:DeleteType("ergkeys", true) end
    end
end

