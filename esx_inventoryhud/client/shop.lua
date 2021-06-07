local shopData = nil
local currentAction, currentActionMsg, currentActionData = nil, nil, {}
local canOpenShopInventory = true

Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        player = GetPlayerPed(-1)
        coords = GetEntityCoords(player)
        if IsInPaletoKeyMasterZone(coords)
        or IsInPaletoWeaponShopZone(coords)
        or IsInPaletoLiquorZone(coords)
        or IsInPaletoShopZone(coords)
        or IsInRegularShopZone(coords)
        or IsInMarketShopZone(coords)
        or IsInRobsLiquorZone(coords)
        or IsInYouToolZone(coords)
        or IsInGadgetShopZone(coords)
        or IsInWeaponShopZone(coords)
        or IsInDonatorA1ShopZone(coords)
        --or IsInWareHouseShopZone(coords)
        then
            
  if Config.EnableOpeningHours then
    ----------------------//donators//---------------------------
    if IsInDonatorA1ShopZone(coords) then
        if currentAction then
            ESX.ShowHelpNotification(currentActionMsg)
            if IsControlJustReleased(0, Keys["E"]) then
                OpenShopInv("donatorshop")
                Citizen.Wait(2000)
            end
        end
    end
------------------------//PALETO//----------------------------------------
	   if IsInPaletoKeyMasterZone(coords) then
                if currentAction then
                    ESX.ShowHelpNotification(currentActionMsg)
                    if IsControlJustReleased(0, Keys["E"]) then
			
                        OpenShopInv("keymaster")
                        Citizen.Wait(2000)

                    end
                end
            end
	   if IsInPaletoWeaponShopZone(coords) then
                if currentAction then
                    ESX.ShowHelpNotification(currentActionMsg)
                    if IsControlJustReleased(0, Keys["E"]) then
			
                        OpenShopInv("paletoweapon")
                        Citizen.Wait(2000)

                    end
                end
            end
	   if IsInPaletoLiquorZone(coords) then
                if currentAction then
                    ESX.ShowHelpNotification(currentActionMsg)
                    if IsControlJustReleased(0, Keys["E"]) then
                        OpenShopInv("paletoliquor")
                        Citizen.Wait(2000)
                    end
                end
            end
	   if IsInPaletoShopZone(coords) then
                if currentAction then
                    ESX.ShowHelpNotification(currentActionMsg)
                    if IsControlJustReleased(0, Keys["E"]) then
			
                        OpenShopInv("paletoregular")
                        Citizen.Wait(2000)

                    end
                end
            end
-----------------------------------------------------------------------------------------------------------------------------	
	   if IsInRegularShopZone(coords) then
                if currentAction then
                    ESX.ShowHelpNotification(currentActionMsg)
                    if IsControlJustReleased(0, Keys["E"]) then
			
                        OpenShopInv("regular")
                        Citizen.Wait(2000)

                    end
                end
            end

	   if IsInMarketShopZone(coords) then
                if currentAction then
                    ESX.ShowHelpNotification(currentActionMsg)
                    if IsControlJustReleased(0, Keys["E"]) then
			
                        OpenShopInv("market")
                        Citizen.Wait(2000)

                    end
                end
            end


            if IsInRobsLiquorZone(coords) then
                if currentAction then
                    ESX.ShowHelpNotification(currentActionMsg)
                    if IsControlJustReleased(0, Keys["E"]) then
                        OpenShopInv("robsliquor")
                        Citizen.Wait(2000)
                    end
                end
            end
            if IsInYouToolZone(coords) then
                if currentAction then
                    ESX.ShowHelpNotification(currentActionMsg)
                    if IsControlJustReleased(0, Keys["E"]) then
                        OpenShopInv("youtool")
                        Citizen.Wait(2000)
                    end
                end
            end
            if IsInGadgetShopZone(coords) then
                if currentAction then
                    ESX.ShowHelpNotification(currentActionMsg)
                    if IsControlJustReleased(0, Keys["E"]) then
                        OpenShopInv("gadget")
                        Citizen.Wait(2000)
                    end
                end
            end

            if IsInWeaponShopZone(coords) then
                if currentAction then
                    ESX.ShowHelpNotification(currentActionMsg)
                    if IsControlJustReleased(0, Keys["E"]) then
			
		      	if Config.EnableLicense then
                        ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
                            if hasWeaponLicense then
                                OpenShopInv("weaponshop")
                                Citizen.Wait(2000)
                            else
                                exports['mythic_notify']:SendAlert('error', _U('license_check_fail'))
                            end
                        end, GetPlayerServerId(PlayerId()), 'weapon')
		      	else
			OpenShopInv("weaponshop")
			end


        end
		end
        end
	end
	end
    end
end)

function OpenShopInv(shoptype)
    text = "shop"
    data = {text = text}
    inventory = {}

    ESX.TriggerServerCallback("suku:getShopItems", function(shopInv)
        for i = 1, #shopInv, 1 do
            table.insert(inventory, shopInv[i])
        end
    end, shoptype)

    Citizen.Wait(500)
    TriggerEvent("esx_inventoryhud:openShopInventory", data, inventory)
end

AddEventHandler('esx_inventoryhud:disableOpen', function()
    closeInventory()
    canOpenShopInventory = false
end)
AddEventHandler("esx_inventoryhud:enableOpen", function()
    canOpenShopInventory = true
end)

RegisterNetEvent("suku:OpenCustomShopInventory")
AddEventHandler("suku:OpenCustomShopInventory", function(type, shopinventory)
    text = "shop"
    data = {text = text}
    inventory = {}

    ESX.TriggerServerCallback("suku:getCustomShopItems", function(shopInv)
        for i = 1, #shopInv, 1 do
            table.insert(inventory, shopInv[i])
        end
    end, type, shopinventory)
    Citizen.Wait(500)

    TriggerEvent("esx_inventoryhud:openShopInventory", data, inventory)
end)

RegisterNetEvent("esx_inventoryhud:openShopInventory")
AddEventHandler("esx_inventoryhud:openShopInventory", function(data, inventory)
    setShopInventoryData(data, inventory, weapons)
    openShopInventory()
end)

function setShopInventoryData(data, inventory)
    shopData = data

    SendNUIMessage(
        {
            action = "setInfoText",
            text = data.text
        }
    )

    items = {}

    SendNUIMessage(
        {
            action = "setShopInventoryItems",
            itemList = inventory
        }
    )
end

function openShopInventory()
    if canOpenShopInventory then
        loadPlayerInventory()
        isInInventory = true

        SendNUIMessage(
            {
                action = "display",
                type = "shop"
            }
        )
        SetNuiFocus(true, true)
    end
end

RegisterNUICallback("TakeFromShop", function(data, cb)
    if IsPedSittingInAnyVehicle(playerPed) then
        return
    end

    if type(data.number) == "number" and math.floor(data.number) == data.number then
        TriggerServerEvent("suku:SellItemToPlayer", GetPlayerServerId(PlayerId()), data.item.type, data.item.name, tonumber(data.number))
    end
    Wait(150)
    loadPlayerInventory()

    cb("ok")
end)

--------------------//donator//------------------------------
function IsInDonatorA1ShopZone(coords)
    DonatorA1Shop = Config.Shops.DonatorA1Shop.Locations
    for i = 1, #DonatorA1Shop, 1 do
        if GetDistanceBetweenCoords(coords, DonatorA1Shop[i].x, DonatorA1Shop[i].y, DonatorA1Shop[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end
-------------------------------//PALETO//------------------------------------
function IsInPaletoShopZone(coords)
    PaletoShop = Config.Shops.PaletoShop.Locations
    for i = 1, #PaletoShop, 1 do
        if GetDistanceBetweenCoords(coords, PaletoShop[i].x, PaletoShop[i].y, PaletoShop[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end
function IsInPaletoLiquorZone(coords)
    PaletoLiquor = Config.Shops.PaletoLiquor.Locations
    for i = 1, #PaletoLiquor, 1 do
        if GetDistanceBetweenCoords(coords, PaletoLiquor[i].x, PaletoLiquor[i].y, PaletoLiquor[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end
function IsInPaletoKeyMasterZone(coords)
    PaletoKeyMaster = Config.Shops.PaletoKeyMaster.Locations
    for i = 1, #PaletoKeyMaster, 1 do
        if GetDistanceBetweenCoords(coords, PaletoKeyMaster[i].x, PaletoKeyMaster[i].y, PaletoKeyMaster[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end
function IsInPaletoWeaponShopZone(coords)
    PaletoWeaponShop = Config.Shops.PaletoWeaponShop.Locations
    for i = 1, #PaletoWeaponShop, 1 do
        if GetDistanceBetweenCoords(coords, PaletoWeaponShop[i].x, PaletoWeaponShop[i].y, PaletoWeaponShop[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------
function IsInRegularShopZone(coords)
    RegularShop = Config.Shops.RegularShop.Locations
    for i = 1, #RegularShop, 1 do
        if GetDistanceBetweenCoords(coords, RegularShop[i].x, RegularShop[i].y, RegularShop[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end

function IsInMarketShopZone(coords)
    MarketShop = Config.Shops.MarketShop.Locations
    for i = 1, #MarketShop, 1 do
        if GetDistanceBetweenCoords(coords, MarketShop[i].x, MarketShop[i].y, MarketShop[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end

function IsInRobsLiquorZone(coords)
    RobsLiquor = Config.Shops.RobsLiquor.Locations
    for i = 1, #RobsLiquor, 1 do
        if GetDistanceBetweenCoords(coords, RobsLiquor[i].x, RobsLiquor[i].y, RobsLiquor[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end

function IsInYouToolZone(coords)
    YouTool = Config.Shops.YouTool.Locations
    for i = 1, #YouTool, 1 do
        if GetDistanceBetweenCoords(coords, YouTool[i].x, YouTool[i].y, YouTool[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end

function IsInGadgetShopZone(coords)
    GadgetShop = Config.Shops.GadgetShop.Locations
    for i = 1, #GadgetShop, 1 do
        if GetDistanceBetweenCoords(coords, GadgetShop[i].x, GadgetShop[i].y, GadgetShop[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end
function IsInWeaponShopZone(coords)
    WeaponShop = Config.Shops.WeaponShop.Locations
    for i = 1, #WeaponShop, 1 do
        if GetDistanceBetweenCoords(coords, WeaponShop[i].x, WeaponShop[i].y, WeaponShop[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end
-- function IsInWareHouseShopZone(coords)
--     Warehouse = Config.Shops.Warehouse.Locations
--     for i = 1, #Warehouse, 1 do
--         if GetDistanceBetweenCoords(coords, Warehouse[i].x, Warehouse[i].y, Warehouse[i].z, true) < 1.5 then
--             return true
--         end
--     end
--     return false
-- end
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        LicenseShop = Config.Shops.LicenseShop.Locations
        player = GetPlayerPed(-1)
        coords = GetEntityCoords(player)
		for i = 1, #LicenseShop, 1 do
			if GetDistanceBetweenCoords(coords, LicenseShop[i].x, LicenseShop[i].y, LicenseShop[i].z, true) < 8.0 then
				DrawMarker(25, LicenseShop[i].x, LicenseShop[i].y, LicenseShop[i].z - 0.99, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					if currentAction then
						ESX.ShowHelpNotification(_U('license_shop_help'))
						if IsControlJustReleased(0, Keys["E"]) then
							ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
							if hasWeaponLicense then
								exports['mythic_notify']:SendAlert('error', _U('license_shop_check'))
							else
								OpenBuyLicenseMenu()
								Citizen.Wait(2000)
							end
						end, GetPlayerServerId(PlayerId()), 'weapon')
					end
				end
			end
		end
    end
end)

function OpenBuyLicenseMenu()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_license',{
        title = _U('license_shop_title'), --Register a License
        elements = {
          { label = 'Yes', value = 'yes' }, --yes
          { label = 'No', value = 'no' },
        }
      },
      function (data, menu)		
		if data.current.value == 'yes' then
            ESX.TriggerServerCallback('suku:buyLicense', function(bought)
                if bought then
                    menu.close()
                end
            end)
        end
    end,
    function (data, menu)
        menu.close()
    end)
end

Citizen.CreateThread(function()
    player = GetPlayerPed(-1)
    coords = GetEntityCoords(player)
    for k, v in pairs(Config.Shops.RegularShop.Locations) do
        CreateBlip(vector3(Config.Shops.RegularShop.Locations[k].x, Config.Shops.RegularShop.Locations[k].y, Config.Shops.RegularShop.Locations[k].z ), _U('regular_shop_name'), 3.0, Config.Color, Config.ShopBlipID)
    end
    for k, v in pairs(Config.Shops.MarketShop.Locations) do
        CreateBlip(vector3(Config.Shops.MarketShop.Locations[k].x, Config.Shops.MarketShop.Locations[k].y, Config.Shops.MarketShop.Locations[k].z ), _U('Market_shop_name'), 3.0, Config.Color, Config.ShopBlipID)
    end

    for k, v in pairs(Config.Shops.RobsLiquor.Locations) do
         CreateBlip(vector3(Config.Shops.RobsLiquor.Locations[k].x, Config.Shops.RobsLiquor.Locations[k].y, Config.Shops.RobsLiquor.Locations[k].z ), _U('robs_liquor_name'), 3.0, Config.Color, Config.LiquorBlipID)
    end

    for k, v in pairs(Config.Shops.YouTool.Locations) do
        CreateBlip(vector3(Config.Shops.YouTool.Locations[k].x, Config.Shops.YouTool.Locations[k].y, Config.Shops.YouTool.Locations[k].z ), _U('you_tool_name'), 3.0, Config.Color, Config.YouToolBlipID)
    end

    for k, v in pairs(Config.Shops.GadgetShop.Locations) do
        CreateBlip(vector3(Config.Shops.GadgetShop.Locations[k].x, Config.Shops.GadgetShop.Locations[k].y, Config.Shops.GadgetShop.Locations[k].z), _U('gadget_shop_name'), 3.0, Config.Color, Config.GadgetShopBlipID)
    end
    for k, v in pairs(Config.Shops.WeaponShop.Locations) do
        CreateBlip(vector3(Config.Shops.WeaponShop.Locations[k].x, Config.Shops.WeaponShop.Locations[k].y, Config.Shops.WeaponShop.Locations[k].z), _U('weapon_shop_name'), 3.0, Config.WeaponColor, Config.WeaponShopBlipID)
    end
----------------//PALETO------------------------
    for k, v in pairs(Config.Shops.PaletoShop.Locations) do
        CreateBlip(vector3(Config.Shops.PaletoShop.Locations[k].x, Config.Shops.PaletoShop.Locations[k].y, Config.Shops.PaletoShop.Locations[k].z), 'Brgy Irisan Store', 3.0, 47, 52)
    end
    for k, v in pairs(Config.Shops.PaletoLiquor.Locations) do
        CreateBlip(vector3(Config.Shops.PaletoLiquor.Locations[k].x, Config.Shops.PaletoLiquor.Locations[k].y, Config.Shops.PaletoLiquor.Locations[k].z), 'Brgy Irisan Brewery', 3.0, 47, 466)
    end
    for k, v in pairs(Config.Shops.PaletoWeaponShop.Locations) do
        CreateBlip(vector3(Config.Shops.PaletoWeaponShop.Locations[k].x, Config.Shops.PaletoWeaponShop.Locations[k].y, Config.Shops.PaletoWeaponShop.Locations[k].z), 'Brgy Irisan Guns', 3.0, 47, 567)
    end
    for k, v in pairs(Config.Shops.PaletoKeyMaster.Locations) do
        CreateBlip(vector3(Config.Shops.PaletoKeyMaster.Locations[k].x, Config.Shops.PaletoKeyMaster.Locations[k].y, Config.Shops.PaletoKeyMaster.Locations[k].z), 'Brgy Irisan KeyMaster', 3.0, 47, 134)
    end
---------------------------------------------------------------
   -- CreateBlip(vector3(-755.79, 5596.07, 41.67), "Cablecart", 3.0, 4, 36)
end)

Citizen.CreateThread(function()
    while true do
        Player = nil
        Citizen.Wait(0)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local isInMarker, letSleep, currentZone = false, false
        for k,v in pairs(Config.Shops) do
            for i = 1, #v.Locations, 1 do
                local distance = GetDistanceBetweenCoords(playerCoords, v.Locations[i].x, v.Locations[i].y, v.Locations[i].z, true)
                if distance <  1.5 then
                    letSleep = false
                    if distance < Config.MarkerSize.x then
                        isInMarker  = true
                        currentZone = k
                        lastZone    = k
                    end
                end
            end
        end
        if isInMarker and not hasAlreadyEnteredMarker then
            hasAlreadyEnteredMarker = true
            TriggerEvent('suku:hasEnteredMarker', currentZone)
        end
        if not isInMarker and hasAlreadyEnteredMarker then
            hasAlreadyEnteredMarker = false
            TriggerEvent('suku:hasExitedMarker', lastZone)
        end
        if letSleep then
            Citizen.Wait(500)
        end
    end
end)

AddEventHandler('suku:hasEnteredMarker', function(zone)
    currentAction     = 'shop_menu'
    currentActionMsg  = _U('shop_press_menu')
    currentActionData = {zone = zone}
end)

AddEventHandler('suku:hasExitedMarker', function(zone)
    SendNUIMessage({
        display = false,
        clear = true
    })
    currentAction = false
    SetNuiFocus(false, false)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        player = GetPlayerPed(-1)
        coords = GetEntityCoords(player)

        for k, v in pairs(Config.Shops.RegularShop.Locations) do
            if GetDistanceBetweenCoords(coords, Config.Shops.RegularShop.Locations[k].x, Config.Shops.RegularShop.Locations[k].y, Config.Shops.RegularShop.Locations[k].z, true) < 12.0 then
                DrawMarker(25, Config.Shops.RegularShop.Locations[k].x, Config.Shops.RegularShop.Locations[k].y, Config.Shops.RegularShop.Locations[k].z + 0.01, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
            end
        end
        for k, v in pairs(Config.Shops.MarketShop.Locations) do
            if GetDistanceBetweenCoords(coords, Config.Shops.MarketShop.Locations[k].x, Config.Shops.MarketShop.Locations[k].y, Config.Shops.MarketShop.Locations[k].z, true) < 12.0 then
                DrawMarker(25, Config.Shops.MarketShop.Locations[k].x, Config.Shops.MarketShop.Locations[k].y, Config.Shops.MarketShop.Locations[k].z + 0.01, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
            end
        end
        for k, v in pairs(Config.Shops.RobsLiquor.Locations) do
            if GetDistanceBetweenCoords(coords, Config.Shops.RobsLiquor.Locations[k].x, Config.Shops.RobsLiquor.Locations[k].y, Config.Shops.RobsLiquor.Locations[k].z + 0.01, true) < 12.0 then
                DrawMarker(25, Config.Shops.RobsLiquor.Locations[k].x, Config.Shops.RobsLiquor.Locations[k].y, Config.Shops.RobsLiquor.Locations[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
            end
        end
        for k, v in pairs(Config.Shops.YouTool.Locations) do
            if GetDistanceBetweenCoords(coords, Config.Shops.YouTool.Locations[k].x, Config.Shops.YouTool.Locations[k].y, Config.Shops.YouTool.Locations[k].z + 0.01, true) < 12.0 then
                DrawMarker(25, Config.Shops.YouTool.Locations[k].x, Config.Shops.YouTool.Locations[k].y, Config.Shops.YouTool.Locations[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
            end
        end
        for k, v in pairs(Config.Shops.GadgetShop.Locations) do
            if GetDistanceBetweenCoords(coords, Config.Shops.GadgetShop.Locations[k].x, Config.Shops.GadgetShop.Locations[k].y, Config.Shops.GadgetShop.Locations[k].z + 0.01, true) < 12.0 then
                DrawMarker(25, Config.Shops.GadgetShop.Locations[k].x, Config.Shops.GadgetShop.Locations[k].y, Config.Shops.GadgetShop.Locations[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
            end
        end
        for k, v in pairs(Config.Shops.WeaponShop.Locations) do
            if GetDistanceBetweenCoords(coords, Config.Shops.WeaponShop.Locations[k].x, Config.Shops.WeaponShop.Locations[k].y, Config.Shops.WeaponShop.Locations[k].z + 0.01, true) < 12.0 then
                DrawMarker(25, Config.Shops.WeaponShop.Locations[k].x, Config.Shops.WeaponShop.Locations[k].y, Config.Shops.WeaponShop.Locations[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
            end
        end
-----------------------//PALETO//-----------------------------------
        for k, v in pairs(Config.Shops.PaletoShop.Locations) do
            if GetDistanceBetweenCoords(coords, Config.Shops.PaletoShop.Locations[k].x, Config.Shops.PaletoShop.Locations[k].y, Config.Shops.PaletoShop.Locations[k].z + 0.01, true) < 12.0 then
                DrawMarker(25, Config.Shops.PaletoShop.Locations[k].x, Config.Shops.PaletoShop.Locations[k].y, Config.Shops.PaletoShop.Locations[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
            end
        end
        for k, v in pairs(Config.Shops.PaletoLiquor.Locations) do
            if GetDistanceBetweenCoords(coords, Config.Shops.PaletoLiquor.Locations[k].x, Config.Shops.PaletoLiquor.Locations[k].y, Config.Shops.PaletoLiquor.Locations[k].z + 0.01, true) < 12.0 then
                DrawMarker(25, Config.Shops.PaletoLiquor.Locations[k].x, Config.Shops.PaletoLiquor.Locations[k].y, Config.Shops.PaletoLiquor.Locations[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
            end
        end
        for k, v in pairs(Config.Shops.PaletoWeaponShop.Locations) do
            if GetDistanceBetweenCoords(coords, Config.Shops.PaletoWeaponShop.Locations[k].x, Config.Shops.PaletoWeaponShop.Locations[k].y, Config.Shops.PaletoWeaponShop.Locations[k].z + 0.01, true) < 12.0 then
                DrawMarker(25, Config.Shops.PaletoWeaponShop.Locations[k].x, Config.Shops.PaletoWeaponShop.Locations[k].y, Config.Shops.PaletoWeaponShop.Locations[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
            end
        end
        for k, v in pairs(Config.Shops.PaletoKeyMaster.Locations) do
            if GetDistanceBetweenCoords(coords, Config.Shops.PaletoKeyMaster.Locations[k].x, Config.Shops.PaletoKeyMaster.Locations[k].y, Config.Shops.PaletoKeyMaster.Locations[k].z + 0.01, true) < 12.0 then
                DrawMarker(25, Config.Shops.PaletoKeyMaster.Locations[k].x, Config.Shops.PaletoKeyMaster.Locations[k].y, Config.Shops.PaletoKeyMaster.Locations[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
            end
        end
-----------------------------//donator//-------------------------------
        for k, v in pairs(Config.Shops.DonatorA1Shop.Locations) do
            if GetDistanceBetweenCoords(coords, Config.Shops.DonatorA1Shop.Locations[k].x, Config.Shops.DonatorA1Shop.Locations[k].y, Config.Shops.DonatorA1Shop.Locations[k].z + 0.01, true) < 12.0 then
                DrawMarker(25, Config.Shops.DonatorA1Shop.Locations[k].x, Config.Shops.DonatorA1Shop.Locations[k].y, Config.Shops.DonatorA1Shop.Locations[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
            end
        end
---------------------------------------------------------------------------------------
    end
end)

function CreateBlip(coords, text, radius, color, sprite)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, color)
    SetBlipScale(blip, 0.8)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
end

RegisterNetEvent("esx_inventoryhud:openWareHouse")
AddEventHandler("esx_inventoryhud:openWareHouse", function(data)
    OpenShopInv("warehouse")
    Citizen.Wait(2000)
end)

RegisterNetEvent("esx_inventoryhud:openForcesStore")
AddEventHandler("esx_inventoryhud:openForcesStore", function(data)
    OpenShopInv("forces")
    Citizen.Wait(2000)
end)