Config = {}
Config.Locale = 'en'
Config.IncludeCash = true -- DONT TOUCH!
Config.IncludeWeapons = true -- TRUE or FALSE
Config.IncludeAccounts = true -- TRUE or FALSE
Config.ExcludeAccountsList = {"bank", "money"} --  DONT TOUCH!
Config.OpenControl = 289 -- Key for opening inventory. Edit html/js/config.js to change key for closing it.
Config.CloseControl = 200
----------------------------------------------------------------------------------    
-- List of item names that will close ui when used
Config.CloseUiItems = {
	"chips",
	"chocolate",
	"bunsdog",
	"repairkit", 
	"tyrekit", 
	"bmcdo",
	"tacos", 
	"cola", 
	"bandage",
	"lockpick", 
        "gacha_01",
        "gacha_02", 
        "gacha_03",  
	"HeavyArmor", 
    "MedArmor",
    "bulletproof",
	"bobbypin",
    "clip",
    "radio",
	"bangsilog",
	"fchicken",
	"marijuana", 
	"opium", 
	"meth",
	"coke", 
	"xanax", 
	"balut", 
	"hamburger", 
	"arroz", 
	"spicychicken",
	"rice",
    "longsilog",
    "litebackpack",
    "superbackpack",
    "heavybackpack",
	"chopsuey",
	"porkadobo",
	"burritos", 
	"coffee", 
	"sandwich",
	"icetea", 
	"chocolate", 
	"cupcake", 
	"milk", 
	"beer", 
	"wine",
	"vodka",
	"whisky",
	"tequila",
	"cigarett",
	"cigarette", 
	"prozac", 
	"meth",
	"litebackpack",
	"heavybackpack",
        "camtablet",
    "superbackpack",
    "clip_extended",
    "suppressor",
    "grip",
    "boxpistol",
	"boxsmg",
    "boxshot",
    "boxrifle",
    "boxmg",
    "weakit"
	}

Config.ShopBlipID = 52
Config.LiquorBlipID = 93
Config.YouToolBlipID = 402
Config.GadgetShopBlipID = 521
Config.WeedStoreBlipID = 140
Config.WeaponShopBlipID = 110
Config.MarketShopBlipID = 492

Config.ShopLength = 14
Config.LiquorLength = 10
Config.YouToolLength = 2
Config.PrisonShopLength = 2

Config.MarkerSize = {x = 1.5, y = 1.5, z = 1.5}
Config.MarkerColor = {r = 0, g = 128, b = 255}
Config.Color = 46
Config.Resto = 24
Config.WeaponColor = 0

Config.EnableOpeningHours = true 
Config.OpenHour = 6
Config.CloseHour = 23

Config.EnableLicense = true
Config.LicensePrice = 50000

Config.Shops = {
    RegularShop = {
        Locations = {
            {x = 373.875,   y = 325.896,  z = 102.566},
            {x = 2557.458,  y = 382.282,  z = 107.622},
            {x = -3038.939, y = 585.954,  z = 6.908},
            {x = -3241.927, y = 1001.462, z = 11.830},
            {x = 547.431,   y = 2671.710, z = 41.156},
            {x = 1961.464,  y = 3740.672, z = 31.343},
            {x = 2678.916,  y = 3280.671, z = 54.241},
            {x = 1729.216,  y = 6414.131, z = 34.037},
            {x = -48.519,   y = -1757.514, z = 28.421},
            {x = 1163.373,  y = -323.801,  z = 68.205},
            {x = -707.501,  y = -914.260,  z = 18.215},
            {x = -1820.523, y = 792.518,   z = 137.118},
            {x = 1698.388,  y = 4924.404,  z = 41.063},
            {x = 25.723,   y = -1346.966, z = 28.497},
            { x = 189.73965454102, y = -890.35314941406, z = 29.713088989258},

        },
        Items = {
            {name = 'bread'}, -- add more items here
            {name = 'water'},
            {name = 'phone'},
	         {name = 'mobile_load'},            
        }
    },
------//PALETO//------------------------------------------
    PaletoShop = {
        Locations = {
		--{x = 161.31,   y = 6640.71, z = 31.71 - 0.90},
		--{x = 1733.52,  y = 3244.59,  z = 41.4 - 0.99}

        },
        Items = {
            		{name = 'chips'},
            		{name = 'chocolate'},
            		{name = 'cigarett'},
            		{name = 'lighter'},
            		{name = 'sarsi'},
            		{name = 'water'},
            		{name = 'cigarette'},
					{name = 'mobile_load'},
                    {name = 'newspaper'},
                    {name = 'superbackpack'}
        }
    },

    PaletoLiquor = {
	Locations = {
			--{x = 1811.63,  y = 3271.27,  z = 43.17 - 0.99},
			--{x = -690.05,  y = 5796.94,  z = 17.33 - 0.99},
			--{x = 1729.216,  y = 6414.131, z = 34.037},
        },
        Items = {
            {name = 'tuba'},
            {name = 'tanduay'},
            {name = 'bnb'},
            {name = 'goldbeer'},
            {name = 'stag'}
        }
   },

    PaletoWeaponShop = {
        Locations = {
           --{ x = -330.24, y = 6083.88, z = 30.45 },

        
        },
        Weapons = {
            {name = "WEAPON_FLASHLIGHT", ammo = 1},
            --{name = "WEAPON_MARKSMANPISTOL", ammo = 12},
            {name = "WEAPON_KNIFE", ammo = 1},
            {name = "WEAPON_BAT", ammo = 1},
            --{name = "WEAPON_DOUBLEACTION", ammo = 12},
            {name = "WEAPON_DAGGER", ammo = 1},
            {name = "WEAPON_SWITCHBLADE", ammo = 1},
            {name = "WEAPON_KNUCKLE", ammo = 1},

        },
        Ammo = {
        },
        Items = {
            {name = 'MedArmor'},
            {name = 'suppressor'},
            {name = 'grip'},
            {name = 'flashlight'},
            {name = 'superbackpack'}

        }
    },

    PaletoKeyMaster = {
	Locations = {
			--{x = 157.51,  y = 6653.67,  z = 31.67 - 0.99},
        },
        Items = {
        {name = 'remkey'},
       	--{name = 'parkcard'},
		--{name = 'fishingrod'},
		--{name = 'turtlebait'},
		{name = 'bobbypin'},
		{name = 'handcuffs'},
		{name = 'black_chip'},
        --{name = 'sickle'},
        {name = 'superbackpack'}
        }
   },

---------------------------------------------------------------------
    MarketShop = {
        Locations = {
		--{x = -949.5,   y = -176.83,  z = 46.27 - 0.99},
        },
        Items = {
                	{name = 'fresh_vegetables'},
            		{name = 'rice'},
            		{name = 'fresh_egg'},
            		{name = 'bangus'},
            		{name = 'longganisa'},
            		--{name = 'fresh_chicken'},
            		--{name = 'pork'},
            		--{name = 'fresh_meat'},
            		{name = 'hotdog'},
					{name = 'taco_wrap'},
            		{name = 'buns'}
        }
    },

    RobsLiquor = {
	Locations = {
        {x = 1135.808,  y = -982.281,  z = 45.415},
			
        },
        Items = {
            {name = 'bread'}, -- add more items here
            {name = 'water'},
            {name = 'drugbags'},
            {name = 'rolpaper'},
            {name = 'cigarette'}
        }
   },

    YouTool = {
        Locations = {
            {x = 1728.41, y = 2584.31, z = 45.84},
        },
        Items = {
            {name = 'bread'}, -- add more items here
            {name = 'water'},
            {name = 'white_phone'}
        }
    },

    GadgetShop = {
        Locations = {
            --{x = -1081.92, y = -247.47, z = 37.76 - 0.99},
        },
        Items = {
            --{name = 'plastic_card'},
            {name = 'black_chip'},
            --{name = 'lithium'},
            {name = 'id_card_f'},
            --{name = 'hqscale'},
            --{name = 'drugItem'},
            {name = 'id_card'},
            --{name = 'raspberry'},
            {name = 'laptop_h'},
            {name = 'hackerDevice'},
			{name = 'remkey'},
			--{name = 'parkcard'},
			--{name = 'fishingrod'},
			--{name = 'turtlebait'},
            {name = 'thermal_charge'},
            {name = 'superbackpack'}

        }
    },

    WeaponShop = {
        Locations = {
            { x = 21.94, y = -1107.27, z = 28.8 },  
        },
        Weapons = {
            {name = "WEAPON_FLASHLIGHT", ammo = 1},
            {name = "WEAPON_PISTOL", ammo = 250}
        },
        Ammo = {
        },
        Items = {
            {name = 'boxrifle'},
            {name = 'boxpistol'},
            {name = 'boxsmg'}

        }
    },
    -------------//WAREHOUSE//---------------------------
    WareHouse = {
        Locations = {
           -- { x = -662.180, y = -934.961, z = 20.829 }
        },
        Weapons = {
            {name = "WEAPON_FLASHLIGHT", ammo = 1},
            {name = "WEAPON_CROWBAR", ammo = 1},
            {name = "WEAPON_KNIFE", ammo = 1},
            {name = "WEAPON_BAT", ammo = 1},
            {name = "WEAPON_HAMMER", ammo = 1},
            {name = "WEAPON_DAGGER", ammo = 1},
            {name = "WEAPON_SWITCHBLADE", ammo = 1},
            {name = "WEAPON_KNUCKLE", ammo = 1},

            {name = "WEAPON_PISTOL", ammo = 50},
            {name = "WEAPON_PISTOL50", ammo = 50},
            {name = "WEAPON_REVOLVER", ammo = 50},
            {name = "WEAPON_ASSAULTSMG", ammo = 50},
            {name = "WEAPON_MICROSMG", ammo = 50},
            {name = "WEAPON_MINISMG", ammo = 50},
            {name = "WEAPON_PUMPSHOTGUN", ammo = 50},
            {name = "WEAPON_CARBINERIFLE", ammo = 50},
            {name = "WEAPON_ADVANCEDRIFLE", ammo = 50},
            {name = "WEAPON_ASSAULTRIFLE", ammo = 50},
            {name = "WEAPON_SPECIALCARBINE", ammo = 50},
            {name = "WEAPON_COMPACTRIFLE", ammo = 50},
            {name = "WEAPON_GUSENBERG", ammo = 50}

            --{name = "WEAPON_COMBATPISTOL", ammo = 50},
            --{name = "WEAPON_APPISTOL", ammo = 50},
            --{name = "WEAPON_SNSPISTOL", ammo = 50},
            --{name = "WEAPON_HEAVYPISTOL", ammo = 50},
            --{name = "WEAPON_VINTAGEPISTOL", ammo = 50},
            --{name = "WEAPON_MACHINEPISTOL", ammo = 50},
            --{name = "WEAPON_MARKSMANPISTOL", ammo = 50},
            --{name = "WEAPON_DOUBLEACTION", ammo = 50},
            --{name = "WEAPON_SMG", ammo = 50},
            --{name = "WEAPON_COMBATPDW", ammo = 50},
            --{name = "WEAPON_SAWNOFFSHOTGUN", ammo = 50},
            --{name = "WEAPON_ASSAULTSHOTGUN", ammo = 50},
            --{name = "WEAPON_BULLPUPSHOTGUN", ammo = 50},
            --{name = "WEAPON_HEAVYSHOTGUN", ammo = 50},
            --{name = "WEAPON_DBSHOTGUN", ammo = 50},
            --{name = "WEAPON_BULLPUPRIFLE", ammo = 50},
            --{name = "WEAPON_MG", ammo = 50},
            --{name = "WEAPON_COMBATMG", ammo = 50},
            --{name = "WEAPON_SNIPERRIFLE", ammo = 50},
            --{name = "WEAPON_HEAVYSNIPER", ammo = 50},
            --{name = "WEAPON_MARKSMANRIFLE", ammo = 50}
        },
        Ammo = {
            -- {name = "WEAPON_PISTOL_AMMO", weaponhash = "WEAPON_PISTOL", ammo = 250},
            -- {name = "WEAPON_PISTOL50_AMMO", weaponhash = "WEAPON_PISTOL50", ammo = 250},
            -- {name = "WEAPON_REVOLVER_AMMO", weaponhash = "WEAPON_REVOLVER", ammo = 250},
            -- {name = "WEAPON_ASSAULTSMG_AMMO", weaponhash = "WEAPON_ASSAULTSMG", ammo = 250},
            -- {name = "WEAPON_MICROSMG_AMMO", weaponhash = "WEAPON_MICROSMG", ammo = 250},
            -- {name = "WEAPON_MINISMG_AMMO", weaponhash = "WEAPON_MINISMG", ammo = 250},
            -- {name = "WEAPON_PUMPSHOTGUN_AMMO", weaponhash = "WEAPON_PUMPSHOTGUN", ammo = 250},
            -- {name = "WEAPON_CARBINERIFLE_AMMO", weaponhash = "WEAPON_CARBINERIFLE", ammo = 250},
            -- {name = "WEAPON_ADVANCEDRIFLE_AMMO", weaponhash = "WEAPON_ADVANCEDRIFLE", ammo = 250},
            -- {name = "WEAPON_SPECIALCARBINE_AMMO", weaponhash = "WEAPON_SPECIALCARBINE", ammo = 250},
            -- {name = "WEAPON_COMPACTRIFLE_AMMO", weaponhash = "WEAPON_COMPACTRIFLE", ammo = 250},
            -- {name = "WEAPON_GUSENBERG_AMMO", weaponhash = "WEAPON_GUSENBERG", ammo = 250}
        },
        Items = {
            {name = 'sciroppo'}, 
            {name = 'antibiotico'},
		    {name = 'antibioticorosacea'},
            {name = 'medikit'},
            {name = 'bandage'},
            {name = 'prozac'},
            {name = 'phone'}, 
            {name = 'radio'},
		    {name = 'mobile_load'},
            {name = 'pocket_wifi'},
            {name = 'suppressor'},
            {name = 'clip_extended'},
		    {name = 'grip'},
            {name = 'flashlight'},
            {name = 'nos'},
            {name = 'HeavyArmor'},
            {name = 'MedArmor'},
            {name = 'bulletproof'},

            {name = 'boxpistol'},
            {name = 'boxsmg'},
            {name = 'boxshot'},
            {name = 'boxrifle'},
            {name = 'boxmg'}
            -- {name = 'WEAPON_PISTOL_AMMO'},
            -- {name = 'WEAPON_ASSAULTSMG_AMMO'},
            -- {name = 'WEAPON_CARBINERIFLE_AMMO'},
            -- {name = 'WEAPON_PUMPSHOTGUN_AMMO'},
            -- {name = 'WEAPON_GUSENBERG_AMMO'}

        }
    },
    ------//DONATORS//------------------------------------------
    DonatorA1Shop = {
        Locations = {
		--{x = -3206.12,   y = 791.93, z = 8.93 - 0.90},
       -- {x = -1869.03,   y = 2066.26, z = 140.98 - 0.90}
        },
        Items = {
            		{name = 'chips'},
            		{name = 'chocolate'},
            		{name = 'cigarett'},
            		{name = 'lighter'},
            		{name = 'sarsi'},
            		{name = 'cigarette'},
                    {name = 'newspaper'},
                    {name = 'superbackpack'},
                    {name = 'hamburger'},
                    {name = 'cola'},
                    {name = 'water'}
        }
    },

    -- ForcesStore = {
--         Weapons = {
--             {name = "WEAPON_SPECIALCARBINE", ammo = 250},
--             {name = "WEAPON_PUMPSHOTGUN", ammo = 250},
--             {name = "WEAPON_BZGAS", ammo = 250},
--             -- {name = "WEAPON_GRENADE", ammo = 250},
--             {name = "WEAPON_KNIFE", ammo = 1},
--             {name = "WEAPON_CARBINERIFLE", ammo = 250},
--             {name = "WEAPON_DAGGER", ammo = 1},
--             {name = "WEAPON_SWITCHBLADE", ammo = 1},
--             {name = "WEAPON_KNUCKLE", ammo = 1},
--             {name = "WEAPON_PISTOL50", ammo = 250},
--             {name = "WEAPON_COMBATPISTOL", ammo = 150},
--             {name = "WEAPON_MICROSMG", ammo = 250},
--             {name = "WEAPON_SNSPISTOL", ammo = 250},
--             {name = "WEAPON_NIGHTSTICK", ammo = 1},
--             {name = "WEAPON_FLASHLIGHT", ammo = 1},
--         },
--         Ammo = {

--         },
--         Items = {
--             {name = 'suppressor'},
--             {name = 'grip'},
--             {name = 'flashlight'},
--             {name = 'superbackpack'},
--             {name = 'boxpistol'},
--             {name = 'boxsmg'},
--             {name = 'boxrifle'},
--             {name = 'boxmg'},
--             {name = 'binoculars'},
--             {name = 'bulletproof'},
--         }
--     },

    LicenseShop = {
        Locations = {
            {  x = 451.27514648438, y = -998.16009521484, z = 30.689510345459 }
        }
    }
}

Config.PropList = {
    cash = {["model"] = 'prop_cash_pile_02', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0}
}


-----------------------backpack--------------------------------
-- -- backpack weight 
-- Config.SuperBackPack = 100

-- -- backpack skin(props) (e.g. bag_1 = 40)
-- Config.SuperBag = 22 

-- -- Whitelisted backpack
-- Config.WlJobBagSuper = 21

-- -- Update Checker
-- Config.AutoCheckForUpdate = true -- Do you want to check for new version ? | if Yes then check Config.ShowChanges if not then ignore Config.ShowChanges or put it false.
-- Config.ShowChanges = true -- If Config.AutoCheckForUpdate = true then it's up to you if you want to print the change log or not if there's new update in the console.

-- -- MenuAlign (e.g. 'center', 'left', 'right')

-- Config.MenuAlign = 'right'