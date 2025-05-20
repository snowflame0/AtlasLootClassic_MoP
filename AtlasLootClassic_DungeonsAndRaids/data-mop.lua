-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select = _G.select
local string = _G.string
local format = string.format

-- WoW

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname = ...
local AtlasLoot = _G.AtlasLoot
if AtlasLoot:GameVersion_LT(AtlasLoot.MOP_VERSION_NUM) then return end
local data = AtlasLoot.ItemDB:Add(addonname, 1, AtlasLoot.MOP_VERSION_NUM)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales
local INFERNO_DIFF = data:AddDifficulty(AL["Elemental Rune Inferno"], "ERI", nil, nil, true)
local TWILIGHT_DIFF = data:AddDifficulty(AL["Elemental Rune Twilight"], "ERT", nil, nil, true)
local NORMAL_DIFF = data:AddDifficulty("NORMAL", nil, nil, nil, true)
local HEROIC_DIFF = data:AddDifficulty("HEROIC", nil, nil, nil, true)
local VENDOR_DIFF = data:AddDifficulty(AL["Vendor"], "vendor", 0)

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local SET_ITTYPE = data:AddItemTableType("Set", "Item")
local AC_ITTYPE = data:AddItemTableType("Achievement", "Item")

local DUNGEON_CONTENT = data:AddContentType(AL["Dungeons"], ATLASLOOT_DUNGEON_COLOR)
local RAID_CONTENT = data:AddContentType(AL["Raids"], ATLASLOOT_RAID40_COLOR)

-- extra
local CLASS_NAME = AtlasLoot:GetColoredClassNames()

-- name formats
local NAME_COLOR, NAME_COLOR_BOSS = "|cffC0C0C0", "|cffC0C0C0"
local NAME_CAVERNS_OF_TIME = NAME_COLOR..AL["CoT"]..":|r %s" -- Caverns of Time

-- colors
--local BLUE = "|cff6666ff%s|r"
--local GREY = "|cff999999%s|r"
--local GREEN = "|cff66cc33%s|r"
local RED = "|cffcc6666%s|r"
local PURPLE = "|cff9900ff%s|r"
local WHITE = "|cffffffff%s|r"

-- format
local BONUS_LOOT_SPLIT = "%s - %s"

-- tier sets
local T11_SET = {
    name = format(AL["Tier %s Sets"], "11"),
    ExtraList = true,
    TableType = SET_ITTYPE,
    IgnoreAsSource = true,
    [NORMAL_DIFF] = {
        {1, 4000941 }, -- Warlock
        {3, 4000935 }, -- Priest Holy
        {4, 4000936 }, -- Priest Shadow
        {6, 4000937 }, -- Rogue
        {8, 4000930 }, -- Hunter
        {10, 4000943 }, -- Warrior Tank
        {11, 4000942 }, -- Warrior DPS
        {13, 4000926 }, -- Death Knight Tank
        {14, 4000925 }, -- Death Knight DPS
        {16, 4000931 }, -- Mage
        {18, 4000928 }, -- Druid Resto
        {19, 4000929 }, -- Druid Balance
        {20, 4000927 }, -- Druid Feral
        {22, 4000938 }, -- Shaman Resto
        {23, 4000940 }, -- Shaman Elemental
        {24, 4000939 }, -- Shaman Enhance
        {26, 4000933 }, -- Paladin Holy
        {27, 4000934 }, -- Paladin Prot
        {28, 4000932 }, -- Paladin DPS
    },
    [HEROIC_DIFF] = {
        {1, 4001941 }, -- Warlock
        {3, 4001935 }, -- Priest Holy
        {4, 4001936 }, -- Priest Shadow
        {6, 4001937 }, -- Rogue
        {8, 4001930 }, -- Hunter
        {10, 4001943 }, -- Warrior Tank
        {11, 4001942 }, -- Warrior DPS
        {13, 4001926 }, -- Death Knight Tank
        {14, 4001925 }, -- Death Knight DPS
        {16, 4001931 }, -- Mage
        {18, 4001928 }, -- Druid Resto
        {19, 4001929 }, -- Druid Balance
        {20, 4001927 }, -- Druid Feral
        {22, 4001938 }, -- Shaman Resto
        {23, 4001940 }, -- Shaman Elemental
        {24, 4001939 }, -- Shaman Enhance
        {26, 4001933 }, -- Paladin Holy
        {27, 4001934 }, -- Paladin Prot
        {28, 4001932 }, -- Paladin DPS
    },
}

local T12_SET = {
    name = format(AL["Tier %s Sets"], "12"),
    ExtraList = true,
    TableType = SET_ITTYPE,
    ContentPhaseCata = 3,
    IgnoreAsSource = true,
    [NORMAL_DIFF] = {
        {1, 40001008 }, -- Warlock
        {3, 40001009 }, -- Priest Holy
        {4, 40001010 }, -- Priest Shadow
        {6, 40001006 }, -- Rogue
        {8, 40001005 }, -- Hunter
        {10, 40001018 }, -- Warrior Tank
        {11, 40001017 }, -- Warrior DPS
        {13, 40001001 }, -- Death Knight Tank
        {14, 40001000 }, -- Death Knight DPS
        {16, 40001007 }, -- Mage
        {18, 40001004 }, -- Druid Resto
        {19, 40001003 }, -- Druid Balance
        {20, 40001002 }, -- Druid Feral
        {22, 40001014 }, -- Shaman Resto
        {23, 40001016 }, -- Shaman Elemental
        {24, 40001015 }, -- Shaman Enhance
        {26, 40001011 }, -- Paladin Holy
        {27, 40001013 }, -- Paladin Prot
        {28, 40001012 }, -- Paladin DPS
    },
    [HEROIC_DIFF] = {
        {1, 40011008 }, -- Warlock
        {3, 40011009 }, -- Priest Holy
        {4, 40011010 }, -- Priest Shadow
        {6, 40011006 }, -- Rogue
        {8, 40011005 }, -- Hunter
        {10, 40011018 }, -- Warrior Tank
        {11, 40011017 }, -- Warrior DPS
        {13, 40011001 }, -- Death Knight Tank
        {14, 40011000 }, -- Death Knight DPS
        {16, 40011007 }, -- Mage
        {18, 40011004 }, -- Druid Resto
        {19, 40011003 }, -- Druid Balance
        {20, 40011002 }, -- Druid Feral
        {22, 40011014 }, -- Shaman Resto
        {23, 40011016 }, -- Shaman Elemental
        {24, 40011015 }, -- Shaman Enhance
        {26, 40011011 }, -- Paladin Holy
        {27, 40011013 }, -- Paladin Prot
        {28, 40011012 }, -- Paladin DPS
    },
}

local T13_SET = {
    name = format(AL["Tier %s Sets"], "13"),
    ExtraList = true,
    TableType = SET_ITTYPE,
    ContentPhaseCata = 4,
    IgnoreAsSource = true,
    [TWILIGHT_DIFF] = {
        {1, 40001072 }, -- Warlock
        {3, 40001066 }, -- Priest Holy
        {4, 40001067 }, -- Priest Shadow
        {6, 40001068 }, -- Rogue
        {8, 40001061 }, -- Hunter
        {10, 40001074 }, -- Warrior Tank
        {11, 40001073 }, -- Warrior Dps
        {13, 40001056 }, -- Death Knight Tank
        {14, 40001057 }, -- Death Knight DPS
        {16, 40001062 }, -- Mage
        {18, 40001060 }, -- Druid Resto
        {19, 40001059 }, -- Druid Balance
        {20, 40001058 }, -- Druid Melee
        {22, 40001069 }, -- Shaman Resto
        {23, 40001070 }, -- Shaman Elemental
        {24, 40001071 }, -- Shaman Enhance
        {26, 40001063 }, -- Paladin Holy
        {27, 40001065 }, -- Paladin Prot
        {28, 40001064 }, -- Paladin DPS
    },
    [NORMAL_DIFF] = {
        {1, 40011072 }, -- Warlock
        {3, 40011066 }, -- Priest Holy
        {4, 40011067 }, -- Priest Shadow
        {6, 40011068 }, -- Rogue
        {8, 40011061 }, -- Hunter
        {10, 40011074 }, -- Warrior Tank
        {11, 40011073 }, -- Warrior Dps
        {13, 40011056 }, -- Death Knight Tank
        {14, 40011057 }, -- Death Knight DPS
        {16, 40011062 }, -- Mage
        {18, 40011060 }, -- Druid Resto
        {19, 40011059 }, -- Druid Balance
        {20, 40011058 }, -- Druid Melee
        {22, 40011069 }, -- Shaman Resto
        {23, 40011070 }, -- Shaman Elemental
        {24, 40011071 }, -- Shaman Enhance
        {26, 40011063 }, -- Paladin Holy
        {27, 40011065 }, -- Paladin Prot
        {28, 40011064 }, -- Paladin DPS
    },
    [HEROIC_DIFF] = {
        {1, 40021072 }, -- Warlock
        {3, 40021066 }, -- Priest Holy
        {4, 40021067 }, -- Priest Shadow
        {6, 40021068 }, -- Rogue
        {8, 40021061 }, -- Hunter
        {10, 40021074 }, -- Warrior Tank
        {11, 40021073 }, -- Warrior Dps
        {13, 40021056 }, -- Death Knight Tank
        {14, 40021057 }, -- Death Knight DPS
        {16, 40021062 }, -- Mage
        {18, 40021060 }, -- Druid Resto
        {19, 40021059 }, -- Druid Balance
        {20, 40021058 }, -- Druid Melee
        {22, 40021069 }, -- Shaman Resto
        {23, 40021070 }, -- Shaman Elemental
        {24, 40021071 }, -- Shaman Enhance
        {26, 40021063 }, -- Paladin Holy
        {27, 40021065 }, -- Paladin Prot
        {28, 40021064 }, -- Paladin DPS
    },
}

--Achievements
local CATA_DUNGEON_HERO_AC_TABLE = {	--[Cataclysm Dungeon Hero]
name = select(2, GetAchievementInfo(4844)),
TableType = AC_ITTYPE,
ExtraList = true,
IgnoreAsSource = true,
CoinTexture = "Achievement",
[HEROIC_DIFF] = {
    { 1, 4844 },
    { 2, 5060 },			{ 17, 5061 },
    { 3, 5063 },			{ 18, 5064 },
    { 4, 5062 },			{ 19, 5065 },
    { 5, 5066 },			{ 20, 5083 },
    { 6, 5093 }
},
}

local CATA_GLORY_OF_THE_HERO_AC_TABLE = {	--[Glory of the Cataclysm Hero]
AchievementID = 4845,
TableType = AC_ITTYPE,
ExtraList = true,
IgnoreAsSource = true,
CoinTexture = "Achievement",
[HEROIC_DIFF] = {
    { 1, 4845 },
    { 2, 4844 },			{ 17, 5281 },
    { 3, 5282 },			{ 18, 5283 },
    { 4, 5284 },			{ 19, 5285 },
    { 5, 5286 },			{ 20, 5287 },
    { 6, 5288 },			{ 21, 5289 },
    { 7, 5290 },			{ 22, 5291 },
    { 8, 5292 },			{ 23, 5293 },
    { 9, 5294 },			{ 24, 5295 },
    { 10, 5296 },			{ 25, 5297 },
    { 11, 5366 },			{ 26, 5367 },
    { 12, 5368 },			{ 27, 5369 },
    { 13, 5370 },			{ 28, 5371 },
    { 14, 5503 },			{ 29, 5504 },
    { 15, 5505 },			{ 30, 5298 },
},
}

local CATA_DEFENDER_AC_TABLE = {	--[Defender of a Shattered World]
AchievementID = 5506,
TableType = AC_ITTYPE,
ExtraList = true,
IgnoreAsSource = true,
CoinTexture = "Achievement",
[NORMAL_DIFF] = {
    { 1, 5506 },
    { 2, 4842 },			{ 17, 4851 },
    { 3, 4850 },
},
[HEROIC_DIFF] = {
    { 1, 5506 },
    { 2, 5060 },			{ 17, 5061 },
    { 3, 5063 },			{ 18, 5064 },
    { 4, 5062 },			{ 19, 5065 },
    { 5, 5066 },			{ 20, 5083 },
    { 6, 5093 }
}
}

local PROTOCOL_INFERNO_AC_TABLE = {	--[Protocol Inferno: Terminated]
AchievementID = 41148,
TableType = AC_ITTYPE,
ExtraList = true,
IgnoreAsSource = true,
CoinTexture = "Achievement",
[INFERNO_DIFF] = {
    { 1, 41148 },
    { 2, 41139 },			{ 17, 41140 },
    { 3, 41141 },			{ 18, 41142 },
    { 4, 41143 },			{ 19, 41144 },
    { 5, 41145 },			{ 20, 41146 },
    { 6, 41147 }
}
}

local CATA_RAID1_AC_TABLE = {	--[Glory of the Cataclysm Raider]
AchievementID = 4853,
TableType = AC_ITTYPE,
ExtraList = true,
IgnoreAsSource = true,
CoinTexture = "Achievement",
[NORMAL_DIFF] = {
    { 1, 4853 },
    { 2, 5306 },			{ 17, 5307 },
    { 3, 5308 },			{ 18, 5309 },
    { 4, 5310 },			{ 19, 4849 },
    { 5, 5300 },			{ 20, 4852 },
    { 6, 5311 },			{ 21, 5312 },
    { 7, 5304 },			{ 22, 5305 },
},
[HEROIC_DIFF] = {
    { 1, 4853 },
    { 2, 5094 },			{ 17, 5109 },
    { 3, 5108 },			{ 18, 5116 },
    { 4, 5115 },			{ 19, 5117 },
    { 5, 5118 },			{ 20, 5120 },
    { 6, 5119 },			{ 21, 5123 },
    { 7, 5107 },
},
}

local CATA_RAID2_AC_TABLE = {	--[Glory of the Firelands Raider]
AchievementID = 5828,
TableType = AC_ITTYPE,
ExtraList = true,
IgnoreAsSource = true,
CoinTexture = "Achievement",
ContentPhaseCata = 3,
[NORMAL_DIFF] = {
    { 1, 5828 },
    { 2, 5821 },			{ 17, 5810 },
    { 3, 5813 },			{ 18, 5829 },
    { 4, 5830 },			{ 19, 5799 },
},
[HEROIC_DIFF] = {
    { 1, 5828, "mount97560" },
    { 2, 5807 },			{ 17, 5808 },
    { 3, 5806 },			{ 18, 5809 },
    { 4, 5805 },			{ 19, 5804 },
},
}

local CATA_RAID3_AC_TABLE = {	--[Glory of the Dragon Soul Raider]
AchievementID = 6169,
TableType = AC_ITTYPE,
ExtraList = true,
IgnoreAsSource = true,
CoinTexture = "Achievement",
ContentPhaseCata = 4,
[NORMAL_DIFF] = {
    { 1, 6169 },
    { 2, 6174 },			{ 17, 6129 },
    { 3, 6128 },			{ 18, 6175 },
    { 4, 6084 },			{ 19, 6105 },
    { 5, 6133 },			{ 20, 6180 },
},
[HEROIC_DIFF] = {
    { 1, 6169 },
    { 2, 6109 },			{ 17, 6110 },
    { 3, 6111 },			{ 18, 6112 },
    { 4, 6113 },			{ 19, 6114 },
},
}

data["StormstoutBrewery"] = {
    MapID = 4926,
    InstanceID = 645,
    ContentType = DUNGEON_CONTENT,
    LevelRange = {77, 80, 83},
    items = {
        { -- Rom'ogg Bonecrusher
        name = AL["Rom'ogg Bonecrusher"],
        DisplayIDs = {{33147}},
        [NORMAL_DIFF] = {
            { 1, 55278 },	-- Inquisition Robes
            { 2, 55279 },	-- Manacles of Pain
            { 3, 55776 },	-- Skullcracker Ring
            { 4, 55777 },	-- Torturer's Mercy
            { 5, 55778 },	-- Shield of the Iron Maiden
        },
        [HEROIC_DIFF] = {
            { 1, 56311 },	-- Inquisition Robes
            { 2, 56313 },	-- Manacles of Pain
            { 3, 56310 },	-- Skullcracker Ring
            { 4, 56312 },	-- Torturer's Mercy
            { 5, 56314 },	-- Shield of the Iron Maiden
            { 16, "c395", [ATLASLOOT_IT_AMOUNT1] = 70 }, -- Justice Points
            { 18, "ac5281" },
        },
        [INFERNO_DIFF] = {
            { 1, 56311 },	-- Inquisition Robes
            { 2, 56313 },	-- Manacles of Pain
            { 3, 56310 },	-- Skullcracker Ring
            { 4, 56312 },	-- Torturer's Mercy
            { 5, 56314 },	-- Shield of the Iron Maiden
            { 16, "c3148", [ATLASLOOT_IT_AMOUNT1] = 2 }, -- Fissure Stone Fragment
            { 17, "c395", [ATLASLOOT_IT_AMOUNT1] = 70 }, -- Justice Points
            { 19, "ac5281" },
        },
        [TWILIGHT_DIFF] = {
            { 1, 56311 },	-- Inquisition Robes
            { 2, 56313 },	-- Manacles of Pain
            { 3, 56310 },	-- Skullcracker Ring
            { 4, 56312 },	-- Torturer's Mercy
            { 5, 56314 },	-- Shield of the Iron Maiden
            { 16, "c3281", [ATLASLOOT_IT_AMOUNT1] = 2 }, -- Obsidian Fragment
            { 17, "c395", [ATLASLOOT_IT_AMOUNT1] = 70 }, -- Justice Points
            { 19, "ac5281" },
        },
    },
    { -- Corla, Herald of Twilight
    name = AL["Corla, Herald of Twilight"],
    DisplayIDs = {{31546}},
    [NORMAL_DIFF] = {
        { 1, 55264 },	-- Armbands of Change
        { 2, 55263 },	-- Renouncer's Cowl
        { 3, 55265 },	-- Signet of Transformation
        { 4, 55266 },	-- Grace of the Herald
        { 5, 55267 },	-- Corla's Baton
    },
    [HEROIC_DIFF] = {
        { 1, 56297 },	-- Armbands of Change
        { 2, 56298 },	-- Renouncer's Cowl
        { 3, 56299 },	-- Signet of Transformation
        { 4, 56295 },	-- Grace of the Herald
        { 5, 56296 },	-- Corla's Baton
        { 16, "c395", [ATLASLOOT_IT_AMOUNT1] = 70 }, -- Justice Points
        { 18, "ac5282" },
    },
    [INFERNO_DIFF] = {
        { 1, 56297 },	-- Armbands of Change
        { 2, 56298 },	-- Renouncer's Cowl
        { 3, 56299 },	-- Signet of Transformation
        { 4, 56295 },	-- Grace of the Herald
        { 5, 56296 },	-- Corla's Baton
        { 16, "c3148", [ATLASLOOT_IT_AMOUNT1] = 2 }, -- Fissure Stone Fragment
        { 17, "c395", [ATLASLOOT_IT_AMOUNT1] = 70 }, -- Justice Points
        { 19, "ac5282" },
    },
    [TWILIGHT_DIFF] = {
        { 1, 56297 },	-- Armbands of Change
        { 2, 56298 },	-- Renouncer's Cowl
        { 3, 56299 },	-- Signet of Transformation
        { 4, 56295 },	-- Grace of the Herald
        { 5, 56296 },	-- Corla's Baton
        { 16, "c3281", [ATLASLOOT_IT_AMOUNT1] = 2 }, -- Obsidian Fragment
        { 17, "c395", [ATLASLOOT_IT_AMOUNT1] = 70 }, -- Justice Points
        { 19, "ac5282" },
    },
},
{ -- Karsh Steelbender
name = AL["Karsh Steelbender"],
DisplayIDs = {{31710}},
[NORMAL_DIFF] = {
    { 1, 55270 },	-- Burned Gatherings
    { 2, 55269 },	-- Heat Wave Leggings
    { 3, 55268 },	-- Bracers of Cooled Anger
    { 4, 55271 },	-- Quicksilver Amulet
    { 5, 55272 },	-- Steelbender's Masterpiece
},
[HEROIC_DIFF] = {
    { 1, 56304 },	-- Burned Gatherings
    { 2, 56303 },	-- Heat Wave Leggings
    { 3, 56301 },	-- Bracers of Cooled Anger
    { 4, 56300 },	-- Quicksilver Amulet
    { 5, 56302 },	-- Steelbender's Masterpiece
    { 16, "c395", [ATLASLOOT_IT_AMOUNT1] = 70 }, -- Justice Points
    { 18, "ac5283" },
},
[INFERNO_DIFF] = {
    { 1, 56304 },	-- Burned Gatherings
    { 2, 56303 },	-- Heat Wave Leggings
    { 3, 56301 },	-- Bracers of Cooled Anger
    { 4, 56300 },	-- Quicksilver Amulet
    { 5, 56302 },	-- Steelbender's Masterpiece
    { 16, "c3148", [ATLASLOOT_IT_AMOUNT1] = 2 }, -- Fissure Stone Fragment
    { 17, "c395", [ATLASLOOT_IT_AMOUNT1] = 70 }, -- Justice Points
    { 19, "ac5283" },
},
[TWILIGHT_DIFF] = {
    { 1, 56304 },	-- Burned Gatherings
    { 2, 56303 },	-- Heat Wave Leggings
    { 3, 56301 },	-- Bracers of Cooled Anger
    { 4, 56300 },	-- Quicksilver Amulet
    { 5, 56302 },	-- Steelbender's Masterpiece
    { 16, "c3281", [ATLASLOOT_IT_AMOUNT1] = 2 }, -- Obsidian Fragment
    { 17, "c395", [ATLASLOOT_IT_AMOUNT1] = 70 }, -- Justice Points
    { 19, "ac5283" },
},
},
{ -- Beauty
name = AL["Beauty"],
DisplayIDs = {{34433}},
[NORMAL_DIFF] = {
    { 1, 55275 },	-- Beauty's Silken Ribbon
    { 2, 55273 },	-- Beauty's Chew Toy
    { 3, 55274 },	-- Beauty's Plate
    { 4, 55276 },	-- Kibble
    { 5, 55277 },	-- Beauty's Favorite Bone
},
[HEROIC_DIFF] = {
    { 1, 56305 },	-- Beauty's Silken Ribbon
    { 2, 56309 },	-- Beauty's Chew Toy
    { 3, 56308 },	-- Beauty's Plate
    { 4, 56307 },	-- Kibble
    { 5, 56306 },	-- Beauty's Favorite Bone
    { 16, "c395", [ATLASLOOT_IT_AMOUNT1] = 70 }, -- Justice Points
},
[INFERNO_DIFF] = {
    { 1, 56305 },	-- Beauty's Silken Ribbon
    { 2, 56309 },	-- Beauty's Chew Toy
    { 3, 56308 },	-- Beauty's Plate
    { 4, 56307 },	-- Kibble
    { 5, 56306 },	-- Beauty's Favorite Bone
    { 16, "c3148", [ATLASLOOT_IT_AMOUNT1] = 2 }, -- Fissure Stone Fragment
    { 17, "c395", [ATLASLOOT_IT_AMOUNT1] = 70 }, -- Justice Points
},
[TWILIGHT_DIFF] = {
    { 1, 56305 },	-- Beauty's Silken Ribbon
    { 2, 56309 },	-- Beauty's Chew Toy
    { 3, 56308 },	-- Beauty's Plate
    { 4, 56307 },	-- Kibble
    { 5, 56306 },	-- Beauty's Favorite Bone
    { 16, "c3281", [ATLASLOOT_IT_AMOUNT1] = 2 }, -- Obsidian Fragment
    { 17, "c395", [ATLASLOOT_IT_AMOUNT1] = 70 }, -- Justice Points
},
},
{ -- Ascendant Lord Obsidius
name = AL["Ascendant Lord Obsidius"],
DisplayIDs = {{36465}},
[NORMAL_DIFF] = {
    { 1, 55780 },	-- Twitching Shadows
    { 2, 55786 },	-- Kyrstel Mantle
    { 3, 55785 },	-- Willowy Crown
    { 4, 55779 },	-- Raz's Pauldrons
    { 5, 55784 },	-- Clutches of Dying Light
    { 6, 55781 },	-- Carrier Wave Pendant
    { 7, 55787 },	-- Witching Hourglass
    { 8, 55782 },	-- Amber Messenger
    { 9, 55788 },	-- Crepuscular Shield
    { 10, 55783 },  -- Sandshift Relic
    { 16, "ac4833" },
},
[HEROIC_DIFF] = {
    { 1, 56315 },	-- Twitching Shadows
    { 2, 56324 },	-- Kyrstel Mantle
    { 3, 56321 },	-- Willowy Crown
    { 4, 56318 },	-- Raz's Pauldrons
    { 5, 56323 },	-- Clutches of Dying Light
    { 6, 56319 },	-- Carrier Wave Pendant
    { 7, 56320 },	-- Witching Hourglass
    { 8, 56317 },	-- Amber Messenger
    { 9, 56322 },	-- Crepuscular Shield
    { 10,56316 },   -- Sandshift Relic
    { 12, 52078, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Chaos Orb
    { 16, "c395", [ATLASLOOT_IT_AMOUNT1] = 70 }, -- Justice Points
    { 18, "ac5060" },
    { 19, "ac5284" },
},
[INFERNO_DIFF] = {
    { 1, 56315 },	-- Twitching Shadows
    { 2, 56324 },	-- Kyrstel Mantle
    { 3, 56321 },	-- Willowy Crown
    { 4, 56318 },	-- Raz's Pauldrons
    { 5, 56323 },	-- Clutches of Dying Light
    { 6, 56319 },	-- Carrier Wave Pendant
    { 7, 56320 },	-- Witching Hourglass
    { 8, 56317 },	-- Amber Messenger
    { 9, 56322 },	-- Crepuscular Shield
    { 10,56316 },   -- Sandshift Relic
    { 12, 52078, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Chaos Orb
    { 16, "c3148", [ATLASLOOT_IT_AMOUNT1] = "2/5" }, -- Fissure Stone Fragment
    { 17, "c395", [ATLASLOOT_IT_AMOUNT1] = 70 }, -- Justice Points
    { 19, "ac41139"},
    { 20, "ac5060" },
    { 21, "ac5284" },
},
[TWILIGHT_DIFF] = {
    { 1, 56315 },	-- Twitching Shadows
    { 2, 56324 },	-- Kyrstel Mantle
    { 3, 56321 },	-- Willowy Crown
    { 4, 56318 },	-- Raz's Pauldrons
    { 5, 56323 },	-- Clutches of Dying Light
    { 6, 56319 },	-- Carrier Wave Pendant
    { 7, 56320 },	-- Witching Hourglass
    { 8, 56317 },	-- Amber Messenger
    { 9, 56322 },	-- Crepuscular Shield
    { 10, 56316 },  -- Sandshift Relic
    { 12, 52078, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Chaos Orb
    { 16, 78482 },  -- Kiril, Fury of Beasts
    { 17, 77975 },  -- Will of Unbinding
    { 18, "INV_Box_01", nil, AL["Tier Token iLvl384"], nil, "Tier13ElementalRuneTokens"},
    { 20, "c3281", [ATLASLOOT_IT_AMOUNT1] = "2/5" }, -- Obsidian Fragment
    { 21, "c395", [ATLASLOOT_IT_AMOUNT1] = 70 }, -- Justice Points
    { 23, "ac5060" },
    { 24, "ac5284" },
},
},
{	--BlackrockCavernsTrash
name = AL["Trash Mobs"],
ExtraList = true,
[NORMAL_DIFF] = {
    { 1, 55791 },	-- Acanthia's Lost Pendant
    { 16, 55790 },	-- Toxidunk Dagger
    { 17, 55789 },	-- Berto's Staff
},
},
CATA_DUNGEON_HERO_AC_TABLE,
CATA_DEFENDER_AC_TABLE,
CATA_GLORY_OF_THE_HERO_AC_TABLE,
PROTOCOL_INFERNO_AC_TABLE,
}
}

data["WorldBossesMoP"] = {
    name = AL["World Bosses"],
    ContentType = RAID_CONTENT,
    items = {
        { -- Akma'hat
        name = AL["Akma'hat"],
        npcID = 50063,
        Level = 999,
        DisplayIDs = {{34573}},
        [NORMAL_DIFF] = {
            { 1, 69877 }, -- Belt of a Thousand Mouths
            { 3, "INV_sword_04", nil, ALIL["Random World Epics"] },
            { 16, 67541 }, -- Pattern: High Society Top Hat
            { 17, 71965 }, -- Design: Rhinestone Sunglasses
            { 18, 52496 }, -- Design: Jeweler's Amber Monocle
            { 19, 52495 }, -- Design: Jeweler's Sapphire Monocle
            { 20, 52494 }, -- Design: Jeweler's Ruby Monocle
        }
    },
    { -- Garr
    name = AL["Garr"],
    npcID = 50056,
    Level = 999,
    DisplayIDs = {{37307}},
    [NORMAL_DIFF] = {
        { 1, 69842 }, -- Garr's Girdle of Memories
        { 3, "INV_sword_04", nil, ALIL["Random World Epics"] },
        { 16, 67541 }, -- Pattern: High Society Top Hat
        { 17, 71965 }, -- Design: Rhinestone Sunglasses
        { 18, 52496 }, -- Design: Jeweler's Amber Monocle
        { 19, 52495 }, -- Design: Jeweler's Sapphire Monocle
        { 20, 52494 }, -- Design: Jeweler's Ruby Monocle
    }
},
{ -- Julak-Doom
name = AL["Julak-Doom"],
npcID = 50089,
Level = 999,
DisplayIDs = {{24301}},
[NORMAL_DIFF] = {
    { 1, 69844 }, -- Beak of Julak-Doom
    { 3, "INV_sword_04", nil, ALIL["Random World Epics"] },
    { 16, 67541 }, -- Pattern: High Society Top Hat
    { 17, 71965 }, -- Design: Rhinestone Sunglasses
    { 18, 52496 }, -- Design: Jeweler's Amber Monocle
    { 19, 52495 }, -- Design: Jeweler's Sapphire Monocle
    { 20, 52494 }, -- Design: Jeweler's Ruby Monocle
}
},
{ -- Mobus
name = AL["Mobus"],
npcID = 50009,
Level = 999,
DisplayIDs = {{37338}},
[NORMAL_DIFF] = {
    { 1, 69843 }, -- Mobus's Vile Halberd
    { 3, "INV_sword_04", nil, ALIL["Random World Epics"] },
    { 16, 67541 }, -- Pattern: High Society Top Hat
    { 17, 71965 }, -- Design: Rhinestone Sunglasses
    { 18, 52496 }, -- Design: Jeweler's Amber Monocle
    { 19, 52495 }, -- Design: Jeweler's Sapphire Monocle
    { 20, 52494 }, -- Design: Jeweler's Ruby Monocle
}
},
{ -- Xariona
name = AL["Xariona"],
npcID = 50061,
Level = 999,
DisplayIDs = {{32229}},
[NORMAL_DIFF] = {
    { 1, 69876 }, -- Xariona's Spectral Claws
    { 3, "INV_sword_04", nil, ALIL["Random World Epics"] },
    { 16, 67541 }, -- Pattern: High Society Top Hat
    { 17, 71965 }, -- Design: Rhinestone Sunglasses
    { 18, 52496 }, -- Design: Jeweler's Amber Monocle
    { 19, 52495 }, -- Design: Jeweler's Sapphire Monocle
    { 20, 52494 }, -- Design: Jeweler's Ruby Monocle
}
},
{ -- Poseidus
name = AL["Poseidus"],
npcID = 50005,
Level = 999,
DisplayIDs = {{37308}},
[NORMAL_DIFF] = {
    { 1, 67151 }, -- Reins of Poseidus
    { 3, "INV_sword_04", nil, ALIL["Random World Epics"] },
    { 16, 67541 }, -- Pattern: High Society Top Hat
    { 17, 71965 }, -- Design: Rhinestone Sunglasses
    { 18, 52496 }, -- Design: Jeweler's Amber Monocle
    { 19, 52495 }, -- Design: Jeweler's Sapphire Monocle
    { 20, 52494 }, -- Design: Jeweler's Ruby Monocle
}
},
}
}

--[[
data["MogushanVaults"] = {

}
--]]
