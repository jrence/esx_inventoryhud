isInInventory = false
ESX = nil
local canOpenInventory = true
local targetInventory = nil
local toghud = true

-- backpack
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
         Citizen.Wait(0)
    end
    ---------------------------------------------
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end
    ESX.PlayerData = ESX.GetPlayerData()

    -- Citizen.Wait(100000)
    -- TriggerEvent('creatures_backpack:CheckBag')
    --------------------------------------------
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)



RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

local CheckMSG = false
local isbackPackBusy = false
-- end


-------------------------------------------------------------
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if IsControlJustReleased(0, Config.CloseControl) then
			if isInInventory then
                closeInventory()
				end
            end
        end
    end
)
-- RegisterNetEvent("esx_intoryhud:openInventory")
-- AddEventHandler("esx_inventoryhud:openInventory", function()
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
           if IsControlJustReleased(0, Config.OpenControl) and IsInputDisabled(0) then
                openInventory()
		--SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
		 --AnimInv()
           end
       end
end)

function openInventory()
    ESX.UI.Menu.CloseAll()-- this also closes any esx menus to prevent from society inventory duping
    if canOpenInventory then -- checks if inventory is being searched (can be opened)
        loadPlayerInventory()
        isInInventory = true
        SendNUIMessage(
            {
                action = "display",
                type = "normal",
            weight = weight

            }
        )
        SetNuiFocus(true, true)
    else
        -- add any notification that lets person know that he can't open inventory
	exports['mythic_notify']:SendAlert('error', 'Inventory is disabled')
    end
end

-- sets the id of target
RegisterNetEvent("esx_invnetoryhud:setOpenedPlayerId")
AddEventHandler("esx_invnetoryhud:setOpenedPlayerId", function(target)
    --print(target)
    targetInventory = target
end)

-- disables inventory opening if someone is searching the source
RegisterNetEvent("esx_inventoryhud:disableOpen")
AddEventHandler('esx_inventoryhud:disableOpen', function()
    ESX.UI.Menu.CloseAll() -- this also closes any esx menus to prevent duping using society inventory
    closeInventory()
    canOpenInventory = false
end)

-- enables opening after search is finished
RegisterNetEvent("esx_inventoryhud:enableOpen")
AddEventHandler("esx_inventoryhud:enableOpen", function()
    canOpenInventory = true
end)

RegisterNetEvent("esx_inventoryhud:doClose")
AddEventHandler("esx_inventoryhud:doClose", function()
    closeInventory()
end)

RegisterCommand('closeinv', function(source, args, raw)
    closeInventory()
end)

function closeInventory()
    if targetInventory ~= nil then -- checks if search inventory was open and target's inventory needs to be enabled
        print(targetInventory)
        TriggerServerEvent("esx_inventoryhud:enableTargetInv", targetInventory)
        targetInventory = nil
    end
    isInInventory = false
    SendNUIMessage(
        {
            action = "hide"
        }
    )
    SetNuiFocus(false, false)
end

RegisterNUICallback(
    "NUIFocusOff",
    function()
        closeInventory()
    end
)

RegisterNUICallback(
    "GetNearPlayers",
    function(data, cb)
        local playerPed = PlayerPedId()
        local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
        local foundPlayers = false
        local elements = {}

        for i = 1, #players, 1 do
            if players[i] ~= PlayerId() then
                foundPlayers = true

                table.insert(
                    elements,
                    {
                        label = '',
                        player = GetPlayerServerId(players[i])
                    }
                )
            end
        end

        if not foundPlayers then
        	exports['mythic_notify']:SendAlert('error', _U("players_nearby"))
        else

            SendNUIMessage(
                {
                    action = "nearPlayers",
                    foundAny = foundPlayers,
                    players = elements,
                    item = data.item
                }
            )
            
        end

        cb("ok")
    end
)

RegisterNUICallback(
    "UseItem",
    function(data, cb)
        TriggerServerEvent("esx:useItem", data.item.name)

        if shouldCloseInventory(data.item.name) then
            closeInventory()
        else
            Citizen.Wait(250)
            loadPlayerInventory()
        end

        cb("ok")
    end
)

RegisterNUICallback(
    "DropItem",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
			if data.item.type == "item_money" then
				TriggerServerEvent("esx:removeInventoryItem", "item_account", "money", data.number)
			else
				TriggerServerEvent("esx:removeInventoryItem", data.item.type, data.item.name, data.number)
			end
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "GiveItem",
    function(data, cb)
        local playerPed = PlayerPedId()--GetPlayerServerId(id) 
        local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
        local foundPlayer = false
        for i = 1, #players, 1 do
            if players[i] ~= PlayerId() then
                if GetPlayerServerId(players[i]) == data.player then
                    foundPlayer = true
                end
            end
        end

        if foundPlayer then
            local count = tonumber(data.number)

            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            
            end

            if data.item.type == "item_money" then
                TriggerServerEvent("esx:giveInventoryItem", data.player, "item_account", "money", count)
                AnimInv()
            elseif data.item.type == "item_weapon" then
                TriggerServerEvent("esx:giveInventoryItem", data.player, data.item.type, data.item.name, count)
                AnimInv2()
			else
                TriggerServerEvent("esx:giveInventoryItem", data.player, data.item.type, data.item.name, count)
                AnimInv()
			end
            Citizen.Wait(0)
            loadPlayerInventory()
            Citizen.Wait(0)
            closeInventory()
        else
        	exports['mythic_notify']:SendAlert('error', _U("players_nearby"))        

        end
        cb("ok")
    end
)

function shouldCloseInventory(itemName)
    for index, value in ipairs(Config.CloseUiItems) do
        if value == itemName then
            return true
        end
    end

    return false
end

function shouldSkipAccount(accountName)
    for index, value in ipairs(Config.ExcludeAccountsList) do
        if value == accountName then
            return true
        end
    end

    return false
end

function loadPlayerInventory()
	    --StatusLoaded = false
    		--loadStatus()

    ESX.TriggerServerCallback(
        "esx_inventoryhud:getPlayerInventory",
        function(data)
            items = {}
            inventory = data.inventory
            accounts = data.accounts
            money = data.money
            weapons = data.weapons
            weight = data.weight
            maxWeight = data.maxWeight

            SendNUIMessage(
                {
                    action = "setWeight",
                    text = "<p>" .._U("player_inventory_weight").. "</p><div class=\"control\"><p>" ..weight.. " / " ..maxWeight.. "</p></div>"
                }
            )
            if Config.IncludeCash and money ~= nil and money > 0 then
                moneyData = {
                    label = _U("cash"),
                    name = "cash",
                    type = "item_money",
                    count = money,
                    usable = false,
                    rare = false,
                    weight = -1,
                    canRemove = true
                }

                table.insert(items, moneyData)
            end

            if Config.IncludeAccounts and accounts ~= nil then
                for key, value in pairs(accounts) do
                    if not shouldSkipAccount(accounts[key].name) then
                        local canDrop = accounts[key].name ~= "bank"

                        if accounts[key].money > 0 then
                            accountData = {
                                label = accounts[key].label,
                                count = accounts[key].money,
                                type = "item_account",
                                name = accounts[key].name,
                                usable = false,
                                rare = false,
                                weight = -1,
                                canRemove = canDrop
                            }
                            table.insert(items, accountData)
                        end
                    end
                end
            end

            if inventory ~= nil then
                for key, value in pairs(inventory) do
                    if inventory[key].count <= 0 then
                        inventory[key] = nil
                    else
                        inventory[key].type = "item_standard"
                        table.insert(items, inventory[key])
                    end
                end
            end

            if Config.IncludeWeapons and weapons ~= nil then
                for key, value in pairs(weapons) do
                    local weaponHash = GetHashKey(weapons[key].name)
                    local playerPed = PlayerPedId()
                    if HasPedGotWeapon(playerPed, weaponHash, false) and weapons[key].name ~= "WEAPON_UNARMED" then
                        local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
                        table.insert(
                            items,
                            {
                                label = weapons[key].label,
                                -- count = weapons[key].ammo,
                                count = ammo,
                                weight = -1,
                                type = "item_weapon",
                                name = weapons[key].name,
                                usable = false,
                                rare = false,
                                canRemove = true
                            }
                        )
                    end
                end
            end

            SendNUIMessage(
                {
                    action = "setItems",
                    itemList = items
                }
            )
        end,
        GetPlayerServerId(PlayerId())
    )
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)
            if isInInventory then
                local playerPed = PlayerPedId()
                DisableAllControlActions(0)
                EnableControlAction(0, 47, true)
                EnableControlAction(0, 245, true)
                EnableControlAction(0, 38, true)
            end
            
            if not canOpenInventory then -- if inventory is being searched (can not be opened) - disable open control
                local playerPed = PlayerPedId()
                DisableControlAction(0, Config.OpenControl, true)
            else
                Citizen.Wait(2000)
            end
        end
    end
)

function AnimInv() 
  local ped = PlayerPedId()
  Citizen.CreateThread(function()
    RequestAnimDict("mp_common")
    Citizen.Wait(100)
    TaskPlayAnim((ped), 'mp_common', 'givetake1_a', 2.5, 2.5, -1, 50, 0, 0, 0, 0)
    --FreezeEntityPosition(PlayerPedId(), true)
    Citizen.Wait(1000)
    ClearPedTasks(ped)
    --FreezeEntityPosition(PlayerPedId(), false)
  end)
end
function AnimInv2() 
    local ped = PlayerPedId()
    Citizen.CreateThread(function()
      RequestAnimDict("reaction@intimidation@cop@unarmed")
      Citizen.Wait(100)
      TaskPlayAnim(ped, "reaction@intimidation@1h", "outro", 5.0, 1.0, -1, 50, 0, 0, 0, 0 )
      --TaskPlayAnim((ped), 'reaction@intimidation@cop@unarmed', 'intro', 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
      --TaskPlayAnim((ped), 'mp_common', 'givetake1_a', 1.0, -1, -1, 50, 0, 0, 0, 0)
      --FreezeEntityPosition(PlayerPedId(), true)
      Citizen.Wait(1000)
      ClearPedTasks(ped)
      --FreezeEntityPosition(PlayerPedId(), false)
    end)
  end

RegisterNetEvent('esx_inventoryhud:notification')
AddEventHandler('esx_inventoryhud:notification', function(sourceitemname, sourceitemlabel, sourceitemcount, sourceitemremove)
        SendNUIMessage({
            action = "notification",
            itemname = sourceitemname,
            itemlabel = sourceitemlabel,
            itemcount = sourceitemcount,
            itemremove = sourceitemremove
        })
end)
--=========================[Bag MENU]================================--

--=========================[Super BACKPACK]==========================--
-- function superBag()
--     ESX.TriggerServerCallback('creatures_backpack:item', function(quantity)
--         if quantity > 0 then
--             if isbackPackBusy then
--                 exports['mythic_notify']:SendAlert('error', _U('YouAreBusy') ,5000)
--             else               
--                 TriggerServerEvent('creatures_backpack:GiveWieght', Config.SuperBackPack)
--                 isbackPackBusy = true
--                 Citizen.Wait(7000)
--                 isbackPackBusy = false
--             end
                    
--             isbackPackBusy = false
--         end

--     end, 'superbackpack')
-- end

-- --===================================================[FUNCTIONS/TRIGGERS]====================================================--
-- function RemoveBag()
--     local plySkin
--     ESX.UI.Menu.CloseAll()
--     TriggerEvent('skinchanger:getSkin', function(skin)plySkin = skin; end)
    
--     if (plySkin["bags_1"] ~= 0 or plySkin["bags_2"] ~= 0) then
--         TriggerServerEvent('creatures_backpack:RemoveWieght')
--     end

-- end

-- RegisterCommand('removebag', function()
--     ESX.UI.Menu.CloseAll()
--     local elements = {}

--     table.insert(elements, {label = _U('RemoveBackPack'), value = 'take'})    
    
--     ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'removebackpack',
--         {
--             title = _U('LiteMenu'),
--             align = Config.MenuAlign,
--             elements = elements
--         }, function(data, menu)            
--             if data.current.value == 'take' then
--                 if isbackPackBusy then
--                     exports['mythic_notify']:SendAlert('error', _U('YouAreBusy') ,5000)
--                 else
--                     RemoveBag()
--                     isbackPackBusy = true
--                     Citizen.Wait(7000)
--                     isbackPackBusy = false
--                 end                  
--             end 
--         end,function(data, menu)
--             menu.close()
--     end)
-- end)

-- RegisterNetEvent('creatures_backpack:PutBackpackItem')
-- AddEventHandler('creatures_backpack:PutBackpackItem', function()
        
--     local plySkin
--     TriggerEvent('skinchanger:getSkin', function(skin)
--         plySkin = skin;
--     end)        
    
--     if (plySkin["bags_1"] ~= 0 or plySkin["bags_2"] ~= 0) then
--         if CheckMSG == false then
--             exports['mythic_notify']:SendAlert('error', _U('YouAlreadyWoreTheBag'),5000)
--         end
--     else
--        -- SuperBackPack
--         ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
--             if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
--                 TriggerEvent('skinchanger:change', "bags_1", Config.WlJobBagSuper)
--                 TriggerEvent('skinchanger:change', "bags_2", 3)
--                 TriggerEvent('skinchanger:getSkin', function(skin)
--                 TriggerServerEvent('esx_skin:save', skin)
--                 end)
--             elseif ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
--                 TriggerEvent('skinchanger:change', "bags_1", Config.WlJobBagSuper)
--                 TriggerEvent('skinchanger:change', "bags_2", 0)
--                 TriggerEvent('skinchanger:getSkin', function(skin)
--                 TriggerServerEvent('esx_skin:save', skin)
--                 end)
--             elseif ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
--                 TriggerEvent('skinchanger:change', "bags_1", Config.WlJobBagSuper)
--                 TriggerEvent('skinchanger:change', "bags_2", 10)
--                 TriggerEvent('skinchanger:getSkin', function(skin)
--                 TriggerServerEvent('esx_skin:save', skin)
--                 end)
--             elseif ESX.PlayerData.job and ESX.PlayerData.job.name == 'gunner' then
--                 TriggerEvent('skinchanger:change', "bags_1", Config.WlJobBagSuper)
--                 TriggerEvent('skinchanger:change', "bags_2", 13)
--                 TriggerEvent('skinchanger:getSkin', function(skin)
--                 TriggerServerEvent('esx_skin:save', skin)
--                 end)
--             elseif ESX.PlayerData.job and ESX.PlayerData.job.name == 'resto' then
--                 TriggerEvent('skinchanger:change', "bags_1", Config.WlJobBagSuper)
--                 TriggerEvent('skinchanger:change', "bags_2", 11)
--                 TriggerEvent('skinchanger:getSkin', function(skin)
--                 TriggerServerEvent('esx_skin:save', skin)
--                 end)
--             else
--                 TriggerEvent('skinchanger:change', "bags_1", Config.SuperBag)
--                 TriggerEvent('skinchanger:change', "bags_2", 0)
--                 TriggerEvent('skinchanger:getSkin', function(skin)
--                 TriggerServerEvent('esx_skin:save', skin)
--                 end)
--             end
--         end)                
--         CheckMSG = true           
--     end
-- end)


-- RegisterNetEvent('creatures_backpack:RemoveBackpackItem')
-- AddEventHandler('creatures_backpack:RemoveBackpackItem', function()
--     ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
--         PlayZft("anim@mp_parachute_outro@male@lose", "lose", 6000)
--         TriggerEvent('skinchanger:change', "bags_1", 0)
--         TriggerEvent('skinchanger:change', "bags_2", 0)
--         TriggerEvent('skinchanger:getSkin', function(skin)
--             TriggerServerEvent('esx_skin:save', skin)
--         end)
--     end)
--     CheckMSG = false
-- end)


-- RegisterNetEvent('creatures_backpack:OpenMenu')
-- AddEventHandler('creatures_backpack:OpenMenu', function()
--     PlayZft("anim@mp_parachute_outro@male@lose", "lose", 4000)
--     superBag()
-- end)


-- RegisterNetEvent('creatures_backpack:CheckBag')
-- AddEventHandler('creatures_backpack:CheckBag', function()
--     TriggerEvent('skinchanger:getSkin', function(skin)
--         Citizen.CreateThread(function()
--             while skin == nil do
--                 Citizen.Wait(10)
--             end
--             if skin == nil then
--                 print("[creatures_backpack]: Failed to detect if wearing any bag.")
--             end
--         end)
        
--         if (skin["bags_1"] == Config.SuperBag) or (skin["bags_1"] == Config.WlJobBagSuper) then
--             TriggerServerEvent('creatures_backpack:CheckWieght', Config.SuperBackPack)
--             CheckMSG = true
--         else 
--             CheckMSG = false
--         end
    
--     end)

-- end)

-- function PlayZft(AnimeDicts, AnimeTask, Cleartime)
--     local playerPed = PlayerPedId()
    
--     ESX.Streaming.RequestAnimDict(AnimeDicts, function()
--         TaskPlayAnim(playerPed, AnimeDicts, AnimeTask, 8.0, -8, -1, 49, 0, 0, 0, 0)
--     end)
    
--     if Cleartime == nil then
--         Citizen.Wait(10)
--     else
--         Citizen.Wait(Cleartime)
--         ClearPedTasksImmediately(playerPed)
--     end
-- end
