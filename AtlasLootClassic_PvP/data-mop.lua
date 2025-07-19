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
local addonname, private = ...
local AtlasLoot = _G.AtlasLoot
if AtlasLoot:GameVersion_LT(AtlasLoot.MOP_VERSION_NUM) then
	return
end
local data = AtlasLoot.ItemDB:Add(addonname, 1, AtlasLoot.MOP_VERSION_NUM)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local NORMAL_DIFF = data:AddDifficulty("NORMAL", "n", 1, nil, true)
local ALLIANCE_DIFF
local HORDE_DIFF
local LOAD_DIFF
if UnitFactionGroup("player") == "Horde" then
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE, "horde", nil, 1)
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE, "alliance", nil, 1)
	LOAD_DIFF = HORDE_DIFF
else
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE, "alliance", nil, 1)
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE, "horde", nil, 1)
	LOAD_DIFF = ALLIANCE_DIFF
end

local SET1_DIFF = data:AddDifficulty(format(AL["Dreadful %s"], AL["Gladiator"]), "set1", nil, 1)
local SET2_DIFF = data:AddDifficulty(format(AL["Malevolent %s"], AL["Gladiator"]), "set2", nil, 1)
local SET2_ELITE_DIFF = data:AddDifficulty(format(AL["Malevolent (Elite) %s"], AL["Gladiator"]), "set2", nil, 1)
local SET3_DIFF = data:AddDifficulty(format(AL["Tyrannical %s"], AL["Gladiator"]), "set3", nil, 1)
local SET3_ELITE_DIFF = data:AddDifficulty(format(AL["Tyrannical (Elite) %s"], AL["Gladiator"]), "set3", nil, 1)
local SET4_DIFF = data:AddDifficulty(format(AL["Grievous %s"], AL["Gladiator"]), "set4", nil, 1)
local SET5_DIFF = data:AddDifficulty(format(AL["Prideful %s"], AL["Gladiator"]), "set5", nil, 1)

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local SET_ITTYPE = data:AddItemTableType("Set", "Item")
--local ICON_ITTYPE = data:AddItemTableType("Dummy")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
local SET_EXTRA_ITTYPE = data:AddExtraItemTableType("Set")

local PVP_CONTENT = data:AddContentType(AL["Battlegrounds"], ATLASLOOT_PVP_COLOR)
local ARENA_CONTENT = data:AddContentType(AL["Arena"], ATLASLOOT_PVP_COLOR)
--local OPEN_WORLD_CONTENT = data:AddContentType(AL["Open World"], ATLASLOOT_PVP_COLOR)
local GENERAL_CONTENT = data:AddContentType(GENERAL, ATLASLOOT_RAID40_COLOR)

--local HORDE, ALLIANCE, RANK_FORMAT = "Horde", "Alliance", AL["|cff33ff99Rank:|r %s"]
--local BLIZZARD_NYI = " |cff00ccff<NYI |T130946:12:20:0:0:32:16:4:28:0:16|t>|r"

data["PvPMountsMoP"] = {
	name = ALIL["Mounts"],
	ContentType = GENERAL_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	CorrespondingFields = private.MOUNTS_LINK,
	items = {
		{ -- PvPMountsCata
			name = ALIL["Mounts"],
			[NORMAL_DIFF] = {
				{ 1, 95041, "ac8216" }, -- Malevolent Gladiator's Cloud Serpent
				{ 2, 104325, "ac8678" }, -- Tyrannical Gladiator's Cloud Serpent
				{ 3, 104326, "ac8705" }, -- Grievous Gladiator's Cloud Serpent
				{ 4, 104327, "ac8707" }, -- Prideful Gladiator's Cloud Serpent
			},
		},
	},
}

data["ArenaS12PvP"] = {
	name = format(AL["Season %s"], "12"),
	ContentType = ARENA_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	items = {
		{
			name = AL["Sets"],
			TableType = SET_ITTYPE,
			[SET1_DIFF] = {
				{ 1, 50011117 }, -- Warlock
				{ 3, 50011112 }, -- Priest Healing
				{ 4, 50011146 }, -- Priest Shadow
				{ 6, 50011113 }, -- Rogue
				{ 8, 50011108 }, -- Hunter
				{ 10, 50011118 }, -- Warrior Melee
				{ 13, 50011104 }, -- Death Knight Melee
				{ 16, 50011109 }, -- Mage
				{ 18, 50011105 }, -- Druid Resto
				{ 19, 50011107 }, -- Druid Balance
				{ 20, 50011106 }, -- Druid Feral
				{ 22, 50011114 }, -- Shaman Resto
				{ 23, 50011116 }, -- Shaman Elemental
				{ 24, 50011115 }, -- Shaman Enhancement
				{ 26, 50011110 }, -- Paladin Holy
				{ 27, 50011111 }, -- Paladin Melee
				{ 29, 50011119 }, -- Monk (Copperskin)
				{ 30, 50011120 }, -- Monk (Ironskin)
			},
			[SET2_DIFF] = {
				{ 1, 50031117 }, -- Warlock
				{ 3, 50031112 }, -- Priest Healing
				{ 4, 50031146 }, -- Priest Shadow
				{ 6, 50031113 }, -- Rogue
				{ 8, 50031108 }, -- Hunter
				{ 10, 50031118 }, -- Warrior Melee
				{ 13, 50031104 }, -- Death Knight Melee
				{ 16, 50031109 }, -- Mage
				{ 18, 50031105 }, -- Druid Resto
				{ 19, 50031107 }, -- Druid Balance
				{ 20, 50031106 }, -- Druid Feral
				{ 22, 50031114 }, -- Shaman Resto
				{ 23, 50031116 }, -- Shaman Elemental
				{ 24, 50031115 }, -- Shaman Enhancement
				{ 26, 50031110 }, -- Paladin Holy
				{ 27, 50031111 }, -- Paladin Melee
				{ 29, 50031119 }, -- Monk (Copperskin)
				{ 30, 50031120 }, -- Monk (Ironskin)
			},
			[SET2_ELITE_DIFF] = {
				{ 1, 50041117 }, -- Warlock
				{ 3, 50041112 }, -- Priest Healing
				{ 4, 50041146 }, -- Priest Shadow
				{ 6, 50041113 }, -- Rogue
				{ 8, 50041108 }, -- Hunter
				{ 10, 50041118 }, -- Warrior Melee
				{ 13, 50041104 }, -- Death Knight Melee
				{ 16, 50041109 }, -- Mage
				{ 18, 50041105 }, -- Druid Resto
				{ 19, 50041107 }, -- Druid Balance
				{ 20, 50041106 }, -- Druid Feral
				{ 22, 50041114 }, -- Shaman Resto
				{ 23, 50041116 }, -- Shaman Elemental
				{ 24, 50041115 }, -- Shaman Enhancement
				{ 26, 50041110 }, -- Paladin Holy
				{ 27, 50041111 }, -- Paladin Melee
				{ 29, 50041119 }, -- Monk (Copperskin)
				{ 30, 50041120 }, -- Monk (Ironskin)
			},
		},
		{
			name = AL["Gladiator Mount"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 95041 },
				{ 16, "ac8216" },
			},
		},
	},
}

data["ArenaS13PvP"] = {
	name = format(AL["Season %s"], "13"),
	ContentType = ARENA_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	items = {
		{
			name = AL["Sets"],
			TableType = SET_ITTYPE,
			[SET2_DIFF] = {
				{ 1, 50021117 }, -- Warlock
				{ 3, 50021112 }, -- Priest Healing
				{ 4, 50021146 }, -- Priest Shadow
				{ 6, 50021113 }, -- Rogue
				{ 8, 50021108 }, -- Hunter
				{ 10, 50021118 }, -- Warrior Melee
				{ 13, 50021104 }, -- Death Knight Melee
				{ 16, 50021109 }, -- Mage
				{ 18, 50021105 }, -- Druid Resto
				{ 19, 50021107 }, -- Druid Balance
				{ 20, 50021106 }, -- Druid Feral
				{ 22, 50021114 }, -- Shaman Resto
				{ 23, 50021116 }, -- Shaman Elemental
				{ 24, 50021115 }, -- Shaman Enhancement
				{ 26, 50021110 }, -- Paladin Holy
				{ 27, 50021111 }, -- Paladin Melee
				{ 29, 50021119 }, -- Monk (Copperskin)
				{ 30, 50021120 }, -- Monk (Ironskin)
			},
			[SET3_DIFF] = {
				{ 1, AtlasLoot:GetRetByFaction(50061117, 50051117) }, -- Warlock
				{ 3, AtlasLoot:GetRetByFaction(50061112, 50051112) }, -- Priest Healing
				{ 4, AtlasLoot:GetRetByFaction(50061146, 50051146) }, -- Priest Shadow
				{ 6, AtlasLoot:GetRetByFaction(50061113, 50051113) }, -- Rogue
				{ 8, AtlasLoot:GetRetByFaction(50061108, 50051108) }, -- Hunter
				{ 10, AtlasLoot:GetRetByFaction(50061118, 50051118) }, -- Warrior Melee
				{ 13, AtlasLoot:GetRetByFaction(50061104, 50051104) }, -- Death Knight Melee
				{ 16, AtlasLoot:GetRetByFaction(50061109, 50051109) }, -- Mage
				{ 18, AtlasLoot:GetRetByFaction(50061105, 50051105) }, -- Druid Resto
				{ 19, AtlasLoot:GetRetByFaction(50061107, 50051107) }, -- Druid Balance
				{ 20, AtlasLoot:GetRetByFaction(50061106, 50051106) }, -- Druid Feral
				{ 22, AtlasLoot:GetRetByFaction(50061114, 50051114) }, -- Shaman Resto
				{ 23, AtlasLoot:GetRetByFaction(50061116, 50051116) }, -- Shaman Elemental
				{ 24, AtlasLoot:GetRetByFaction(50061115, 50051115) }, -- Shaman Enhancement
				{ 26, AtlasLoot:GetRetByFaction(50061110, 50051110) }, -- Paladin Holy
				{ 27, AtlasLoot:GetRetByFaction(50061111, 50051111) }, -- Paladin Melee
				{ 29, AtlasLoot:GetRetByFaction(50061119, 50051119) }, -- Monk (Copperskin)
				{ 30, AtlasLoot:GetRetByFaction(50061120, 50051120) }, -- Monk (Ironskin)
			},
			[SET3_ELITE_DIFF] = {
				{ 1, 50071117 }, -- Warlock
				{ 3, 50071112 }, -- Priest Healing
				{ 4, 50071146 }, -- Priest Shadow
				{ 6, 50071113 }, -- Rogue
				{ 8, 50071108 }, -- Hunter
				{ 10, 50071118 }, -- Warrior Melee
				{ 13, 50071104 }, -- Death Knight Melee
				{ 16, 50071109 }, -- Mage
				{ 18, 50071105 }, -- Druid Resto
				{ 19, 50071107 }, -- Druid Balance
				{ 20, 50071106 }, -- Druid Feral
				{ 22, 50071114 }, -- Shaman Resto
				{ 23, 50071116 }, -- Shaman Elemental
				{ 24, 50071115 }, -- Shaman Enhancement
				{ 26, 50071110 }, -- Paladin Holy
				{ 27, 50071111 }, -- Paladin Melee
				{ 29, 50071119 }, -- Monk (Copperskin)
				{ 30, 50071120 }, -- Monk (Ironskin)
			},
		},
		{
			name = AL["Gladiator Mount"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 104325 },
				{ 16, "ac8678" },
			},
		},
	},
}

data["ArenaS14PvP"] = {
	name = format(AL["Season %s"], "14"),
	ContentType = ARENA_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	items = {
		{
			name = AL["Sets"],
			TableType = SET_ITTYPE,
			[SET3_DIFF] = {
				{ 1, AtlasLoot:GetRetByFaction(50091117, 50081117) }, -- Warlock
				{ 3, AtlasLoot:GetRetByFaction(50091112, 50081112) }, -- Priest Healing
				{ 4, AtlasLoot:GetRetByFaction(50091146, 50081146) }, -- Priest Shadow
				{ 6, AtlasLoot:GetRetByFaction(50091113, 50081113) }, -- Rogue
				{ 8, AtlasLoot:GetRetByFaction(50091108, 50081108) }, -- Hunter
				{ 10, AtlasLoot:GetRetByFaction(50091118, 50081118) }, -- Warrior Melee
				{ 13, AtlasLoot:GetRetByFaction(50091104, 50081104) }, -- Death Knight Melee
				{ 16, AtlasLoot:GetRetByFaction(50091109, 50081109) }, -- Mage
				{ 18, AtlasLoot:GetRetByFaction(50091105, 50081105) }, -- Druid Resto
				{ 19, AtlasLoot:GetRetByFaction(50091107, 50081107) }, -- Druid Balance
				{ 20, AtlasLoot:GetRetByFaction(50091106, 50081106) }, -- Druid Feral
				{ 22, AtlasLoot:GetRetByFaction(50091114, 50081114) }, -- Shaman Resto
				{ 23, AtlasLoot:GetRetByFaction(50091116, 50081116) }, -- Shaman Elemental
				{ 24, AtlasLoot:GetRetByFaction(50091115, 50081115) }, -- Shaman Enhancement
				{ 26, AtlasLoot:GetRetByFaction(50091110, 50081110) }, -- Paladin Holy
				{ 27, AtlasLoot:GetRetByFaction(50091111, 50081111) }, -- Paladin Melee
				{ 29, AtlasLoot:GetRetByFaction(50091119, 50081119) }, -- Monk (Copperskin)
				{ 30, AtlasLoot:GetRetByFaction(50091120, 50081120) }, -- Monk (Ironskin)
			},
			[SET4_DIFF] = {
				{ 1, AtlasLoot:GetRetByFaction(50111117, 50101117) }, -- Warlock
				{ 3, AtlasLoot:GetRetByFaction(50111112, 50101112) }, -- Priest Healing
				{ 4, AtlasLoot:GetRetByFaction(50111146, 50101146) }, -- Priest Shadow
				{ 6, AtlasLoot:GetRetByFaction(50111113, 50101113) }, -- Rogue
				{ 8, AtlasLoot:GetRetByFaction(50111108, 50101108) }, -- Hunter
				{ 10, AtlasLoot:GetRetByFaction(50111118, 50101118) }, -- Warrior Melee
				{ 13, AtlasLoot:GetRetByFaction(50111104, 50101104) }, -- Death Knight Melee
				{ 16, AtlasLoot:GetRetByFaction(50111109, 50101109) }, -- Mage
				{ 18, AtlasLoot:GetRetByFaction(50111105, 50101105) }, -- Druid Resto
				{ 19, AtlasLoot:GetRetByFaction(50111107, 50101107) }, -- Druid Balance
				{ 20, AtlasLoot:GetRetByFaction(50111106, 50101106) }, -- Druid Feral
				{ 22, AtlasLoot:GetRetByFaction(50111114, 50101114) }, -- Shaman Resto
				{ 23, AtlasLoot:GetRetByFaction(50111116, 50101116) }, -- Shaman Elemental
				{ 24, AtlasLoot:GetRetByFaction(50111115, 50101115) }, -- Shaman Enhancement
				{ 26, AtlasLoot:GetRetByFaction(50111110, 50101110) }, -- Paladin Holy
				{ 27, AtlasLoot:GetRetByFaction(50111111, 50101111) }, -- Paladin Melee
				{ 29, AtlasLoot:GetRetByFaction(50111119, 50101119) }, -- Monk (Copperskin)
				{ 30, AtlasLoot:GetRetByFaction(50111120, 50101120) }, -- Monk (Ironskin)
			},
		},
		{
			name = AL["Gladiator Mount"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 104326 },
				{ 16, "ac8705" },
			},
		},
	},
}

data["ArenaS15PvP"] = {
	name = format(AL["Season %s"], "15"),
	ContentType = ARENA_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	items = {
		{
			name = AL["Sets"],
			TableType = SET_ITTYPE,
			[SET4_DIFF] = {
				{ 1, AtlasLoot:GetRetByFaction(50121117, 50131117) }, -- Warlock
				{ 3, AtlasLoot:GetRetByFaction(50121112, 50131112) }, -- Priest Healing
				{ 4, AtlasLoot:GetRetByFaction(50121146, 50131146) }, -- Priest Shadow
				{ 6, AtlasLoot:GetRetByFaction(50121113, 50131113) }, -- Rogue
				{ 8, AtlasLoot:GetRetByFaction(50121108, 50131108) }, -- Hunter
				{ 10, AtlasLoot:GetRetByFaction(50121118, 50131118) }, -- Warrior Melee
				{ 13, AtlasLoot:GetRetByFaction(50121104, 50131104) }, -- Death Knight Melee
				{ 16, AtlasLoot:GetRetByFaction(50121109, 50131109) }, -- Mage
				{ 18, AtlasLoot:GetRetByFaction(50121105, 50131105) }, -- Druid Resto
				{ 19, AtlasLoot:GetRetByFaction(50121107, 50131107) }, -- Druid Balance
				{ 20, AtlasLoot:GetRetByFaction(50121106, 50131106) }, -- Druid Feral
				{ 22, AtlasLoot:GetRetByFaction(50121114, 50131114) }, -- Shaman Resto
				{ 23, AtlasLoot:GetRetByFaction(50121116, 50131116) }, -- Shaman Elemental
				{ 24, AtlasLoot:GetRetByFaction(50121115, 50131115) }, -- Shaman Enhancement
				{ 26, AtlasLoot:GetRetByFaction(50121110, 50131110) }, -- Paladin Holy
				{ 27, AtlasLoot:GetRetByFaction(50121111, 50131111) }, -- Paladin Melee
				{ 29, AtlasLoot:GetRetByFaction(50121119, 50131119) }, -- Monk (Copperskin)
				{ 30, AtlasLoot:GetRetByFaction(50121120, 50131120) }, -- Monk (Ironskin)
			},
			[SET5_DIFF] = {
				{ 1, AtlasLoot:GetRetByFaction(50151117, 50141117) }, -- Warlock
				{ 3, AtlasLoot:GetRetByFaction(50151112, 50141112) }, -- Priest Healing
				{ 4, AtlasLoot:GetRetByFaction(50151146, 50141146) }, -- Priest Shadow
				{ 6, AtlasLoot:GetRetByFaction(50151113, 50141113) }, -- Rogue
				{ 8, AtlasLoot:GetRetByFaction(50151108, 50141108) }, -- Hunter
				{ 10, AtlasLoot:GetRetByFaction(50151118, 50141118) }, -- Warrior Melee
				{ 13, AtlasLoot:GetRetByFaction(50151104, 50141104) }, -- Death Knight Melee
				{ 16, AtlasLoot:GetRetByFaction(50151109, 50141109) }, -- Mage
				{ 18, AtlasLoot:GetRetByFaction(50151105, 50141105) }, -- Druid Resto
				{ 19, AtlasLoot:GetRetByFaction(50151107, 50141107) }, -- Druid Balance
				{ 20, AtlasLoot:GetRetByFaction(50151106, 50141106) }, -- Druid Feral
				{ 22, AtlasLoot:GetRetByFaction(50151114, 50141114) }, -- Shaman Resto
				{ 23, AtlasLoot:GetRetByFaction(50151116, 50141116) }, -- Shaman Elemental
				{ 24, AtlasLoot:GetRetByFaction(50151115, 50141115) }, -- Shaman Enhancement
				{ 26, AtlasLoot:GetRetByFaction(50151110, 50141110) }, -- Paladin Holy
				{ 27, AtlasLoot:GetRetByFaction(50151111, 50141111) }, -- Paladin Melee
				{ 29, AtlasLoot:GetRetByFaction(50151119, 50141119) }, -- Monk (Copperskin)
				{ 30, AtlasLoot:GetRetByFaction(50151120, 50141120) }, -- Monk (Ironskin)
			},
		},
		{
			name = AL["Gladiator Mount"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 104327 },
				{ 16, "ac8707" },
			},
		},
	},
}
