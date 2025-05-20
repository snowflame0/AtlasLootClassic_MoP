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

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")

--local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
--local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
--local SET_EXTRA_ITTYPE = data:AddExtraItemTableType("Set")

local FACTIONS_CONTENT = data:AddContentType(AL["Factions"], ATLASLOOT_FACTION_COLOR)
--local FACTIONS2_CONTENT = data:AddContentType(AL["Secondary factions"], {0.1, 0.3, 0.1, 1})

local FACTIONS_HORDE_CONTENT, FACTIONS_ALLI_CONTENT
if UnitFactionGroup("player") == "Horde" then
    FACTIONS_HORDE_CONTENT = data:AddContentType(FACTION_HORDE, ATLASLOOT_HORDE_COLOR)
    FACTIONS_ALLI_CONTENT = data:AddContentType(FACTION_ALLIANCE, ATLASLOOT_ALLIANCE_COLOR)
else
    FACTIONS_ALLI_CONTENT = data:AddContentType(FACTION_ALLIANCE, ATLASLOOT_ALLIANCE_COLOR)
    FACTIONS_HORDE_CONTENT = data:AddContentType(FACTION_HORDE, ATLASLOOT_HORDE_COLOR)
end

--[[
0 - Unknown
1 - Hated
2 - Hostile
3 - Unfriendly
4 - Neutral
5 - Friendly
6 - Honored
7 - Revered
8 - Exalted
]]--

data["GoldenLotus"] = {
    FactionID = 1269,
    ContentType = FACTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    --ContentPhaseMoP = 1,
    items = {
        { -- Exalted 8
            name = ALIL["Exalted"],
            [NORMAL_DIFF] = {
                {1, "f1269rep8"},
                {2, 71237}, -- Quicksilver Signet of the Avengers
                {3, 71215}, -- Obsidian Signet of the Avengers
                {4, 70934}, -- Adamantine Signet of the Avengers
                {5, 71216}, -- Viridian Signet of the Avengers
                {6, 71217}, -- Infernal Signet of the Avengers
            },
        },
        { -- Revered 7
            name = ALIL["Revered"],
            [NORMAL_DIFF] = {
                {1, "f1269rep7"},
                {2, 69001}, -- Ancient Petrified Seed
                {3, 68998}, -- Rune of Zeth
                {4, 69000}, -- Fiery Quintessence
                {5, 68996}, -- Stay of Execution
                {6, 69002}, -- Essence of the Eternal Flame
            },
        },
        { -- Honored 6
            name = ALIL["Honored"],
            [NORMAL_DIFF] = {
                {1, "f1269rep6"},
                {2, 71258}, -- Embereye Belt
                {3, 71249}, -- Firescar Sash
                {4, 71131}, -- Flamebinding Girdle
                {5, 71254}, -- Firemend Cinch
                {6, 71255}, -- Firearrow Belt
                {7, 71250}, -- Cinch of the Flaming Ember
                {8, 70933}, -- Girdle of the Indomitable Flame
                {9, 71253}, -- Belt of the Seven Seals
            },
        },
        { -- Friendly 5
            name = ALIL["Friendly"],
            [NORMAL_DIFF] = {
                {1, "f1269rep5"},
                {2, 71229}, -- Flowing Flamewrath Cape
                {3, 71227}, -- Bladed Flamewrath Cover
                {4, 70930}, -- Durable Flamewrath Greatcloak
                {5, 71228}, -- Sleek Flamewrath Cloak
                {6, 71230}, -- Rippling Flamewrath Drape
            },
        },
    },
}
