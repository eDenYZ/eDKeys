KeysSql = {}

KeysOpen = function()
	ESX.TriggerServerCallback('</eDen:AfficheKeys', function(AffiKeys)
		KeysSql = AffiKeys
  end)
end

VehNoKeys = {}

NewKeys = function()
    ESX.TriggerServerCallback(eDKeys.Keys.TriggerVehiculeLock..':getVehiclesnokey', function(Vehicles2)
		VehNoKeys = Vehicles2
   end)
end

PlayerMarker = function()
    local closestPlayer = GetPlayerPed(ESX.Game.GetClosestPlayer())
    local pos = GetEntityCoords(closestPlayer);
    local target, distance = ESX.Game.GetClosestPlayer();
    if distance <= 2.0 then
		DrawMarker(20, pos.x, pos.y, pos.z+1.2, 1.0, 0.0, 1.0, 5.0, 0.0, 0.0, 0.35, 0.35, 0.35, 0, 96, 125, 139, 5, 1, 2, 0, nil, nil, 0);
    end
end