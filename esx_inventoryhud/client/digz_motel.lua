

----[[pinkcage]]----
RegisterNetEvent("esx_inventoryhud:openPinkcageInventory")
AddEventHandler(
    "esx_inventoryhud:openPinkcageInventory",
    function(data)
        setPropertyPinkcageData(data)
        openPinkcageInventory()
        SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
    end
)

function refreshPropertyPinkcageInventory()
    ESX.TriggerServerCallback("digz_motel:getPinkcageInventory", function(inventory)
		setPropertyPinkcageData(inventory)
	end, ESX.GetPlayerData().identifier, currentPinkcage)
end

function setPropertyPinkcageData(data)

    items = {}
	currentPinkcage = data.stash_name
    SendNUIMessage(
                {
                    action = "setInfoText",
                    text = data.stash_name .." - Stash"
                }
            )

    local blackMoney = data.blackMoney
    --local appleCoin = data.appleCoin
    --local wetMoney = data.wetMoney
    local propertyItems = data.items
    local propertyWeapons = data.weapons

    if blackMoney > 0 then
        accountData = {
            label = _U("black_money"),
            count = blackMoney,
            type = "item_account",
            name = "black_money",
            usable = false,
            rare = false,
            limit = -1,
            canRemove = false
        }
        table.insert(items, accountData)
    end
    -- if appleCoin > 0 then
    --     accountData = {
    --         label = _U("apple_coin"),
    --         count = appleCoin,
    --         type = "item_account",
    --         name = "apple_coin",
    --         usable = false,
    --         rare = false,
    --         weight = -1,
    --         canRemove = false
    --     }
    --     table.insert(items, accountData)
    -- end

    -- if wetMoney > 0 then
    --     accountData = {
    --         label = _U("wet_money"),
    --         count = wetMoney,
    --         type = "item_account",
    --         name = "wet_money",
    --         usable = false,
    --         rare = false,
    --         weight = -1,
    --         canRemove = false
    --     }
    --     table.insert(items, accountData)
    -- end
    for i = 1, #propertyItems, 1 do
        local item = propertyItems[i]

        if item.count > 0 then
            item.type = "item_standard"
            item.usable = false
            item.rare = false
            item.limit = -1
            item.canRemove = false

            table.insert(items, item)
        end
    end

    for i = 1, #propertyWeapons, 1 do
        local weapon = propertyWeapons[i]

        if propertyWeapons[i].name ~= "WEAPON_UNARMED" then
            table.insert(
                items,
                {
                    label = ESX.GetWeaponLabel(weapon.name),
                    count = weapon.ammo,
                    limit = -1,
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

function openPinkcageInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "Pinkcage"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback(
    "PutIntoPinkcage",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)

            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end

            TriggerServerEvent("digz_motel:putItem1", ESX.GetPlayerData().identifier, data.item.type, data.item.name, count, currentPinkcage)
            AnimWood() 
        end

        Citizen.Wait(150)
        refreshPropertyPinkcageInventory()
        Citizen.Wait(150)
        loadPlayerInventory()
        Citizen.Wait(250)
        closeInventory()
       
        cb("ok")
    end
)

RegisterNUICallback(
    "TakeFromPinkcage",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            TriggerServerEvent("digz_motel:getItem1", ESX.GetPlayerData().identifier, data.item.type, data.item.name, tonumber(data.number), currentPinkcage)
            AnimWood()
        end

        Wait(150)
        refreshPropertyPinkcageInventory()
        Wait(150)
        loadPlayerInventory()
        closeInventory()
        cb("ok")
    end
)
----[[firefly]]----


RegisterNetEvent("esx_inventoryhud:openFireflyInventory")
AddEventHandler(
    "esx_inventoryhud:openFireflyInventory",
    function(data)
        setPropertyFireflyData(data)
        openFireflyInventory()
        SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
    end
)

function refreshPropertyFireflyInventory()
    ESX.TriggerServerCallback("digz_motel:getFireflyInventory", function(inventory)
		setPropertyFireflyData(inventory)
	end, ESX.GetPlayerData().identifier, currentFirefly)
end

function setPropertyFireflyData(data)

    items = {}
	currentFirefly = data.stash_name
    SendNUIMessage(
                {
                    action = "setInfoText",
                    text = data.stash_name .." - Stash"
                }
            )

    local blackMoney = data.blackMoney
    --local appleCoin = data.appleCoin
    --local wetMoney = data.wetMoney
    local propertyItems = data.items
    local propertyWeapons = data.weapons

    if blackMoney > 0 then
        accountData = {
            label = _U("black_money"),
            count = blackMoney,
            type = "item_account",
            name = "black_money",
            usable = false,
            rare = false,
            limit = -1,
            canRemove = false
        }
        table.insert(items, accountData)
    end
    -- if appleCoin > 0 then
    --     accountData = {
    --         label = _U("apple_coin"),
    --         count = appleCoin,
    --         type = "item_account",
    --         name = "apple_coin",
    --         usable = false,
    --         rare = false,
    --         weight = -1,
    --         canRemove = false
    --     }
    --     table.insert(items, accountData)
    -- end

    -- if wetMoney > 0 then
    --     accountData = {
    --         label = _U("wet_money"),
    --         count = wetMoney,
    --         type = "item_account",
    --         name = "wet_money",
    --         usable = false,
    --         rare = false,
    --         weight = -1,
    --         canRemove = false
    --     }
    --     table.insert(items, accountData)
    -- end
    for i = 1, #propertyItems, 1 do
        local item = propertyItems[i]

        if item.count > 0 then
            item.type = "item_standard"
            item.usable = false
            item.rare = false
            item.limit = -1
            item.canRemove = false

            table.insert(items, item)
        end
    end

    for i = 1, #propertyWeapons, 1 do
        local weapon = propertyWeapons[i]

        if propertyWeapons[i].name ~= "WEAPON_UNARMED" then
            table.insert(
                items,
                {
                    label = ESX.GetWeaponLabel(weapon.name),
                    count = weapon.ammo,
                    limit = -1,
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

function openFireflyInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "Firefly"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback(
    "PutIntoFirefly",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)

            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end

            TriggerServerEvent("digz_motel:putItem2", ESX.GetPlayerData().identifier, data.item.type, data.item.name, count, currentFirefly)
            AnimWood() 
        end

        Wait(150)
        refreshPropertyFireflyInventory()
        Wait(150)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "TakeFromFirefly",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            TriggerServerEvent("digz_motel:getItem2", ESX.GetPlayerData().identifier, data.item.type, data.item.name, tonumber(data.number), currentFirefly)
            AnimWood()
        end

        Wait(150)
        refreshPropertyFireflyInventory()
        Wait(150)
        loadPlayerInventory()

        cb("ok")
    end
)
----[[crastenburg]]----
RegisterNetEvent("esx_inventoryhud:openCrastenburgInventory")
AddEventHandler(
    "esx_inventoryhud:openCrastenburgInventory",
    function(data)
        setPropertyCrastenburgData(data)
        openCrastenburgInventory()
        SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
    end
)

function refreshPropertyCrastenburgInventory()
    ESX.TriggerServerCallback("digz_motel:getCrastenburgInventory", function(inventory)
		setPropertyCrastenburgData(inventory)
	end, ESX.GetPlayerData().identifier, currentCrastenburg)
end

function setPropertyCrastenburgData(data)

    items = {}
	currentCrastenburg = data.stash_name
    SendNUIMessage(
                {
                    action = "setInfoText",
                    text = data.stash_name .." - Stash"
                }
            )

    local blackMoney = data.blackMoney
    --local appleCoin = data.appleCoin
    --local wetMoney = data.wetMoney
    local propertyItems = data.items
    local propertyWeapons = data.weapons

    if blackMoney > 0 then
        accountData = {
            label = _U("black_money"),
            count = blackMoney,
            type = "item_account",
            name = "black_money",
            usable = false,
            rare = false,
            limit = -1,
            canRemove = false
        }
        table.insert(items, accountData)
    end
    -- if appleCoin > 0 then
    --     accountData = {
    --         label = _U("apple_coin"),
    --         count = appleCoin,
    --         type = "item_account",
    --         name = "apple_coin",
    --         usable = false,
    --         rare = false,
    --         weight = -1,
    --         canRemove = false
    --     }
    --     table.insert(items, accountData)
    -- end

    -- if wetMoney > 0 then
    --     accountData = {
    --         label = _U("wet_money"),
    --         count = wetMoney,
    --         type = "item_account",
    --         name = "wet_money",
    --         usable = false,
    --         rare = false,
    --         weight = -1,
    --         canRemove = false
    --     }
    --     table.insert(items, accountData)
    -- end
    for i = 1, #propertyItems, 1 do
        local item = propertyItems[i]

        if item.count > 0 then
            item.type = "item_standard"
            item.usable = false
            item.rare = false
            item.limit = -1
            item.canRemove = false

            table.insert(items, item)
        end
    end

    for i = 1, #propertyWeapons, 1 do
        local weapon = propertyWeapons[i]

        if propertyWeapons[i].name ~= "WEAPON_UNARMED" then
            table.insert(
                items,
                {
                    label = ESX.GetWeaponLabel(weapon.name),
                    count = weapon.ammo,
                    limit = -1,
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

function openCrastenburgInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "Crastenburg"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback(
    "PutIntoCrastenburg",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)

            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end

            TriggerServerEvent("digz_motel:putItem3", ESX.GetPlayerData().identifier, data.item.type, data.item.name, count, currentCrastenburg)
            AnimWood() 
        end

        Wait(150)
        refreshPropertyCrastenburgInventory()
        Wait(150)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "TakeFromCrastenburg",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            TriggerServerEvent("digz_motel:getItem3", ESX.GetPlayerData().identifier, data.item.type, data.item.name, tonumber(data.number), currentCrastenburg)
            AnimWood()
        end

        Wait(150)
        refreshPropertyCrastenburgInventory()
        Wait(150)
        loadPlayerInventory()

        cb("ok")
    end
)
----[[bayview]]----
RegisterNetEvent("esx_inventoryhud:openBayviewInventory")
AddEventHandler(
    "esx_inventoryhud:openBayviewInventory",
    function(data)
        setPropertyBayviewData(data)
        openBayviewInventory()
        SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
    end
)

function refreshPropertyBayviewInventory()
    ESX.TriggerServerCallback("digz_motel:getBayviewInventory", function(inventory)
		setPropertyBayviewData(inventory)
	end, ESX.GetPlayerData().identifier, currentBayview)
end

function setPropertyBayviewData(data)

    items = {}
	currentBayview = data.stash_name
    SendNUIMessage(
                {
                    action = "setInfoText",
                    text = data.stash_name .." - Stash"
                }
            )

    local blackMoney = data.blackMoney
    --local appleCoin = data.appleCoin
    --local wetMoney = data.wetMoney
    local propertyItems = data.items
    local propertyWeapons = data.weapons

    if blackMoney > 0 then
        accountData = {
            label = _U("black_money"),
            count = blackMoney,
            type = "item_account",
            name = "black_money",
            usable = false,
            rare = false,
            limit = -1,
            canRemove = false
        }
        table.insert(items, accountData)
    end
    -- if appleCoin > 0 then
    --     accountData = {
    --         label = _U("apple_coin"),
    --         count = appleCoin,
    --         type = "item_account",
    --         name = "apple_coin",
    --         usable = false,
    --         rare = false,
    --         weight = -1,
    --         canRemove = false
    --     }
    --     table.insert(items, accountData)
    -- end

    -- if wetMoney > 0 then
    --     accountData = {
    --         label = _U("wet_money"),
    --         count = wetMoney,
    --         type = "item_account",
    --         name = "wet_money",
    --         usable = false,
    --         rare = false,
    --         weight = -1,
    --         canRemove = false
    --     }
    --     table.insert(items, accountData)
    -- end
    for i = 1, #propertyItems, 1 do
        local item = propertyItems[i]

        if item.count > 0 then
            item.type = "item_standard"
            item.usable = false
            item.rare = false
            item.limit = -1
            item.canRemove = false

            table.insert(items, item)
        end
    end

    for i = 1, #propertyWeapons, 1 do
        local weapon = propertyWeapons[i]

        if propertyWeapons[i].name ~= "WEAPON_UNARMED" then
            table.insert(
                items,
                {
                    label = ESX.GetWeaponLabel(weapon.name),
                    count = weapon.ammo,
                    limit = -1,
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

function openBayviewInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "Bayview"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback(
    "PutIntoBayview",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)

            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end

            TriggerServerEvent("digz_motel:putItem4", ESX.GetPlayerData().identifier, data.item.type, data.item.name, count, currentBayview)
            AnimWood() 
        end

        Wait(150)
        refreshPropertyBayviewInventory()
        Wait(150)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "TakeFromBayview",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            TriggerServerEvent("digz_motel:getItem4", ESX.GetPlayerData().identifier, data.item.type, data.item.name, tonumber(data.number), currentBayview)
            AnimWood()
        end

        Wait(150)
        refreshPropertyBayviewInventory()
        Wait(150)
        loadPlayerInventory()

        cb("ok")
    end
)
----[[perrera]]----
RegisterNetEvent("esx_inventoryhud:openPerreraInventory")
AddEventHandler(
    "esx_inventoryhud:openPerreraInventory",
    function(data)
        setPropertyPerreraData(data)
        openPerreraInventory()
        SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
    end
)

function refreshPropertyPerreraInventory()
    ESX.TriggerServerCallback("digz_motel:getPerreraInventory", function(inventory)
		setPropertyPerreraData(inventory)
	end, ESX.GetPlayerData().identifier, currentPerrera)
end

function setPropertyPerreraData(data)

    items = {}
	currentPerrera = data.stash_name
    SendNUIMessage(
                {
                    action = "setInfoText",
                    text = data.stash_name .." - Stash"
                }
            )

    local blackMoney = data.blackMoney
    --local appleCoin = data.appleCoin
    --local wetMoney = data.wetMoney
    local propertyItems = data.items
    local propertyWeapons = data.weapons

    if blackMoney > 0 then
        accountData = {
            label = _U("black_money"),
            count = blackMoney,
            type = "item_account",
            name = "black_money",
            usable = false,
            rare = false,
            limit = -1,
            canRemove = false
        }
        table.insert(items, accountData)
    end
    -- if appleCoin > 0 then
    --     accountData = {
    --         label = _U("apple_coin"),
    --         count = appleCoin,
    --         type = "item_account",
    --         name = "apple_coin",
    --         usable = false,
    --         rare = false,
    --         weight = -1,
    --         canRemove = false
    --     }
    --     table.insert(items, accountData)
    -- end

    -- if wetMoney > 0 then
    --     accountData = {
    --         label = _U("wet_money"),
    --         count = wetMoney,
    --         type = "item_account",
    --         name = "wet_money",
    --         usable = false,
    --         rare = false,
    --         weight = -1,
    --         canRemove = false
    --     }
    --     table.insert(items, accountData)
    -- end
    for i = 1, #propertyItems, 1 do
        local item = propertyItems[i]

        if item.count > 0 then
            item.type = "item_standard"
            item.usable = false
            item.rare = false
            item.limit = -1
            item.canRemove = false

            table.insert(items, item)
        end
    end

    for i = 1, #propertyWeapons, 1 do
        local weapon = propertyWeapons[i]

        if propertyWeapons[i].name ~= "WEAPON_UNARMED" then
            table.insert(
                items,
                {
                    label = ESX.GetWeaponLabel(weapon.name),
                    count = weapon.ammo,
                    limit = -1,
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

function openPerreraInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "Perrera"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback(
    "PutIntoPerrera",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)

            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end

            TriggerServerEvent("digz_motel:putItem5", ESX.GetPlayerData().identifier, data.item.type, data.item.name, count, currentPerrera)
            AnimWood() 
        end

        Wait(150)
        refreshPropertyPerreraInventory()
        Wait(150)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "TakeFromPerrera",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            TriggerServerEvent("digz_motel:getItem5", ESX.GetPlayerData().identifier, data.item.type, data.item.name, tonumber(data.number), currentPerrera)
            AnimWood()
        end

        Wait(150)
        refreshPropertyPerreraInventory()
        Wait(150)
        loadPlayerInventory()

        cb("ok")
    end
)
------------------------------------
function AnimWood() 
	local ped = PlayerPedId()
	Citizen.CreateThread(function()
	  RequestAnimDict("random@domestic")
	  TaskPlayAnim((ped), 'random@domestic', 'pickup_low', 1.0, -1, -1, 50, 0, 0, 0, 0)
	  Citizen.Wait(1500)
	  ClearPedTasksImmediately(ped)
	end)
  end