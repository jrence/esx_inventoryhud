----[[POLICE]]----
RegisterNetEvent("c5ms_inventory:openPoliceInventory")
AddEventHandler("c5ms_inventory:openPoliceInventory", function(data)
        setPoliceInventoryData(data)
        openPoliceInventory()
        SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
    end
)

function refreshPoliceInventory()
    ESX.TriggerServerCallback("c5ms_police:getPoliceInventory", function(inventory)
            setPoliceInventoryData(inventory)
        end,
        ESX.GetPlayerData().identifier
    )
end

function setPoliceInventoryData(data)
    items = {}

    local PoliceItems = data.items
    local PoliceWeapons = data.weapons

    for i = 1, #PoliceItems, 1 do
        local item = PoliceItems[i]

        if item.count > 0 then
            item.type = "item_standard"
            item.usable = false
            item.rare = false
            item.weight = -1
            item.canRemove = false

            table.insert(items, item)
        end
    end

    SendNUIMessage(
        {
            action = "setSecondInventoryItems",
            itemList = items
        }
    )
end

function openPoliceInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "Police"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback("PutIntoPolice", function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)

            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end

            TriggerServerEvent("c5ms_police:putItemPolice", ESX.GetPlayerData().identifier, data.item.type, data.item.name, count)
        end

        Wait(150)
        refreshPoliceInventory()
        Wait(150)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback("TakeFromPolice", function(data, cb)
    if ESX.PlayerData.job and ESX.PlayerData.job.name ~= 'police' then
        exports['mythic_notify']:SendAlert('inform', 'You are not an Officer')
    else
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            TriggerServerEvent("c5ms_police:getItemPolice", ESX.GetPlayerData().identifier, data.item.type, data.item.name, tonumber(data.number))
            openPoliceInventory() --Apparently switches INSTANTLY to your own Police inventory when you try to drop/take items from an other one's. You can't duplicate anymore.
        end

        Wait(150)
        refreshPoliceInventory()
        Wait(150)
        loadPlayerInventory()

        cb("ok")
    end
end)