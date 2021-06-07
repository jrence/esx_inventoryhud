----[[POLICE]]----
RegisterNetEvent("c5ms_inventory:openPoliceWeaps")
AddEventHandler("c5ms_inventory:openPoliceWeaps", function(data)
        setPoliceInventoryDataW(data)
        openPoliceInventoryW()
        SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
    end
)

function refreshPoliceInventoryW()
    ESX.TriggerServerCallback("c5ms_police:getPoliceWeaps", function(store)
            setPoliceInventoryDataW(store)
        end,
        ESX.GetPlayerData().identifier
    )
end

function setPoliceInventoryDataW(data)
    items = {}

    local PoliceItems = data.items
    local PoliceWeapons = data.weapons

    for i = 1, #PoliceWeapons, 1 do
        local weapon = PoliceWeapons[i]

        if PoliceWeapons[i].name ~= "WEAPON_UNARMED" then
            table.insert(
                items,
                {
                    label = ESX.GetWeaponLabel(weapon.name),
                    count = weapon.ammo,
                    weight = -1,
                    type = "item_weapon",
                    name = weapon.name,
                    usable = false,
                    rare = false,
                    canRemove = false
                }
            )
        end
    end

    SendNUIMessage(
        {
            action = "setSecondInventoryItems",
            itemList = items
        }
    )
end

function openPoliceInventoryW()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "PoliceWeaps"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback("PutIntoPoliceWeaps", function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)

            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end

            TriggerServerEvent("c5ms_police:putWeapsPolice", ESX.GetPlayerData().identifier, data.item.type, data.item.name, count)
        end

        Wait(150)
        refreshPoliceInventoryW()
        Wait(150)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback("TakeFromPoliceWeaps", function(data, cb)
    if ESX.PlayerData.job and ESX.PlayerData.job.name ~= 'police' then
        exports['mythic_notify']:SendAlert('inform', 'You are not an Officer')
    else
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            TriggerServerEvent("c5ms_police:getWeapsPolice", ESX.GetPlayerData().identifier, data.item.type, data.item.name, tonumber(data.number))
            openPoliceInventoryW() --Apparently switches INSTANTLY to your own Police inventory when you try to drop/take items from an other one's. You can't duplicate anymore.
        end

        Wait(150)
        refreshPoliceInventoryW()
        Wait(150)
        loadPlayerInventory()

        cb("ok")
    end
end)
