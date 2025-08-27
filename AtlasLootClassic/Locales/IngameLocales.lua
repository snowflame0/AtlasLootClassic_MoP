-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select = _G.select
local string = _G.string
local format = string.format
local rawget = _G.rawget

-- WoW
-- TODO: Fix name of new function bindings
local GetSpellName, GetItemInfo = C_Spell.GetSpellName, C_Item.GetItemInfo
local GetItemClassInfo, GetItemSubClassInfo = C_Item.GetItemClassInfo, C_Item.GetItemSubClassInfo
local GetDifficultyInfo, GetCurrencyInfo = GetDifficultyInfo, C_CurrencyInfo.GetCurrencyInfo

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname = ...
local AtlasLoot = _G.AtlasLoot

local _, tmp1
local months = {
	MONTH_JANUARY,
	MONTH_FEBRUARY,
	MONTH_MARCH,
	MONTH_APRIL,
	MONTH_MAY,
	MONTH_JUNE,
	MONTH_JULY,
	MONTH_AUGUST,
	MONTH_SEPTEMBER,
	MONTH_OCTOBER,
	MONTH_NOVEMBER,
	MONTH_DECEMBER,
}

local GLOBAL = setmetatable({}, {__index = function(t,k) return _G[k] or k end})
local GetMapNameByID = C_Map.GetMapInfo

local function AtlasLootGLOBALetClassName(class)
	if (not LOCALIZED_CLASS_NAMES_MALE[class]) then
		return nil;
	end
	if (UnitSex("player") == "3") then
		return LOCALIZED_CLASS_NAMES_FEMALE[class];
	else
		return LOCALIZED_CLASS_NAMES_MALE[class];
	end
end

local function GetLocRepStanding(id)
	if (id > 10) then
		return FACTION_STANDING_LABEL4_FEMALE
	else
		return UnitSex("player")==3 and GLOBAL["FACTION_STANDING_LABEL"..(id or 4).."_FEMALE"] or GLOBAL["FACTION_STANDING_LABEL"..(id or 4)]
	end
end

local function GetCurrencyName(currencyID)
	return GetCurrencyInfo(currencyID)['name']
end

local IngameLocales = {
	-- ######################################################################
	-- Faction standing
	-- ######################################################################
	["Hated"] = GetLocRepStanding(1),
	["Hostile"] = GetLocRepStanding(2),
	["Unfriendly"] = GetLocRepStanding(3),
	["Neutral"] = GetLocRepStanding(4),
	["Friendly"] = GetLocRepStanding(5),
	["Honored"] = GetLocRepStanding(6),
	["Revered"] = GetLocRepStanding(7),
	["Exalted"] = GetLocRepStanding(8),

	-- ######################################################################
	-- Professions
	-- ######################################################################
	["Professions"] = GLOBAL["TRADE_SKILLS"],
	["First Aid"] = GetSpellName(3273),
	["Blacksmithing"] = GetSpellName(2018),
	["Leatherworking"] = GetSpellName(2108),
	["Alchemy"] = GetSpellName(2259),
	["Herbalism"] = GetSpellName(2366),
	["Cooking"] = GetSpellName(2550),
	["Mining"] = GetSpellName(2575),
	["Tailoring"] = GetSpellName(3908),
	["Engineering"] = GetSpellName(4036),
	["Enchanting"] = GetSpellName(7411),
	["Fishing"] = GetSpellName(7732),
	["Skinning"] = GetSpellName(8618),
	["Poisons"] = GetSpellName(2842),
	["Jewelcrafting"] = GetSpellName(353970) or UNKNOWN,
	["Inscription"] = GetSpellName(45357) or UNKNOWN,
	["Archaeology"] = GetSpellName(78670) or UNKNOWN,

	-- Sub Professions
	["Armorsmith"] = GetSpellName(9788),
	["Weaponsmith"] = GetSpellName(9787),
	["Hammersmith"] = GetSpellName(17041),
	["Axesmith"] = GetSpellName(17041),
	["Swordsmith"] = GetSpellName(17039),
	["Gnomish Engineer"] = GetSpellName(20220),

	-- MoP Cooking
	["Way of the Brew"] = GetSpellName(125589),
	["Way of the Grill"] = GetSpellName(124694),
	["Way of the Oven"] = GetSpellName(125588),
	["Way of the Pot"] = GetSpellName(125586),
	["Way of the Steamer"] = GetSpellName(125587),
	["Way of the Wok"] = GetSpellName(125584),

	-- glyphs
	["Minor Glyph"] = GLOBAL["MINOR_GLYPH"],
	["Minor Glyphs"] = GLOBAL["MINOR_GLYPHS"],
	["Major Glyph"] = GLOBAL["MAJOR_GLYPH"],
	["Major Glyphs"] = GLOBAL["MAJOR_GLYPHS"],
	["Prime Glyph"] = GLOBAL["PRIME_GLYPH"],
	["Prime Glyphs"] = GLOBAL["PRIME_GLYPHS"],


	-- ######################################################################
	-- Months
	-- ######################################################################
	["January"] = months[1],
	["February"] = months[2],
	["March"] = months[3],
	["April"] = months[4],
	["May"] = months[5],
	["June"] = months[6],
	["July"] = months[7],
	["August"] = months[8],
	["September"] = months[9],
	["October"] = months[10],
	["November"] = months[11],
	["December"] = months[12],

	-- ######################################################################
	-- Armor Classes
	-- ######################################################################
	["Cloth"] = GetItemSubClassInfo(4,1),
	["Leather"] = GetItemSubClassInfo(4,2),
	["Mail"] = GetItemSubClassInfo(4,3),
	["Plate"] = GetItemSubClassInfo(4,4),
	["Bucklers"] = GetItemSubClassInfo(4,5),
	["Shields"] = GetItemSubClassInfo(4,6),
	["Librams"] = GetItemSubClassInfo(4,7),
	["Idols"] = GetItemSubClassInfo(4,8),
	["Totems"] = GetItemSubClassInfo(4,9),

	-- ######################################################################
	-- Stats
	-- ######################################################################
	["Mana"] = GLOBAL["ITEM_MOD_MANA_SHORT"],
	["Health"] = GLOBAL["ITEM_MOD_HEALTH_SHORT"],
	["Agility"] = GLOBAL["ITEM_MOD_AGILITY_SHORT"],
	["Strength"] = GLOBAL["ITEM_MOD_STRENGTH_SHORT"],
	["Intellect"] = GLOBAL["ITEM_MOD_INTELLECT_SHORT"],
	["Spirit"] = GLOBAL["ITEM_MOD_SPIRIT_SHORT"],
	["Stamina"] = GLOBAL["ITEM_MOD_STAMINA_SHORT"],
	["Happiness Per 5 Sec."] = GLOBAL["ITEM_MOD_POWER_REGEN4_SHORT"],
	["Hit"] = GLOBAL["ITEM_MOD_HIT_RATING_SHORT"],
	["PvP Resilience"] = GLOBAL["ITEM_MOD_RESILIENCE_RATING_SHORT"],
	["Bonus Healing"] = GLOBAL["ITEM_MOD_SPELL_HEALING_DONE_SHORT"],
	["Critical Strike"] = GLOBAL["ITEM_MOD_CRIT_RATING_SHORT"],
	["Armor Penetration"] = GLOBAL["ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT"],
	["Critical Strike (Spell)"] = GLOBAL["ITEM_MOD_CRIT_SPELL_RATING_SHORT"],
	["Critical Strike (Melee)"] = GLOBAL["ITEM_MOD_CRIT_MELEE_RATING_SHORT"],
	["Runic Power Per 5 Sec."] = GLOBAL["ITEM_MOD_POWER_REGEN6_SHORT"],
	["Hit Avoidance (Spell)"] = GLOBAL["ITEM_MOD_HIT_TAKEN_SPELL_RATING_SHORT"],
	["Energy Per 5 Sec."] = GLOBAL["ITEM_MOD_POWER_REGEN3_SHORT"],
	["Health Per 5 Sec."] = GLOBAL["ITEM_MOD_HEALTH_REGEN_SHORT"],
	["Expertise"] = GLOBAL["ITEM_MOD_EXPERTISE_RATING_SHORT"],
	["Parry"] = GLOBAL["ITEM_MOD_PARRY_RATING_SHORT"],
	["Critical Strike Avoidance"] = GLOBAL["ITEM_MOD_CRIT_TAKEN_RATING_SHORT"],
	["Hit (Spell)"] = GLOBAL["ITEM_MOD_HIT_SPELL_RATING_SHORT"],
	["Block"] = GLOBAL["ITEM_MOD_BLOCK_RATING_SHORT"],
	["Defense"] = GLOBAL["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"],
	["Damage Per Second"] = GLOBAL["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"],
	["Hit Avoidance (Melee)"] = GLOBAL["ITEM_MOD_HIT_TAKEN_MELEE_RATING_SHORT"],
	["Rage Per 5 Sec."] = GLOBAL["ITEM_MOD_POWER_REGEN1_SHORT"],
	["Hit (Ranged)"] = GLOBAL["ITEM_MOD_HIT_RANGED_RATING_SHORT"],
	["Critical Strike Avoidance (Spell)"] = GLOBAL["ITEM_MOD_CRIT_TAKEN_SPELL_RATING_SHORT"],
	["Mana Regeneration"] = GLOBAL["ITEM_MOD_MANA_REGENERATION_SHORT"],
	["Melee Attack Power"] = GLOBAL["ITEM_MOD_MELEE_ATTACK_POWER_SHORT"],
	["Hit Avoidance (Ranged)"] = GLOBAL["ITEM_MOD_HIT_TAKEN_RANGED_RATING_SHORT"],
	["Focus Per 5 Sec."] = GLOBAL["ITEM_MOD_POWER_REGEN2_SHORT"],
	["Mana Per 5 Sec."] = GLOBAL["ITEM_MOD_POWER_REGEN0_SHORT"],
	["PvP Power"] = GLOBAL["ITEM_MOD_PVP_POWER_SHORT"],
	["Critical Strike Avoidance (Ranged)"] = GLOBAL["ITEM_MOD_CRIT_TAKEN_RANGED_RATING_SHORT"],
	["Block Value"] = GLOBAL["ITEM_MOD_BLOCK_VALUE_SHORT"],
	["Haste"] = GLOBAL["ITEM_MOD_HASTE_RATING_SHORT"],
	["Critical Strike (Ranged)"] = GLOBAL["ITEM_MOD_CRIT_RANGED_RATING_SHORT"],
	["Bonus Damage"] = GLOBAL["ITEM_MOD_SPELL_DAMAGE_DONE_SHORT"],
	["Ranged Attack Power"] = GLOBAL["ITEM_MOD_RANGED_ATTACK_POWER_SHORT"],
	["Attack Power In Forms"] = GLOBAL["ITEM_MOD_FERAL_ATTACK_POWER_SHORT"],
	["Spell Power"] = GLOBAL["ITEM_MOD_SPELL_POWER_SHORT"],
	["Hit Avoidance"] = GLOBAL["ITEM_MOD_HIT_TAKEN_RATING_SHORT"],
	["Critical Strike Avoidance (Melee)"] = GLOBAL["ITEM_MOD_CRIT_TAKEN_MELEE_RATING_SHORT"],
	["Runes Per 5 Sec."] = GLOBAL["ITEM_MOD_POWER_REGEN5_SHORT"],
	["Hit (Melee)"] = GLOBAL["ITEM_MOD_HIT_MELEE_RATING_SHORT"],
	["Dodge"] = GLOBAL["ITEM_MOD_DODGE_RATING_SHORT"],
	["Attack Power"] = GLOBAL["ITEM_MOD_ATTACK_POWER_SHORT"],
	["Armor Penetration Rating"] = GLOBAL["ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT"],
	["Mastery"] = GLOBAL["ITEM_MOD_MASTERY_RATING_SHORT"],

	-- ######################################################################
	-- Slots
	-- ######################################################################
	["Weapon"] = GLOBAL["ENCHSLOT_WEAPON"],
	["2H Weapon"] = GLOBAL["ENCHSLOT_2HWEAPON"],
	["Weapons"] = GLOBAL["WEAPONS"],
	["Armor"] = GLOBAL["ARMOR"],
	["Shield"] = GLOBAL["SHIELDSLOT"],
	["Wrist"] = GLOBAL["INVTYPE_WRIST"],
	["Trinket"]	= GLOBAL["INVTYPE_TRINKET"],
	["Robe"] = GLOBAL["INVTYPE_ROBE"],
	["Cloak"] = GLOBAL["INVTYPE_CLOAK"],
	["Head"] = GLOBAL["INVTYPE_HEAD"],
	["Holdable"] = GLOBAL["INVTYPE_HOLDABLE"],
	["Chest"] = GLOBAL["INVTYPE_CHEST"],
	["Neck"] = GLOBAL["INVTYPE_NECK"],
	["Tabard"] = GLOBAL["INVTYPE_TABARD"],
	["Legs"] = GLOBAL["INVTYPE_LEGS"],
	["Hand"] = GLOBAL["INVTYPE_HAND"],
	["Waist"] = GLOBAL["INVTYPE_WAIST"],
	["Feet"] = GLOBAL["INVTYPE_FEET"],
	["Shoulder"] = GLOBAL["INVTYPE_SHOULDER"],
	["Finger"] = GLOBAL["INVTYPE_FINGER"],
	["Bag"] = GLOBAL["INVTYPE_BAG"],
	["Ammo"] = GLOBAL["INVTYPE_AMMO"],
	["Body"] = GLOBAL["INVTYPE_BODY"], -- Shirt
	["Quiver"] = GLOBAL["INVTYPE_QUIVER"],
	["Relic"] = GLOBAL["INVTYPE_RELIC"],
	["Thrown"] = GLOBAL["INVTYPE_THROWN"],
	["Main Hand"] = GLOBAL["INVTYPE_WEAPONMAINHAND"],
	["Main Attack"]	= GLOBAL["INVTYPE_WEAPONMAINHAND_PET"],	-- "Main Attack"
	["Off Hand"] = GLOBAL["INVTYPE_WEAPONOFFHAND"],
	-- GetItemSubClassInfo(iC,isC)
	["One-Handed Axes"] = GetItemSubClassInfo(2,0),
	["Two-Handed Axes"] = GetItemSubClassInfo(2,1),
	["Bows"] = GetItemSubClassInfo(2,2),
	["Guns"] = GetItemSubClassInfo(2,3),
	["One-Handed Maces"] = GetItemSubClassInfo(2,4),
	["Two-Handed Maces"] = GetItemSubClassInfo(2,5),
	["Polearms"] = GetItemSubClassInfo(2,6),
	["One-Handed Swords"] = GetItemSubClassInfo(2,7),
	["Two-Handed Swords"] = GetItemSubClassInfo(2,8),
	--["Obsolete"] = GetItemSubClassInfo(2,9),
	["Staves"] = GetItemSubClassInfo(2,10),
	["One-Handed Exotics"] = GetItemSubClassInfo(2,11),
	["Two-Handed Exotics"] = GetItemSubClassInfo(2,12),
	["Fist Weapons"] = GetItemSubClassInfo(2,13),
	--["Miscellaneous"] = GetItemSubClassInfo(2,14),
	["Daggers"] = GetItemSubClassInfo(2,15),
	--["Thrown"] = GetItemSubClassInfo(2,16),
	["Spears"] = GetItemSubClassInfo(2,17),
	["Crossbows"] = GetItemSubClassInfo(2,18),
	["Wands"] = GetItemSubClassInfo(2,19),
	["Fishing Pole"] = GetItemSubClassInfo(2,20),
	["Parts"] = GetItemSubClassInfo(7,1),
	["Projectile"] = GetItemClassInfo(6),
	["Bullet"] = GetItemSubClassInfo(6,3),
	["Explosives"] = GetItemSubClassInfo(7,2),

	-- ######################################################################
	-- Gems
	-- ######################################################################
	["Socket Gems"]	 	= AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM, GLOBAL["SOCKET_GEMS"], GLOBAL["SOCKETGLOBALEMS"]),
	["Gems"]			= AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM, GLOBAL["AUCTION_CATEGORY_GEMS"], GLOBAL["AUCTION_CATEGORYGLOBALEMS"]),
	["Meta"]	 		= AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM, GLOBAL["META_GEM"], GLOBAL["METAGLOBALEM"]),
	["Red"]	 			= AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM, GLOBAL["RED_GEM"], GLOBAL["REDGLOBALEM"]),
	["Yellow"]	 		= AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM, GLOBAL["YELLOW_GEM"], GLOBAL["YELLOWGLOBALEM"]),
	["Blue"]	 		= AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM, GLOBAL["BLUE_GEM"], GLOBAL["BLUEGLOBALEM"]),
	-- ######################################################################
	-- Zones
	-- ######################################################################
	-- Classic

	-- ######################################################################
	-- Class
	-- ######################################################################
	["DRUID"] 		= AtlasLootGLOBALetClassName("DRUID"),
	["HUNTER"] 		= AtlasLootGLOBALetClassName("HUNTER"),
	["MAGE"] 		= AtlasLootGLOBALetClassName("MAGE"),
	["PALADIN"] 	= AtlasLootGLOBALetClassName("PALADIN"),
	["PRIEST"] 		= AtlasLootGLOBALetClassName("PRIEST"),
	["ROGUE"] 		= AtlasLootGLOBALetClassName("ROGUE"),
	["SHAMAN"] 		= AtlasLootGLOBALetClassName("SHAMAN"),
	["WARLOCK"] 	= AtlasLootGLOBALetClassName("WARLOCK"),
	["WARRIOR"] 	= AtlasLootGLOBALetClassName("WARRIOR"),
	["DEATHKNIGHT"] = AtlasLootGLOBALetClassName("DEATHKNIGHT"),
	["MONK"] 		= AtlasLootGLOBALetClassName("MONK"),

	-- ######################################################################
	-- Item Quality
	-- ######################################################################
	["Poor"]	 	= GLOBAL["ITEM_QUALITY0_DESC"],
	["Common"] 		= GLOBAL["ITEM_QUALITY1_DESC"],
	["Uncommon"] 	= GLOBAL["ITEM_QUALITY2_DESC"],
	["Rare"] 		= GLOBAL["ITEM_QUALITY3_DESC"],
	["Epic"]		= GLOBAL["ITEM_QUALITY4_DESC"],
	["Legendary"] 	= GLOBAL["ITEM_QUALITY5_DESC"],
	["Artifact"] 	= GLOBAL["ITEM_QUALITY6_DESC"],
	["Heirloom"] 	= GLOBAL["ITEM_QUALITY7_DESC"],

	-- ######################################################################
	-- Difficulties
	-- ######################################################################
	["Normal"]			= GetDifficultyInfo(1),
	["Heroic"]			= GetDifficultyInfo(2),
	["10 Raid"]			= GetDifficultyInfo(3),
	["25 Raid"]     	= GetDifficultyInfo(4),
	["10 Raid Heroic"]  = GetDifficultyInfo(5),
	["25 Raid Heroic"]  = GetDifficultyInfo(6),
	["Challenge Mode"]  = GetDifficultyInfo(8),
	["40 Raid"]     	= GetDifficultyInfo(7),
	["Normal Scenario"] = GetDifficultyInfo(12),
	["Flexible"]		= GetDifficultyInfo(14),
	["20 Raid"]     	= GetDifficultyInfo(148),
	["Celestial"]     	= GetDifficultyInfo(237),

	-- ######################################################################
	-- Currencies
	-- ######################################################################
	["Justice Points"]			= GetCurrencyName(395),
	["Valor Points"]			= GetCurrencyName(396),
	["Ironpaw Token"]			= GetCurrencyName(402),
	["Sidereal Essence"] 		= GetCurrencyName(2589),
	["Defiler's Scourgestone"] 	= GetCurrencyName(2711),
	["Fissure Stone Fragment"] 	= GetCurrencyName(3148),
	["Obsidian Fragment"] 		= GetCurrencyName(3281),
	["August Stone Fragment"] 	= GetCurrencyName(3350),
	["Spirit of Harmony"] 		= GetItemInfo(76061),

	-- ######################################################################
	-- Misc
	-- ######################################################################
	["Food"] = GLOBAL["POWER_TYPE_FOOD"],
	["Special"] = GLOBAL["SPECIAL"],
	["Mounts"] = GLOBAL["MOUNTS"],
	["Mount"] = GLOBAL["MOUNT"],
	["Pet"] = GLOBAL["PET"],
	["Pets"] = GLOBAL["PETS"],
	["Default"] = GLOBAL["DEFAULT"],
	["Settings"] = GLOBAL["SETTINGS"],
	["Dressing Room"] = GLOBAL["DRESSUP_FRAME"],
	["Quest Item"] = GLOBAL["ITEM_BIND_QUEST"],
	["Collected"] = GLOBAL["COLLECTED"],
	["Not Collected"] = GLOBAL["NOT_COLLECTED"],
	["Achievements"] = GLOBAL["ACHIEVEMENTS"],
	["Companions"] = GLOBAL["COMPANIONS"],
	["Currency"] = GLOBAL["CURRENCY"],

	-- ######################################################################
	-- Rares
	-- ######################################################################
	--- Mists of Pandaria - Pandaria: Glorious!
	["Aethis"] = GetAchievementCriteriaInfo(7439,8),
	["Ahone the Wanderer"] = GetAchievementCriteriaInfo(7439,39),
	["Ai-Li Skymirror"] = GetAchievementCriteriaInfo(7439,41),
	["Ai-Ran the Shifting Cloud"] = GetAchievementCriteriaInfo(7439,42),
	["Arness the Scale"] = GetAchievementCriteriaInfo(7439,45),
	["Blackhoof"] = GetAchievementCriteriaInfo(7439,51),
	["Bonobos"] = GetAchievementCriteriaInfo(7439,2),
	["Borginn Darkfist"] = GetAchievementCriteriaInfo(7439,25),
	["Cournith Waterstrider"] = GetAchievementCriteriaInfo(7439,10),
	["Dak the Breaker"] = GetAchievementCriteriaInfo(7439,55),
	["Eshelon"] = GetAchievementCriteriaInfo(7439,12),
	["Ferdinand"] = GetAchievementCriteriaInfo(7439,50),
	["Gaarn the Toxic"] = GetAchievementCriteriaInfo(7439,24),
	["Gar'lok"] = GetAchievementCriteriaInfo(7439,20),
	["Go-Kan"] = GetAchievementCriteriaInfo(7439,52),
	["Havak"] = GetAchievementCriteriaInfo(7439,32),
	["Ik-Ik the Nimble"] = GetAchievementCriteriaInfo(7439,6),
	["Jonn-Dar"] = GetAchievementCriteriaInfo(7439,30),
	["Kah'tir"] = GetAchievementCriteriaInfo(7439,33),
	["Kal'tik the Blight"] = GetAchievementCriteriaInfo(7439,21),
	["Kang the Soul Thief"] = GetAchievementCriteriaInfo(7439,28),
	["Karr the Darkener"] = GetAchievementCriteriaInfo(7439,27),
	["Kor'nas Nightsavage"] = GetAchievementCriteriaInfo(7439,22),
	["Korda Torros"] = GetAchievementCriteriaInfo(7439,53),
	["Krax'ik"] = GetAchievementCriteriaInfo(7439,15),
	["Krol the Blade"] = GetAchievementCriteriaInfo(7439,34),
	["Lith'ik the Stalker"] = GetAchievementCriteriaInfo(7439,19),
	["Lon the Bull"] = GetAchievementCriteriaInfo(7439,54),
	["Major Nanners"] = GetAchievementCriteriaInfo(7439,7),
	["Mister Ferocious"] = GetAchievementCriteriaInfo(7439,1),
	["Moldo One-Eye"] = GetAchievementCriteriaInfo(7439,49),
	["Morgrinn Crackfang"] = GetAchievementCriteriaInfo(7439,29),
	["Nal'lak the Ripper"] = GetAchievementCriteriaInfo(7439,16),
	["Nalash Verdantis"] = GetAchievementCriteriaInfo(7439,13),
	["Nasra Spothide"] = GetAchievementCriteriaInfo(7439,37),
	["Nessos the Oracle"] = GetAchievementCriteriaInfo(7439,46),
	["Norlaxx"] = GetAchievementCriteriaInfo(7439,26),
	["Omnis Grinlok"] = GetAchievementCriteriaInfo(7439,48),
	["Qu'nas"] = GetAchievementCriteriaInfo(7439,31),
	["Ruun Ghostpaw"] = GetAchievementCriteriaInfo(7439,38),
	["Sahn Tidehunter"] = GetAchievementCriteriaInfo(7439,14),
	["Salyin Warscout"] = GetAchievementCriteriaInfo(7439,44),
	["Sarnak"] = GetAchievementCriteriaInfo(7439,43),
	["Scritch"] = GetAchievementCriteriaInfo(7439,4),
	["Sele'na"] = GetAchievementCriteriaInfo(7439,9),
	["Siltriss the Sharpener"] = GetAchievementCriteriaInfo(7439,47),
	["Ski'thik"] = GetAchievementCriteriaInfo(7439,18),
	["Spriggin"] = GetAchievementCriteriaInfo(7439,3),
	["Sulik'shor"] = GetAchievementCriteriaInfo(7439,23),
	["The Yowler"] = GetAchievementCriteriaInfo(7439,5),
	["Torik-Ethis"] = GetAchievementCriteriaInfo(7439,17),
	["Urgolax"] = GetAchievementCriteriaInfo(7439,35),
	["Urobi the Walker"] = GetAchievementCriteriaInfo(7439,36),
	["Yorik Sharpeye"] = GetAchievementCriteriaInfo(7439,56),
	["Yul Wildpaw"] = GetAchievementCriteriaInfo(7439,40),
	["Zai the Outcast"] = GetAchievementCriteriaInfo(7439,11),

	--- Mists of Pandaria - Isle of Thunder: Champions of Lei Shen
	["Haywire Sunreaver Construct"] = GetAchievementCriteriaInfo(8103,1),

	--- Mists of Pandaria - Isle of Thunder: It Was Worth Every Ritual Stone
	["Ancient Mogu Guardian"] = GetAchievementCriteriaInfo(8101,6),
	["Cera"] = GetAchievementCriteriaInfo(8101,8),
	["Echo of Kros"] = GetAchievementCriteriaInfo(8101,3),
	["Electromancer Ju'le"] = GetAchievementCriteriaInfo(8101,4),
	["Incomplete Drakkari Colossus"] = GetAchievementCriteriaInfo(8101,9),
	["Kor'dok and Tinzo the Emberkeeper"] = GetAchievementCriteriaInfo(8101,2),
	["Qi'nor"] = GetAchievementCriteriaInfo(8101,5),
	["Spirit of Warlord Teng"] = GetAchievementCriteriaInfo(8101,1),
	["Windweaver Akil'amon"] = GetAchievementCriteriaInfo(8101,7),

	--- Mists of Pandaria - Timeless Isle: Eyes On The Ground
	["Crane Nest"] = GetAchievementCriteriaInfo(8725,3),

	--- Mists of Pandaria - Timeless Isle: Killing Time
	["Ashleaf Sprite"] = GetAchievementCriteriaInfo(8712,11),
	["Burning Berserker"] = GetAchievementCriteriaInfo(8712,25),
	["Crag Stalker"] = GetAchievementCriteriaInfo(8712,10),
	["Damp Shambler"] = GetAchievementCriteriaInfo(8712,18),
	["Eternal Kilnmaster"] = GetAchievementCriteriaInfo(8712,31),
	["Foreboding Flame"] = GetAchievementCriteriaInfo(8712,13),
	["Gulp Frog"] = GetAchievementCriteriaInfo(8712,21),
	["Jademist Dancer"] = GetAchievementCriteriaInfo(8712,14),
	["Molten Guardian"] = GetAchievementCriteriaInfo(8712,26),
	["Ordon Candlekeeper"] = GetAchievementCriteriaInfo(8712,12),
	["Ordon Oathguard"] = GetAchievementCriteriaInfo(8712,24),
	["Primal Stalker"] = GetAchievementCriteriaInfo(8712,19),
	["Windfeather Nestkeeper"] = GetAchievementCriteriaInfo(8712,5),

	--- Mists of Pandaria - Timeless Isle: Timeless Champion
	["Archiereus of Flame"] = GetAchievementCriteriaInfo(8714,31),
	["Bufo"] = GetAchievementCriteriaInfo(8714,14),
	["Champion of the Black Flame"] = GetAchievementCriteriaInfo(8714,23),
	["Chelon"] = GetAchievementCriteriaInfo(8714,8),
	["Cinderfall"] = GetAchievementCriteriaInfo(8714,24),
	["Cranegnasher"] = GetAchievementCriteriaInfo(8714,10),
	["Dread Ship Vazuvius"] = GetAchievementCriteriaInfo(8714,30),
	["Emerald Gander"] = GetAchievementCriteriaInfo(8714,1),
	["Evermaw"] = GetAchievementCriteriaInfo(8714,29),
	["Flintlord Gairan"] = GetAchievementCriteriaInfo(8714,26),
	["Garnia"] = GetAchievementCriteriaInfo(8714,15),
	["Golganarr"] = GetAchievementCriteriaInfo(8714,28),
	["Great Turtle Furyshell"] = GetAchievementCriteriaInfo(8714,3),
	["Gu'chi the Swarmbringer"] = GetAchievementCriteriaInfo(8714,4),
	["Huolon"] = GetAchievementCriteriaInfo(8714,27),
	["Imperial Python"] = GetAchievementCriteriaInfo(8714,18),
	["Jakur of Ordon"] = GetAchievementCriteriaInfo(8714,22),
	["Karkanos"] = GetAchievementCriteriaInfo(8714,7),
	["Leafmender"] = GetAchievementCriteriaInfo(8714,13),
	["Monstrous Spineclaw"] = GetAchievementCriteriaInfo(8714,17),
	["Rattleskew"] = GetAchievementCriteriaInfo(8714,11),
	["Rock Moss"] = GetAchievementCriteriaInfo(8714,20),
	["Spelurk"] = GetAchievementCriteriaInfo(8714,9),
	["Spirit of Jadefire"] = GetAchievementCriteriaInfo(8714,12),
	["Tsavo'ka"] = GetAchievementCriteriaInfo(8714,16),
	["Urdur the Cauterizer"] = GetAchievementCriteriaInfo(8714,25),
	["Watcher Osu"] = GetAchievementCriteriaInfo(8714,21),
	["Zesqua"] = GetAchievementCriteriaInfo(8714,5),
	["Zhu-Gon the Sour"] = GetAchievementCriteriaInfo(8714,6),

	-- ######################################################################
	-- Zones
	-- ######################################################################
	-- Mists of Pandaria
	-- ["Brawl'gar Arena"] = GetMapNameByID(925), -- already existing as faction
	["Deeprun Tram"] = GetMapNameByID(922),
	["Dread Wastes"] = GetMapNameByID(858),
	["Gate of the Setting Sun"] = GetMapNameByID(875),
	["Heart of Fear"] = GetMapNameByID(897),
	["Isle of Giants"] = GetMapNameByID(929),
	["Isle of Thunder"] = GetMapNameByID(928),
	["Krasarang Wilds"] = GetMapNameByID(857),
	["Kun-Lai Summit"] = GetMapNameByID(809),
	["Mogu'Shan Palace"] = GetMapNameByID(885),
	["Mogu'shan Vaults"] = GetMapNameByID(896),
	["Pandaria"] = GetAchievementCriteriaInfo(46,6),
	["Scarlet Halls"] = GetMapNameByID(871),
	["Scarlet Monastery"] = GetMapNameByID(874),
	["Scholomance"] = GetMapNameByID(898),
	["Shado-pan Monastery"] = GetMapNameByID(877),
	["Siege of Niuzao Temple"] = GetMapNameByID(887),
	["Siege of Orgrimmar"] = GetMapNameByID(953),
	["Stormstout Brewery"] = GetMapNameByID(876),
	["Temple of the Jade Serpent"] = GetMapNameByID(867),
	["Terrace of Endless Spring"] = GetMapNameByID(886),
	["The Jade Forest"] = GetMapNameByID(806),
	["Throne of Thunder"] = GetMapNameByID(930),
	["Timeless Isle"] = GetMapNameByID(951),
	["Townlong Steppes"] = GetMapNameByID(810),
	["Vale of Eternal Blossoms"] = GetMapNameByID(811),
	["Valley of the Four Winds"] = GetMapNameByID(807),
}
AtlasLoot.IngameLocales = IngameLocales

setmetatable(IngameLocales, { __index = function(tab, key) return rawget(tab, key) or key end } )
