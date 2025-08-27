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
                { 1,[ATLASLOOT_IT_ALLIANCE] = 102514, [PRICE_EXTRA_ITTYPE] = "103533:1", [ATLASLOOT_IT_HORDE] = 102533, [PRICE_EXTRA_ITTYPE] = "103533:1" },
                { 2, [ATLASLOOT_IT_ALLIANCE] = 70909, [PRICE_EXTRA_ITTYPE] = "103533:1", [ATLASLOOT_IT_HORDE] = 70910, [PRICE_EXTRA_ITTYPE] = "103533:1" },
                { 16, 95041, "ac8216" }, -- Malevolent Gladiator's Cloud Serpent
                { 17, 104325, "ac8678" }, -- Tyrannical Gladiator's Cloud Serpent
                { 18, 104326, "ac8705" }, -- Grievous Gladiator's Cloud Serpent
                { 19, 104327, "ac8707" }, -- Prideful Gladiator's Cloud Serpent
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
            name = AL["Weapons"] .. " - " .. AL["One-Handed"],
            [SET1_DIFF] = {
                { 1, 84701 }, -- Cleaver
                { 2, 84702 }, -- Hacker
                { 4, 84719 }, -- Bonecracker
                { 5, 84720 }, -- Gavel
                { 6, 84700 }, -- Pummeler
                { 8, 84716 }, -- Quickblade
                { 9, 84710 }, -- Slicer
                { 16, 84708 }, -- Shanker
                { 17, 84695 }, -- Spellblade
                { 19, 84699 }, -- Render
                { 20, 84696 }, -- Ripper
                -- { , 84709 }, -- Shiv
                -- { , 84697 }, -- Fleshslicer
                -- { , 84698 }, -- Slasher
            },
            [SET2_DIFF] = {
                { 1, 84965 }, -- Cleaver
                { 2, 84966 }, -- Hacker
                { 4, 84970 }, -- Bonecracker
                { 5, 84971 }, -- Gavel
                { 6, 84964 }, -- Pummeler
                { 8, 84969 }, -- Quickblade
                { 9, 84968 }, -- Slicer
                { 16, 84967 }, -- Shanker
                { 17, 84961 }, -- Spellblade
                { 19, 84963 }, -- Render
                { 20, 84962 }, -- Ripper
                -- { , 84893 }, -- Fleshslicer
                -- { , 84894 }, -- Slasher
            },
            [SET2_ELITE_DIFF] = {
                { 1, 85131 }, -- Cleaver
                { 2, 85132 }, -- Hacker
                { 4, 85136 }, -- Bonecracker
                { 5, 85137 }, -- Gavel
                { 6, 85130 }, -- Pummeler
                { 8, 85135 }, -- Quickblade
                { 9, 85134 }, -- Slicer
                { 16, 85133 }, -- Shanker
                { 17, 85127 }, -- Spellblade
                { 19, 85129 }, -- Render
                { 20, 85128 }, -- Ripper
                -- { , 85116 }, -- Fleshslicer
                -- { , 85117 }, -- Slasher
            }
        },
        {
            name = AL["Weapons"] .. " - " .. AL["Two-Handed"],
            [SET1_DIFF] = {
                { 1, 84707 }, -- Decapitator
                { 3, 84721 }, -- Bonegrinder
                { 5, 84717 }, -- Greatsword
                { 7, 84722 }, -- Pike
                { 16, 84723 }, -- Battle Staff
                { 17, 84724 }, -- Energy Staff
                { 18, 84725 }, -- Staff
            },
            [SET2_DIFF] = {
                { 1, 84791 }, -- Decapitator
                { 3, 84785 }, -- Bonegrinder
                { 5, 84790 }, -- Greatsword
                { 7, 84786 }, -- Pike
                { 16, 84787 }, -- Battle Staff
                { 17, 84788 }, -- Energy Staff
                { 18, 84789 }, -- Staff
            },
            [SET2_ELITE_DIFF] = {

                { 1, 85113 }, -- Decapitator
                { 3, 85107 }, -- Bonegrinder
                { 5, 85112 }, -- Greatsword
                { 7, 85108 }, -- Pike
                { 16, 85109 }, -- Battle Staff
                { 17, 85110 }, -- Energy Staff
                { 18, 85111 }, -- Staff
            }
        },
        {
            name = AL["Weapons"] .. " - " .. AL["Ranged"],
            [SET1_DIFF] = {
                { 1, 84705 }, -- Longbow
                -- { 2, 84718 }, -- Heavy Crossbow
                { 3, 84706 }, -- Rifle
                -- { 16, 84704 }, -- Baton of Light
                -- { 17, 84703 }, -- Touch of Defeat
            },
            [SET2_DIFF] = {
                { 1, 84896 }, -- Longbow
                -- { 2, 84897 }, -- Heavy Crossbow
                { 3, 84900 }, -- Rifle
                -- { 16, 84899 }, -- Baton of Light
                -- { 17, 84898 }, -- Touch of Defeat

            },
            [SET2_ELITE_DIFF] = {
                { 1, 85119 }, -- Longbow
                -- { 2, 85120 }, -- Heavy Crossbow
                { 3, 85123 }, -- Rifle
                -- { 16, 85122 }, -- Baton of Light
                -- { 17, 85121 }, -- Touch of Defeat
            }
        },
        {
            name = AL["Weapons"] .. " - " .. AL["Off-hand"],
            [SET1_DIFF] = {
                { 1, 84711 }, -- Endgame
                { 2, 84712 }, -- Reprieve
            },
            [SET2_DIFF] = {
                { 1, 84866 }, -- Endgame
                { 2, 84867 }, -- Reprieve
                -- { 3, 84895 }, -- Shiv
            },
            [SET2_ELITE_DIFF] = {
                { 1, 85114 }, -- Endgame
                { 2, 85115 }, -- Reprieve
                -- { 3, 85118 }, -- Shiv
            }
        },
        {
            name = AL["Weapons"] .. " - " .. AL["Shield"],
            [SET1_DIFF] = {
                { 1, 84714 }, -- Barrier
                { 2, 84715 }, -- Redoubt
                { 3, 84713 }, -- Shield Wall
            },
            [SET2_DIFF] = {
                { 1, 84911 }, -- Barrier
                { 2, 84912 }, -- Redoubt
                { 3, 84910 }, -- Shield Wall
            },
            [SET2_ELITE_DIFF] = {
                { 1, 85125 }, -- Barrier
                { 2, 85126 }, -- Redoubt
                { 3, 85124 }, -- Shield Wall
            }
        },
        {
            name = AL["Back"],
            [SET1_DIFF] = {
                { 1, 84345 }, -- Cape of Cruelty
                { 2, 84346 }, -- Cape of Prowess
                { 4, 84491 }, -- Cloak of Alacrity
                { 5, 84492 }, -- Cloak of Prowess
                { 16, 84363 }, -- Drape of Cruelty
                { 17, 84364 }, -- Drape of Meditation
                { 18, 84362 }, -- Drape of Prowess
            },
            [SET2_DIFF] = {
                { 1, 84804 }, -- Cape of Cruelty
                { 2, 84805 }, -- Cape of Prowess
                { 4, 84807 }, -- Cloak of Alacrity
                { 5, 84806 }, -- Cloak of Prowess
                { 16, 84801 }, -- Drape of Cruelty
                { 17, 84802 }, -- Drape of Meditation
                { 18, 84803 }, -- Drape of Prowess
            }
        },
        {
            name = AL["Neck"],
            [SET1_DIFF] = {
                { 1, 84347 }, -- Necklace of Proficiency
                { 2, 84493 }, -- Choker of Proficiency
                { 4, 84494 }, -- Choker of Accuracy
                { 5, 84348 }, -- Necklace of Prowess
                { 16, 84365 }, -- Pendant of Alacrity
                { 17, 84366 }, -- Pendant of Cruelty
                { 18, 84367 }, -- Pendant of Meditation
            },
            [SET2_DIFF] = {
                { 1, 84889 }, -- Necklace of Proficiency
                { 2, 84891 }, -- Choker of Proficiency
                { 4, 84892 }, -- Choker of Accuracy
                { 5, 84890 }, -- Necklace of Prowess
                { 16, 84886 }, -- Pendant of Alacrity
                { 17, 84887 }, -- Pendant of Cruelty
                { 18, 84888 }, -- Pendant of Meditation
            }
        },
        {
            name = AL["Finger"],
            [SET1_DIFF] = {
                { 1, 84352 }, -- Ring of Accuracy
                { 2, 84351 }, -- Ring of Cruelty
                { 4, 84498 }, -- Signet of Accuracy
                { 5, 84497 }, -- Signet of Cruelty
                { 16, 84370 }, -- Band of Accuracy
                { 17, 84369 }, -- Band of Cruelty
                { 18, 84371 }, -- Band of Meditation
            },
            [SET2_DIFF] = {
                { 1, 84827 }, -- Ring of Accuracy
                { 2, 84826 }, -- Ring of Cruelty
                { 4, 84829 }, -- Signet of Accuracy
                { 5, 84828 }, -- Signet of Cruelty
                { 16, 84824 }, -- Band of Accuracy
                { 17, 84823 }, -- Band of Cruelty
                { 18, 84825 }, -- Band of Meditation
            }
        },

        {
            name = format(AL["Non Set '%s'"], ALIL["Cloth"]),
            [SET1_DIFF] = {
                { 1, 84359 }, -- Cuffs of Accuracy
                { 2, 84361 }, -- Cuffs of Meditation
                { 3, 84360 }, -- Cuffs of Prowess
                { 5, 84354 }, -- Cord of Accuracy
                { 6, 84353 }, -- Cord of Cruelty
                { 7, 84355 }, -- Cord of Meditation
                { 9, 84357 }, -- Treads of Alacrity
                { 10, 84356 }, -- Treads of Cruelty
                { 11, 84358 }, -- Treads of Meditation
            },
            [SET2_DIFF] = {
                { 1, 84977 }, -- Cuffs of Accuracy (Cloth)
                { 2, 84979 }, -- Cuffs of Meditation (Cloth)
                { 3, 84978 }, -- Cuffs of Prowess (Cloth)
                { 5, 84955 }, -- Cord of Accuracy (Cloth)
                { 6, 84954 }, -- Cord of Cruelty (Cloth)
                { 7, 84956 }, -- Cord of Meditation (Cloth)
                { 9, 84815 }, -- Treads of Alacrity (Cloth)
                { 10, 84814 }, -- Treads of Cruelty (Cloth)
                { 11, 84816 }, -- Treads of Meditation (Cloth)

            },
            [SET2_ELITE_DIFF] = {
                { 1, 85093 }, -- Cord of Accuracy (Cloth)
                { 2, 85092 }, -- Cord of Cruelty (Cloth)
                { 3, 85094 }, -- Cord of Meditation (Cloth)
                { 5, 85005 }, -- Treads of Alacrity (Cloth)
                { 6, 85004 }, -- Treads of Cruelty (Cloth)
                { 7, 85006 }, -- Treads of Meditation (Cloth)
            }
        },
        {
            name = format(AL["Non Set '%s'"], ALIL["Leather"]),
            [SET1_DIFF] = {
                { 1, 84461 }, -- Armwraps of Accuracy
                { 2, 84460 }, -- Armwraps of Alacrity
                { 3, 84384 }, -- Bindings of Meditation
                { 4, 84392 }, -- Bindings of Prowess
                { 6, 84390 }, -- Belt of Cruelty
                { 7, 84382 }, -- Belt of Meditation
                { 8, 84457 }, -- Waistband of Accuracy
                { 9, 84456 }, -- Waistband of Cruelty
                { 16, 84459 }, -- Boots of Alacrity
                { 17, 84458 }, -- Boots of Cruelty
                { 18, 84391 }, -- Footguards of Alacrity
                { 19, 84383 }, -- Footguards of Meditation
            },
            [SET2_DIFF] = {
                { 1, 84973 }, -- Armwraps of Accuracy (Leather)
                { 2, 84972 }, -- Armwraps of Alacrity (Leather)
                { 3, 84976 }, -- Bindings of Meditation (Leather)
                { 4, 84982 }, -- Bindings of Prowess (Leather)
                { 6, 84960 }, -- Belt of Cruelty (Leather)
                { 7, 84953 }, -- Belt of Meditation (Leather)
                { 8, 84948 }, -- Waistband of Accuracy (Leather)
                { 9, 84947 }, -- Waistband of Cruelty (Leather)
                { 16, 84809 }, -- Boots of Alacrity (Leather)
                { 17, 84808 }, -- Boots of Cruelty (Leather)
                { 18, 84819 }, -- Footguards of Alacrity (Leather)
                { 19, 84813 }, -- Footguards of Meditation (Leather)
            },
            [SET2_ELITE_DIFF] = {
                { 1, 85098 }, -- Belt of Cruelty (Leather)
                { 2, 85106 }, -- Belt of Meditation (Leather)
                { 3, 85101 }, -- Waistband of Accuracy (Leather)
                { 4, 85100 }, -- Waistband of Cruelty (Leather)
                { 6, 85010 }, -- Boots of Alacrity (Leather)
                { 7, 85009 }, -- Boots of Cruelty (Leather)
                { 8, 84996 }, -- Footguards of Alacrity (Leather)
                { 9, 85003 }, -- Footguards of Meditation (Leather)
            }
        },
        {
            name = format(AL["Non Set '%s'"], ALIL["Mail"]),
            [SET1_DIFF] = {
                { 1, 84471 }, -- Armbands of Meditation
                { 2, 84470 }, -- Armbands of Prowess
                { 3, 84407 }, -- Wristguards of Accuracy
                { 4, 84406 }, -- Wristguards of Alacrity
                { 6, 84403 }, -- Links of Accuracy
                { 7, 84402 }, -- Links of Cruelty
                { 8, 84482 }, -- Waistguard of Cruelty
                { 9, 84467 }, -- Waistguard of Meditation
                { 16, 84468 }, -- Footguards of Alacrity
                { 17, 84469 }, -- Footguards of Meditation
                { 18, 84405 }, -- Sabatons of Alacrity
                { 19, 84404 }, -- Sabatons of Cruelty
            },
            [SET2_DIFF] = {
                { 1, 84984 }, -- Armbands of Meditation (Mail)
                { 2, 84983 }, -- Armbands of Prowess (Mail)
                { 3, 84981 }, -- Wristguards of Accuracy (Mail)
                { 4, 84980 }, -- Wristguards of Alacrity (Mail)
                { 6, 84957 }, -- Links of Accuracy (Mail)
                { 7, 84958 }, -- Links of Cruelty (Mail)
                { 8, 84959 }, -- Waistguard of Cruelty (Mail)
                { 9, 84946 }, -- Waistguard of Meditation (Mail)
                { 16, 84820 }, -- Footguards of Alacrity (Mail)
                { 17, 84821 }, -- Footguards of Meditation (Mail)
                { 18, 84818 }, -- Sabatons of Alacrity (Mail)
                { 19, 84817 }, -- Sabatons of Cruelty (Mail)


            },
            [SET2_ELITE_DIFF] = {
                { 1, 85095 }, -- Links of Accuracy (Mail)
                { 2, 85096 }, -- Links of Cruelty (Mail)
                { 3, 85097 }, -- Waistguard of Cruelty (Mail)
                { 4, 85099 }, -- Waistguard of Meditation (Mail)
                { 6, 84997 }, -- Footguards of Alacrity (Mail)
                { 7, 84998 }, -- Footguards of Meditation (Mail)
                { 8, 85008 }, -- Sabatons of Alacrity (Mail)
                { 9, 85007 }, -- Sabatons of Cruelty (Mail)
            }
        },
        {
            name = format(AL["Non Set '%s'"], ALIL["Plate"]),
            [SET1_DIFF] = {
                { 1, 84439 }, -- Armplates of Alacrity
                { 2, 84438 }, -- Armplates of Proficiency
                { 3, 84428 }, -- Bracers of Meditation
                { 4, 84427 }, -- Bracers of Prowess
                { 6, 84423 }, -- Clasp of Cruelty
                { 7, 84424 }, -- Clasp of Meditation
                { 8, 84434 }, -- Girdle of Accuracy
                { 9, 84435 }, -- Girdle of Prowess
                { 16, 84425 }, -- Greaves of Alacrity
                { 17, 84426 }, -- Greaves of Meditation
                { 18, 84437 }, -- Warboots of Alacrity
                { 19, 84436 }, -- Warboots of Cruelty
            },
            [SET2_DIFF] = {
                { 1, 84986 }, -- Armplates of Alacrity (Plate)
                { 2, 84985 }, -- Armplates of Proficiency (Plate)
                { 3, 84975 }, -- Bracers of Meditation (Plate)
                { 4, 84974 }, -- Bracers of Prowess (Plate)
                { 6, 84951 }, -- Clasp of Cruelty (Plate)
                { 7, 84952 }, -- Clasp of Meditation (Plate)
                { 8, 84949 }, -- Girdle of Accuracy (Plate)
                { 9, 84950 }, -- Girdle of Prowess (Plate)
                { 16, 84811 }, -- Greaves of Alacrity (Plate)
                { 17, 84812 }, -- Greaves of Meditation (Plate)
                { 18, 84822 }, -- Warboots of Alacrity (Plate)
                { 19, 84810 }, -- Warboots of Cruelty (Plate)
            },
            [SET2_ELITE_DIFF] = {
                { 1, 85104 }, -- Clasp of Cruelty (Plate)
                { 2, 85105 }, -- Clasp of Meditation (Plate)
                { 3, 85102 }, -- Girdle of Accuracy (Plate)
                { 4, 85103 }, -- Girdle of Prowess (Plate)
                { 6, 85001 }, -- Greaves of Alacrity (Plate)
                { 7, 85002 }, -- Greaves of Meditation (Plate)
                { 8, 84999 }, -- Warboots of Alacrity (Plate)
                { 9, 85000 }, -- Warboots of Cruelty (Plate)
            }
        },
        {
            name = AL["Trinkets"],
            [SET1_DIFF] = {
                { 1, 84344 }, -- Dreadful Gladiator's Badge of Conquest
                { 2, 84488 }, -- Dreadful Gladiator's Badge of Dominance
                { 3, 84490 }, -- Dreadful Gladiator's Badge of Victory
                { 5, 84399 }, -- Dreadful Gladiator's Emblem of Cruelty
                { 6, 84401 }, -- Dreadful Gladiator's Emblem of Meditation
                { 7, 84400 }, -- Dreadful Gladiator's Emblem of Tenacity
                { 16, 84349 }, -- Dreadful Gladiator's Insignia of Conquest
                { 17, 84489 }, -- Dreadful Gladiator's Insignia of Dominance
                { 18, 84495 }, -- Dreadful Gladiator's Insignia of Victory
                { 20, AtlasLoot:GetRetByFaction(84451, 84450) }, -- Dreadful Gladiator's Medallion of Cruelty
                { 21, AtlasLoot:GetRetByFaction(84455, 84454) }, -- Dreadful Gladiator's Medallion of Meditation
                { 22, AtlasLoot:GetRetByFaction(84453, 84452) }, -- Dreadful Gladiator's Medallion of Tenacity
            },
            [SET2_DIFF] = {
                { 1, 84934 }, -- Malevolent Gladiator's Badge of Conquest
                { 2, 84940 }, -- Malevolent Gladiator's Badge of Dominance
                { 3, 84942 }, -- Malevolent Gladiator's Badge of Victory
                { 5, 84936 }, -- Malevolent Gladiator's Emblem of Cruelty
                { 6, 84939 }, -- Malevolent Gladiator's Emblem of Meditation
                { 7, 84938 }, -- Malevolent Gladiator's Emblem of Tenacity
                { 16, 84935 }, -- Malevolent Gladiator's Insignia of Conquest
                { 17, 84941 }, -- Malevolent Gladiator's Insignia of Dominance
                { 18, 84937 }, -- Malevolent Gladiator's Insignia of Victory
                { 20, AtlasLoot:GetRetByFaction(84944, 84943) }, -- Malevolent Gladiator's Medallion of Cruelty
                { 21, AtlasLoot:GetRetByFaction(84933, 84932) }, -- Malevolent Gladiator's Medallion of Meditation
                { 22, AtlasLoot:GetRetByFaction(84931, 84945) }, -- Malevolent Gladiator's Medallion of Tenacity
            }
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
    ContentPhaseMoP = 2,
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
    ContentPhaseMoP = 3,
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
    ContentPhaseMoP = 5,
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
