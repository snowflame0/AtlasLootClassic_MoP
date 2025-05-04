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
if AtlasLoot:GameVersion_LT(AtlasLoot.CATA_VERSION_NUM) then
    return
end
local data = AtlasLoot.ItemDB:Add(addonname, 1, AtlasLoot.CATA_VERSION_NUM)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
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
local SET1_DIFF = data:AddDifficulty(format(AL["Bloodthirsty %s"], AL["Gladiator"]), "set1", nil, 1)
local SET2_DIFF = data:AddDifficulty(format(AL["Vicious %s"], AL["Gladiator"]), "set2", nil, 1)
local SET2_ELITE_DIFF = data:AddDifficulty(format(AL["Vicious (Elite) %s"], AL["Gladiator"]), "set3", nil, 1)
local SET2_UPGRADE_DIFF = data:AddDifficulty(format(AL["Vicious %s"], AL["Gladiator"]), "set6", nil, 1) -- Upgraded honor set
local SET3_DIFF = data:AddDifficulty(format(AL["Ruthless %s"], AL["Gladiator"]), "set4", nil, 1)
local SET3_ELITE_DIFF = data:AddDifficulty(format(AL["Ruthless (Elite) %s"], AL["Gladiator"]), "set5", nil, 1)
local SET3_UPGRADE_DIFF = data:AddDifficulty(format(AL["Ruthless %s"], AL["Gladiator"]), "set9", nil, 1) -- Upgraded honor set 390
local SET4_DIFF = data:AddDifficulty(format(AL["Cataclysmic %s"], AL["Gladiator"]), "set7", nil, 1)
local SET4_ELITE_DIFF = data:AddDifficulty(format(AL["Cataclysmic (Elite) %s"], AL["Gladiator"]), "set8", nil, 1)

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

data["PvPMountsCata"] = {
    name = ALIL["Mounts"],
    ContentType = GENERAL_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    CorrespondingFields = private.MOUNTS_LINK,
    items = {{ -- PvPMountsCata
    name = ALIL["Mounts"],
    [NORMAL_DIFF] = {
        {1, [ATLASLOOT_IT_ALLIANCE] = 70909, [ATLASLOOT_IT_HORDE] = 70910},
        {2, 71339}, -- Vicious Gladiator's Twilight Drake
        {3, 71954}, -- Ruthless Gladiator's Twilight Drake
        -- Add in after MoP pre-patch
        -- {4, 85785}, -- Cataclysmic Gladiator's Twilight Drake
        {16, [ATLASLOOT_IT_ALLIANCE] = "ac5328", [ATLASLOOT_IT_HORDE] = "ac5325"},
    },
}}
}

data["ArenaS9PvP"] = {
    name = format(AL["Season %s"], "9"),
    ContentType = ARENA_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    items = {{
        name = AL["Sets"],
        TableType = SET_ITTYPE,
        [SET1_DIFF] = {
            {1, 4000910}, -- Warlock
            {3, 4000916}, -- Priest Healing
            {4, 4000915}, -- Priest Shadow
            {6, 4000914}, -- Rogue
            {8, 4000920}, -- Hunter
            {10, 4000909}, -- Warrior Melee
            {13, 4000924}, -- Death Knight Melee
            {16, 4000919}, -- Mage
            {18, 4000923}, -- Druid Resto
            {19, 4000921}, -- Druid Balance
            {20, 4000922}, -- Druid Feral
            {22, 4000913}, -- Shaman Resto
            {23, 4000911}, -- Shaman Elemental
            {24, 4000912}, -- Shaman Enhancement
            {26, 4000918}, -- Paladin Holy
            {27, 4000917} -- Paladin Melee
        },
        [SET2_DIFF] = {
            {1, 4001910}, -- Warlock
            {3, 4001916}, -- Priest Healing
            {4, 4001915}, -- Priest Shadow
            {6, 4001914}, -- Rogue
            {8, 4001920}, -- Hunter
            {10, 4001909}, -- Warrior Melee
            {13, 4001924}, -- Death Knight Melee
            {16, 4001919}, -- Mage
            {18, 4001923}, -- Druid Resto
            {19, 4001921}, -- Druid Balance
            {20, 4001922}, -- Druid Feral
            {22, 4001913}, -- Shaman Resto
            {23, 4001911}, -- Shaman Elemental
            {24, 4001912}, -- Shaman Enhancement
            {26, 4001918}, -- Paladin Holy
            {27, 4001917} -- Paladin Melee
        },
        [SET2_ELITE_DIFF] = {
            {1, 4002910}, -- Warlock
            {3, 4002916}, -- Priest Healing
            {4, 4002915}, -- Priest Shadow
            {6, 4002914}, -- Rogue
            {8, 4002920}, -- Hunter
            {10, 4002909}, -- Warrior Melee
            {13, 4002924}, -- Death Knight Melee
            {16, 4002919}, -- Mage
            {18, 4002923}, -- Druid Resto
            {19, 4002921}, -- Druid Balance
            {20, 4002922}, -- Druid Feral
            {22, 4002913}, -- Shaman Resto
            {23, 4002911}, -- Shaman Elemental
            {24, 4002912}, -- Shaman Enhancement
            {26, 4002918}, -- Paladin Holy
            {27, 4002917} -- Paladin Melee
        },
    }, {
        name = AL["Weapons"] .. " - " .. AL["One-Handed"],
        [SET2_ELITE_DIFF] = {
            { 1, 67474 }, -- Vicious Gladiator's Cleaver
            { 2, 67473 }, -- Vicious Gladiator's Hacker
            { 4, 67470 }, -- Vicious Gladiator's Bonecracker
            { 5, 67471 }, -- Vicious Gladiator's Pummeler
            { 7, 67468 }, -- Vicious Gladiator's Quickblade
            { 8, 67469 }, -- Vicious Gladiator's Slicer
            { 16, 67457 }, -- Vicious Gladiator's Spellblade
            { 17, 67454 }, -- Vicious Gladiator's Gavel
            { 19, 67472 }, -- Vicious Gladiator's Shanker
            { 20, 67460 }, -- Vicious Gladiator's Shiv
            { 22, 67455 }, -- Vicious Gladiator's Right Render
            { 23, 67456 }, -- Vicious Gladiator's Right Ripper
            { 25, 67458 }, -- Vicious Gladiator's Left Render
            { 26, 67459 }, -- Vicious Gladiator's Left Ripper
        },
    }, {
        name = AL["Weapons"] .. " - " .. AL["Two-Handed"],
        [SET2_ELITE_DIFF] = {
            { 1, 67451 }, -- Vicious Gladiator's Pike
            { 2, 67448 }, -- Vicious Gladiator's Staff
            { 4, 67453 }, -- Vicious Gladiator's Decapitator
            { 5, 67452 }, -- Vicious Gladiator's Bonegrinder
            { 6, 67447 }, -- Vicious Gladiator's Greatsword
            { 16, 67449 }, -- Vicious Gladiator's Energy Staff
            { 17, 67450 }, -- Vicious Gladiator's Battle Staff
        },
    }, {
        name = AL["Weapons"] .. " - " .. AL["Ranged"],
        [SET2_ELITE_DIFF] = {
            { 1, 67461 }, -- Vicious Gladiator's Longbow
            { 2, 67462 }, -- Vicious Gladiator's Heavy Crossbow
            { 3, 67463 }, -- Vicious Gladiator's Rifle
            { 5, 67466 }, -- Vicious Gladiator's Hatchet
            { 6, 67467 }, -- Vicious Gladiator's War Edge
            { 16, 67464 }, -- Vicious Gladiator's Baton of Light
            { 17, 67465 }, -- Vicious Gladiator's Touch of Defeat
        },
    }, {
        name = AL["Weapons"] .. " - " .. ALIL["Off Hand"],
        [SET2_ELITE_DIFF] = {
            { 1, 67478 }, -- Vicious Gladiator's Reprieve
            { 2, 67479 }, -- Vicious Gladiator's Endgame
        }
    }, {
        name = AL["Weapons"] .. " - " .. ALIL["Shields"],
        [SET2_ELITE_DIFF] = {
            { 1, 67476 }, -- Vicious Gladiator's Barrier
            { 2, 67475 }, -- Vicious Gladiator's Redoubt
            { 3, 67477 }, -- Vicious Gladiator's Shield Wall
        },
    }, {
        name = ALIL["Cloak"],
        [SET2_DIFF] = {
            { 1, 60783 }, -- Vicious Gladiator's Cape of Cruelty
            { 2, 60779 }, -- Vicious Gladiator's Cape of Prowess
            { 4, 60776 }, -- Vicious Gladiator's Cloak of Alacrity
            { 5, 60778 }, -- Vicious Gladiator's Cloak of Prowess
            { 16, 60786 }, -- Vicious Gladiator's Drape of Diffusion
            { 17, 60788 }, -- Vicious Gladiator's Drape of Meditation
            { 18, 60787 }, -- Vicious Gladiator's Drape of Prowess
        },
    }, {
        name = ALIL["Relic"],
        [SET2_DIFF] = {
            { 1, 61391 }, -- Vicious Gladiator's Relic of Conquest
            { 2, 61388 }, -- Vicious Gladiator's Relic of Dominance
            { 3, 61389 }, -- Vicious Gladiator's Relic of Salvation
            { 4, 61390 }, -- Vicious Gladiator's Relic of Triumph
        },
    }, {
        name = ALIL["Neck"],
        [SET1_DIFF] = {
            { 1, 64713 }, -- Bloodthirsty Gladiator's Choker of Accuracy
            { 2, 64714 }, -- Bloodthirsty Gladiator's Choker of Proficiency
            { 5, 64800 }, -- Bloodthirsty Gladiator's Necklace of Proficiency
            { 6, 64801 }, -- Bloodthirsty Gladiator's Necklace of Prowess
            { 16, 64807 }, -- Bloodthirsty Gladiator's Pendant of Alacrity
            { 17, 64808 }, -- Bloodthirsty Gladiator's Pendant of Diffusion
            { 18, 64809 }, -- Bloodthirsty Gladiator's Pendant of Meditation
        },
        [SET2_DIFF] = {
            { 1, 60673 }, -- Vicious Gladiator's Choker of Accuracy
            { 2, 60670 }, -- Vicious Gladiator's Choker of Proficiency
            { 5, 60669 }, -- Vicious Gladiator's Necklace of Proficiency
            { 6, 60668 }, -- Vicious Gladiator's Necklace of Prowess
            { 16, 60662 }, -- Vicious Gladiator's Pendant of Alacrity
            { 17, 60661 }, -- Vicious Gladiator's Pendant of Diffusion
            { 18, 60664 }, -- Vicious Gladiator's Pendant of Meditation
        },
    }, {
        name = ALIL["Finger"],
        [SET1_DIFF] = {
            { 1, 64851 }, -- Bloodthirsty Gladiator's Signet of Accuracy
            { 2, 64852 }, -- Bloodthirsty Gladiator's Signet of Cruelty
            { 4, 64832 }, -- Bloodthirsty Gladiator's Ring of Accuracy
            { 5, 64833 }, -- Bloodthirsty Gladiator's Ring of Cruelty
            { 16, 64690 }, -- Bloodthirsty Gladiator's Band of Accuracy
            { 17, 64691 }, -- Bloodthirsty Gladiator's Band of Cruelty
            { 18, 64692 }, -- Bloodthirsty Gladiator's Band of Meditation
        },
        [SET2_DIFF] = {
            { 1, 60651 }, -- Vicious Gladiator's Signet of Accuracy
            { 2, 60650 }, -- Vicious Gladiator's Signet of Cruelty
            { 4, 60658 }, -- Vicious Gladiator's Ring of Accuracy
            { 5, 60659 }, -- Vicious Gladiator's Ring of Cruelty
            { 16, 60647 }, -- Vicious Gladiator's Band of Accuracy
            { 17, 60645 }, -- Vicious Gladiator's Band of Cruelty
            { 18, 60649 }, -- Vicious Gladiator's Band of Meditation
        },
    }, {
        name = format(AL["Non Set '%s'"], ALIL["Cloth"]),
        [SET1_DIFF] = {
            { 1, 64862 }, -- Bloodthirsty Gladiator's Treads of Alacrity
            { 2, 64863 }, -- Bloodthirsty Gladiator's Treads of Cruelty
            { 3, 64864 }, -- Bloodthirsty Gladiator's Treads of Meditation
            { 5, 64720 }, -- Bloodthirsty Gladiator's Cord of Accuracy
            { 6, 64721 }, -- Bloodthirsty Gladiator's Cord of Cruelty
            { 7, 64722 }, -- Bloodthirsty Gladiator's Cord of Meditation
            { 16, 64723 }, -- Bloodthirsty Gladiator's Cuffs of Accuracy
            { 17, 64724 }, -- Bloodthirsty Gladiator's Cuffs of Meditation
            { 18, 64725 }, -- Bloodthirsty Gladiator's Cuffs of Prowess
        },
        [SET2_DIFF] = {
            { 1, 60630 }, -- Vicious Gladiator's Treads of Alacrity
            { 2, 60613 }, -- Vicious Gladiator's Treads of Cruelty
            { 3, 60636 }, -- Vicious Gladiator's Treads of Meditation
            { 5, 60626 }, -- Vicious Gladiator's Cord of Accuracy
            { 6, 60612 }, -- Vicious Gladiator's Cord of Cruelty
            { 7, 60637 }, -- Vicious Gladiator's Cord of Meditation
            { 16, 60628 }, -- Vicious Gladiator's Cuffs of Accuracy
            { 17, 60635 }, -- Vicious Gladiator's Cuffs of Meditation
            { 18, 60634 }, -- Vicious Gladiator's Cuffs of Prowess
        },
        [SET2_ELITE_DIFF] = {
            { 1, 65599 }, -- Vicious Gladiator's Treads of Alacrity
            { 2, 65598 }, -- Vicious Gladiator's Treads of Cruelty
            { 3, 65600 }, -- Vicious Gladiator's Treads of Meditation
        },
    }, {
        name = format(AL["Non Set '%s'"], ALIL["Leather"]),
        [SET1_DIFF] = {
            { 1, 64702 }, -- Bloodthirsty Gladiator's Boots of Alacrity
            { 2, 64703 }, -- Bloodthirsty Gladiator's Boots of Cruelty
            { 3, 64750 }, -- Bloodthirsty Gladiator's Footguards of Alacrity
            { 4, 64751 }, -- Bloodthirsty Gladiator's Footguards of Meditation
            { 6, 64696 }, -- Bloodthirsty Gladiator's Belt of Cruelty
            { 7, 64697 }, -- Bloodthirsty Gladiator's Belt of Meditation
            { 8, 64865 }, -- Bloodthirsty Gladiator's Waistband of Accuracy
            { 9, 64866 }, -- Bloodthirsty Gladiator's Waistband of Cruelty
            { 16, 64685 }, -- Bloodthirsty Gladiator's Armwraps of Accuracy
            { 17, 64686 }, -- Bloodthirsty Gladiator's Armwraps of Alacrity
            { 18, 64698 }, -- Bloodthirsty Gladiator's Bindings of Meditation
            { 19, 64699 }, -- Bloodthirsty Gladiator's Bindings of Prowess
        },
        [SET2_DIFF] = {
            { 1, 60593 }, -- Vicious Gladiator's Boots of Alacrity
            { 2, 60587 }, -- Vicious Gladiator's Boots of Cruelty
            { 3, 60607 }, -- Vicious Gladiator's Footguards of Alacrity
            { 4, 60581 }, -- Vicious Gladiator's Footguards of Meditation
            { 6, 60583 }, -- Vicious Gladiator's Belt of Cruelty
            { 7, 60580 }, -- Vicious Gladiator's Belt of Meditation
            { 8, 60589 }, -- Vicious Gladiator's Waistband of Accuracy
            { 9, 60586 }, -- Vicious Gladiator's Waistband of Cruelty
            { 16, 60591 }, -- Vicious Gladiator's Armwraps of Accuracy
            { 17, 60594 }, -- Vicious Gladiator's Armwraps of Alacrity
            { 18, 60582 }, -- Vicious Gladiator's Bindings of Meditation
            { 19, 60611 }, -- Vicious Gladiator's Bindings of Prowess
        },
        [SET2_ELITE_DIFF] = {
            { 1, 65610 }, -- Vicious Gladiator's Boots of Alacrity
            { 2, 65609 }, -- Vicious Gladiator's Boots of Cruelty
            { 3, 65602 }, -- Vicious Gladiator's Footguards of Alacrity
            { 4, 65601 }, -- Vicious Gladiator's Footguards of Meditation
        },
    }, {
        name = format(AL["Non Set '%s'"], ALIL["Mail"]),
        [SET1_DIFF] = {
            { 1, 64835 }, -- Bloodthirsty Gladiator's Sabatons of Alacrity
            { 2, 64834 }, -- Bloodthirsty Gladiator's Sabatons of Alacrity
            { 3, 64836 }, -- Bloodthirsty Gladiator's Sabatons of Cruelty
            { 4, 64837 }, -- Bloodthirsty Gladiator's Sabatons of Meditation
            { 6, 64781 }, -- Bloodthirsty Gladiator's Links of Accuracy
            { 7, 64782 }, -- Bloodthirsty Gladiator's Links of Cruelty
            { 8, 64867 }, -- Bloodthirsty Gladiator's Waistguard of Cruelty
            { 9, 64868 }, -- Bloodthirsty Gladiator's Waistguard of Meditation
            { 16, 64681 }, -- Bloodthirsty Gladiator's Armbands of Meditation
            { 17, 64682 }, -- Bloodthirsty Gladiator's Armbands of Prowess
            { 18, 64872 }, -- Bloodthirsty Gladiator's Wristguards of Accuracy
            { 19, 64873 }, -- Bloodthirsty Gladiator's Wristguards of Alacrity
        },
        [SET2_DIFF] = {
            { 1, 60557 }, -- Vicious Gladiator's Sabatons of Alacrity
            { 2, 60567 }, -- Vicious Gladiator's Sabatons of Alacrity
            { 3, 60554 }, -- Vicious Gladiator's Sabatons of Cruelty
            { 4, 60534 }, -- Vicious Gladiator's Sabatons of Meditation
            { 6, 60564 }, -- Vicious Gladiator's Links of Accuracy
            { 7, 60555 }, -- Vicious Gladiator's Links of Cruelty
            { 8, 60536 }, -- Vicious Gladiator's Waistguard of Cruelty
            { 9, 60533 }, -- Vicious Gladiator's Waistguard of Meditation
            { 16, 60535 }, -- Vicious Gladiator's Armbands of Meditation
            { 17, 60569 }, -- Vicious Gladiator's Armbands of Prowess
            { 18, 60565 }, -- Vicious Gladiator's Wristguards of Accuracy
            { 19, 60559 }, -- Vicious Gladiator's Wristguards of Alacrity
        },
        [SET2_ELITE_DIFF] = {
            { 1, 65604 }, -- Vicious Gladiator's Sabatons of Alacrity
            { 2, 65611 }, -- Vicious Gladiator's Sabatons of Alacrity
            { 3, 65603 }, -- Vicious Gladiator's Sabatons of Cruelty
            { 4, 65612 }, -- Vicious Gladiator's Sabatons of Meditation
        },
    }, {
        name = format(AL["Non Set '%s'"], ALIL["Plate"]),
        [SET1_DIFF] = {
            { 1, 64756 }, -- Bloodthirsty Gladiator's Greaves of Alacrity
            { 2, 64757 }, -- Bloodthirsty Gladiator's Greaves of Meditation
            { 3, 64869 }, -- Bloodthirsty Gladiator's Warboots of Alacrity
            { 4, 64870 }, -- Bloodthirsty Gladiator's Warboots of Cruelty
            { 6, 64715 }, -- Bloodthirsty Gladiator's Clasp of Cruelty
            { 7, 64716 }, -- Bloodthirsty Gladiator's Clasp of Meditation
            { 8, 64753 }, -- Bloodthirsty Gladiator's Girdle of Cruelty
            { 9, 64754 }, -- Bloodthirsty Gladiator's Girdle of Prowess
            { 16, 64683 }, -- Bloodthirsty Gladiator's Armplates of Alacrity
            { 17, 64684 }, -- Bloodthirsty Gladiator's Armplates of Proficiency
            { 18, 64704 }, -- Bloodthirsty Gladiator's Bracers of Meditation
            { 19, 64705 }, -- Bloodthirsty Gladiator's Bracers of Prowess
        },
        [SET2_DIFF] = {
            { 1, 60516 }, -- Vicious Gladiator's Greaves of Alacrity
            { 2, 60540 }, -- Vicious Gladiator's Greaves of Meditation
            { 3, 60513 }, -- Vicious Gladiator's Warboots of Alacrity
            { 4, 60509 }, -- Vicious Gladiator's Warboots of Cruelty
            { 6, 60505 }, -- Vicious Gladiator's Clasp of Cruelty
            { 7, 60539 }, -- Vicious Gladiator's Clasp of Meditation
            { 8, 60508 }, -- Vicious Gladiator's Girdle of Cruelty
            { 9, 60521 }, -- Vicious Gladiator's Girdle of Prowess
            { 16, 60512 }, -- Vicious Gladiator's Armplates of Alacrity
            { 17, 60523 }, -- Vicious Gladiator's Armplates of Proficiency
            { 18, 60541 }, -- Vicious Gladiator's Bracers of Meditation
            { 19, 60520 }, -- Vicious Gladiator's Bracers of Prowess
        },
        [SET2_ELITE_DIFF] = {
            { 1, 65605 }, -- Vicious Gladiator's Greaves of Alacrity
            { 2, 65606 }, -- Vicious Gladiator's Greaves of Meditation
            { 3, 65608 }, -- Vicious Gladiator's Warboots of Alacrity
            { 4, 65607 }, -- Vicious Gladiator's Warboots of Cruelty
        }
    }, {
        name = ALIL["Trinket"],
        [SET1_DIFF] = {
            { 1, 64687 }, -- Bloodthirsty Gladiator's Badge of Conquest
            { 2, 64688 }, -- Bloodthirsty Gladiator's Badge of Dominance
            { 3, 64689 }, -- Bloodthirsty Gladiator's Badge of Victory
            { 5, 64740 }, -- Bloodthirsty Gladiator's Emblem of Cruelty
            { 6, 64741 }, -- Bloodthirsty Gladiator's Emblem of Meditation
            { 7, 64742 }, -- Bloodthirsty Gladiator's Emblem of Tenacity
            { 16, 64761 }, -- Bloodthirsty Gladiator's Insignia of Conquest
            { 17, 64762 }, -- Bloodthirsty Gladiator's Insignia of Dominance
            { 18, 64763 }, -- Bloodthirsty Gladiator's Insignia of Victory
            { 20, AtlasLoot:GetRetByFaction(64789, 64790) }, -- Bloodthirsty Gladiator's Medallion of Cruelty
            { 21, AtlasLoot:GetRetByFaction(64792, 64791) }, -- Bloodthirsty Gladiator's Medallion of Meditation
            { 22, AtlasLoot:GetRetByFaction(64794, 64793) }, -- Bloodthirsty Gladiator's Medallion of Tenacity
        },
        [SET2_DIFF] = {
            { 1, 61033 }, -- Vicious Gladiator's Badge of Conquest
            { 2, 61035 }, -- Vicious Gladiator's Badge of Dominance
            { 3, 61034 }, -- Vicious Gladiator's Badge of Victory
            { 5, 61026 }, -- Vicious Gladiator's Emblem of Cruelty
            { 6, 61031 }, -- Vicious Gladiator's Emblem of Meditation
            { 7, 61032 }, -- Vicious Gladiator's Emblem of Tenacity
            { 16, 61047 }, -- Vicious Gladiator's Insignia of Conquest
            { 17, 61045 }, -- Vicious Gladiator's Insignia of Dominance
            { 18, 61046 }, -- Vicious Gladiator's Insignia of Victory
            { 20, AtlasLoot:GetRetByFaction(60801, 60794) }, -- Vicious Gladiator's Medallion of Cruelty
            { 21, AtlasLoot:GetRetByFaction(60806, 60799) }, -- Vicious Gladiator's Medallion of Meditation
            { 22, AtlasLoot:GetRetByFaction(60807, 60800) }, -- Vicious Gladiator's Medallion of Tenacity
        },
    }, {
        name = AL["Gladiator Mount"],
        ExtraList = true,
        [NORMAL_DIFF] = {
            { 1, "ac6003" },
            { 2, 71339 },
        },
    }}
}

data["ArenaS10PvP"] = {
    name = format(AL["Season %s"], "10"),
    ContentType = ARENA_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    ContentPhaseCata = 3,
    items = {{
        name = AL["Sets"],
        TableType = SET_ITTYPE,
        [SET2_UPGRADE_DIFF] = {
            {1, 4005910}, -- Warlock
            {3, 4005916}, -- Priest Healing
            {4, 4005915}, -- Priest Shadow
            {6, 4005914}, -- Rogue
            {8, 4005920}, -- Hunter
            {10, 4005909}, -- Warrior Melee
            {13, 4005924}, -- Death Knight Melee
            {16, 4005919}, -- Mage
            {18, 4005923}, -- Druid Resto
            {19, 4005921}, -- Druid Balance
            {20, 4005922}, -- Druid Feral
            {22, 4005913}, -- Shaman Resto
            {23, 4005911}, -- Shaman Elemental
            {24, 4005912}, -- Shaman Enhancement
            {26, 4005918}, -- Paladin Holy
            {27, 4005917} -- Paladin Melee
        },
        [SET3_DIFF] = {
            {1, 4003910}, -- Warlock
            {3, 4003916}, -- Priest Healing
            {4, 4003915}, -- Priest Shadow
            {6, 4003914}, -- Rogue
            {8, 4003920}, -- Hunter
            {10, 4003909}, -- Warrior Melee
            {13, 4003924}, -- Death Knight Melee
            {16, 4003919}, -- Mage
            {18, 4003923}, -- Druid Resto
            {19, 4003921}, -- Druid Balance
            {20, 4003922}, -- Druid Feral
            {22, 4003913}, -- Shaman Resto
            {23, 4003911}, -- Shaman Elemental
            {24, 4003912}, -- Shaman Enhancement
            {26, 4003918}, -- Paladin Holy
            {27, 4003917} -- Paladin Melee
        },
        [SET3_ELITE_DIFF] = {
            {1, 4004910}, -- Warlock
            {3, 4004916}, -- Priest Healing
            {4, 4004915}, -- Priest Shadow
            {6, 4004914}, -- Rogue
            {8, 4004920}, -- Hunter
            {10, 4004909}, -- Warrior Melee
            {13, 4004924}, -- Death Knight Melee
            {16, 4004919}, -- Mage
            {18, 4004923}, -- Druid Resto
            {19, 4004921}, -- Druid Balance
            {20, 4004922}, -- Druid Feral
            {22, 4004913}, -- Shaman Resto
            {23, 4004911}, -- Shaman Elemental
            {24, 4004912}, -- Shaman Enhancement
            {26, 4004918}, -- Paladin Holy
            {27, 4004917} -- Paladin Melee
        },
    }, {
        name = AL["Weapons"] .. " - " .. AL["One-Handed"],
        [SET2_UPGRADE_DIFF] = {
            { 1, 61324 }, -- Vicious Gladiator's Cleaver
            { 2, 61325 }, -- Vicious Gladiator's Hacker
            { 4, 61336 }, -- Vicious Gladiator's Bonecracker
            { 5, 61335 }, -- Vicious Gladiator's Pummeler
            { 7, 61345 }, -- Vicious Gladiator's Quickblade
            { 8, 61344 }, -- Vicious Gladiator's Slicer
            { 16, 61329 }, -- Vicious Gladiator's Spellblade
            { 17, 61338 }, -- Vicious Gladiator's Gavel
            { 19, 61327 }, -- Vicious Gladiator's Shanker
            { 20, 61328 }, -- Vicious Gladiator's Shiv
            { 22, 61333 }, -- Vicious Gladiator's Right Render
            { 23, 61330 }, -- Vicious Gladiator's Right Ripper
            { 25, 61332 }, -- Vicious Gladiator's Left Render
            { 26, 61331 }, -- Vicious Gladiator's Left Ripper
        },
        [SET3_DIFF] = {
            { 1, 70211 }, -- Ruthless Gladiator's Cleaver
            { 2, 70212 }, -- Ruthless Gladiator's Hacker
            { 4, 70222 }, -- Ruthless Gladiator's Bonecracker
            { 5, 70221 }, -- Ruthless Gladiator's Pummeler
            { 7, 70230 }, -- Ruthless Gladiator's Quickblade
            { 8, 70229 }, -- Ruthless Gladiator's Slicer
            { 16, 70216 }, -- Ruthless Gladiator's Spellblade
            { 17, 70223 }, -- Ruthless Gladiator's Gavel
            { 19, 70214 }, -- Ruthless Gladiator's Shanker
            { 20, 70215 }, -- Ruthless Gladiator's Shiv
            { 22, 70220 }, -- Ruthless Gladiator's Right Render
            { 23, 70217 }, -- Ruthless Gladiator's Right Ripper
            { 25, 70219 }, -- Ruthless Gladiator's Left Render
            { 26, 70218 }, -- Ruthless Gladiator's Left Ripper
        },
        [SET3_ELITE_DIFF] = {
            { 1, 70205 }, -- Ruthless Gladiator's Cleaver
            { 2, 70204 }, -- Ruthless Gladiator's Hacker
            { 4, 70201 }, -- Ruthless Gladiator's Bonecracker
            { 5, 70202 }, -- Ruthless Gladiator's Pummeler
            { 7, 70199 }, -- Ruthless Gladiator's Quickblade
            { 8, 70200 }, -- Ruthless Gladiator's Slicer
            { 16, 70188 }, -- Ruthless Gladiator's Spellblade
            { 17, 70185 }, -- Ruthless Gladiator's Gavel
            { 19, 70203 }, -- Ruthless Gladiator's Shanker
            { 20, 70191 }, -- Ruthless Gladiator's Shiv
            { 22, 70186 }, -- Ruthless Gladiator's Right Render
            { 23, 70187 }, -- Ruthless Gladiator's Right Ripper
            { 25, 70189 }, -- Ruthless Gladiator's Left Render
            { 26, 70190 }, -- Ruthless Gladiator's Left Ripper
        },
    }, {
        name = AL["Weapons"] .. " - " .. AL["Two-Handed"],
        [SET2_UPGRADE_DIFF] = {
            { 1, 61340 }, -- Vicious Gladiator's Pike
            { 2, 61343 }, -- Vicious Gladiator's Staff
            { 4, 61326 }, -- Vicious Gladiator's Decapitator
            { 5, 61339 }, -- Vicious Gladiator's Bonegrinder
            { 6, 61346 }, -- Vicious Gladiator's Greatsword
            { 16, 61341 }, -- Vicious Gladiator's Battle Staff
            { 17, 61342 }, -- Vicious Gladiator's Energy Staff
        },
        [SET3_DIFF] = {
            { 1, 70225 }, -- Ruthless Gladiator's Pike
            { 2, 70228 }, -- Ruthless Gladiator's Staff
            { 4, 70213 }, -- Ruthless Gladiator's Decapitator
            { 5, 70224 }, -- Ruthless Gladiator's Bonegrinder
            { 6, 70231 }, -- Ruthless Gladiator's Greatsword
            { 16, 70226 }, -- Ruthless Gladiator's Battle Staff
            { 17, 70227 }, -- Ruthless Gladiator's Energy Staff
        },
        [SET3_ELITE_DIFF] = {
            { 1, 70182 }, -- Ruthless Gladiator's Pike
            { 2, 70179 }, -- Ruthless Gladiator's Staff
            { 4, 70184 }, -- Ruthless Gladiator's Decapitator
            { 5, 70183 }, -- Ruthless Gladiator's Bonegrinder
            { 6, 70178 }, -- Ruthless Gladiator's Greatsword
            { 16, 70181 }, -- Ruthless Gladiator's Battle Staff
            { 17, 70180 }, -- Ruthless Gladiator's Energy Staff
        },
    }, {
        name = AL["Weapons"] .. " - " .. AL["Ranged"],
        [SET2_UPGRADE_DIFF] = {
            { 1, 61353 }, -- Vicious Gladiator's Longbow
            { 2, 61355 }, -- Vicious Gladiator's Heavy Crossbow
            { 3, 61354 }, -- Vicious Gladiator's Rifle
            { 5, 61348 }, -- Vicious Gladiator's Hatchet
            { 6, 61347 }, -- Vicious Gladiator's War Edge
            { 16, 61351 }, -- Vicious Gladiator's Baton of Light
            { 17, 61350 }, -- Vicious Gladiator's Touch of Defeat
        },
        [SET3_DIFF] = {
            { 1, 70236 }, -- Ruthless Gladiator's Longbow
            { 2, 70238 }, -- Ruthless Gladiator's Heavy Crossbow
            { 3, 70237 }, -- Ruthless Gladiator's Rifle
            { 5, 70233 }, -- Ruthless Gladiator's Hatchet
            { 6, 70232 }, -- Ruthless Gladiator's War Edge
            { 16, 70235 }, -- Ruthless Gladiator's Baton of Light
            { 17, 70234 }, -- Ruthless Gladiator's Touch of Defeat
        },
        [SET3_ELITE_DIFF] = {
            { 1, 70192 }, -- Ruthless Gladiator's Longbow
            { 2, 70193 }, -- Ruthless Gladiator's Heavy Crossbow
            { 3, 70194 }, -- Ruthless Gladiator's Rifle
            { 5, 70197 }, -- Ruthless Gladiator's Hatchet
            { 6, 70198 }, -- Ruthless Gladiator's War Edge
            { 16, 70195 }, -- Ruthless Gladiator's Baton of Light
            { 17, 70196 }, -- Ruthless Gladiator's Touch of Defeat
        },
    }, {
        name = AL["Weapons"] .. " - " .. ALIL["Off Hand"],
        [SET2_UPGRADE_DIFF] = {
            { 1, 61357 }, -- Vicious Gladiator's Endgame
            { 2, 61358 }, -- Vicious Gladiator's Reprieve
        },
        [SET3_DIFF] = {
            { 1, 70239 }, -- Ruthless Gladiator's Endgame
            { 2, 70240 }, -- Ruthless Gladiator's Reprieve
        },
        [SET3_ELITE_DIFF] = {
            { 1, 70209 }, -- Ruthless Gladiator's Reprieve
            { 2, 70210 }, -- Ruthless Gladiator's Endgame
        },
    }, {
        name = AL["Weapons"] .. " - " .. ALIL["Shields"],
        [SET2_UPGRADE_DIFF] = {
            { 1, 61360 }, -- Vicious Gladiator's Barrier
            { 2, 61361 }, -- Vicious Gladiator's Redoubt
            { 3, 61359 }, -- Vicious Gladiator's Shield Wall
        },
        [SET3_DIFF] = {
            { 1, 70242 }, -- Ruthless Gladiator's Barrier
            { 2, 70243 }, -- Ruthless Gladiator's Redoubt
            { 3, 70241 }, -- Ruthless Gladiator's Shield Wall
        },
        [SET3_ELITE_DIFF] = {
            { 1, 70207 }, -- Ruthless Gladiator's Barrier
            { 2, 70206 }, -- Ruthless Gladiator's Redoubt
            { 3, 70208 }, -- Ruthless Gladiator's Shield Wall
        },
    }, {
        name = ALIL["Cloak"],
        [SET2_UPGRADE_DIFF] = {
            { 1, 70531 }, -- Vicious Gladiator's Cape of Cruelty
            { 2, 70532 }, -- Vicious Gladiator's Cape of Prowess
            { 4, 70542 }, -- Vicious Gladiator's Cloak of Alacrity
            { 5, 70543 }, -- Vicious Gladiator's Cloak of Prowess
            { 16, 70555 }, -- Vicious Gladiator's Drape of Diffusion
            { 17, 70556 }, -- Vicious Gladiator's Drape of Meditation
            { 18, 70557 }, -- Vicious Gladiator's Drape of Prowess
        },
        [SET3_DIFF] = {
            { 1, 70386 }, -- Ruthless Gladiator's Cape of Cruelty
            { 2, 70385 }, -- Ruthless Gladiator's Cape of Prowess
            { 4, 70383 }, -- Ruthless Gladiator's Cloak of Alacrity
            { 5, 70384 }, -- Ruthless Gladiator's Cloak of Prowess
            { 16, 70387 }, -- Ruthless Gladiator's Drape of Diffusion
            { 17, 70389 }, -- Ruthless Gladiator's Drape of Meditation
            { 18, 70388 }, -- Ruthless Gladiator's Drape of Prowess
        },
    }, {
        name = ALIL["Relic"],
        [SET2_UPGRADE_DIFF] = {
            { 1, 70628 }, -- Vicious Gladiator's Relic of Conquest
            { 2, 70629 }, -- Vicious Gladiator's Relic of Dominance
            { 3, 70630 }, -- Vicious Gladiator's Relic of Salvation
            { 4, 70631 }, -- Vicious Gladiator's Relic of Triumph
        },
        [SET3_DIFF] = {
            { 1, 70408 }, -- Ruthless Gladiator's Relic of Conquest
            { 2, 70405 }, -- Ruthless Gladiator's Relic of Dominance
            { 3, 70406 }, -- Ruthless Gladiator's Relic of Salvation
            { 4, 70407 }, -- Ruthless Gladiator's Relic of Triumph
        },
    }, {
        name = ALIL["Neck"],
        [SET2_UPGRADE_DIFF] = {
            { 1, 70538 }, -- Vicious Gladiator's Choker of Accuracy
            { 2, 70539 }, -- Vicious Gladiator's Choker of Proficiency
            { 5, 70613 }, -- Vicious Gladiator's Necklace of Proficiency
            { 6, 70614 }, -- Vicious Gladiator's Necklace of Prowess
            { 16, 70620 }, -- Vicious Gladiator's Pendant of Alacrity
            { 17, 70621 }, -- Vicious Gladiator's Pendant of Diffusion
            { 18, 70622 }, -- Vicious Gladiator's Pendant of Meditation
        },
        [SET3_DIFF] = {
            { 1, 70382 }, -- Ruthless Gladiator's Choker of Accuracy
            { 2, 70381 }, -- Ruthless Gladiator's Choker of Proficiency
            { 5, 70380 }, -- Ruthless Gladiator's Necklace of Proficiency
            { 6, 70379 }, -- Ruthless Gladiator's Necklace of Prowess
            { 16, 70377 }, -- Ruthless Gladiator's Pendant of Alacrity
            { 17, 70376 }, -- Ruthless Gladiator's Pendant of Diffusion
            { 18, 70378 }, -- Ruthless Gladiator's Pendant of Meditation
        },
    }, {
        name = ALIL["Finger"],
        [SET2_UPGRADE_DIFF] = {
            { 1, 70653 }, -- Vicious Gladiator's Signet of Accuracy
            { 2, 70654 }, -- Vicious Gladiator's Signet of Cruelty
            { 4, 70637 }, -- Vicious Gladiator's Ring of Accuracy
            { 5, 70638 }, -- Vicious Gladiator's Ring of Cruelty
            { 16, 70520 }, -- Vicious Gladiator's Band of Accuracy
            { 17, 70521 }, -- Vicious Gladiator's Band of Cruelty
            { 18, 70522 }, -- Vicious Gladiator's Band of Meditation
        },
        [SET3_DIFF] = {
            { 1, 70373 }, -- Ruthless Gladiator's Signet of Accuracy
            { 2, 70372 }, -- Ruthless Gladiator's Signet of Cruelty
            { 4, 70374 }, -- Ruthless Gladiator's Ring of Accuracy
            { 5, 70375 }, -- Ruthless Gladiator's Ring of Cruelty
            { 16, 70370 }, -- Ruthless Gladiator's Band of Accuracy
            { 17, 70369 }, -- Ruthless Gladiator's Band of Cruelty
            { 18, 70371 }, -- Ruthless Gladiator's Band of Meditation
        },
    }, {
        ---TODO--- Add 371ilvl Vicious Gladiator
        name = format(AL["Non Set '%s'"], ALIL["Cloth"]),
        [SET2_UPGRADE_DIFF] = {
            { 1, 70660 }, -- Vicious Gladiator's Treads of Alacrity
            { 2, 70661 }, -- Vicious Gladiator's Treads of Cruelty
            { 3, 70662 }, -- Vicious Gladiator's Treads of Meditation
            { 5, 70544 }, -- Vicious Gladiator's Cord of Accuracy
            { 6, 70545 }, -- Vicious Gladiator's Cord of Cruelty
            { 7, 70546 }, -- Vicious Gladiator's Cord of Meditation
            { 16, 70547 }, -- Vicious Gladiator's Cuffs of Accuracy
            { 17, 70548 }, -- Vicious Gladiator's Cuffs of Meditation
            { 18, 70549 }, -- Vicious Gladiator's Cuffs of Prowess
        },
        [SET3_DIFF] = {
            { 1, 70364 }, -- Ruthless Gladiator's Treads of Alacrity
            { 2, 70361 }, -- Ruthless Gladiator's Treads of Cruelty
            { 3, 70367 }, -- Ruthless Gladiator's Treads of Meditation
            { 5, 70362 }, -- Ruthless Gladiator's Cord of Accuracy
            { 6, 70360 }, -- Ruthless Gladiator's Cord of Cruelty
            { 7, 70368 }, -- Ruthless Gladiator's Cord of Meditation
            { 16, 70363 }, -- Ruthless Gladiator's Cuffs of Accuracy
            { 17, 70366 }, -- Ruthless Gladiator's Cuffs of Meditation
            { 18, 70365 }, -- Ruthless Gladiator's Cuffs of Prowess
        },
        [SET3_ELITE_DIFF] = {
            { 1, 70496 }, -- Ruthless Gladiator's Treads of Alacrity
            { 2, 70495 }, -- Ruthless Gladiator's Treads of Cruelty
            { 3, 70497 }, -- Ruthless Gladiator's Treads of Meditation
        },
    }, {
        name = format(AL["Non Set '%s'"], ALIL["Leather"]),
        [SET2_UPGRADE_DIFF] = {
            { 1, 70527 }, -- Vicious Gladiator's Boots of Alacrity
            { 2, 70528 }, -- Vicious Gladiator's Boots of Cruelty
            { 3, 70571 }, -- Vicious Gladiator's Footguards of Alacrity
            { 4, 70572 }, -- Vicious Gladiator's Footguards of Meditation
            { 6, 70523 }, -- Vicious Gladiator's Belt of Cruelty
            { 7, 70524 }, -- Vicious Gladiator's Belt of Meditation
            { 8, 70663 }, -- Vicious Gladiator's Waistband of Accuracy
            { 9, 70664 }, -- Vicious Gladiator's Waistband of Cruelty
            { 16, 70515 }, -- Vicious Gladiator's Armwraps of Accuracy
            { 17, 70516 }, -- Vicious Gladiator's Armwraps of Alacrity
            { 18, 70525 }, -- Vicious Gladiator's Bindings of Meditation
            { 19, 70526 }, -- Vicious Gladiator's Bindings of Prowess
        },
        [SET3_DIFF] = {
            { 1, 70351 }, -- Ruthless Gladiator's Boots of Alacrity
            { 2, 70348 }, -- Ruthless Gladiator's Boots of Cruelty
            { 3, 70358 }, -- Ruthless Gladiator's Footguards of Alacrity
            { 4, 70344 }, -- Ruthless Gladiator's Footguards of Meditation
            { 6, 70346 }, -- Ruthless Gladiator's Belt of Cruelty
            { 7, 70343 }, -- Ruthless Gladiator's Belt of Meditation
            { 8, 70349 }, -- Ruthless Gladiator's Waistband of Accuracy
            { 9, 70347 }, -- Ruthless Gladiator's Waistband of Cruelty
            { 16, 70350 }, -- Ruthless Gladiator's Armwraps of Accuracy
            { 17, 70352 }, -- Ruthless Gladiator's Armwraps of Alacrity
            { 18, 70345 }, -- Ruthless Gladiator's Bindings of Meditation
            { 19, 70359 }, -- Ruthless Gladiator's Bindings of Prowess
        },
        [SET3_ELITE_DIFF] = {
            { 1, 70507 }, -- Ruthless Gladiator's Boots of Alacrity
            { 2, 70506 }, -- Ruthless Gladiator's Boots of Cruelty
            { 3, 70499 }, -- Ruthless Gladiator's Footguards of Alacrity
            { 4, 70498 }, -- Ruthless Gladiator's Footguards of Meditation
        },
    }, {
        name = format(AL["Non Set '%s'"], ALIL["Mail"]),
        [SET2_UPGRADE_DIFF] = {
            { 1, 70640 }, -- Vicious Gladiator's Sabatons of Alacrity
            { 2, 70639 }, -- Vicious Gladiator's Sabatons of Alacrity
            { 3, 70641 }, -- Vicious Gladiator's Sabatons of Cruelty
            { 4, 70642 }, -- Vicious Gladiator's Sabatons of Meditation
            { 6, 70595 }, -- Vicious Gladiator's Links of Accuracy
            { 7, 70596 }, -- Vicious Gladiator's Links of Cruelty
            { 8, 70665 }, -- Vicious Gladiator's Waistguard of Cruelty
            { 9, 70666 }, -- Vicious Gladiator's Waistguard of Meditation
            { 16, 70511 }, -- Vicious Gladiator's Armbands of Meditation
            { 17, 70512 }, -- Vicious Gladiator's Armbands of Prowess
            { 18, 70669 }, -- Vicious Gladiator's Wristguards of Accuracy
            { 19, 70670 }, -- Vicious Gladiator's Wristguards of Alacrity
        },
        [SET3_DIFF] = {
            { 1, 70337 }, -- Ruthless Gladiator's Sabatons of Alacrity
            { 2, 70341 }, -- Ruthless Gladiator's Sabatons of Alacrity
            { 3, 70335 }, -- Ruthless Gladiator's Sabatons of Cruelty
            { 4, 70329 }, -- Ruthless Gladiator's Sabatons of Meditation
            { 6, 70339 }, -- Ruthless Gladiator's Links of Accuracy
            { 7, 70336 }, -- Ruthless Gladiator's Links of Cruelty
            { 8, 70331 }, -- Ruthless Gladiator's Waistguard of Cruelty
            { 9, 70328 }, -- Ruthless Gladiator's Waistguard of Meditation
            { 16, 70330 }, -- Ruthless Gladiator's Armbands of Meditation
            { 17, 70342 }, -- Ruthless Gladiator's Armbands of Prowess
            { 18, 70340 }, -- Ruthless Gladiator's Wristguards of Accuracy
            { 19, 70338 }, -- Ruthless Gladiator's Wristguards of Alacrity
        },
        [SET3_ELITE_DIFF] = {
            { 1, 70501 }, -- Ruthless Gladiator's Sabatons of Alacrity
            { 2, 70508 }, -- Ruthless Gladiator's Sabatons of Alacrity
            { 3, 70500 }, -- Ruthless Gladiator's Sabatons of Cruelty
            { 4, 70509 }, -- Ruthless Gladiator's Sabatons of Meditation
        },
    }, {
        name = format(AL["Non Set '%s'"], ALIL["Plate"]),
        [SET2_UPGRADE_DIFF] = {
            { 1, 70575 }, -- Vicious Gladiator's Greaves of Alacrity
            { 2, 70576 }, -- Vicious Gladiator's Greaves of Meditation
            { 3, 70667 }, -- Vicious Gladiator's Warboots of Alacrity
            { 4, 70668 }, -- Vicious Gladiator's Warboots of Cruelty
            { 6, 70540 }, -- Vicious Gladiator's Clasp of Cruelty
            { 7, 70541 }, -- Vicious Gladiator's Clasp of Meditation
            { 8, 70573 }, -- Vicious Gladiator's Girdle of Cruelty
            { 9, 70574 }, -- Vicious Gladiator's Girdle of Prowess
            { 16, 70513 }, -- Vicious Gladiator's Armplates of Alacrity
            { 17, 70514 }, -- Vicious Gladiator's Armplates of Proficiency
            { 18, 70529 }, -- Vicious Gladiator's Bracers of Meditation
            { 19, 70530 }, -- Vicious Gladiator's Bracers of Prowess
        },
        [SET3_DIFF] = {
            { 1, 70324 }, -- Ruthless Gladiator's Greaves of Alacrity
            { 2, 70333 }, -- Ruthless Gladiator's Greaves of Meditation
            { 3, 70323 }, -- Ruthless Gladiator's Warboots of Alacrity
            { 4, 70321 }, -- Ruthless Gladiator's Warboots of Cruelty
            { 6, 70319 }, -- Ruthless Gladiator's Clasp of Cruelty
            { 7, 70332 }, -- Ruthless Gladiator's Clasp of Meditation
            { 8, 70320 }, -- Ruthless Gladiator's Girdle of Cruelty
            { 9, 70326 }, -- Ruthless Gladiator's Girdle of Prowess
            { 16, 70322 }, -- Ruthless Gladiator's Armplates of Alacrity
            { 17, 70327 }, -- Ruthless Gladiator's Armplates of Proficiency
            { 18, 70334 }, -- Ruthless Gladiator's Bracers of Meditation
            { 19, 70325 }, -- Ruthless Gladiator's Bracers of Prowess
        },
        [SET3_ELITE_DIFF] = {
            { 1, 70502 }, -- Ruthless Gladiator's Greaves of Alacrity
            { 2, 70503 }, -- Ruthless Gladiator's Greaves of Meditation
            { 3, 70505 }, -- Ruthless Gladiator's Warboots of Alacrity
            { 4, 70504 }, -- Ruthless Gladiator's Warboots of Cruelty
        },
    }, {
        name = ALIL["Trinket"],
        [SET2_UPGRADE_DIFF] = {
            { 1, 70517 }, -- Vicious Gladiator's Badge of Conquest
            { 2, 70518 }, -- Vicious Gladiator's Badge of Dominance
            { 3, 70519 }, -- Vicious Gladiator's Badge of Victory
            { 5, 70563 }, -- Vicious Gladiator's Emblem of Cruelty
            { 6, 70564 }, -- Vicious Gladiator's Emblem of Meditation
            { 7, 70565 }, -- Vicious Gladiator's Emblem of Tenacity
            { 16, 70577 }, -- Vicious Gladiator's Insignia of Conquest
            { 17, 70578 }, -- Vicious Gladiator's Insignia of Dominance
            { 18, 70579 }, -- Vicious Gladiator's Insignia of Victory
            { 20, [ATLASLOOT_IT_ALLIANCE] = 70603, [ATLASLOOT_IT_HORDE] = 70602}, -- Vicious Gladiator's Medallion of Cruelty
            { 21, [ATLASLOOT_IT_ALLIANCE] = 70604, [ATLASLOOT_IT_HORDE] = 70605}, -- Vicious Gladiator's Medallion of Meditation
            { 22, [ATLASLOOT_IT_ALLIANCE] = 70606, [ATLASLOOT_IT_HORDE] = 70607}, -- Vicious Gladiator's Medallion of Tenacity
        },
        [SET3_DIFF] = {
            { 1, 70399 }, -- Ruthless Gladiator's Badge of Conquest
            { 2, 70401 }, -- Ruthless Gladiator's Badge of Dominance
            { 3, 70400 }, -- Ruthless Gladiator's Badge of Victory
            { 5, 70396 }, -- Ruthless Gladiator's Emblem of Cruelty
            { 6, 70397 }, -- Ruthless Gladiator's Emblem of Meditation
            { 7, 70398 }, -- Ruthless Gladiator's Emblem of Tenacity
            { 16, 70404 }, -- Ruthless Gladiator's Insignia of Conquest
            { 17, 70402 }, -- Ruthless Gladiator's Insignia of Dominance
            { 18, 70403 }, -- Ruthless Gladiator's Insignia of Victory
            { 20, [ATLASLOOT_IT_ALLIANCE] = 70390, [ATLASLOOT_IT_HORDE] = 70393}, -- Ruthless Gladiator's Medallion of Cruelty
            { 21, [ATLASLOOT_IT_ALLIANCE] = 70391, [ATLASLOOT_IT_HORDE] = 70394}, -- Ruthless Gladiator's Medallion of Meditation
            { 22, [ATLASLOOT_IT_ALLIANCE] = 70392, [ATLASLOOT_IT_HORDE] = 70395}, -- Ruthless Gladiator's Medallion of Tenacity
        },
    }, {
        name = AL["Gladiator Mount"],
        ExtraList = true,
        [NORMAL_DIFF] = {
            { 1, "ac6322" },
            { 2, 71954 },
        }
    }}
}

data["ArenaS11PvP"] = {
    name = format(AL["Season %s"], "11"),
    ContentType = ARENA_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    items = {
        {
            name = AL["Sets"],
            TableType = SET_ITTYPE,
            [SET3_UPGRADE_DIFF] = {
                {1, 4006910}, -- Warlock
                {3, 4006916}, -- Priest Healing
                {4, 4006915}, -- Priest Shadow
                {6, 4006914}, -- Rogue
                {8, 4006920}, -- Hunter
                {10, 4006909}, -- Warrior Melee
                {13, 4006924}, -- Death Knight Melee
                {16, 4006919}, -- Mage
                {18, 4006923}, -- Druid Resto
                {19, 4006921}, -- Druid Balance
                {20, 4006922}, -- Druid Feral
                {22, 4006913}, -- Shaman Resto
                {23, 4006911}, -- Shaman Elemental
                {24, 4006912}, -- Shaman Enhancement
                {26, 4006918}, -- Paladin Holy
                {27, 4006917} -- Paladin Melee
            },
            [SET4_DIFF] = {
                {1, 4007910}, -- Warlock
                {3, 4007916}, -- Priest Healing
                {4, 4007915}, -- Priest Shadow
                {6, 4007914}, -- Rogue
                {8, 4007920}, -- Hunter
                {10, 4007909}, -- Warrior Melee
                {13, 4007924}, -- Death Knight Melee
                {16, 4007919}, -- Mage
                {18, 4007923}, -- Druid Resto
                {19, 4007921}, -- Druid Balance
                {20, 4007922}, -- Druid Feral
                {22, 4007913}, -- Shaman Resto
                {23, 4007911}, -- Shaman Elemental
                {24, 4007912}, -- Shaman Enhancement
                {26, 4007918}, -- Paladin Holy
                {27, 4007917} -- Paladin Melee
            },
            [SET4_ELITE_DIFF] = {
                {1, 4008910}, -- Warlock
                {3, 4008916}, -- Priest Healing
                {4, 4008915}, -- Priest Shadow
                {6, 4008914}, -- Rogue
                {8, 4008920}, -- Hunter
                {10, 4008909}, -- Warrior Melee
                {13, 4008924}, -- Death Knight Melee
                {16, 4008919}, -- Mage
                {18, 4008923}, -- Druid Resto
                {19, 4008921}, -- Druid Balance
                {20, 4008922}, -- Druid Feral
                {22, 4008913}, -- Shaman Resto
                {23, 4008911}, -- Shaman Elemental
                {24, 4008912}, -- Shaman Enhancement
                {26, 4008918}, -- Paladin Holy
                {27, 4008917} -- Paladin Melee
            },
        }, {
            name = AL["Weapons"] .. " - " .. AL["One-Handed"],
            [SET3_UPGRADE_DIFF] = {
                { 1, 70211 }, -- Ruthless Gladiator's Cleaver
                { 2, 70212 }, -- Ruthless Gladiator's Hacker
                { 4, 70222 }, -- Ruthless Gladiator's Bonecracker
                { 5, 70221 }, -- Ruthless Gladiator's Pummeler
                { 7, 70230 }, -- Ruthless Gladiator's Quickblade
                { 8, 70229 }, -- Ruthless Gladiator's Slicer
                { 16, 70216 }, -- Ruthless Gladiator's Spellblade
                { 17, 70223 }, -- Ruthless Gladiator's Gavel
                { 19, 70214 }, -- Ruthless Gladiator's Shanker
                { 20, 70215 }, -- Ruthless Gladiator's Shiv
                { 22, 70220 }, -- Ruthless Gladiator's Right Render
                { 23, 70217 }, -- Ruthless Gladiator's Right Ripper
                { 25, 70219 }, -- Ruthless Gladiator's Left Render
                { 26, 70218 }, -- Ruthless Gladiator's Left Ripper
            },
            [SET4_DIFF] = {
                { 1, 73474 }, -- Cataclysmic Gladiator's Cleaver
                { 2, 73449 }, -- Cataclysmic Gladiator's Hacker
                { 4, 73448 }, -- Cataclysmic Gladiator's Bonecracker
                { 5, 73473 }, -- Cataclysmic Gladiator's Pummeler
                { 7, 73472 }, -- Cataclysmic Gladiator's Quickblade
                { 8, 73447 }, -- Cataclysmic Gladiator's Slicer
                { 16, 73467 }, -- Cataclysmic Gladiator's Spellblade
                { 17, 73459 }, -- Cataclysmic Gladiator's Gavel
                { 19, 73455 }, -- Cataclysmic Gladiator's Shanker
                { 20, 73461 }, -- Cataclysmic Gladiator's Shiv
                { 22, 73452 }, -- Cataclysmic Gladiator's Right Render
                { 23, 73454 }, -- Cataclysmic Gladiator's Right Ripper
                { 25, 73451 }, -- Cataclysmic Gladiator's Left Render
                { 26, 73453 }, -- Cataclysmic Gladiator's Left Ripper
            },
            [SET4_ELITE_DIFF] = {
                { 1, 73441 }, -- Cataclysmic Gladiator's Cleaver
                { 2, 73416 }, -- Cataclysmic Gladiator's Hacker
                { 4, 73415 }, -- Cataclysmic Gladiator's Bonecracker
                { 5, 73440 }, -- Cataclysmic Gladiator's Pummeler
                { 7, 73439 }, -- Cataclysmic Gladiator's Quickblade
                { 8, 73414 }, -- Cataclysmic Gladiator's Slicer
                { 16, 73434 }, -- Cataclysmic Gladiator's Spellblade
                { 17, 73426 }, -- Cataclysmic Gladiator's Gavel
                { 19, 73422 }, -- Cataclysmic Gladiator's Shanker
                { 20, 73428 }, -- Cataclysmic Gladiator's Shiv
                { 22, 73419 }, -- Cataclysmic Gladiator's Right Render
                { 23, 73421 }, -- Cataclysmic Gladiator's Right Ripper
                { 25, 73418 }, -- Cataclysmic Gladiator's Left Render
                { 26, 73420 }, -- Cataclysmic Gladiator's Left Ripper
            },
        }, {
            name = AL["Weapons"] .. " - " .. AL["Two-Handed"],
            [SET3_UPGRADE_DIFF] = {
                { 1, 70225 }, -- Ruthless Gladiator's Pike
                { 2, 70228 }, -- Ruthless Gladiator's Staff
                { 4, 70213 }, -- Ruthless Gladiator's Decapitator
                { 5, 70224 }, -- Ruthless Gladiator's Bonegrinder
                { 6, 70231 }, -- Ruthless Gladiator's Greatsword
                { 16, 70226 }, -- Ruthless Gladiator's Battle Staff
                { 17, 70227 }, -- Ruthless Gladiator's Energy Staff
            },
            [SET4_DIFF] = {
                { 1, 73456 }, -- Cataclysmic Gladiator's Pike
                { 2, 73462 }, -- Cataclysmic Gladiator's Staff
                { 4, 73477 }, -- Cataclysmic Gladiator's Decapitator
                { 5, 73476 }, -- Cataclysmic Gladiator's Bonegrinder
                { 6, 73475 }, -- Cataclysmic Gladiator's Greatsword
                { 16, 73466 }, -- Cataclysmic Gladiator's Battle Staff
                { 17, 73457 }, -- Cataclysmic Gladiator's Energy Staff
            },
            [SET4_ELITE_DIFF] = {
                { 1, 73423 }, -- Cataclysmic Gladiator's Pike
                { 2, 73429 }, -- Cataclysmic Gladiator's Staff
                { 4, 73444 }, -- Cataclysmic Gladiator's Decapitator
                { 5, 73443 }, -- Cataclysmic Gladiator's Bonegrinder
                { 6, 73442 }, -- Cataclysmic Gladiator's Greatsword
                { 16, 73433 }, -- Cataclysmic Gladiator's Battle Staff
                { 17, 73424 }, -- Cataclysmic Gladiator's Energy Staff
            },
        }, {
            name = AL["Weapons"] .. " - " .. AL["Ranged"],
            [SET3_UPGRADE_DIFF] = {
                { 1, 70236 }, -- Ruthless Gladiator's Longbow
                { 2, 70238 }, -- Ruthless Gladiator's Heavy Crossbow
                { 3, 70237 }, -- Ruthless Gladiator's Rifle
                { 5, 70233 }, -- Ruthless Gladiator's Hatchet
                { 6, 70232 }, -- Ruthless Gladiator's War Edge
                { 16, 70235 }, -- Ruthless Gladiator's Baton of Light
                { 17, 70234 }, -- Ruthless Gladiator's Touch of Defeat
            },
            [SET4_DIFF] = {
                { 1, 73470 }, -- Cataclysmic Gladiator's Longbow
                { 2, 73463 }, -- Cataclysmic Gladiator's Heavy Crossbow
                { 3, 73460 }, -- Cataclysmic Gladiator's Rifle
                { 5, 73471 }, -- Cataclysmic Gladiator's Hatchet
                { 6, 73445 }, -- Cataclysmic Gladiator's War Edge
                { 16, 73450 }, -- Cataclysmic Gladiator's Baton of Light
                { 17, 73464 }, -- Cataclysmic Gladiator's Touch of Defeat
            },
            [SET4_ELITE_DIFF] = {
                { 1, 73437 }, -- Cataclysmic Gladiator's Longbow
                { 2, 73430 }, -- Cataclysmic Gladiator's Heavy Crossbow
                { 3, 73427 }, -- Cataclysmic Gladiator's Rifle
                { 5, 73438 }, -- Cataclysmic Gladiator's Hatchet
                { 6, 73412 }, -- Cataclysmic Gladiator's War Edge
                { 16, 73417 }, -- Cataclysmic Gladiator's Baton of Light
                { 17, 73431 }, -- Cataclysmic Gladiator's Touch of Defeat
            },
        }, {
            name = AL["Weapons"] .. " - " .. ALIL["Off Hand"],
            [SET3_UPGRADE_DIFF] = {
                { 1, 61357 }, -- Vicious Gladiator's Endgame
                { 2, 61358 }, -- Vicious Gladiator's Reprieve
            },
            [SET4_DIFF] = {
                { 1, 73469 }, -- Cataclysmic Gladiator's Endgame
                { 2, 73465 }, -- Cataclysmic Gladiator's Reprieve
            },
            [SET4_ELITE_DIFF] = {
                { 1, 73436 }, -- Cataclysmic Gladiator's Endgame
                { 2, 73432 }, -- Cataclysmic Gladiator's Reprieve
            },
        }, {
            name = AL["Weapons"] .. " - " .. ALIL["Shields"],
            [SET3_UPGRADE_DIFF] = {
                { 1, 61360 }, -- Vicious Gladiator's Barrier
                { 2, 61361 }, -- Vicious Gladiator's Redoubt
                { 3, 61359 }, -- Vicious Gladiator's Shield Wall
            },
            [SET4_DIFF] = {
                { 1, 73468 }, -- Cataclysmic Gladiator's Barrier
                { 2, 73458 }, -- Cataclysmic Gladiator's Redoubt
                { 3, 73446 }, -- Cataclysmic Gladiator's Shield Wall
            },
            [SET4_ELITE_DIFF] = {
                { 1, 73435 }, -- Cataclysmic Gladiator's Barrier
                { 2, 73425 }, -- Cataclysmic Gladiator's Redoubt
                { 3, 73413 }, -- Cataclysmic Gladiator's Shield Wall
            },
        }, {
            name = ALIL["Relic"],
                [SET3_UPGRADE_DIFF] = {
                    { 1, 72456 }, -- Ruthless Gladiator's Relic of Conquest
                    { 2, 72328 }, -- Ruthless Gladiator's Relic of Dominance
                    { 3, 72358 }, -- Ruthless Gladiator's Relic of Salvation
                    { 4, 72310 }, -- Ruthless Gladiator's Relic of Triumph
                },
                [SET4_DIFF] = {
                    { 1, 73490 }, -- Cataclysmic Gladiator's Relic of Conquest
                    { 2, 73624 }, -- Cataclysmic Gladiator's Relic of Dominance
                    { 3, 73594 }, -- Cataclysmic Gladiator's Relic of Salvation
                    { 4, 73642 }, -- Cataclysmic Gladiator's Relic of Triumph
                },
                [SET4_ELITE_DIFF] = {
                    { 1, 74783 }, -- Cataclysmic Gladiator's Relic of Conquest
                    { 2, 74785 }, -- Cataclysmic Gladiator's Relic of Dominance
                    { 3, 74784 }, -- Cataclysmic Gladiator's Relic of Salvation
                    { 4, 74786 }, -- Cataclysmic Gladiator's Relic of Triumph
                }
        }, {
            name = ALIL["Cloak"],
            [SET3_UPGRADE_DIFF] = {
                { 1, 72305 }, -- Ruthless Gladiator's Cape of Cruelty
                { 2, 72306 }, -- Ruthless Gladiator's Cape of Prowess
                { 4, 72451 }, -- Ruthless Gladiator's Cloak of Alacrity
                { 5, 72452 }, -- Ruthless Gladiator's Cloak of Prowess
                { 16, 72323 }, -- Ruthless Gladiator's Drape of Diffusion
                { 17, 72324 }, -- Ruthless Gladiator's Drape of Meditation
                { 18, 72322 }, -- Ruthless Gladiator's Drape of Prowess
            },
            [SET4_DIFF] = {
                { 1, 73647 }, -- Cataclysmic Gladiator's Cape of Cruelty
                { 2, 73646 }, -- Cataclysmic Gladiator's Cape of Prowess
                { 4, 73494 }, -- Cataclysmic Gladiator's Cloak of Alacrity
                { 5, 72452 }, -- Cataclysmic Gladiator's Cloak of Prowess
                { 16, 73629 }, -- Cataclysmic Gladiator's Drape of Diffusion
                { 17, 73628 }, -- Cataclysmic Gladiator's Drape of Meditation
                { 18, 73630 }, -- Cataclysmic Gladiator's Drape of Prowess
            },
        }, {
            name = ALIL["Neck"],
                [SET3_UPGRADE_DIFF] = {
                    { 1, 72454 }, -- Ruthless Gladiator's Choker of Accuracy
                    { 2, 72453 }, -- Ruthless Gladiator's Choker of Proficiency
                    { 5, 72307 }, -- Ruthless Gladiator's Necklace of Proficiency
                    { 6, 72308 }, -- Ruthless Gladiator's Necklace of Prowess
                    { 16, 72325 }, -- Ruthless Gladiator's Pendant of Alacrity
                    { 17, 72326 }, -- Ruthless Gladiator's Pendant of Diffusion
                    { 18, 72327 }, -- Ruthless Gladiator's Pendant of Meditation
                },
                [SET4_DIFF] = {
                    { 1, 73492 }, -- Cataclysmic Gladiator's Choker of Accuracy
                    { 2, 73493 }, -- Cataclysmic Gladiator's Choker of Proficiency
                    { 5, 73645 }, -- Cataclysmic Gladiator's Necklace of Proficiency
                    { 6, 73644 }, -- Cataclysmic Gladiator's Necklace of Prowess
                    { 16, 73627 }, -- Cataclysmic Gladiator's Pendant of Alacrity
                    { 17, 73626 }, -- Cataclysmic Gladiator's Pendant of Diffusion
                    { 18, 73625 }, -- Cataclysmic Gladiator's Pendant of Meditation
                },
        }, {
            name = ALIL["Finger"],
            [SET3_UPGRADE_DIFF] = {
                { 1, 72458 }, -- Ruthless Gladiator's Signet of Accuracy
                { 2, 72457 }, -- Ruthless Gladiator's Signet of Cruelty
                { 4, 72312 }, -- Ruthless Gladiator's Ring of Accuracy
                { 5, 72311 }, -- Ruthless Gladiator's Ring of Cruelty
                { 16, 72330 }, -- Ruthless Gladiator's Band of Accuracy
                { 17, 72329 }, -- Ruthless Gladiator's Band of Cruelty
                { 18, 72331 }, -- Ruthless Gladiator's Band of Meditation
            },
            [SET4_DIFF] = {
                { 1, 73488 }, -- Cataclysmic Gladiator's Signet of Accuracy
                { 2, 73489 }, -- Cataclysmic Gladiator's Signet of Cruelty
                { 4, 73640 }, -- Cataclysmic Gladiator's Ring of Accuracy
                { 5, 73641 }, -- Cataclysmic Gladiator's Ring of Cruelty
                { 16, 73622 }, -- Cataclysmic Gladiator's Band of Accuracy
                { 17, 73623 }, -- Cataclysmic Gladiator's Band of Cruelty
                { 18, 73621 }, -- Cataclysmic Gladiator's Band of Meditation
            },
        }, {
            name = format(AL["Non Set '%s'"], ALIL["Cloth"]),
            [SET3_UPGRADE_DIFF] = {
                { 1, 72317 }, -- Ruthless Gladiator's Treads of Alacrity
                { 2, 72316 }, -- Ruthless Gladiator's Treads of Cruelty
                { 3, 72318 }, -- Ruthless Gladiator's Treads of Meditation
                { 5, 72314 }, -- Ruthless Gladiator's Cord of Accuracy
                { 6, 72313 }, -- Ruthless Gladiator's Cord of Cruelty
                { 7, 72315 }, -- Ruthless Gladiator's Cord of Meditation
                { 16, 72319 }, -- Ruthless Gladiator's Cuffs of Accuracy
                { 17, 72321 }, -- Ruthless Gladiator's Cuffs of Meditation
                { 18, 72320 }, -- Ruthless Gladiator's Cuffs of Prowess
            },
            [SET4_DIFF] = {
                { 1, 73635 }, -- Cataclysmic Gladiator's Treads of Alacrity
                { 2, 73636 }, -- Cataclysmic Gladiator's Treads of Cruelty
                { 3, 73634 }, -- Cataclysmic Gladiator's Treads of Meditation
                { 5, 73638 }, -- Cataclysmic Gladiator's Cord of Accuracy
                { 6, 73639 }, -- Cataclysmic Gladiator's Cord of Cruelty
                { 7, 73637 }, -- Cataclysmic Gladiator's Cord of Meditation
                { 16, 73633 }, -- Cataclysmic Gladiator's Cuffs of Accuracy
                { 17, 73631 }, -- Cataclysmic Gladiator's Cuffs of Meditation
                { 18, 73632 }, -- Cataclysmic Gladiator's Cuffs of Prowess
            },
            [SET4_ELITE_DIFF] = {
                { 1, 73744 }, -- Cataclysmic Gladiator's Treads of Alacrity
                { 2, 73745 }, -- Cataclysmic Gladiator's Treads of Cruelty
                { 3, 73743 }, -- Cataclysmic Gladiator's Treads of Meditation
            }
        }, {
            name = format(AL["Non Set '%s'"], ALIL["Leather"]),
            [SET3_UPGRADE_DIFF] = {
                { 1, 72419 }, -- Ruthless Gladiator's Boots of Alacrity
                { 2, 72418 }, -- Ruthless Gladiator's Boots of Cruelty
                { 3, 72351 }, -- Ruthless Gladiator's Footguards of Alacrity
                { 4, 72343 }, -- Ruthless Gladiator's Footguards of Meditation
                { 6, 72350 }, -- Ruthless Gladiator's Belt of Cruelty
                { 7, 72342 }, -- Ruthless Gladiator's Belt of Meditation
                { 8, 72417 }, -- Ruthless Gladiator's Waistband of Accuracy
                { 9, 72416 }, -- Ruthless Gladiator's Waistband of Cruelty
                { 16, 72421 }, -- Ruthless Gladiator's Armwraps of Accuracy
                { 17, 72420 }, -- Ruthless Gladiator's Armwraps of Alacrity
                { 18, 72431 }, -- Ruthless Gladiator's Bindings of Meditation
                { 19, 72430 }, -- Ruthless Gladiator's Bindings of Prowess
            },
            [SET4_DIFF] = {
                { 1, 73530 }, -- Cataclysmic Gladiator's Boots of Alacrity
                { 2, 73531 }, -- Cataclysmic Gladiator's Boots of Cruelty
                { 3, 73601 }, -- Cataclysmic Gladiator's Footguards of Alacrity
                { 4, 73609 }, -- Cataclysmic Gladiator's Footguards of Meditation
                { 6, 73602 }, -- Cataclysmic Gladiator's Belt of Cruelty
                { 7, 73610 }, -- Cataclysmic Gladiator's Belt of Meditation
                { 8, 73532 }, -- Cataclysmic Gladiator's Waistband of Accuracy
                { 9, 73533 }, -- Cataclysmic Gladiator's Waistband of Cruelty
                { 16, 73528 }, -- Cataclysmic Gladiator's Armwraps of Accuracy
                { 17, 73529 }, -- Cataclysmic Gladiator's Armwraps of Alacrity
                { 18, 73608 }, -- Cataclysmic Gladiator's Bindings of Meditation
                { 19, 73600 }, -- Cataclysmic Gladiator's Bindings of Prowess
            },
            [SET4_ELITE_DIFF] = {
                { 1, 73683 }, -- Cataclysmic Gladiator's Boots of Alacrity
                { 2, 73684 }, -- Cataclysmic Gladiator's Boots of Cruelty
                { 3, 73726 }, -- Cataclysmic Gladiator's Footguards of Alacrity
                { 4, 73732 }, -- Cataclysmic Gladiator's Footguards of Meditation
            },
        }, {
            name = format(AL["Non Set '%s'"], ALIL["Mail"]),
            [SET3_UPGRADE_DIFF] = {
                { 1, 72428 }, -- Ruthless Gladiator's Sabatons of Alacrity
                { 2, 72365 }, -- Ruthless Gladiator's Sabatons of Alacrity
                { 3, 72364 }, -- Ruthless Gladiator's Sabatons of Cruelty
                { 4, 72429 }, -- Ruthless Gladiator's Sabatons of Meditation
                { 6, 72363 }, -- Ruthless Gladiator's Links of Accuracy
                { 7, 72362 }, -- Ruthless Gladiator's Links of Cruelty
                { 8, 72442 }, -- Ruthless Gladiator's Waistguard of Cruelty
                { 9, 72427 }, -- Ruthless Gladiator's Waistguard of Meditation
                { 16, 72399 }, -- Ruthless Gladiator's Armbands of Meditation
                { 17, 72398 }, -- Ruthless Gladiator's Armbands of Prowess
                { 18, 72367 }, -- Ruthless Gladiator's Wristguards of Accuracy
                { 19, 72366 }, -- Ruthless Gladiator's Wristguards of Alacrity
            },
            [SET4_DIFF] = {
                { 1, 73587 }, -- Cataclysmic Gladiator's Sabatons of Alacrity
                { 2, 73521 }, -- Cataclysmic Gladiator's Sabatons of Alacrity
                { 3, 73588 }, -- Cataclysmic Gladiator's Sabatons of Cruelty
                { 4, 73520 }, -- Cataclysmic Gladiator's Sabatons of Meditation
                { 6, 73589 }, -- Cataclysmic Gladiator's Links of Accuracy
                { 7, 73590 }, -- Cataclysmic Gladiator's Links of Cruelty
                { 8, 73507 }, -- Cataclysmic Gladiator's Waistguard of Cruelty
                { 9, 73522 }, -- Cataclysmic Gladiator's Waistguard of Meditation
                { 16, 73518 }, -- Cataclysmic Gladiator's Armbands of Meditation
                { 17, 73519 }, -- Cataclysmic Gladiator's Armbands of Prowess
                { 18, 73585 }, -- Cataclysmic Gladiator's Wristguards of Accuracy
                { 19, 73586 }, -- Cataclysmic Gladiator's Wristguards of Alacrity
            },
            [SET4_ELITE_DIFF] = {
                { 1, 73677 }, -- Cataclysmic Gladiator's Sabatons of Alacrity
                { 2, 73719 }, -- Cataclysmic Gladiator's Sabatons of Alacrity
                { 3, 73720 }, -- Cataclysmic Gladiator's Sabatons of Cruelty
                { 4, 73676 }, -- Cataclysmic Gladiator's Sabatons of Meditation
            },
        }, {
            name = format(AL["Non Set '%s'"], ALIL["Plate"]),
            [SET3_UPGRADE_DIFF] = {
                { 1, 72385 }, -- Ruthless Gladiator's Greaves of Alacrity
                { 2, 72386 }, -- Ruthless Gladiator's Greaves of Meditation
                { 3, 72397 }, -- Ruthless Gladiator's Warboots of Alacrity
                { 4, 72396 }, -- Ruthless Gladiator's Warboots of Cruelty
                { 6, 72383 }, -- Ruthless Gladiator's Clasp of Cruelty
                { 7, 72384 }, -- Ruthless Gladiator's Clasp of Meditation
                { 8, 72394 }, -- Ruthless Gladiator's Girdle of Cruelty
                { 9, 72395 }, -- Ruthless Gladiator's Girdle of Prowess
                { 16, 72344 }, -- Ruthless Gladiator's Armplates of Alacrity
                { 17, 72352 }, -- Ruthless Gladiator's Armplates of Proficiency
                { 18, 72388 }, -- Ruthless Gladiator's Bracers of Meditation
                { 19, 72387 }, -- Ruthless Gladiator's Bracers of Prowess
            },
            [SET4_DIFF] = {
                { 1, 73564 }, -- Cataclysmic Gladiator's Greaves of Alacrity
                { 2, 73563 }, -- Cataclysmic Gladiator's Greaves of Meditation
                { 3, 73552 }, -- Cataclysmic Gladiator's Warboots of Alacrity
                { 4, 73553 }, -- Cataclysmic Gladiator's Warboots of Cruelty
                { 6, 73566 }, -- Cataclysmic Gladiator's Clasp of Cruelty
                { 7, 73565 }, -- Cataclysmic Gladiator's Clasp of Meditation
                { 8, 73555 }, -- Cataclysmic Gladiator's Girdle of Cruelty
                { 9, 73554 }, -- Cataclysmic Gladiator's Girdle of Prowess
                { 16, 73550 }, -- Cataclysmic Gladiator's Armplates of Alacrity
                { 17, 73551 }, -- Cataclysmic Gladiator's Armplates of Proficiency
                { 18, 73561 }, -- Cataclysmic Gladiator's Bracers of Meditation
                { 19, 73562 }, -- Cataclysmic Gladiator's Bracers of Prowess
            },
            [SET4_ELITE_DIFF] = {
                { 1, 73703 }, -- Cataclysmic Gladiator's Greaves of Alacrity
                { 2, 73702 }, -- Cataclysmic Gladiator's Greaves of Meditation
                { 3, 73695 }, -- Cataclysmic Gladiator's Warboots of Alacrity
                { 4, 73696 }, -- Cataclysmic Gladiator's Warboots of Cruelty
            },
        }, {
            name = ALIL["Trinket"],
            [SET3_UPGRADE_DIFF] = {
                { 1, 72304 }, -- Ruthless Gladiator's Badge of Conquest
                { 2, 72448 }, -- Ruthless Gladiator's Badge of Dominance
                { 3, 72450 }, -- Ruthless Gladiator's Badge of Victory
                { 5, 72359 }, -- Ruthless Gladiator's Emblem of Cruelty
                { 6, 72361 }, -- Ruthless Gladiator's Emblem of Meditation
                { 7, 72360 }, -- Ruthless Gladiator's Emblem of Tenacity
                { 16, 72309 }, -- Ruthless Gladiator's Insignia of Conquest
                { 17, 72449 }, -- Ruthless Gladiator's Insignia of Dominance
                { 18, 72455 }, -- Ruthless Gladiator's Insignia of Victory
                { 20, [ATLASLOOT_IT_ALLIANCE] = 72411, [ATLASLOOT_IT_HORDE] = 72410 }, -- Ruthless Gladiator's Medallion of Cruelty
                { 21, [ATLASLOOT_IT_ALLIANCE] = 72414, [ATLASLOOT_IT_HORDE] = 72415 }, -- Ruthless Gladiator's Medallion of Meditation
                { 22, [ATLASLOOT_IT_ALLIANCE] = 72412, [ATLASLOOT_IT_HORDE] = 72413 }, -- Ruthless Gladiator's Medallion of Tenacity
            },
            [SET4_DIFF] = {
                { 1, 73648 }, -- Cataclysmic Gladiator's Badge of Conquest
                { 2, 73498 }, -- Cataclysmic Gladiator's Badge of Dominance
                { 3, 73496 }, -- Cataclysmic Gladiator's Badge of Victory
                { 5, 73593 }, -- Cataclysmic Gladiator's Emblem of Cruelty
                { 6, 73591 }, -- Cataclysmic Gladiator's Emblem of Meditation
                { 7, 73592 }, -- Cataclysmic Gladiator's Emblem of Tenacity
                { 16, 73643 }, -- Cataclysmic Gladiator's Insignia of Conquest
                { 17, 73497 }, -- Cataclysmic Gladiator's Insignia of Dominance
                { 18, 73491 }, -- Cataclysmic Gladiator's Insignia of Victory
                { 20, [ATLASLOOT_IT_ALLIANCE] = 73539, [ATLASLOOT_IT_HORDE] = 73538 }, -- Cataclysmic Gladiator's Medallion of Cruelty
                { 21, [ATLASLOOT_IT_ALLIANCE] = 73535, [ATLASLOOT_IT_HORDE] = 73534 }, -- Cataclysmic Gladiator's Medallion of Meditation
                { 22, [ATLASLOOT_IT_ALLIANCE] = 73536, [ATLASLOOT_IT_HORDE] = 73537 }, -- Cataclysmic Gladiator's Medallion of Tenacity
            },
        }, {
            name = ALIL["Gems"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 77140 }, -- Stormy Deepholm Iolite
                { 3, 77134 }, -- Mystic Lightstone
                { 5, 77144 }, -- Willful Lava Coral
                { 6, 77141 }, -- Tenuous Lava Coral
                { 7, 77138 }, -- Splendid Lava Coral
                { 8, 77136 }, -- Resplendent Lava Coral
                { 9, 77132 }, -- Lucent Lava Coral
                { 16, 77133 }, -- Mysterious Shadow Spinel
                { 18, 77143 }, -- Vivid Elven Peridot
                { 19, 77142 }, -- Turbid Elven Peridot
                { 20, 77139 }, -- Steady Elven Peridot
                { 21, 77137 }, -- Shattered Elven Peridot
                { 22, 77154 }, -- Radiant Elven Peridot
                { 23, 77131 }, -- Infused Elven Peridot
                { 24, 77130 }, -- Balanced Elven Peridot
            },
        },
        --- Add back after MoP pre-patch, doesn't seem exist in Cata right now
        -- {
        --     name = AL["Gladiator Mount"],
        --     ExtraList = true,
        --     [NORMAL_DIFF] = {
        --         { 1, "ac6741" },
        --         { 2, 85785 },
        --     }
        --     }
    }
}
