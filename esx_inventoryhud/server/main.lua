ESX = nil
itemShopList = {}

TriggerEvent("esx:getSharedObject",function(obj)
	ESX = obj
end)
-------------------backpack------------------------
local ServerMaxWiegt,newMaxWieght

Citizen.CreateThread(function()
        Citizen.Wait(5000)
        while not ESX.GetConfig().MaxWeight do Citizen.Wait(7); end
        if ESX.GetConfig().MaxWeight == nil then
            print("^7[^2creatures_backpack^7]: ^8There's a problem getting the Weight, make sure you are using the latest ESX version.")
        else
            ServerMaxWiegt = ESX.GetConfig().MaxWeight
        end
end)
-- end
-----------------------------------------------------------------------
ESX.RegisterServerCallback(
	"esx_inventoryhud:getPlayerInventory",
	function(source, cb, target)
		local targetXPlayer = ESX.GetPlayerFromId(target)

		if targetXPlayer ~= nil then
			cb({inventory = targetXPlayer.inventory, money = targetXPlayer.getMoney(), accounts = targetXPlayer.accounts, weapons = targetXPlayer.loadout, weight = targetXPlayer.getWeight(), maxWeight = targetXPlayer.maxWeight})
		else
			cb(nil)
		end
	end
)

RegisterServerEvent("esx_inventoryhud:tradePlayerItem")
AddEventHandler(
	"esx_inventoryhud:tradePlayerItem",
	function(from, target, type, itemName, itemCount)
		local _source = from

		local sourceXPlayer = ESX.GetPlayerFromId(_source)
		local targetXPlayer = ESX.GetPlayerFromId(target)

		if type == "item_standard" then
			local sourceItem = sourceXPlayer.getInventoryItem(itemName)
			local targetItem = targetXPlayer.getInventoryItem(itemName)

			if itemCount > 0 and sourceItem.count >= itemCount then
				if targetXPlayer.canCarryItem(itemName, itemCount) then
				--if targetItem.weight ~= -1 and (targetItem.count + itemCount) > targetItem.weight then
					sourceXPlayer.removeInventoryItem(itemName, itemCount)
					TriggerClientEvent('mythic_notify:client:SendAlert', sourceXPlayer, { type = 'inform', text = _U('item_removed') .. itemName})
					
					targetXPlayer.addInventoryItem(itemName, itemCount)
					TriggerClientEvent('mythic_notify:client:SendAlert', targetXPlayer, { type = 'inform', text = _U('item_added') .. itemName})
					
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', targetXPlayer, { type = 'error', text = _U('player_inv_no_space') .. itemName})
					TriggerClientEvent('mythic_notify:client:SendAlert', sourceXPlayer, { type = 'error', text = _U('player_inv_no_space') .. itemName})
					
				end
			end
		elseif type == "item_money" then
			if itemCount > 0 and sourceXPlayer.getMoney() >= itemCount then
				sourceXPlayer.removeMoney(itemCount)
				TriggerClientEvent('mythic_notify:client:SendAlert', sourceXPlayer, { type = 'success', text = _U('money_removed') .. itemCount})
				
				targetXPlayer.addMoney(itemCount)
				TriggerClientEvent('mythic_notify:client:SendAlert', targetXPlayer, { type = 'success', text = _U('money_added') .. itemCount})
				
			end
		elseif type == "item_account" then
			if itemCount > 0 and sourceXPlayer.getAccount(itemName).money >= itemCount then
				sourceXPlayer.removeAccountMoney(itemName, itemCount)
				TriggerClientEvent('mythic_notify:client:SendAlert', sourceXPlayer, { type = 'success', text = _U('money_removed') .. itemCount .. itemName})
				
				targetXPlayer.addAccountMoney(itemName, itemCount)
				TriggerClientEvent('mythic_notify:client:SendAlert', targetXPlayer, { type = 'success', text = _U('money_added') .. itemCount .. itemName})
				
			end
		elseif type == "item_weapon" then
			if not targetXPlayer.hasWeapon(itemName) then
				sourceXPlayer.removeWeapon(itemName)
				TriggerClientEvent('mythic_notify:client:SendAlert', sourceXPlayer, { type = 'success', text = _U('weapon_removed') .. itemName})
				
				targetXPlayer.addWeapon(itemName, itemCount)
				TriggerClientEvent('mythic_notify:client:SendAlert', targetXPlayer, { type = 'success', text = _U('weapon_added') .. itemName})
				
			end
		end
	end
)

RegisterCommand(
	"openinventory",
	function(source, args, rawCommand)
		if IsPlayerAceAllowed(source, "inventory.openinventory") then
			local target = tonumber(args[1])
			local targetXPlayer = ESX.GetPlayerFromId(target)

			if targetXPlayer ~= nil then
				TriggerClientEvent("esx_inventoryhud:openPlayerInventory", source, target, targetXPlayer.name)
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U('no_player')})
				
			end
		else
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U('no_permissions')})
				
		end
	end
)

RegisterServerEvent("suku:sendShopItems")
AddEventHandler("suku:sendShopItems", function(source, itemList)
	itemShopList = itemList
end)

ESX.RegisterServerCallback("suku:getShopItems", function(source, cb, shoptype)
	itemShopList = {}
	local itemResult = MySQL.Sync.fetchAll('SELECT * FROM items')
	local itemInformation = {}

	for i=1, #itemResult, 1 do

		if itemInformation[itemResult[i].name] == nil then
			itemInformation[itemResult[i].name] = {}
		end

		itemInformation[itemResult[i].name].name = itemResult[i].name
		itemInformation[itemResult[i].name].label = itemResult[i].label
		itemInformation[itemResult[i].name].weight = itemResult[i].weight
		itemInformation[itemResult[i].name].rare = itemResult[i].rare
		itemInformation[itemResult[i].name].can_remove = itemResult[i].can_remove
		itemInformation[itemResult[i].name].price = itemResult[i].price

		----------------------//donator//-----------------------------
		if shoptype == "donatorshop" then
			for _, v in pairs(Config.Shops.DonatorA1Shop.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end
		end
		-- if shoptype == "telecom" then
		-- 	for _, v in pairs(Config.Shops.TeleShop.Items) do
		-- 		if v.name == itemResult[i].name then
		-- 			table.insert(itemShopList, {
		-- 				type = "item_standard",
		-- 				name = itemInformation[itemResult[i].name].name,
		-- 				label = itemInformation[itemResult[i].name].label,
		-- 				weight = itemInformation[itemResult[i].name].weight,
		-- 				rare = itemInformation[itemResult[i].name].rare,
		-- 				can_remove = itemInformation[itemResult[i].name].can_remove,
		-- 				price = itemInformation[itemResult[i].name].price,
		-- 				count = 99999999
		-- 			})
		-- 		end
		-- 	end
		-- end
		-- if shoptype == "medshop" then
		-- 	for _, v in pairs(Config.Shops.MedsShop.Items) do
		-- 		if v.name == itemResult[i].name then
		-- 			table.insert(itemShopList, {
		-- 				type = "item_standard",
		-- 				name = itemInformation[itemResult[i].name].name,
		-- 				label = itemInformation[itemResult[i].name].label,
		-- 				weight = itemInformation[itemResult[i].name].weight,
		-- 				rare = itemInformation[itemResult[i].name].rare,
		-- 				can_remove = itemInformation[itemResult[i].name].can_remove,
		-- 				price = itemInformation[itemResult[i].name].price,
		-- 				count = 99999999
		-- 			})
		-- 		end
		-- 	end
		-- end
--------------------------------------------------//PALETO//-----------------------------------------
		if shoptype == "keymaster" then
			for _, v in pairs(Config.Shops.PaletoKeyMaster.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end
		end
		if shoptype == "paletoweapon" then
			local weapons = Config.Shops.PaletoWeaponShop.Weapons
			for _, v in pairs(Config.Shops.PaletoWeaponShop.Weapons) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_weapon",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = 1,
						ammo = v.ammo,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end

			local ammo = Config.Shops.PaletoWeaponShop.Ammo
			for _,v in pairs(Config.Shops.PaletoWeaponShop.Ammo) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_ammo",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = 1,
						weaponhash = v.weaponhash,
						ammo = v.ammo,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end

			for _, v in pairs(Config.Shops.PaletoWeaponShop.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end
		end
		if shoptype == "paletoliquor" then
			for _, v in pairs(Config.Shops.PaletoLiquor.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end
		end
		if shoptype == "paletoregular" then
			for _, v in pairs(Config.Shops.PaletoShop.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end
		end
--------------------------------------------------------------------------------------------------
		if shoptype == "regular" then
			for _, v in pairs(Config.Shops.RegularShop.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end
		end

		if shoptype == "market" then
			for _, v in pairs(Config.Shops.MarketShop.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end
		end

		if shoptype == "robsliquor" then
			for _, v in pairs(Config.Shops.RobsLiquor.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end
		end
		if shoptype == "youtool" then
			for _, v in pairs(Config.Shops.YouTool.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end
		end
		if shoptype == "gadget" then
			for _, v in pairs(Config.Shops.GadgetShop.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end
		end

		if shoptype == "weaponshop" then
			local weapons = Config.Shops.WeaponShop.Weapons
			for _, v in pairs(Config.Shops.WeaponShop.Weapons) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_weapon",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = 1,
						ammo = v.ammo,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end

			local ammo = Config.Shops.WeaponShop.Ammo
			for _,v in pairs(Config.Shops.WeaponShop.Ammo) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_ammo",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = 1,
						weaponhash = v.weaponhash,
						ammo = v.ammo,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end

			for _, v in pairs(Config.Shops.WeaponShop.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end
		end
			----------//WAREHOUSE//----------------
		if shoptype == "warehouse" then
			local weapons = Config.Shops.WareHouse.Weapons
			for _, v in pairs(Config.Shops.WareHouse.Weapons) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_weapon",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = 1,
						ammo = v.ammo,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end
	
			local ammo = Config.Shops.WareHouse.Ammo
			for _,v in pairs(Config.Shops.WareHouse.Ammo) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_ammo",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = 1,
						weaponhash = v.weaponhash,
						ammo = v.ammo,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end
	
			for _, v in pairs(Config.Shops.WareHouse.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end
		end
		if shoptype == "forces" then
			local weapons = Config.Shops.ForcesStore.Weapons
			for _, v in pairs(Config.Shops.ForcesStore.Weapons) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_weapon",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = 1,
						ammo = v.ammo,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end
	
			local ammo = Config.Shops.ForcesStore.Ammo
			for _,v in pairs(Config.Shops.ForcesStore.Ammo) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_ammo",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = 1,
						weaponhash = v.weaponhash,
						ammo = v.ammo,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end
	
			for _, v in pairs(Config.Shops.ForcesStore.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end
		end


	end
	cb(itemShopList)
end)

ESX.RegisterServerCallback("suku:getCustomShopItems", function(source, cb, shoptype, customInventory)
	itemShopList = {}
	local itemResult = MySQL.Sync.fetchAll('SELECT * FROM items')
	local itemInformation = {}

	for i=1, #itemResult, 1 do

		if itemInformation[itemResult[i].name] == nil then
			itemInformation[itemResult[i].name] = {}
		end

		itemInformation[itemResult[i].name].name = itemResult[i].name
		itemInformation[itemResult[i].name].label = itemResult[i].label
		itemInformation[itemResult[i].name].weight = itemResult[i].weight
		itemInformation[itemResult[i].name].rare = itemResult[i].rare
		itemInformation[itemResult[i].name].can_remove = itemResult[i].can_remove
		itemInformation[itemResult[i].name].price = itemResult[i].price

		if shoptype == "normal" then
			for _, v in pairs(customInventory.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end
		end
		
		if shoptype == "weapon" then
			local weapons = customInventory.Weapons
			for _, v in pairs(customInventory.Weapons) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_weapon",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = 1,
						ammo = v.ammo,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end

			local ammo = customInventory.Ammo
			for _,v in pairs(customInventory.Ammo) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_ammo",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = 1,
						weaponhash = v.weaponhash,
						ammo = v.ammo,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end

			for _, v in pairs(customInventory.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end
		end
	end
	cb(itemShopList)
end)

ESX.RegisterServerCallback('suku:buyLicense', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.LicensePrice then
		xPlayer.removeMoney(Config.LicensePrice)

		TriggerEvent('esx_license:addLicense', source, 'weapon', function()
			cb(true)
		end)
	else
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U('no_money')})
			
		cb(false)
	end
end)

RegisterNetEvent("suku:SellItemToPlayer")
AddEventHandler("suku:SellItemToPlayer",function(source, type, item, count)
   	local _source = source
    	local xPlayer = ESX.GetPlayerFromId(_source)

	if type == "item_standard" then
		local targetItem = xPlayer.getInventoryItem(item)
		if xPlayer.canCarryItem(item, count) then

			local list = itemShopList
           		for i = 1, #list, 1 do
				if list[i].name == item then
					local totalPrice = count * list[i].price

					if xPlayer.getMoney() >= totalPrice then

						xPlayer.removeMoney(totalPrice)
						xPlayer.addInventoryItem(item, count)
						TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'You purchased '..count.." "..list[i].label})
				
					else
						TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U('no_money')})
				
					end
				end
            		end
       		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U('insufficient_space')})
			
       		end
	end
	
	if type == "item_weapon" then
        local targetItem = xPlayer.getInventoryItem(item)
        if targetItem.count < 1 then
            local list = itemShopList
            for i = 1, #list, 1 do
				if list[i].name == item then
					local targetWeapon = xPlayer.hasWeapon(tostring(list[i].name)) 
					if not targetWeapon then
						local totalPrice = 1 * list[i].price
						if xPlayer.getMoney() >= totalPrice then
							xPlayer.removeMoney(totalPrice)
							xPlayer.addWeapon(list[i].name, list[i].ammo)
					TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'You purchased '..count.." "..list[i].label})
					
						else
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U('no_money')})
				
						end
					else
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U('weapon_exist')})
				
					end
				end
            end
        else
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U('weapon_exist')})
			
        end
	end
	
	if type == "item_ammo" then
		local targetItem = xPlayer.getInventoryItem(item)
		local list = itemShopList
		for i = 1, #list, 1 do
			if list[i].name == item then
				local targetWeapon = xPlayer.hasWeapon(list[i].weaponhash)
				if targetWeapon then
					local totalPrice = count * list[i].price
					local ammo = count * list[i].ammo
					if xPlayer.getMoney() >= totalPrice then
						xPlayer.removeMoney(totalPrice)
						xPlayer.addWeaponAmmo(list[i].weaponhash, ammo)
					TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'You purchased '..count.." "..list[i].label})

					else
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U('no_money')})

					end
				else
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U('no_weapon')})

				end
            end
        end
    end
end)

------------------------------------------------------------
--Event that disables target inventory opening while being searched
RegisterServerEvent('esx_inventoryhud:disableTargetInv')
AddEventHandler('esx_inventoryhud:disableTargetInv', function(target)
	local _source = source
	local _target = target
	TriggerClientEvent("esx_inventoryhud:disableOpen", _target)
	--TriggerClientEvent("esx_inventoryhud:disableOpenShop", _target)
	TriggerClientEvent("esx_invnetoryhud:setOpenedPlayerId", _source, _target)
end)

--Event that enables target inventory after being searched
RegisterServerEvent('esx_inventoryhud:enableTargetInv')
AddEventHandler('esx_inventoryhud:enableTargetInv', function(target)
	print('enabling open inv')
	print(target)
	TriggerClientEvent('esx_inventoryhud:enableOpen', target)
	--TriggerClientEvent('esx_inventoryhud:enableOpenShop', target)
end)


-- backpack
--=========================[FUNCTIONS/TRIGGERS]==========================--
-- ESX.RegisterServerCallback('creatures_backpack:item', function(source, cb, item)
--     local xPlayer = ESX.GetPlayerFromId(source)
--     local qtty = xPlayer.getInventoryItem('superbackpack').count

--     cb(qtty)
-- end)

-- RegisterServerEvent('creatures_backpack:GiveWieght')
-- AddEventHandler('creatures_backpack:GiveWieght', function(maxwieght2)       
--     local xPlayer = ESX.GetPlayerFromId(source)
--     newMaxWieght = ESX.GetConfig().MaxWeight + maxwieght2

--     xPlayer.setMaxWeight(newMaxWieght)
--     TriggerClientEvent('creatures_backpack:PutBackpackItem', source)
--     xPlayer.removeInventoryItem('superbackpack', 1)
--     xPlayer.showNotification(_U("YouPutTheBackpack") .. " " .. newMaxWieght .. "grams.")        
-- end)

-- RegisterServerEvent('creatures_backpack:CheckWieght')
-- AddEventHandler('creatures_backpack:CheckWieght', function(maxwieght3)
--         local xPlayer = ESX.GetPlayerFromId(source)
--         local newMaxWieght = ESX.GetConfig().MaxWeight + maxwieght3
--         xPlayer.setMaxWeight(newMaxWieght)
-- end)

-- RegisterServerEvent('creatures_backpack:RemoveWieght')
-- AddEventHandler('creatures_backpack:RemoveWieght', function()
--     local xPlayer = ESX.GetPlayerFromId(source)
--     local currentWieght = xPlayer.getWeight()
--     if currentWieght >= ServerMaxWiegt then
--         xPlayer.showNotification(_U("WeightExceed") .. " " .. ServerMaxWiegt  .. " grams.")
--     else 
--         xPlayer.setMaxWeight(ServerMaxWiegt) 
--         xPlayer.showNotification(_U("RemovedBackPack"))
--         TriggerClientEvent('creatures_backpack:RemoveBackpackItem', source)
--         xPlayer.addInventoryItem('superbackpack', 1)
--     end
-- end)

-- ESX.RegisterUsableItem('superbackpack', function(source)
--     local xPlayer = ESX.GetPlayerFromId(source)      
--     TriggerClientEvent('creatures_backpack:OpenMenu', source)
-- end)
-------------------------------------