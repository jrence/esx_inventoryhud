local trunkData = nil
local canOpenTrunkInventory = true

AddEventHandler('esx_inventoryhud:disableOpen', function()
    closeInventory()
    canOpenTrunkInventory = false
end)
AddEventHandler("esx_inventoryhud:enableOpen", function()
    canOpenTrunkInventory = true
end)

RegisterNetEvent("esx_inventoryhud:openTrunkInventory")
AddEventHandler(
    "esx_inventoryhud:openTrunkInventory",
    function(data, blackMoney, inventory, weapons)
        setTrunkInventoryData(data, blackMoney, inventory, weapons)
        openTrunkInventory()
        SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
    end
)

RegisterNetEvent("esx_inventoryhud:refreshTrunkInventory")
AddEventHandler(
    "esx_inventoryhud:refreshTrunkInventory",
    function(data, blackMoney, inventory, weapons)
        setTrunkInventoryData(data, blackMoney, inventory, weapons)
    end
)

function setTrunkInventoryData(data, blackMoney, inventory, weapons)
    trunkData = data
    --print(data.text)
    SendNUIMessage(
        {
            action = "setTrunkData",
            text = data.text
        }
    )

    items = {}

    if blackMoney > 0 then
        accountData = {
            label = _U("black_money"),
            count = blackMoney,
            type = "item_account",
            name = "black_money",
            usable = false,
            rare = false,
            weight = -1,
            canRemove = false
        }
        table.insert(items, accountData)
    end
	
    if inventory ~= nil then
        for key, value in pairs(inventory) do
            if inventory[key].count <= 0 then
                inventory[key] = nil
            else
                inventory[key].type = "item_standard"
                inventory[key].usable = false
                inventory[key].rare = false
                inventory[key].weight = -1
                inventory[key].canRemove = false
                table.insert(items, inventory[key])
            end
        end
    end

    if Config.IncludeWeapons and weapons ~= nil then
        for key, value in pairs(weapons) do
            local weaponHash = GetHashKey(weapons[key].name)
            if weapons[key].name ~= "WEAPON_UNARMED" then
                table.insert(
                    items,
                    {
                        label = weapons[key].label,
                        count = weapons[key].ammo,
                        weight = -1,
                        type = "item_weapon",
                        name = weapons[key].name,
                        usable = false,
                        rare = false,
                        canRemove = false
                    }
                )
            end
        end
    end

    SendNUIMessage(
        {
            action = "setSecondInventoryItems",
            itemList = items
        }
    )
end

function openTrunkInventory()
    if canOpenTrunkInventory then -- adds a check if trunk inventory can be opened
        loadPlayerInventory()
        isInInventory = true

        SendNUIMessage(
            {
                action = "display",
                type = "trunk"
            }
        )

        SetNuiFocus(true, true)
    end
end

RegisterNUICallback("PutIntoTrunk", function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

    closeInventory()
		
    TriggerEvent("mythic_progbar:client:progress", {
        name = "Trunk_Action",
        duration = 5000,
        label = "Dragging",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer",
        },
        prop = {
            model = "",
        }
    }, function(status)
        if not status then
	---------------------------------------------------------------------------------------------------------------------------------------------------
        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)

            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end

            TriggerServerEvent("esx_trunk:putItem", trunkData.plate, data.item.type, data.item.name, count, trunkData.max, trunkData.myVeh, data.item.label)

        end
        Wait(250)
        loadPlayerInventory()
        cb("ok")
-------------------------
        end
    end)

end)

RegisterNUICallback(
    "TakeFromTrunk",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            TriggerServerEvent("esx_trunk:getItem", trunkData.plate, data.item.type, data.item.name, tonumber(data.number), trunkData.max, trunkData.myVeh)
        end

        Wait(250)
        loadPlayerInventory()
	Citizen.Wait(250)
	closeInventory()
        cb("ok")
    end
)
