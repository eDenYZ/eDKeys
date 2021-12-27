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

