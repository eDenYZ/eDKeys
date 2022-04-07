ESX = nil

TriggerEvent(eDKeys.GetESX, function(obj) ESX = obj end)

ESX.RegisterServerCallback('</eDen:AfficheKeys', function(source, cb, plate)
    local xPlayer  = ESX.GetPlayerFromId(source)
    local AffiKeys = {}

    if xPlayer ~= nil then
        MySQL.Async.fetchAll('SELECT * FROM open_car WHERE identifier = @identifier ', {
            ['@identifier'] = xPlayer.identifier
        }, function(result)
            for k, v in pairs(result) do
                table.insert(AffiKeys, {
                    id = v.id, 
                    label = v.label,
                    value = v.value,
                    got = v.got,
                    nb = v.nb,
                })
            end
            cb(AffiKeys)
        end)
    end
end)

RegisterServerEvent("</eDen:donnerkey")
AddEventHandler("</eDen:donnerkey", function(target, plate)
	if (not (target ~= nil)) then
		return
	end
	if (not (plate ~= nil)) then
		return
	end
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local xTarget = ESX.GetPlayerFromId(target)
	local toplate = plate
	if (xPlayer) then
		MySQL.Async.fetchAll("SELECT * FROM open_car WHERE identifier = @identifier", {
			["@identifier"] = xPlayer.identifier
		}, function(result)
			if (result) then
				for k, v in pairs(result) do
					if (v.value == toplate) then
						MySQL.Async.execute("UPDATE open_car SET identifier = @identifier WHERE value = @value", {
							["@identifier"] = xTarget.identifier,
							["@value"] = toplate
						})
					end
				end
			end
		end)
		MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @owner", {
			["@owner"] = xPlayer.identifier
		}, function(result)
			if (result) then
				for k, v in pairs(result) do
					if (v.plate == toplate) then
						MySQL.Async.execute("UPDATE owned_vehicles SET owner = @owner WHERE plate = @plate", {
							["@owner"] = xTarget.identifier,
							["@plate"] = toplate
						})
						print("Insert Into Terminé")
					end
				end
			end
		end)
		TriggerClientEvent("esx:showNotification", xTarget.source, "Vous avez reçu de nouvelle clé ")
		TriggerClientEvent("esx:showNotification", xPlayer.source, "Vous avez donné votre clé, vous ne les avez plus !")
	end
end)
