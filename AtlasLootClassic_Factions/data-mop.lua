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

data["Golden Lotus"] = {
    FactionID = 1269,
    ContentType = FACTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    items = {
        { -- Exalted 8
            name = ALIL["Exalted"],
            [NORMAL_DIFF] = {
                {1, "f1269rep8"},
                {2, 89797}, -- Golden Lotus Tabard
                {17, 87782}, -- Reins of the Golden Riding Crane
                {18, 87781}, -- Reins of the Azure Riding Crane
                {19, 87783}, -- Reins of the Regal Riding Crane
            },
        },
        { -- Revered 7
            name = ALIL["Revered"],
            [NORMAL_DIFF] = {
                {1, "f1269rep7"},
                {2, 89433}, -- Vestments of Thundering Skies
                {3, 89434}, -- Robe of the Five Sisters
                {4, 89431}, -- Softfoot Silentwrap
                {5, 89429}, -- Robes of the Setting Sun
                {6, 89420}, -- Dawnblade's Chestguard
                {7, 89423}, -- Battleguard of Guo-Lai
                {8, 89421}, -- Cuirass of the Twin Monoliths
                {9, 89432}, -- Mistfall Robes
                {10, 89430}, -- Breastplate of the Golden Pagoda
                {17, 93215}, -- Grand Commendation of the Golden Lotus
            },
        },
        { -- Honored 6
            name = ALIL["Honored"],
            [NORMAL_DIFF] = {
                {1, "f1269rep6"},
                {2, 89339}, -- Tenderheart Shoulders
                {3, 89340}, -- Mantle of the Golden Sun
                {4, 89341}, -- Imperion Spaulders
                {5, 89342}, -- Whitepetal Shouldergarb
                {6, 89344}, -- Windwalker Spaulders
                {7, 89343}, -- Mindbender Shoulders
                {8, 89345}, -- Stonetoe Spaulders
                {9, 89347}, -- Paleblade Shoulderguards
                {10, 89346}, -- Shoulders of Autumnlight
                {17, 89072}, -- Simple Harmonius Ring
                {18, 89073}, -- Leven's Circle of Hope
                {19, 89070}, -- Anji's Keepsake
                {20, 89069}, -- Ring of the Golden Stair
                {21, 89071}, -- Alani's Inflexible Ring
                {101, "f1269rep6"},
                {102, 86295}, -- Pattern: Shadowleather Leg Armor
                {103, 86235}, -- Pattern: Angerhide Leg Armor
                {104, 86276}, -- Pattern: Ironscale Leg Armor
                {105, 86273}, -- Pattern: Gloves of Earthen Harmony
                {106, 86237}, -- Pattern: Chestguard of Earthen Harmony
                {107, 86308}, -- Pattern: Wildblood Gloves
                {108, 86309}, -- Pattern: Wildblood Vest
                {109, 86274}, -- Pattern: Greyshadow Chestguard
                {110, 86275}, -- Pattern: Greyshadow Gloves
                {111, 86278}, -- Pattern: Lifekeeper's Robe
                {112, 86277}, -- Pattern: Lifekeeper's Gloves
                {117, 86376}, -- Pattern: Greater Cerulean Spellthread
                {118, 86375}, -- Pattern: Greater Pearlescent Spellthread
                {119, 86370}, -- Pattern: Robes of Creation
                {120, 86371}, -- Pattern: Gloves of Creation
                {121, 86368}, -- Pattern: Spelltwister's Grand Robe
                {122, 86369}, -- Pattern: Spelltwister's Gloves
            },
        },
    },
}

data["Shado-Pan"] = {
    FactionID = 1270,
    ContentType = FACTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    items = {
        { -- Exalted 8
            name = ALIL["Exalted"],
            [NORMAL_DIFF] = {
                {1, "f1270rep8"},
                {2, 89801}, -- Replica Shado-Pan Helmet
                {3, 90844}, -- Replica Shado-Pan Helmet
                {4, 90845}, -- Replica Shado-Pan Helmet
                {5, 90846}, -- Replica Shado-Pan Helmet
                {7, 89800}, -- Shado-Pan Tabard
                {17, 89306}, -- Reins of the Red Shado-Pan Riding Tiger
                {18, 89307}, -- Reins of the Blue Shado-Pan Riding Tiger
                {19, 89305}, -- Reins of the Green Shado-Pan Riding Tiger
            },
        },
        { -- Revered 7
            name = ALIL["Revered"],
            [NORMAL_DIFF] = {
                {1, "f1270rep7"},
                {2, 89337}, -- Firecracker Corona
                {3, 89338}, -- Yalia's Cowl
                {4, 89300}, -- Red Smoke Bandana
                {5, 89308}, -- Snowdrift Helm
                {6, 89291}, -- Hawkmaster's Headguard
                {7, 89296}, -- Nightwatcher's Helm
                {8, 89096}, -- Six Pool's Open Helm
                {9, 89280}, -- Voice Amplyifying Greathelm
                {10, 89216}, -- Yi's Least Favorite Helmet
                {17, 93220}, -- Grand Commendation of the Shado-Pan
                {19, 84584}, -- Formula: Enchant Weapon - Dancing Steel
                {20, 84583}, -- Formula: Enchant Weapon - Jade Spirit
                {21, 84580}, -- Formula: Enchant Weapon - River's Song
            },
        },
        { -- Honored 6
            name = ALIL["Honored"],
            [NORMAL_DIFF] = {
                {1, "f1270rep6"},
                {2, 89078}, -- Sagewhisper's Wrap
                {3, 89077}, -- Cloak of Snow Blossoms
                {4, 89074}, -- Cloak of the Dark Disciple
                {5, 89076}, -- Blackguard Cape
                {6, 89075}, -- Yi's Cloak of Courage
                {8, 89081}, -- Blossom of Pure Snow
                {9, 89083}, -- Iron Belly Wok
                {10, 89082}, -- Hawkmaster's Talon
                {11, 89079}, -- Lao-Chin's Liquid Courage
                {12, 89080}, -- Scroll of Revered Ancestors
                {17, 89301}, -- Stack of Wooden Boards
                {18, 89302}, -- Stack of Bamboo
                {19, 89303}, -- Stack of Stone Blocks
            },
        },
    },
}

data["Order of the Cloud Serpent"] = {
    FactionID = 1271,
    ContentType = FACTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    items = {
        { -- Exalted 8
            name = ALIL["Exalted"],
            [NORMAL_DIFF] = {
                {1, "f1271rep8"},
                {2, 89796}, -- Order of the Cloud Serpent Tabard
                {17, 85429}, -- Reins of the Golden Cloud Serpent
                {18, 79802}, -- Reins of the Jade Cloud Serpent
                {19, 85430}, -- Reins of the Azure Cloud Serpent
                {21, 83877}, -- Design: Jeweled Onyx Panther
            },
        },
        { -- Revered 7
            name = ALIL["Revered"],
            [NORMAL_DIFF] = {
                {1, "f1271rep7"},
                {2, 89222}, -- Cloud Ring
                {3, 89223}, -- Racing Flag
                {4, 89224}, -- Floating Racing Flag
                {5, 89227}, -- Floating Finish Line
                {6, 89225}, -- Finish Line
                {17, 93229}, -- Grand Commendation of the Order of the Cloud Serpent
                {19, 83931}, -- Design: Ruby Panther
                {20, 83932}, -- Design: Sapphire Panther
            },
        },
        { -- Honored 6
            name = ALIL["Honored"],
            [NORMAL_DIFF] = {
                {1, "f1271rep6"},
                {17, 83845}, -- Design: Jade Panther
                {18, 83830}, -- Design: Sunstone Panther
            },
        },
    },
}

data["The Tillers"] = {
    FactionID = 1272,
    ContentType = FACTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    items = {
        { -- Exalted 8
            name = ALIL["Exalted"],
            [NORMAL_DIFF] = {
                {1, "f1272rep8"},
                {2, 80914}, -- Mourning Glory
                {4, 89784}, -- Tillers Tabard
                {17, 89391}, -- Reins of the Black Riding Goat
                {18, 89390}, -- Reins of the White Riding Goat
                {19, 89362}, -- Reins of the Brown Riding Goat
                {21, 90175}, -- Gin-Ji Knife Set
            },
        },
        { -- Revered 7
            name = ALIL["Revered"],
            [NORMAL_DIFF] = {
                {1, "f1272rep7"},
                {2, 89869}, -- Pandaren Scarecrow
                {17, 93226}, -- Grand Commendation of the Tillers
                {19, 74657}, -- Recipe: Spicy Salmon
                {20, 74658}, -- Recipe: Spicy Vegetable Chips
            },
        },
    },
}

data["The Anglers"] = {
    FactionID = 1302,
    ContentType = FACTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    items = {
        { -- Exalted 8
            name = ALIL["Exalted"],
            [NORMAL_DIFF] = {
                {1, "f1302rep8"},
                {2, 89401}, -- Anglers Tabard
                {17, 81354}, -- Reins of the Azure Water Strider
                {18, 87791}, -- Reins of the Crimson Water Strider
                {19, 87793}, -- Reins of the Jade Water Strider
                {20, 87792}, -- Reins of the Orange Water Strider
                {21, 87794}, -- Reins of the Golden Water Strider
            },
        },
        { -- Revered 7
            name = ALIL["Revered"],
            [NORMAL_DIFF] = {
                {1, "f1302rep7"},
                {2, 84661}, -- Dragon Fishing Pole
                {3, 88535}, -- Sharpened Tuskarr Spear
                {17, 93225}, -- Grand Commendation of the Anglers
                {19, 85500}, -- Anglers Fishing Raft
                {20, 107950}, -- Bipsi's Bobbing Berg
            },
        },
        { -- Honored 6
            name = ALIL["Honored"],
            [NORMAL_DIFF] = {
                {1, "f1302rep6"},
                {2, 84660}, -- Pandaren Fishing Pole
                {17, 85447}, -- Tiny Goldfish
            },
        },
        { -- Friendly 5
            name = ALIL["Friendly"],
            [NORMAL_DIFF] = {
                {1, "f1302rep5"},
                {17, 85502}, -- Recipe: Viseclaw Soup
                {18, 85505}, -- Recipe: Krasarang Fritters
            },
        },
    },
}

data["The August Celestials"] = {
    FactionID = 1341,
    ContentType = FACTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    items = {
        { -- Exalted 8
            name = ALIL["Exalted"],
            [NORMAL_DIFF] = {
                {1, "f1341rep8"},
                {2, 89799}, -- August Celestials Tabard
                {17, 90655}, -- Reins of the Thundering Ruby Cloud Serpent
                {18, 89304}, -- Reins of the Thundering August Cloud Serpent
                {20, 86377}, -- Pattern: Royal Satchel
            },
        },
        { -- Revered 7
            name = ALIL["Revered"],
            [NORMAL_DIFF] = {
                {1, "f1341rep7"},
                {2, 88877}, -- Storm-Sing Sandals
                {3, 88878}, -- Void Flame Slippers
                {4, 88876}, -- Boots of the High Adept
                {5, 88868}, -- Tukka-Tuk's Hairy Boots
                {6, 88866}, -- Steps of the War Serpent
                {7, 88867}, -- Sandals of the Elder Sage
                {8, 88862}, -- Tankiss Warstompers
                {9, 88864}, -- Yu'lon Guardian Boots
                {10, 88865}, -- Bramblestaff Boots
                {17, 93224}, -- Grand Commendation of the August Celestials
                {19, 84561}, -- Formula: Enchant Bracer - Exceptional Strength
                {20, 84557}, -- Formula: Enchant Bracer - Greater Agility
                {21, 84559}, -- Formula: Enchant Bracer - Super Intellect
            },
        },
        { -- Honored 6
            name = ALIL["Honored"],
            [NORMAL_DIFF] = {
                {1, "f1341rep6"},
                {2, 88893}, -- Minh's Beaten Bracers
                {3, 88892}, -- Bracers of Inlaid Jade
                {4, 88885}, -- Clever Ashyo's Armbands
                {5, 88884}, -- Quillpaw Family Bracers
                {6, 88883}, -- Brewmaster Chani's Bracers
                {7, 88882}, -- Tiger-Striped Wristguards
                {8, 88879}, -- Braided Black and White Bracer
                {9, 88880}, -- Battle Shadow Bracers
                {10, 88881}, -- Fallen Sentinel Bracers
                {12, 89124}, -- Celestial Offering
                {17, 88741}, -- Gloves of Red Feathers
                {18, 88742}, -- Sunspeaker's Flared Gloves
                {19, 88743}, -- Ogo's Elder Gloves
                {20, 88744}, -- Fingers of the Loneliest Monk
                {21, 88748}, -- Ravenmane's Gloves
                {22, 88745}, -- Sentinel Commander's Gauntlets
                {23, 88747}, -- Streetfighter's Iron Knuckles
                {24, 88746}, -- Gloves of the Overwhelming Swarm
                {25, 88749}, -- Gauntlets of Jade Sutras
            },
        },
    },
}
data["The Klaxxi"] = {
    FactionID = 1337,
    ContentType = FACTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    items = {
        { -- Exalted 8
            name = ALIL["Exalted"],
            [NORMAL_DIFF] = {
                {1, "f1337rep8"},
                {2, 89396}, -- Amber Espada of Klaxxi'vess
                {3, 89398}, -- Amber Flammard of Klaxxi'vess
                {4, 89397}, -- Amber Saber of Klaxxi'vess
                {5, 89395}, -- Amber Scythe of Klaxxi'vess
                {6, 89400}, -- Amber Sledge of Klaxxi'vess
                {7, 89393}, -- Amber Slicer of Klaxxi'vess
                {8, 89394}, -- Amber Spear of Klaxxi'vess
                {9, 89392}, -- Amber Spine of Klaxxi'vess
                {10, 89399}, -- Amber Sprayer of Klaxxi'vess
                {12, 89798}, -- Klaxxi Tabard
                {17, 85262}, -- Reins of the Amber Scorpion
            },
        },
        { -- Revered 7
            name = ALIL["Revered"],
            [NORMAL_DIFF] = {
                {1, "f1337rep7"},
                {2, 89088}, -- Leggings of the Poisoned Soul
                {3, 89087}, -- Poisoncrafter's Kilt
                {4, 89089}, -- Wind-Reaver Greaves
                {5, 89090}, -- Dreadsworn Slayer Legs
                {6, 89091}, -- Swarmkeeper's Leggings
                {7, 89092}, -- Locust Swarm Legguards
                {8, 89093}, -- Kovok's Riven Legguards
                {9, 89095}, -- Legguards of the Unscathed
                {10, 89094}, -- Ambersmith Legplates
                {17, 92522}, -- Grand Commendation of the Klaxxi
            },
        },
        { -- Honored 6
            name = ALIL["Honored"],
            [NORMAL_DIFF] = {
                {1, "f1337rep6"},
                {2, 89062}, -- Klaxxi Lash of the Orator
                {3, 89063}, -- Klaxxi Lash of the Seeker
                {4, 89061}, -- Klaxxi Lash of the Harbinger
                {5, 89060}, -- Klaxxi Lash of the Borrower
                {6, 89058}, -- Klaxxi Lash of the Winnower
                {7, 89059}, -- Klaxxi Lash of the Precursor
                {8, 89055}, -- Klaxxi Lash of the Rescinder
                {9, 89056}, -- Klaxxi Lash of the Consumer
                {10, 89057}, -- Klaxxi Lash of the Doubter
                {17, 89068}, -- Wire of the Wakener
                {18, 89067}, -- Links of the Lucid
                {19, 89065}, -- Choker of the Klaxxi'va
                {20, 89064}, -- Bloodseeker's Solitaire
                {21, 89066}, -- Paragon's Pale Pendant
                {23, 89230}, -- Restorative Amber
                {101, "f1337rep6"},
                {102, 90531}, -- Plans: Ghost Iron Shield Spike
                {103, 84197}, -- Plans: Masterwork Forgewire Axe
                {104, 83789}, -- Plans: Living Steel Breastplate
                {105, 84218}, -- Plans: Masterwork Spiritblade Decimator
                {106, 83790}, -- Plans: Living Steel Gauntlets
                {107, 83787}, -- Plans: Ghost Reaver's Breastplate
                {108, 83792}, -- Plans: Gauntlets of Ancient Steel
                {109, 84217}, -- Plans: Masterwork Phantasmal Hammer
                {110, 83791}, -- Plans: Breastplate of Ancient Steel
                {111, 84196}, -- Plans: Living Steel Belt Buckle
                {112, 84198}, -- Plans: Masterwork Ghost Shard
                {113, 84200}, -- Plans: Masterwork Ghost-Forged Blade
                {114, 83788}, -- Plans: Ghost Reaver's Gauntlets
                {115, 90532}, -- Plans: Living Steel Weapon Chain
            },
        },
    },
}
data["The Lorewalkers"] = {
    FactionID = 1345,
    ContentType = FACTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    items = {
        { -- Exalted 8
            name = ALIL["Exalted"],
            [NORMAL_DIFF] = {
                {1, "f1345rep8"},
                {2, 95509}, -- Mantid Artifact Sonic Locator
                {3, 87548}, -- Lorewalker's Lodestone
                {4, 87549}, -- Lorewalker's Map
                {6, 89795}, -- Lorewalkers Tabard
                {17, 89363}, -- Disc of the Red Flying Cloud
            },
        },
        { -- Revered 7
            name = ALIL["Revered"],
            [NORMAL_DIFF] = {
                {1, "f1345rep7"},
                {17, 93230}, -- Grand Commendation of the Lorewalkers
            },
        },
    },
}
data["Dominance Offensive"] = {
    FactionID = 1375,
    ContentType = FACTIONS_HORDE_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    ContentPhaseMoP = 2,
    items = {
        { -- Exalted 8
            name = ALIL["Exalted"],
            [NORMAL_DIFF] = {
                {1, "f1375rep8"},
                {17, 93169}, -- Grand Armored Wyvern
            },
        },
        { -- Revered 7
            name = ALIL["Revered"],
            [NORMAL_DIFF] = {
                {1, "f1375rep7"},
                {2, 93255}, -- Cutstitcher Medallion
                {3, 93257}, -- Medallion of Mystifying Vapors
                {4, 93256}, -- Skullrender Medallion
                {5, 93254}, -- Static-Caster's Medallion
                {6, 93253}, -- Woundripper Medallion
                {8, 93270}, -- Slippers of Soothing Balm
                {9, 93323}, -- Kwon's Crushing Girdle
                {10, 93268}, -- Treads of Rejuvenating Mists
                {11, 93269}, -- Troll-Toe Tabi
                {12, 93326}, -- Shigi's Chain of Cheerful Summons
                {13, 93327}, -- Bloodbinder Links
                {14, 93328}, -- Prevenge's Dagger-Carrier
                {17, 93232}, -- Grand Commendation of the Dominance Offensive
                {19, 93329}, -- Bambrick's Striking Strap
                {20, 93264}, -- Cragchewer Sollerets
                {21, 93266}, -- Boots of the Healing Stream
                {22, 93324}, -- Immovable Waistplate
                {23, 93325}, -- Divide's Greatheart Clasp
                {24, 93265}, -- Scar Swallower Greatboots
                {25, 93267}, -- Greaves of Manifest Destiny
                {26, 93271}, -- Beach-Born Sandals
                {27, 93330}, -- Chang's Changing Cord
                {28, 93331}, -- Sash of Surehandedness
                {29, 93263}, -- Groundbreaker Sabatons
            },
        },
        { -- Honored 6
            name = ALIL["Honored"],
            [NORMAL_DIFF] = {
                {1, "f1375rep6"},
                {2, 93249}, -- Dominator's Band
                {3, 93251}, -- Dominator's Circle
                {4, 93250}, -- Dominator's Loop
                {5, 93252}, -- Dominator's Seal
                {6, 93248}, -- Dominator's Signet
                {8, 93344}, -- Dominator's Knightly Badge
                {9, 93345}, -- Dominator's Durable Badge
                {10, 93341}, -- Dominator's Deadeye Badge
                {11, 93342}, -- Dominator's Arcane Badge
                {12, 93343}, -- Dominator's Mending Badge
            },
        },
    },
}

data["Operation: Shieldwall"] = {
    FactionID = 1376,
    ContentType = FACTIONS_ALLI_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    ContentPhaseMoP = 2,
    items = {
        { -- Exalted 8
            name = ALIL["Exalted"],
            [NORMAL_DIFF] = {
                {1, "f1376rep8"},
                {17, 93168}, -- Grand Armored Gryphon
            },
        },
        { -- Revered 7
            name = ALIL["Revered"],
            [NORMAL_DIFF] = {
                {1, "f1376rep7"},
                {2, 93258}, -- Arrowflight Medallion
                {3, 93260}, -- Heartwarmer Medallion
                {4, 93261}, -- Helmbreaker Medallion
                {5, 93259}, -- Shock-Charger Medallion
                {6, 93262}, -- Vaporshield Medallion
                {8, 93340}, -- Sash of Bouncing Power
                {9, 93338}, -- Soothing Straps
                {10, 93276}, -- Odlaw's Everwalkers
                {11, 93275}, -- Totem-Binder Boots
                {12, 93277}, -- Statue Summoner's Treads
                {13, 93278}, -- Crab-Leather Tabi
                {14, 93337}, -- Prevenge's Swashbuckling Cinch
                {17, 93231}, -- Grand Commendation of Operation: Shieldwall
                {19, 93333}, -- Waistplate of Immobility
                {20, 93334}, -- Divide's Loyal Clasp
                {21, 93335}, -- Chain of Flaming Arrows
                {22, 93273}, -- Sea-Soaked Sollerets
                {23, 93274}, -- Greatboots of Flashing Light
                {24, 93279}, -- Shieldwarden Slippers
                {25, 93280}, -- Sandals of Oiled Silk
                {26, 93336}, -- Links of Bonded Blood
                {27, 93272}, -- Sabatons of the Sullied Shore
                {28, 93332}, -- Girdle of Crushing Strength
                {29, 93339}, -- Bon-iy's Unbreakable Cord
            },
        },
        { -- Honored 6
            name = ALIL["Honored"],
            [NORMAL_DIFF] = {
                {1, "f1376rep6"},
                {2, 93244}, -- Band of the Shieldwall
                {3, 93246}, -- Circle of the Shieldwall
                {4, 93245}, -- Loop of the Shieldwall
                {5, 93247}, -- Seal of the Shieldwall
                {6, 93243}, -- Signet of the Shieldwall
                {8, 93347}, -- Arcane Badge of the Shieldwall
                {9, 93350}, -- Durable Badge of the Shieldwall
                {10, 93346}, -- Deadeye Badge of the Shieldwall
                {11, 93349}, -- Knightly Badge of the Shieldwall
                {12, 93348}, -- Mending Badge of the Shieldwall
            },
        },
    },
}
data["Shado-Pan Assault"] = {
    FactionID = 1435,
    ContentType = FACTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    ContentPhaseMoP = 3,
    items = {
        { -- Exalted 8
            name = ALIL["Exalted"],
            [NORMAL_DIFF] = {
                {1, "f1435rep8"},
                {2, 95101}, -- Halo-Graced Mantle
                {3, 95102}, -- Frost-Kissed Shoulderwraps
                {4, 95096}, -- Shoulders of Demonic Dreams
                {5, 95097}, -- Heartroot Shoulderguards
                {6, 95100}, -- Wallwalker Spaulders
                {7, 95099}, -- Lightning Strike Mantle
                {8, 95095}, -- Targetblinder Spaulders
                {9, 95098}, -- Sightblinder Shoulderguards
                {10, 95103}, -- Sparksmasher Pauldrons
                {11, 95104}, -- Shoulderguards of Potentiation
                {17, 97131}, -- Shado-Pan Assault Tabard
            },
        },
        { -- Revered 7
            name = ALIL["Revered"],
            [NORMAL_DIFF] = {
                {1, "f1435rep7"},
                {17, 95559}, -- Grand Commendation of the Shado-Pan Assault
            },
        },
        { -- Friendly 5
            name = ALIL["Friendly"],
            [NORMAL_DIFF] = {
                {1, "f1435rep5"},
                {2, 95081}, -- Fire Support Robes
                {3, 95082}, -- Robes of Misty Bindings
                {4, 95106}, -- Flameweaver Handwraps
                {5, 95105}, -- Ghostbinder Grips
                {6, 95135}, -- Bracers of Shielding Thought
                {7, 95136}, -- Troll-Burner Bracers
                {8, 95090}, -- Firestrike Cord
                {9, 95091}, -- Girdle of Glowing Light
                {10, 95123}, -- Charfire Leggings
                {11, 95122}, -- Wisp-Weave Pantaloons
                {17, 95078}, -- Raiment of Silent Stars
                {18, 95077}, -- Roofstalker Shadowwrap
                {19, 95134}, -- Hearthfire Armwraps
                {20, 95133}, -- Willow-Weave Armbands
                {21, 95108}, -- Daggerfinger Clutches
                {22, 95107}, -- Gloves of Enduring Renewal
                {23, 95088}, -- Darkfang Belt
                {24, 95089}, -- Martiean's Splitleaf Girdle
                {25, 95125}, -- Legguards of Hidden Knives
                {26, 95124}, -- Trousers of Waning Shadow
                {101, "f1435rep5"},
                {102, 95079}, -- Carapace of Segmented Scale
                {103, 95080}, -- Skinsealer Tunic
                {104, 95132}, -- Spiritcaller Cuffs
                {105, 95131}, -- Powderburn Bracers
                {106, 95109}, -- Gauntlets of the Longbow
                {107, 95112}, -- Totemshaper Gloves
                {108, 95087}, -- Cracklebite Links
                {109, 95086}, -- Nightflight Chain
                {110, 95127}, -- Homeguard Leggings
                {111, 95126}, -- Kilt of Rising Thunder
                {113, 95076}, -- Breastplate of Brutal Strikes
                {114, 95075}, -- Gianttooth Chestplate
                {115, 95074}, -- Hauberk of Gleaming Fire
                {117, 95129}, -- Axebinder Wristguards
                {118, 95128}, -- Bonecrusher Bracers
                {119, 95130}, -- Softscar Armplates
                {120, 95111}, -- Bloodstained Skullsqueezers
                {121, 95110}, -- Stoneward Handguards
                {122, 95113}, -- Touch of Soothing Mists
                {123, 95084}, -- Reinforced Spiritplate Girdle
                {124, 95083}, -- Swordhook Slingbelt
                {125, 95085}, -- Waistplate of Channeled Mending
                {126, 95120}, -- Legguards of Renewal
                {127, 95119}, -- Thunderbreaker Legplates
                {128, 95121}, -- Vaultbreaker Greaves
                {201, "f1435rep5"},
                {202, 95118}, -- Dreamweaver Drape
                {203, 95116}, -- Longshot Forestcloak
                {204, 95115}, -- Many-Layered Scalecloak
                {205, 95117}, -- Shadowspike Cloak
                {206, 95114}, -- Spikeshard Greatcloak
                {208, 95138}, -- Signet of the Shado-Pan Assault
                {209, 95137}, -- Seal of the Shado-Pan Assault
                {210, 95141}, -- Loop of the Shado-Pan Assault
                {211, 95139}, -- Ring of the Shado-Pan Assault
                {212, 95140}, -- Band of the Shado-Pan Assault
                {213, 98017}, -- Signet of the Shado-Pan Assault
                {217, 94508}, -- Brutal Talisman of the Shado-Pan Assault
                {218, 94509}, -- Soothing Talisman of the Shado-Pan Assault
                {219, 94507}, -- Steadfast Talisman of the Shado-Pan Assault
                {220, 94511}, -- Vicious Talisman of the Shado-Pan Assault
                {221, 94510}, -- Volatile Talisman of the Shado-Pan Assault
            },
        },
        { -- Neutral 4
            name = ALIL["Neutral"],
            [NORMAL_DIFF] = {
                {1, "f1435rep4"},
                {2, 95146}, -- Destroyer's Battletags
                {3, 95143}, -- Flanker's Battletags
                {4, 95145}, -- Mender's Battletags
                {5, 95142}, -- Striker's Battletags
                {6, 95144}, -- Vanguard's Battletags
            },
        },
    },
}
data["Sunreaver Onslaught"] = {
    FactionID = 1388,
    ContentType = FACTIONS_HORDE_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    ContentPhaseMoP = 3,
    items = {
        { -- Exalted 8
            name = ALIL["Exalted"],
            [NORMAL_DIFF] = {
                {1, "f1388rep8"},
                {2, 97196}, -- Ancient Overlord's Onyx Band
                {3, 97194}, -- Ancient Primalist's Seal
                {4, 97192}, -- Refurbished Band of Jin
                {5, 97193}, -- Restored Hexxer's Signet
                {6, 97195}, -- Refurbished Seal of Jin
                {8, 95592}, -- Sunreaver Onslaught Tabard
                {10, 98559}, -- Empty Supply Crate
                {11, 97155}, -- Polymorphic Key
                {12, 98562}, -- Sunreaver Bounty
                {17, 95565}, -- Reins of the Crimson Primal Direhorn
                {19, 95590}, -- Glorious Standard of the Sunreaver Onslaught
            },
        },
        { -- Revered 7
            name = ALIL["Revered"],
            [NORMAL_DIFF] = {
                {1, "f1388rep7"},
                {2, 97212}, -- Cloak of the Immortal Guardian
                {3, 97210}, -- Shan'ze Gravetender Cloak
                {4, 97211}, -- Shan'ze Partisan's Greatcloak
                {5, 97209}, -- Static-Collecting Cloak
                {6, 97208}, -- Thunder-Chaser Cloak
                {8, 97159}, -- Arcane Propellant
                {9, 97156}, -- Frost Rune Trap
                {17, 95548}, -- Grand Commendation of the Sunreaver Onslaught
            },
        },
        { -- Honored 6
            name = ALIL["Honored"],
            [NORMAL_DIFF] = {
                {1, "f1388rep6"},
                {2, 95523}, -- Belt of Loa Charms
                {3, 95518}, -- Pain-Binder Girdle
                {4, 95517}, -- Shan'ze Scholar's Girdle
                {5, 95521}, -- Cinch of the Dead Forest's Vigil
                {6, 95519}, -- Skumblade-Tooth Girdle
                {7, 95522}, -- Rotting Bog Cinch
                {8, 95525}, -- Skumblade Ritualist Links
                {9, 95520}, -- Girdle of Shan'ze Glory
                {10, 95524}, -- Thunder Caressed Waistguard
                {12, 97158}, -- A Common Rock
                {13, 97154}, -- Sleep Dust
            },
        },
        { -- Friendly 5
            name = ALIL["Friendly"],
            [NORMAL_DIFF] = {
                {1, "f1388rep5"},
                {2, 97157}, -- Potion of Light Steps
            },
        },
    },
}
data["Kirin Tor Offensive"] = {
    FactionID = 1387,
    ContentType = FACTIONS_ALLI_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    ContentPhaseMoP = 3,
    items = {
        { -- Exalted 8
            name = ALIL["Exalted"],
            [NORMAL_DIFF] = {
                {1, "f1387rep8"},
                {2, 97191}, -- Ancient Overlord's Onyx Band
                {3, 97189}, -- Ancient Primalist's Seal
                {4, 97187}, -- Refurbished Band of Jin
                {5, 97188}, -- Restored Hexxer's Signet
                {6, 97190}, -- Refurbished Seal of Jin
                {8, 95591}, -- Kirin Tor Offensive Tabard
                {10, 98558}, -- Empty Supply Crate
                {11,95056}, -- Polymorphic Key
                {12,98560}, -- Arcane Trove
                {17,95564}, -- Reins of the Golden Primal Direhorn
                {19,95589}, -- Glorious Standard of the Kirin Tor Offensive
            },
        },
        { -- Revered 7
            name = ALIL["Revered"],
            [NORMAL_DIFF] = {
                {1, "f1387rep7"},
                {2, 97207}, -- Cloak of the Immortal Guardian
                {3, 97205}, -- Shan'ze Gravetender Cloak
                {4, 97206}, -- Shan'ze Partisan's Greatcloak
                {5, 97204}, -- Static-Collecting Cloak
                {6, 97203}, -- Thunder-Chaser Cloak
                {8, 95052}, -- Arcane Propellant
                {9, 95055}, -- Frost Rune Trap
                {17, 95545}, -- Grand Commendation of the Kirin Tor Offensive
            },
        },
        { -- Honored 6
            name = ALIL["Honored"],
            [NORMAL_DIFF] = {
                {1, "f1387rep6"},
                {2, 95532}, -- Belt of Loa Charms
                {3, 95527}, -- Pain-Binder Girdle
                {4, 95526}, -- Shan'ze Scholar's Girdle
                {5, 95530}, -- Cinch of the Dead Forest's Vigil
                {6, 95528}, -- Skumblade-Tooth Girdle
                {7, 95531}, -- Rotting Bog Cinch
                {8, 95534}, -- Skumblade Ritualist Links
                {9, 95529}, -- Girdle of Shan'ze Glory
                {10, 95533}, -- Thunder Caressed Waistguard
                {12, 95053}, -- A Common Rock
                {13, 95093}, -- Sleep Dust
            },
        },
        { -- Friendly 5
            name = ALIL["Friendly"],
            [NORMAL_DIFF] = {
                {1, "f1387rep5"},
                {2, 95054}, -- Potion of Light Steps
            },
        },
    },
}
data["Emperor Shaohao"] = {
    FactionID = 1492,
    ContentType = FACTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    ContentPhaseMoP = 5,
    items = {
        { -- Exalted 8
            name = ALIL["Exalted"],
            [NORMAL_DIFF] = {
                {1, "f1492rep8"},
                {2, 87774}, -- Reins of the Heavenly Golden Cloud Serpent
            },
        },
        { -- Revered 7
            name = ALIL["Revered"],
            [NORMAL_DIFF] = {
                {1, "f1492rep7"},
                {17, 104295}, -- Harmonious Porcupette
                {19, 103685}, -- Celestial Defender's Medallion
            },
        },
        { -- Honored 6
            name = ALIL["Honored"],
            [NORMAL_DIFF] = {
                {1, "f1492rep6"},
                {2, 103678}, -- Time-Lost Artifact
                {4, 103684}, -- Scroll of Challenge
                {17, 104014}, -- Pouch of Timeless Coins
            },
        },
        { -- Friendly 5
            name = ALIL["Friendly"],
            [NORMAL_DIFF] = {
                {1, "f1492rep5"},
                {2, 103683}, -- Mask of Anger
                {3, 103682}, -- Mask of Violence
                {4, 103679}, -- Mask of Fear
                {5, 103680}, -- Mask of Hatred
                {6, 103681}, -- Mask of Doubt
            },
        },
    },
}
