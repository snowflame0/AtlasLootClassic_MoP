-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select = _G.select
local string = _G.string
local format = string.format

-- WoW
local function C_Map_GetAreaInfo(id)
    local d = C_Map.GetAreaInfo(id)
    return d or ("GetAreaInfo" .. id)
end

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

local CELESTIAL_DIFF = data:AddDifficulty("CELESTIAL", nil, nil, nil, true)
local NORMAL_DIFF = data:AddDifficulty("NORMAL", nil, nil, nil, true)
local HEROIC_DIFF = data:AddDifficulty("HEROIC", nil, nil, nil, true)

local VENDOR_DIFF = data:AddDifficulty(AL["Vendor"], "vendor", 0)

-- Potentially temporary to separate phases of Celestial vendor by raid
local MSV_DIFF = data:AddDifficulty(C_Map_GetAreaInfo(6125), nil, 0)
local HOF_DIFF = data:AddDifficulty(C_Map_GetAreaInfo(6297), nil, 0)
local TERRACE_DIFF = data:AddDifficulty(C_Map_GetAreaInfo(6067), nil, 0)


local ALLIANCE_DIFF, HORDE_DIFF, LOAD_DIFF
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
local SET_ITTYPE = data:AddItemTableType("Set", "Item")
local AC_ITTYPE = data:AddItemTableType("Item", "Achievement")

-- local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
-- local SET_EXTRA_ITTYPE = data:AddExtraItemTableType("Set")

local VENDOR_CONTENT = data:AddContentType(AL["Vendor"], ATLASLOOT_DUNGEON_COLOR)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)
-- local WORLD_BOSS_CONTENT = data:AddContentType(AL["World Bosses"], ATLASLOOT_WORLD_BOSS_COLOR)
local COLLECTIONS_CONTENT = data:AddContentType(AL["Collections"], ATLASLOOT_COLLECTIONS_COLOR)
local WORLD_EVENT_CONTENT = data:AddContentType(AL["World Events"], ATLASLOOT_SEASONALEVENTS_COLOR)

-- colors
local SUPERIOR_QUALITY = "|cff0070dd%s|r"
local EPIC_QUALITY = "|cffa335ee%s|r"
local BOA_QUALITY = "|cff00ccff%s|r"
local LEGENDARY_QUALITY = "|cffff8000%s|r"
--local BLUE = "|cff0070dd%s|r"
-- local GREY = "|cff999999%s|r"
-- local GREEN = "|cff66cc33%s|r"
-- local RED = "|cffcc6666%s|r"
-- local PURPLE = "|cffa335ee%s|r"
-- local WHIT = "|cffffffff%s|r"

data["ValorPointsMoP"] = {
    name = format(AL["'%s' Vendor"], format(EPIC_QUALITY, ALIL["Valor Points"])),
    ContentType = VENDOR_CONTENT,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.VALOR_POINTS,
     items = {
        {
        name = ALIL["Armor"] .. " - " .. ALIL["Cloth"],
        [VENDOR_DIFF] = {
            { 1, 89337 }, -- Firecracker Corona
            { 2, 89338 }, -- Yalia's Cowl
            { 4, 89340 }, -- Mantle of the Golden Sun
            { 5, 89339 }, -- Tenderheart Shoulders
            { 7, 89434 }, -- Robe of the Five Sisters
            { 8, 89433 }, -- Vestments of Thundering Skies
            { 10, 88892 }, -- Bracers of Inlaid Jade
            { 11, 88893 }, -- Minh's Beaten Bracers
            { 16, 88741 }, -- Gloves of Red Feathers
            { 17, 88742 }, -- Sunspeaker's Flared Gloves
            { 19, 89062 }, -- Klaxxi Lash of the Orator
            { 20, 89063 }, -- Klaxxi Lash of the Seeker
            { 22, 89088 }, -- Leggings of the Poisoned Soul
            { 23, 89087 }, -- Poisoncrafter's Kilt
            { 25, 88877 }, -- Storm-Sing Sandals
            { 26, 88878 }, -- Void Flame Slippers
            },
        },
        {
        name = ALIL["Armor"] .. " - " .. ALIL["Leather"],
        [VENDOR_DIFF] = {
            { 1, 89300 }, -- Red Smoke Bandana
            { 2, 89308 }, -- Snowdrift Helm
            { 4, 89341 }, -- Imperion Spaulders
            { 5, 89342 }, -- Whitepetal Shouldergarb
            { 7, 89432 }, -- Mistfall Robes
            { 8, 89431 }, -- Softfoot Silentwrap
            { 10, 88885 }, -- Clever Ashyo's Armbands
            { 11, 88884 }, -- Quillpaw Family Bracers
            { 16, 88744 }, -- Fingers of the Loneliest Monk
            { 17, 88743 }, -- Ogo's Elder Gloves
            { 19, 89060 }, -- Klaxxi Lash of the Borrower
            { 20, 89061 }, -- Klaxxi Lash of the Harbinger
            { 22, 89090 }, -- Dreadsworn Slayer Legs
            { 23, 89089 }, -- Wind-Reaver Greaves
            { 25, 88876 }, -- Boots of the High Adept
            { 26, 88868 }, -- Tukka-Tuk's Hairy Boots
            },
        },
        {
        name = ALIL["Armor"] .. " - " .. ALIL["Mail"],
        [VENDOR_DIFF] = {
            { 1, 89291 }, -- Hawkmaster's Headguard
            { 2, 89296 }, -- Nightwatcher's Helm
            { 4, 89343 }, -- Mindbender Shoulders
            { 5, 89344 }, -- Windwalker Spaulders
            { 7, 89430 }, -- Breastplate of the Golden Pagoda
            { 8, 89429 }, -- Robes of the Setting Sun
            { 10, 88883 }, -- Brewmaster Chani's Bracers
            { 11, 88882 }, -- Tiger-Striped Wristguards
            { 16, 88748 }, -- Ravenmane's Gloves
            { 17, 88745 }, -- Sentinel Commander's Gauntlets
            { 19, 89059 }, -- Klaxxi Lash of the Precursor
            { 20, 89058 }, -- Klaxxi Lash of the Winnower
            { 22, 89092 }, -- Locust Swarm Legguards
            { 23, 89091 }, -- Swarmkeeper's Leggings
            { 25, 88867 }, -- Sandals of the Elder Sage
            { 26, 88866 }, -- Steps of the War Serpent
            },
        },
        {
        name = ALIL["Armor"] .. " - " .. ALIL["Plate"],
        [VENDOR_DIFF] = {
            { 1, 89096 }, -- Six Pool's Open Helm
            { 2, 89280 }, -- Voice Amplyifying Greathelm
            { 3, 89216 }, -- Yi's Least Favorite Helmet
            { 5, 89347 }, -- Paleblade Shoulderguards
            { 6, 89346 }, -- Shoulders of Autumnlight
            { 7, 89345 }, -- Stonetoe Spaulders
            { 9, 89423 }, -- Battleguard of Guo-Lai
            { 10, 89421 }, -- Cuirass of the Twin Monoliths
            { 11, 89420 }, -- Dawnblade's Chestguard
            { 13, 88880 }, -- Battle Shadow Bracers
            { 14, 88879 }, -- Braided Black and White Bracer
            { 15, 88881 }, -- Fallen Sentinel Bracers
            { 16, 88749 }, -- Gauntlets of Jade Sutras
            { 17, 88747 }, -- Streetfighter's Iron Knuckles
            { 18, 88746 }, -- Gloves of the Overwhelming Swarm
            { 20, 89056 }, -- Klaxxi Lash of the Consumer
            { 21, 89057 }, -- Klaxxi Lash of the Doubter
            { 22, 89055 }, -- Klaxxi Lash of the Rescinder
            { 24, 89094 }, -- Ambersmith Legplates
            { 25, 89093 }, -- Kovok's Riven Legguards
            { 26, 89095 }, -- Legguards of the Unscathed
            { 28, 88865 }, -- Bramblestaff Boots
            { 29, 88862 }, -- Tankiss Warstompers
            { 30, 88864 }, -- Yu'lon Guardian Boots
            },
        },
        {
        name = ALIL["Cloak"],
        [VENDOR_DIFF] = {
            { 1, 89076 }, -- Blackguard Cape
            { 2, 89077 }, -- Cloak of Snow Blossoms
            { 3, 89074 }, -- Cloak of the Dark Disciple
            { 4, 89078 }, -- Sagewhisper's Wrap
            { 5, 89075 }, -- Yi's Cloak of Courage
            }
        },
        {
        name = ALIL["Neck"],
        [VENDOR_DIFF] = {
            { 1, 89065 }, -- Choker of the Klaxxi'va
            { 2, 89064 }, -- Bloodseeker's Solitaire
            { 3, 89067 }, -- Links of the Lucid
            { 4, 89066 }, -- Paragon's Pale Pendant
            { 5, 89068 }, -- Wire of the Wakener
            },
        },
        {
        name = ALIL["Finger"],
        [VENDOR_DIFF] = {
            { 1, 89070 }, -- Anji's Keepsake
            { 2, 89071 }, -- Alani's Inflexible Ring
            { 3, 89073 }, -- Leven's Circle of Hope
            { 4, 89069 }, -- Ring of the Golden Stair
            { 5, 89072 }, -- Simple Harmonius Ring
            },
        },
        {
        name = ALIL["Trinket"],
        [VENDOR_DIFF] = {
            { 1, 89081 }, -- Blossom of Pure Snow
            { 2, 89082 }, -- Hawkmaster's Talon
            { 3, 89083 }, -- Iron Belly Wok
            { 4, 89079 }, -- Lao-Chin's Liquid Courage
            { 5, 89080 }, -- Scroll of Revered Ancestors
            }
        },
    }
}

data["JusticePointsMoP"] = {
    name = format(AL["'%s' Vendor"], format(SUPERIOR_QUALITY, ALIL["Justice Points"])),
    ContentType = VENDOR_CONTENT,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.JUSTICE_POINTS,
     items = {
        {
        name = ALIL["Armor"] .. " - " .. ALIL["Cloth"],
        [VENDOR_DIFF] = {
            { 1, 89673 }, -- Robe of Eternal Dynasty
            { 2, 89672 }, -- Robe of Quiet Meditation
            { 4, 89650 }, -- Emperor's Riding Gloves
            { 5, 89651 }, -- Krompf's Fine-Tuning Gloves
            { 16, 89659 }, -- Leggings of Unfinished Conquest
            { 17, 89658 }, -- Subversive Leggings
            { 19, 89642 }, -- Bracers of Eternal Resolve
            { 20, 89643 }, -- Tranquility Bindings
            },
        },
        {
        name = ALIL["Armor"] .. " - " .. ALIL["Leather"],
        [VENDOR_DIFF] = {
            { 1, 89667 }, -- Refurbished Zandalari Vestment
            { 2, 89666 }, -- Vestment of the Ascendant Tribe
            { 4, 89653 }, -- Surehand Grips
            { 5, 89652 }, -- Wandering Friar's Gloves
            { 16, 89660 }, -- Brambleguard Leggings
            { 17, 89661 }, -- Tough Mushanhide Leggings
            { 19, 89645 }, -- Cruel Mercy Bracers
            { 20, 89644 }, -- Sudden Insight Bracers
            },
        },
        {
        name = ALIL["Armor"] .. " - " .. ALIL["Mail"],
        [VENDOR_DIFF] = {
            { 1, 89668 }, -- Mountain Stream Ringmail
            { 2, 89669 }, -- Undergrowth Stalker Chestpiece
            { 4, 89655 }, -- Brushcutter's Gloves
            { 5, 89654 }, -- Gloves of Forgotten Wisdom
            { 16, 89663 }, -- Leggings of Twisted Vines
            { 17, 89662 }, -- Snowpack Waders
            { 19, 89647 }, -- Entombed Traitor's Wristguards
            { 20, 89646 }, -- Runoff Wristguards
            },
        },
        {
        name = ALIL["Armor"] .. " - " .. ALIL["Plate"],
        [VENDOR_DIFF] = {
            { 1, 89671 }, -- Chestplate of the Stone Lion
            { 2, 89670 }, -- Inner Serenity Chestplate
            { 4, 89656 }, -- Gauntlets of Restraint
            { 5, 89657 }, -- Wall Breaker Gauntlets
            { 16, 89665 }, -- Leggings of Ponderous Advance
            { 17, 89664 }, -- Valiant's Shinguards
            { 19, 89648 }, -- Bracers of Inner Light
            { 20, 89649 }, -- Serrated Forearm Guards
            },
        },
        {
        name = ALIL["Cloak"],
        [VENDOR_DIFF] = {
            { 1, 89532 }, -- Bladesong Cloak
            { 2, 89533 }, -- Cloak of Ancient Curses
            { 3, 89537 }, -- Cloak of the Silent Mountain
            { 4, 89534 }, -- Pressed Flower Cloak
            { 5, 89535 }, -- Ribcracker's Cloak
            }
        },
        {
        name = ALIL["Neck"],
        [VENDOR_DIFF] = {
            { 1, 89527 }, -- Amulet of Swirling Mists
            { 2, 89531 }, -- Gorget of Usurped Kings
            { 3, 89528 }, -- Necklace of Jade Pearls
            { 4, 89529 }, -- Pendant of Endless Inquisition
            { 5, 89530 }, -- Triumphant Conqueror's Chain
            },
        },
        {
        name = ALIL["Finger"],
        [VENDOR_DIFF] = {
            { 1, 89523 }, -- Etched Golden Loop
            { 2, 89522 }, -- Mark of the Dancing Crane
            { 3, 89524 }, -- Sorcerer-King's Seal
            { 4, 89525 }, -- Thunderstone Ring
            { 5, 89526 }, -- Signet of the Slumbering Emperor
            },
        },
        {
        name = ALIL["Trinket"],
        [VENDOR_DIFF] = {
            { 1, 89232 }, -- Mogu Rune of Paralysis
            { 2, 88995 }, -- Shado-Pan Dragon Gun
            }
        },
        {
        name = AL["Misc"],
        [VENDOR_DIFF] = {
            { 1, 92742 }, -- Polished Battle-Stone
            }
        }
    }
}

data["CelestialVendorMoP"] = {
    name = format(AL["'%s' Vendor"], format(EPIC_QUALITY, ALIL["Celestial"])),
    ContentType = VENDOR_CONTENT,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    items = {{
        name = ALIL["Armor"] .. " - " .. ALIL["Cloth"],
        [MSV_DIFF] = {
            { 1, 86788 }, -- Hood of Blind Eyes
            { 2, 86809 }, -- Hood of Focused Energy
            { 4, 86770 }, -- Shadowsummoner Spaulders
            { 6, 86758 }, -- Imperial Ghostbinder's Robes
            { 7, 86787 }, -- Undying Shadow Grips
            { 8, 89966 }, -- Claws of Amethyst
            { 16, 86798 }, -- Orbital Belt
            { 17, 89973 }, -- Galaxyfire Girdle
            { 18, 89965 }, -- Ruby-Linked Girdle
            { 20, 86747 }, -- Jade Dust Leggings
            { 21, 86765 }, -- Sandals of the Severed Soul

        },
        [HOF_DIFF] = {
            { 1, 86839 }, -- Xaril's Hood of Intoxicating Vapors
            { 3, 89959 }, -- Shoulders of Foaming Fluids
            { 5, 86911 }, -- Robes of Torn Nightmares
            { 7, 86815 }, -- Attenuating Bracers
            { 8, 86850 }, -- Darting Damselfly Cuffs
            { 9, 86844 }, -- Gleaming Moth Cuffs
            { 10, 86841 }, -- Shining Cicada Bracers
            { 11, 86828 }, -- Twisting Wind Bracers
            { 16, 86857 }, -- Belt of Malleable Amber
            { 18, 86867 }, -- Leggings of Shadow Infestation
            { 20, 86825 }, -- Boots of the Blowing Wind
            { 21, 86836 }, -- Sandals of the Unbidden
            { 22, 89953 }, -- Scent-Soaked Sandals
        },
        [TERRACE_DIFF] = {
            { 1, 89982 }, -- Shoulderpads of Twisted Fate
            { 3, 89984 }, -- Robes of Pinioned Eyes
            { 4, 86892 }, -- Robes of the Unknown Fear
            { 6, 86875 }, -- Cuffs of the Corrupted Waters
            { 8, 86819 }, -- Gloves of Grasping Claws
            { 16, 86884 }, -- Belt of Embodied Terror
            { 17, 86895 }, -- Healer's Belt of Final Winter
            { 18, 86896 }, -- Invoker's Belt of Final Winter
            { 19, 86897 }, -- Sorcerer's Belt of Final Winter
            { 21, 86908 }, -- Dreadwoven Leggings of Failure
            { 23, 86888 }, -- Sandals of the Blackest Night
        },
    },
    {
        name = ALIL["Armor"] .. " - " .. ALIL["Leather"],
        [MSV_DIFF] = {
            { 1, 86757 }, -- Hood of Cursed Dreams
            { 2, 86804 }, -- Crown of Opportunistic Strikes
            { 4, 86763 }, -- Netherrealm Shoulderpads
            { 5, 86768 }, -- Spaulders of the Divided Mind
            { 7, 86795 }, -- Chestguard of Total Annihilation
            { 16, 86786 }, -- Bracers of Dark Thoughts
            { 17, 89970 }, -- Bracers of Violent Meditation
            { 18, 86750 }, -- Tomb Raider's Girdle
            { 19, 86746 }, -- Stonebound Cinch
            { 21, 86808 }, -- Magnetized Leggings
            { 22, 86743 }, -- Stoneflesh Leggings
            { 24, 86797 }, -- Phasewalker Striders

        },
        [HOF_DIFF] = {
            { 1, 89957 }, -- Hood of Stilled Winds
            { 3, 89961 }, -- Shadow Heart Spaulders
            { 5, 86838 }, -- Robes of Eighty Lights
            { 7, 86821 }, -- Bracers of Unseen Strikes
            { 8, 86845 }, -- Pearlescent Butterfly Wristbands
            { 9, 86843 }, -- Smooth Beetle Wristbands
            { 16, 86834 }, -- Bonebreaker Gauntlets
            { 17, 86912 }, -- Clutches of Dying Hope
            { 18, 86817 }, -- Gauntlets of Undesired Gifts
            { 20, 86811 }, -- Boots of the Still Breath
            { 21, 86859 }, -- Treads of Deadly Secretions
        },
        [TERRACE_DIFF] = {
            { 1, 89985 }, -- Wrap of Instant Petrification
            { 3, 89980 }, -- Gauntlets of the Shadow's Caress
            { 5, 86899 }, -- Stalker's Cord of Eternal Autumn
            { 6, 86898 }, -- Weaver's Cord of Eternal Autumn
            { 16, 89983 }, -- Fear-Blackened Leggings
            { 17, 89978 }, -- Legguards of Failing Purification
            { 19, 86878 }, -- Asani's Uncleansed Sandals
        },
    },
    {
        name = ALIL["Armor"] .. " - " .. ALIL["Mail"],
        [MSV_DIFF] = {
            { 1, 89975 }, -- Dreadeye Gaze
            { 2, 86745 }, -- Sixteen-Fanged Crown
            { 4, 86800 }, -- Shoulders of Empyreal Focus
            { 5, 89964 }, -- Stonefang Chestguard
            { 7, 86740 }, -- Stonemaw Armguards
            { 8, 87826 }, -- Grips of Terra Cotta
            { 9, 89977 }, -- Enameled Grips of Solemnity
            { 16, 86755 }, -- Chain of Shadow
            { 17, 86761 }, -- Fetters of Death
            { 19, 86781 }, -- Subetai's Pillaging Leggings
            { 21, 86784 }, -- Meng's Treads of Insanity
            { 22, 86749 }, -- Wildfire Worldwalkers
        },
        [HOF_DIFF] = {
            { 1, 86866 }, -- Crown of the Doomed Empress
            { 2, 89962 }, -- Hood of Dark Dreams
            { 4, 86855 }, -- Wingslasher Pauldrons
            { 6, 86818 }, -- Mail of Screaming Secrets
            { 7, 89960 }, -- Vestments of Steaming Ichor
            { 8, 87823 }, -- Zor'lok's Fizzing Chestguard
            { 16, 86826 }, -- Bracers of Tempestuous Fury
            { 17, 86847 }, -- Jagged Hornet Bracers
            { 18, 86842 }, -- Luminescent Firefly Wristguards
            { 20, 86833 }, -- Grips of the Leviathan
            { 21, 90739 }, -- Kaz'tik's Stormseizer Gauntlets
            { 23, 89955 }, -- Sword Dancer's Leggings
            { 25, 86861 }, -- Monstrous Stompers

        },
        [TERRACE_DIFF] = {
            { 1, 89979 }, -- Waterborne Shoulderguards
            { 3, 86882 }, -- Sunwrought Mail Hauberk
            { 5, 86900 }, -- Binder's Chain of Unending Summer
            { 6, 86901 }, -- Ranger's Chain of Unending Summer
            { 7, 89986 }, -- Shadowgrip Girdle
            { 16, 86769 }, -- Leggings of Imprisoned Will
            { 18, 86877 }, -- Lightning Prisoner's Boots
        },
    },
    {
        name = ALIL["Armor"] .. " - " .. ALIL["Plate"],
        [MSV_DIFF] = {
            { 1, 89974 }, -- Crown of Keening Stars
            { 2, 86752 }, -- Nullification Greathelm
            { 4, 86807 }, -- Spaulders of the Emperor's Rage
            { 5, 86780 }, -- Shoulderguards of the Unflanked
            { 7, 86779 }, -- Breastplate of the Kings' Guard
            { 8, 89976 }, -- Chestguard of Eternal Vigilance
            { 10, 86766 }, -- Bindings of Ancient Spirits
            { 11, 86751 }, -- Bracers of Six Oxen
            { 12, 89969 }, -- Bonded Soul Bracers
            { 16, 86794 }, -- Starcrusher Gauntlets
            { 18, 86785 }, -- Girdle of Delirious Visions
            { 19, 86793 }, -- Star-Stealer Waistguard
            { 21, 86803 }, -- Jang-xi's Devastating Legplates
            { 22, 86756 }, -- Legplates of Sagacious Shadows
            { 24, 86742 }, -- Jasper Clawfeet
            { 25, 86744 }, -- Heavenly Jade Greatboots
            { 26, 86760 }, -- Sollerets of Spirit Splitting
        },
        [HOF_DIFF] = {
            { 1, 86832 }, -- Garalon's Hollow Skull
            { 3, 89956 }, -- Pauldrons of the Broken Blade
            { 4, 86860 }, -- Shoulderpads of Misshapen Life
            { 6, 86816 }, -- Chestplate of the Forbidden Tower
            { 7, 89958 }, -- Garalon's Graven Carapace
            { 9, 86823 }, -- Windblade Talons
            { 10, 86846 }, -- Inlaid Cricket Bracers
            { 11, 86849 }, -- Plated Locust Bracers
            { 12, 86848 }, -- Serrated Wasp Bracers
            { 16, 86837 }, -- Grasps of Panic
            { 18, 86822 }, -- Waistplate of Overwhelming Assault
            { 19, 89954 }, -- Warbelt of Sealed Pods
            { 21, 86854 }, -- Articulated Legplates
            { 22, 89963 }, -- Legplates of Regal Reinforcement
            { 24, 86852 }, -- Impaling Treads
        },
        [TERRACE_DIFF] = {
            { 1, 86876 }, -- Casque of Expelled Corruption
            { 2, 86891 }, -- Cuirass of the Animated Protector
            { 4, 86868 }, -- Bracers of Defiled Earth
            { 6, 89981 }, -- Grasps of Serpentine Might
            { 16, 86902 }, -- Mender's Girdle of Endless Spring
            { 17, 86904 }, -- Patroller's Girdle of Endless Spring
            { 18, 86903 }, -- Protector's Girdle of Endless Spring
            { 20, 86870 }, -- Deepwater Greatboots
            { 21, 86887 }, -- Sollerets of Instability
        },
    },
    {
        name = ALIL["Cloak"],
        [MSV_DIFF] = {
            { 1, 86782 }, -- Arrow Breaking Windcloak
            { 2, 86748 }, -- Cape of Three Lanterns
            { 3, 86753 }, -- Cloak of Peacock Feathers
            { 4, 89971 }, -- Mindshard Drape
        },
        [HOF_DIFF] = {
            { 1, 86853 }, -- Cloak of Raining Blades
            { 2, 86827 }, -- Drape of Gathering Clouds
            { 3, 86812 }, -- Hisek's Chrysanthemum Cape
            { 4, 86831 }, -- Legbreaker Greatcloak
            { 5, 86840 }, -- Stormwake Mistcloak
        },
        [TERRACE_DIFF] = {
            { 1, 86874 }, -- Cloak of Overwhelming Corruption
            { 2, 86883 }, -- Daybreak Drape
        }
    },
    {
        name = ALIL["Weapon"],
        [MSV_DIFF] = {
            { 1, 86741 }, -- Dagger of the Seven Stars
            { 2, 86789 }, -- "Elegion, the Fanged Crescent"
            { 3, 86762 }, -- "Gara'kal, Fist of the Spiritbinder"
            { 4, 86806 }, -- "Tihan, Scepter of the Sleeping Emperor"
            { 16, 86777 }, -- "Screaming Tiger, Qiang's Unbreakable Polearm"
            { 17, 86799 }, -- Starshatter
            { 18, 86801 }, -- "Fang Kung, Spark of Titans"
            { 19, 86796 }, -- Torch of the Celestial Spark
        },
        [HOF_DIFF] = {
            { 1, 86864 }, -- Claws of Shek'zeer
            { 2, 86865 }, -- "Kri'tak, Imperial Scepter of the Swarm"
            { 3, 86863 }, -- Scimitar of Seven Stars
            { 4, 86862 }, -- Un'sok's Amber Scalpel
        },
        [TERRACE_DIFF] = {
            { 1, 86879 }, -- "Gao-Rei, Staff of the Legendary Protector"
            { 2, 86893 }, -- "Jin'ya, Orb of the Waterspeaker"
            { 3, 86906 }, -- "Kilrak, Jaws of Terror"
            { 4, 86886 }, -- "Loshan, Terror Incarnate"
            { 16, 86909 }, -- Regail's Crackling Dagger
            { 17, 86905 }, -- "Shin'ka, Execution of Dominion"
            { 18, 86910 }, -- Spiritsever
            { 19, 86889 }, -- "Taoren, the Soul Burner"
        },
    },
    {
        name = ALIL["Off Hand"] .. "/" .. ALIL["Shield"],
        [MSV_DIFF] = {
            { 1, 89426 }, -- Fan of Fiery Winds
            { 16, 86764 }, -- Eye of the Ancient Spirit
        },
        [HOF_DIFF] = {
            { 1, 86829 }, -- Tornado-Summoning Censer
        }
    },
    {
        name = ALIL["Neck"],
        [MSV_DIFF] = {
            { 1, 86739 }, -- Beads of the Mogu'shi
            { 2, 86754 }, -- Amulet of Seven Curses
            { 3, 86759 }, -- Soulgrasp Choker
            { 4, 86776 }, -- Amulet of the Hidden Kings
            { 5, 86783 }, -- Zian's Choker of Coalesced Shadow
            { 6, 86810 }, -- Worldwaker Cabochon
        },
        [HOF_DIFF] = {
            { 1, 86824 }, -- Choker of the Unleashed Storm
            { 2, 86856 }, -- Korven's Amber-Sealed Beetle
            { 3, 89952 }, -- Pheromone-Coated Choker
            { 4, 86835 }, -- Necklace of Congealed Weaknesses
        },
        [TERRACE_DIFF] = {
            { 1, 86872 }, -- Kaolan's Withering Necklace
            { 2, 86871 }, -- Shackle of Eversparks
        }
    },
    {
        name = ALIL["Finger"],
        [MSV_DIFF] = {
            { 1, 89972 }, -- Band of Bursting Novas
            { 2, 86767 }, -- Circuit of the Frail Soul
            { 3, 89968 }, -- Feng's Ring of Dreams
            { 4, 89967 }, -- Feng's Seal of Binding

        },
        [HOF_DIFF] = {
            { 1, 86814 }, -- Fragment of Fear Made Flesh
            { 2, 86851 }, -- Painful Thorned Ring
            { 3, 86820 }, -- Ring of the Bladed Tempest
            { 4, 86830 }, -- Ring of the Shattered Shell
            { 5, 86858 }, -- Seal of the Profane
            { 6, 86813 }, -- Vizier's Ruby Signet
        },
        [TERRACE_DIFF] = {
            { 1, 86880 }, -- Dread Shadow Ring
            { 2, 86869 }, -- Regail's Band of the Endless
            { 3, 86873 }, -- Watersoul Signet
        }
    },
    {
        name = ALIL["Trinket"],
        [MSV_DIFF] = {
            { 1, 86791 }, -- Bottle of Infinite Stars
            { 2, 86772 }, -- Jade Bandit Figurine
            { 3, 86775 }, -- Jade Warlord Figurine
            { 4, 86774 }, -- Jade Courtesan Figurine
            { 5, 86771 }, -- Jade Charioteer Figurine
            { 6, 86773 }, -- Jade Magistrate Figurine
            { 7, 86802 }, -- Lei Shen's Final Orders
            { 8, 86792 }, -- Light of the Cosmos
            { 9, 86805 }, -- Qin-xi's Polarizing Seal
            { 10, 86790 }, -- Vial of Dragon's Blood
        },
        [TERRACE_DIFF] = {
            { 1, 86907 }, -- Essence of Terror
            { 2, 86894 }, -- Darkmist Vortex
            { 3, 86885 }, -- Spirits of the Sun
            { 4, 86881 }, -- Stuff of Nightmares
            { 5, 86890 }, -- Terror in the Mists
        },
    },
    {
        name = AL["Token"],
        [HOF_DIFF] = {
            { 1, 89265 }, -- Chest of the Shadowy Conqueror
            { 2, 89266 }, -- Chest of the Shadowy Protector
            { 3, 89264 }, -- Chest of the Shadowy Vanquisher
            { 5, 89271 }, -- Gauntlets of the Shadowy Conqueror
            { 6, 89272 }, -- Gauntlets of the Shadowy Protector
            { 7, 89270 }, -- Gauntlets of the Shadowy Vanquisher
            { 16, 89268 }, -- Leggings of the Shadowy Conqueror
            { 17, 89269 }, -- Leggings of the Shadowy Protector
            { 18, 89267 }, -- Leggings of the Shadowy Vanquisher
        },
        [TERRACE_DIFF] = {
            { 1, 89274 }, -- Helm of the Shadowy Conqueror
            { 2, 89275 }, -- Helm of the Shadowy Protector
            { 3, 89273 }, -- Helm of the Shadowy Vanquisher
            { 16, 89277 }, -- Shoulders of the Shadowy Conqueror
            { 17, 89278 }, -- Shoulders of the Shadowy Protector
            { 18, 89276 }, -- Shoulders of the Shadowy Vanquisher
        },
    },
    {
        name = AL["Misc"],
        [VENDOR_DIFF] = {
            { 1, 248329 }, --  Satchel of Stone Fragments
            { 2, 248666 }, --  Satchel of Celestial Chance
            { 16, 247796 },--  Commendation of Service
        }
    },
    }
}

data["SpiritOfHarmonyVendor"] = {
    name = format(AL["'%s' Vendor"], format(SUPERIOR_QUALITY, ALIL["Spirit of Harmony"])),
    ContentType = VENDOR_CONTENT,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    items = {
        {
            name = AL["Crafting"],
            [VENDOR_DIFF] = {
                { 1, 76061 }, -- Spirit of Harmony
                { 3, 72092 }, -- Ghost Iron Ore
                { 4, 72093 }, -- Kyparite
                { 5, 72094 }, -- Black Trillium Ore
                { 6, 72103 }, -- White Trillium Ore
                { 8, 89610 }, -- Pandaria Herbs
                { 9, 72238 }, -- Golden Lotus
                { 11, 74249 }, -- Spirit Dust
                { 12, 74250 }, -- Mysterious Essence
                { 13, 74247 }, -- Ethereal Shard
                { 16, "c402", [PRICE_EXTRA_ITTYPE] = "SpiritOfHarmony:1"}, -- Ironpaw Token
                { 18, 87399 }, -- Restored Artifact
                { 20, 79255 }, -- Starlight Ink
                { 22, 72988 }, -- Windwool Cloth
                { 24, 72120 }, -- Mist-Touched Leather
                { 25, 79101 }, -- Prismatic Scale
                { 27, 76734 }, -- Serpent's Eye
            },
        },
    }
}

data["ChallengeModeMoP"] = {
    name = AL["Challenge Mode Armor Sets"],
    ContentType = SET_CONTENT,
    TableType = NORMAL_DIFF,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    items = {
        {
            name = ALIL["DEATHKNIGHT"],
            [NORMAL_DIFF] = {
                { 1, 90053 }, -- Crown of the Lich Lord
                { 2, 90055 }, -- Shoulderguards of the Lich Lord
                { 3, 90051 }, -- Chestguard of the Lich Lord
                { 4, 90056 }, -- Bracers of the Lich Lord
                { 5, 90052 }, -- Grasps of the Lich Lord
                { 6, 90049 }, -- Girdle of the Lich Lord
                { 7, 90054 }, -- Legplates of the Lich Lord
                { 8, 90050 }, -- Treads of the Lich Lord
            },
        },
        {
            name = ALIL["DRUID"],
            [NORMAL_DIFF] = {
                { 1, 90062 }, -- Hood of the Cycle
                { 2, 90065 }, -- Branches of the Cycle
                { 3, 90064 }, -- Robes of the Cycle
                { 4, 90066 }, -- Bracers of the Cycle
                { 5, 90061 }, -- Gloves of the Cycle
                { 6, 90059 }, -- Waistguard of the Cycle
                { 7, 90063 }, -- Leggings of the Cycle
                { 8, 90060 }, -- Sandals of the Cycle
            },
        },
                {
            name = ALIL["HUNTER"],
            [NORMAL_DIFF] = {
                { 1, 90072 }, -- Helm of the Howling Beast
                { 2, 90074 }, -- Shoulderguards of the Howling Beast
                { 3, 90070 }, -- Chestguard of the Howling Beast
                { 4, 90075 }, -- Wristwraps of the Howling Beast
                { 5, 90071 }, -- Grips of the Howling Beast
                { 6, 90068 }, -- Cinch of the Howling Beast
                { 7, 90073 }, -- Legguards of the Howling Beast
                { 8, 90069 }, -- Boots of the Howling Beast
            },
        },
                {
            name = ALIL["MAGE"],
            [NORMAL_DIFF] = {
                { 1, 90082 }, -- Hood of the Elemental Triad
                { 2, 90085 }, -- Spaulders of the Elemental Triad
                { 3, 90084 }, -- Robes of the Elemental Triad
                { 4, 90086 }, -- Bracers of the Elemental Triad
                { 5, 90081 }, -- Gloves of the Elemental Triad
                { 6, 90079 }, -- Girdle of the Elemental Triad
                { 7, 90083 }, -- Leggings of the Elemental Triad
                { 8, 90080 }, -- Boots of the Elemental Triad
            },
        },
                {
            name = ALIL["MONK"],
            [NORMAL_DIFF] = {
                { 1, 90092 }, -- Crown of the Regal Lord
                { 2, 90094 }, -- Shoulderguards of the Regal Lord
                { 3, 90090 }, -- Chestwrap of the Regal Lord
                { 4, 90095 }, -- Bracers of the Regal Lord
                { 5, 90091 }, -- Handwraps of the Regal Lord
                { 6, 90088 }, -- Greatbelt of the Regal Lord
                { 7, 90093 }, -- Legwraps of the Regal Lord
                { 8, 90089 }, -- Treads of the Regal Lord
            },
        },
                {
            name = ALIL["PALADIN"],
            [NORMAL_DIFF] = {
                { 1, 90100 }, -- Greathelm of the Holy Warrior
                { 2, 90102 }, -- Shoulderplate of the Holy Warrior
                { 3, 90098 }, -- Chestplate of the Holy Warrior
                { 4, 90103 }, -- Wristguards of the Holy Warrior
                { 5, 90099 }, -- Gauntlets of the Holy Warrior
                { 6, 90096 }, -- Girdle of the Holy Warrior
                { 7, 90101 }, -- Legplates of the Holy Warrior
                { 8, 90097 }, -- Greatboots of the Holy Warrior
            },
        },
                {
            name = ALIL["PRIEST"],
            [NORMAL_DIFF] = {
                { 1, 90116 }, -- Cowl of the Light
                { 2, 90113 }, -- Pauldrons of the Light
                { 3, 90114 }, -- Robes of the Light
                { 4, 90112 }, -- Bracers of the Light
                { 5, 90115 }, -- Hands of the Light
                { 6, 90110 }, -- Cord of the Light
                { 7, 90117 }, -- Leggings of the Light
                { 8, 90111 }, -- Steps of the Light
            },
        },
                {
            name = ALIL["ROGUE"],
            [NORMAL_DIFF] = {
                { 1, 90120 }, -- Hood of the Silent Assassin
                { 2, 90125 }, -- Spaulders of the Silent Assassin
                { 3, 90122 }, -- Shadowwrap of the Silent Assassin
                { 4, 90126 }, -- Bracers of the Silent Assassin
                { 5, 90123 }, -- Gloves of the Silent Assassin
                { 6, 90119 }, -- Girdle of the Silent Assassin
                { 7, 90124 }, -- Leggings of the Silent Assassin
                { 8, 90121 }, -- Tabi of the Silent Assassin
            },
        },
        {
            name = ALIL["SHAMAN"],
            [NORMAL_DIFF] = {
                { 1, 90132 }, -- Windfury Mask
                { 2, 90134 }, -- Windfury Spirit Guides
                { 3, 90130 }, -- Windfury Harness
                { 4, 90127 }, -- Windfury Bracers
                { 5, 90131 }, -- Windfury Crushers
                { 6, 90128 }, -- Windfury Belt
                { 7, 90133 }, -- Windfury Legguards
                { 8, 90129 }, -- Windfury Sandals
            },
        },
        {
            name = ALIL["WARLOCK"],
            [NORMAL_DIFF] = {
                { 1, 90142 }, -- Horns of the Betrayer
                { 2, 90138 }, -- Amice of the Betrayer
                { 3, 90140 }, -- Robes of the Betrayer
                { 4, 90139 }, -- Bracers of the Betrayer
                { 5, 90141 }, -- Handguards of the Betrayer
                { 6, 90136 }, -- Belt of the Betrayer
                { 7, 90143 }, -- Leggings of the Betrayer
                { 8, 90137 }, -- Boots of the Betrayer
            },
        },
        {
            name = ALIL["WARRIOR"],
            [NORMAL_DIFF] = {
                { 1, 90151 }, -- Crown of the Golden King
                { 2, 90153 }, -- Mantle of the Golden King
                { 3, 90149 }, -- Chestplate of the Golden King
                { 4, 90154 }, -- Bracers of the Golden King
                { 5, 90150 }, -- Reach of the Golden King
                { 6, 90147 }, -- Girdle of the Golden King
                { 7, 90152 }, -- Greaves of the Golden King
                { 8, 90148 }, -- Greatboots of the Golden King
            },
        },
    },
}

-- shared!
data["WorldEpicsMoP"] = {
    name = AL["World Epics"],
    ContentType = COLLECTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.WORLD_EPICS,
    items = {
        {
            name = AL["World Epics"],
            [NORMAL_ITTYPE] = {
                { 1,  90583 }, -- Don Guerrero's Glorious Choker
                { 2,  90590 }, -- Dorian's Necklace of Burgeoning Dreams
                { 3,  90591 }, -- Ring of the Shipwrecked Prince
                { 4,  90589 }, -- Dirl's Drafty Drape
                { 5,  90571 }, -- Scroll of Whispered Secrets
                { 6,  90575 }, -- Sutiru's Brazen Bulwark
                { 8,  90573 }, -- Wang's Unshakable Smile
                { 9,  90588 }, -- Rittsyn's Ruinblasters
                { 10,  90574 }, -- Etoshia's Elegant Gloves
                { 12,  90585 }, -- Vulajin's Vicious Breastplate
                { 14,  90572 }, -- Kilt of Pandaren Promises
                { 16,  90579 }, -- Legplates of Durable Dreams
                { 17,  90577 }, -- Boblet's Bouncing Hauberk
            }
        }
    }
}

data["RaresMOPMobs"] = {
    name = AL["Rare Mobs"],
    ContentType = COLLECTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    items = {
        {
            name = ALIL["The Jade Forest"],
            [NORMAL_DIFF] = {
                { 1, "INV_box_04", nil, ALIL["Aethis"] },
                { 2, 87649 }, -- Pool-Stirrer
                { 4, "INV_box_04", nil, ALIL["Ferdinand"] },
                { 5, 87652 }, -- Ook-Breaker Mace
                { 7, "INV_box_04", nil, ALIL["Kor'nas Nightsavage"] },
                { 8, 87642 }, -- Darkstaff of Annihilation
                { 10, "INV_box_04", nil, ALIL["Krax'ik"] },
                { 11, 87646 }, -- Needlefang Throatripper
                { 16, "INV_box_04", nil, ALIL["Mister Ferocious"] },
                { 17, 87652 }, -- Ook-Breaker Mace
                { 19, "INV_box_04", nil, ALIL["Morgrinn Crackfang"] },
                { 20, 87643 }, -- Fangcracker Battlemace
                { 22, "INV_box_04", nil, ALIL["Sarnak"] },
                { 23, 87650 }, -- Fishsticker Crossbow
                { 25, "INV_box_04", nil, ALIL["Urobi the Walker"] },
                { 26, 87651 }, -- Pathwalker Greatstaff

                -- Shared Zone Loot (second page, numbers prefixed with 1)
                { 101, "INV_box_04", nil, AL["Shared Zone Loot"] },
                { 102, 87586 }, -- Forest Trickster's Leggings
                { 103, 87590 }, -- Jade Heart Leggings
                { 104, 87587 }, -- Orchard Tender's Leggings
                { 105, 87591 }, -- Tian Trainee Leggings
                { 106, 87592 }, -- Grookin' Grookin' Trousers
                { 107, 87588 }, -- Leggings of Spiritsong Melody
                { 108, 87593 }, -- Gan Shi Warlord Legguards
                { 109, 87594 }, -- Leggings of Forgotten War
                { 110, 87589 }, -- Leggings of Fractured Reflection
                { 111, 87217 }, -- Small Bag of Goods
            }
        },
        {
            name = ALIL["Valley of the Four Winds"],
            [NORMAL_DIFF] = {
                { 1, "INV_box_04", nil, ALIL["Blackhoof"] },
                { 2, 86565 }, -- Battle Horn
                { 4, "INV_box_04", nil, ALIL["Bonobos"] },
                { 5, 86591 }, -- Magic Banana
                { 7, "INV_box_04", nil, ALIL["Jonn-Dar"] },
                { 8, 86572 }, -- Terracotta Fragment
                { 10, "INV_box_04", nil, ALIL["Nal'lak the Ripper"] },
                { 11, 86576 }, -- Dynasty of Steel
                { 16, "INV_box_04", nil, ALIL["Nasra Spothide"] },
                { 17, 86587 }, -- Seed of Tranquil Growth
                { 19, "INV_box_04", nil, ALIL["Salyin Warscout"] },
                { 20, 86583 }, -- Salyin Battle Banner
                { 22, "INV_box_04", nil, ALIL["Sele'na"] },
                { 23, 86580 }, -- Overgrown Lilypad
                { 25, "INV_box_04", nil, ALIL["Sulik'shor"] },
                { 26, 86569 }, -- Crystal of Insanity

                -- Shared Zone Loot
                { 101, "INV_box_04", nil, AL["Shared Zone Loot"] },
                { 102, 87597 }, -- Gloves of Congealed Mist
                { 103, 87598 }, -- Monstrous Silk Gloves
                { 104, 87595 }, -- Gloves of Burrow Spelunking
                { 105, 87599 }, -- Grower's Gloves
                { 106, 87600 }, -- Marshsong Gloves
                { 107, 87596 }, -- Mudmug's Mitts
                { 108, 87602 }, -- Grain Warden's Gauntlets
                { 109, 87603 }, -- Thunderfall Gauntlets
                { 110, 87601 }, -- Plough Driving Grips
                { 111, 87217 }, -- Small Bag of Goods
            }
        },
        {
            name = ALIL["Krasarang Wilds"],
            [NORMAL_DIFF] = {
                { 1, "INV_box_04", nil, ALIL["Arness the Scale"] },
                { 2, 90723 }, -- Arness's Scaled Leggings
                { 4, "INV_box_04", nil, ALIL["Cournith Waterstrider"] },
                { 5, 90721 }, -- Courinth Waterstrider's Silken Finery
                { 7, "INV_box_04", nil, ALIL["Gaarn the Toxic"] },
                { 8, 90725 }, -- Gaarn's Leggings of Infestation
                { 10, "INV_box_04", nil, ALIL["Go-Kan"] },
                { 11, 90719 }, -- Go-Kan's Golden Trousers
                { 16, "INV_box_04", nil, ALIL["Qu'nas"] },
                { 17, 90717 }, -- Qu'nas' Apocryphal Legplates
                { 19, "INV_box_04", nil, ALIL["Ruun Ghostpaw"] },
                { 20, 90720 }, -- Silent Leggings of the Ghostpaw
                { 22, "INV_box_04", nil, ALIL["Spriggin"] },
                { 23, 90724 }, -- Spriggin's Sproggin' Leggin'
                { 25, "INV_box_04", nil, ALIL["Torik-Ethis"] },
                { 26, 90718 }, -- Torik-Ethis' Bloodied Legguards

                -- Shared Zone Loot
                { 101, "INV_box_04", nil, AL["Shared Zone Loot"] },
                { 102, 87604 }, -- Beachcomber's Hat
                { 103, 87608 }, -- Korjan Mystic's Hood
                { 104, 87609 }, -- Brushstalker Helm
                { 105, 87605 }, -- Crest of the Red Crane
                { 106, 87610 }, -- Deepwild Hunting Helm
                { 107, 87606 }, -- Tidehunter Helm
                { 108, 87612 }, -- Ancient Krasari Helm
                { 109, 87611 }, -- Shen-zin Shell Headguard
                { 110, 87607 }, -- Unearthed Dojani Headcover
                { 111, 87217 }, -- Small Bag of Goods
            }
        },
        {
            name = ALIL["Kun-Lai Summit"],
            [NORMAL_DIFF] = {
                { 1, "INV_box_04", nil, ALIL["Ahone the Wanderer"] },
                { 2, 86588 }, -- Pandaren Firework Launcher
                { 4, "INV_box_04", nil, ALIL["Borginn Darkfist"] },
                { 5, 86570 }, -- Crate of Kidnapped Puppies
                { 7, "INV_box_04", nil, ALIL["Havak"] },
                { 8, 86573 }, -- Shard of Archstone
                { 10, "INV_box_04", nil, ALIL["Korda Torros"] },
                { 11, 86566 }, -- Forager's Gloves
                { 16, "INV_box_04", nil, ALIL["Nessos the Oracle"] },
                { 17, 86584 }, -- Hardened Shell
                { 19, "INV_box_04", nil, ALIL["Scritch"] },
                { 20, 86592 }, -- Hozen Peace Pipe
                { 22, "INV_box_04", nil, ALIL["Ski'thik"] },
                { 23, 86577 }, -- Rod of Ambershaping
                { 25, "INV_box_04", nil, ALIL["Zai the Outcast"] },
                { 26, 86581 }, -- Farwater Conch

                -- Shared Zone Loot
                { 101, "INV_box_04", nil, AL["Shared Zone Loot"] },
                { 102, 87616 }, -- Mountain Trailblazer's Cuffs
                { 103, 87615 }, -- Yakwasher's Bracers
                { 104, 87617 }, -- Bracers of the Serene Mountaintop
                { 105, 87613 }, -- Frozen Zandalari Bracer
                { 106, 87618 }, -- Ice Encrusted Bracer
                { 107, 87614 }, -- Kafa Picker's Bracers
                { 108, 87620 }, -- Bracers of the Frozen Summit
                { 109, 87619 }, -- Terracotta Guardian's Bracer
                { 110, 87621 }, -- Wristguards of Great Fortune
                { 111, 87217 }, -- Small Bag of Goods
            }
        },
        {
            name = ALIL["Townlong Steppes"],
            [NORMAL_DIFF] = {
                { 1, "INV_box_04", nil, ALIL["Eshelon"] },
                { 2, 87222 }, -- Big Bag of Linens
                { 4, "INV_box_04", nil, ALIL["Kah'tir"] },
                { 5, 87218 }, -- Big Bag of Arms
                { 7, "INV_box_04", nil, ALIL["Lith'ik the Stalker"] },
                { 8, 87221 }, -- Big Bag of Jewels
                { 10, "INV_box_04", nil, ALIL["Lon the Bull"] },
                { 11, 87219 }, -- Big Bag of Herbs
                { 16, "INV_box_04", nil, ALIL["Norlaxx"] },
                { 17, 87220 }, -- Big Bag of Mysteries
                { 19, "INV_box_04", nil, ALIL["Siltriss the Sharpener"] },
                { 20, 87223 }, -- Big Bag of Skins
                { 22, "INV_box_04", nil, ALIL["The Yowler"] },
                { 23, 87225 }, -- Big Bag of Food
                { 25, "INV_box_04", nil, ALIL["Yul Wildpaw"] },
                { 26, 87224 }, -- Big Bag of Wonders

                -- Shared Zone Loot
                { 101, "INV_box_04", nil, AL["Shared Zone Loot"] },
                { 102, 87625 }, -- Congealed Mist Amulet
                { 103, 87623 }, -- Razor-Sharp Chitin Choker
                { 104, 87626 }, -- Suna's Shattered Locket
                { 105, 87624 }, -- Yaungol Mist-Shaman's Amulet
                { 106, 87622 }, -- Yoke of Niuzao
                { 107, 87217 }, -- Small Bag of Goods
            }
        },
        {
            name = ALIL["Dread Wastes"],
            [NORMAL_DIFF] = {
                { 1, "INV_box_04", nil, ALIL["Ai-Li Skymirror"] },
                { 2, 86589 }, -- Ai-Li's Skymirror
                { 4, "INV_box_04", nil, ALIL["Dak the Breaker"] },
                { 5, 86567 }, -- Yaungol Wind Chime
                { 7, "INV_box_04", nil, ALIL["Gar'lok"] },
                { 8, 86578 }, -- Eternal Warrior's Sigil
                { 10, "INV_box_04", nil, ALIL["Ik-Ik the Nimble"] },
                { 11, 86593 }, -- Hozen Beach Ball
                { 16, "INV_box_04", nil, ALIL["Karr the Darkener"] },
                { 17, 86564 }, -- Imbued Jade Fragment
                { 19, "INV_box_04", nil, ALIL["Krol the Blade"] },
                { 20, 86574 }, -- Elixir of Ancient Knowledge
                { 22, "INV_box_04", nil, ALIL["Nalash Verdantis"] },
                { 23, 86563 }, -- Hollow Reed
                { 25, "INV_box_04", nil, ALIL["Omnis Grinlok"] },
                { 26, 86585 }, -- Golden Fleece

                -- Shared Zone Loot
                { 101, "INV_box_04", nil, AL["Shared Zone Loot"] },
                { 102, 87635 }, -- Amber-Starched Robes
                { 103, 87634 }, -- Mazu's Robe
                { 104, 87631 }, -- Jiao-Skin Tunic
                { 105, 87630 }, -- Chestpiece of Twinkling Stars
                { 106, 87632 }, -- Fearsworn Chestpiece
                { 107, 87629 }, -- Chestplate of Manifest Dread
                { 108, 87627 }, -- Kunchong Carapace Chestguard
                { 109, 87628 }, -- Spinebreaker Chestpiece
                { 110, 87217 }, -- Small Bag of Goods
            }
        },
        {
            name = ALIL["Vale of Eternal Blossoms"],
            [NORMAL_DIFF] = {
                { 1, "INV_box_04", nil, ALIL["Ai-Ran the Shifting Cloud"] },
                { 2, 86590 }, -- Essence of the Breeze
                { 4, "INV_box_04", nil, ALIL["Kal'tik the Blight"] },
                { 5, 86579 }, -- Bottled Tornado
                { 7, "INV_box_04", nil, ALIL["Kang the Soul Thief"] },
                { 8, 86571 }, -- Kang's Bindstone
                { 10, "INV_box_04", nil, ALIL["Major Nanners"] },
                { 11, 86594 }, -- Helpful Wikky's Whistle
                { 16, "INV_box_04", nil, ALIL["Moldo One-Eye"] },
                { 17, 86586 }, -- Panflute of Pandaria
                { 19, "INV_box_04", nil, ALIL["Sahn Tidehunter"] },
                { 20, 86582 }, -- Aqua Jewel
                { 22, "INV_box_04", nil, ALIL["Urgolax"] },
                { 23, 86575 }, -- Chalice of Secrets
                { 25, "INV_box_04", nil, ALIL["Yorik Sharpeye"] },
                { 26, 86568 }, -- Mr. Smite's Brass Compass

                -- Shared Zone Loot
                { 101, "INV_box_04", nil, AL["Shared Zone Loot"] },
                { 102, 87638 }, -- Cloak of Tranquil Clouds
                { 103, 87636 }, -- Cloak of the Forgotten Emperor
                { 104, 87637 }, -- Jade Harbinger's Cloak
                { 105, 87640 }, -- Softfoot's Drape
                { 106, 87639 }, -- Tattered Guo-Lai Dynasty Cloak
                { 107, 87217 }, -- Small Bag of Goods
            }
        },
        {
            name = ALIL["Isle of Thunder"],
            [NORMAL_DIFF] = {
                { 1, "INV_box_04", nil, ALIL["Ancient Mogu Guardian"] },
                { 2, 94826 }, -- Mogu Sportsman's Bow
                { 4, "INV_box_04", nil, ALIL["Cera"] },
                { 5, 94706 }, -- Cera's Impalers
                { 7, "INV_box_04", nil, ALIL["Echo of Kros"] },
                { 8, 94708 }, -- Saurok Ritualist's Sacrificial Dagger
                { 10, "INV_box_04", nil, ALIL["Electromancer Ju'le"] },
                { 11, 94825 }, -- Lightning Snare
                { 16, "INV_box_04", nil, ALIL["Haywire Sunreaver Construct"] },
                { 17, 94124 }, -- Sunreaver Micro-Sentry
                { 19, "INV_box_04", nil, ALIL["Incomplete Drakkari Colossus"] },
                { 20, 94823 }, -- Drakkari Decapitator
                { 22, "INV_box_04", nil, ALIL["Kor'dok and Tinzo the Emberkeeper"] },
                { 23, 94720 }, -- Vengeance of Kor'dok
                { 25, "INV_box_04", nil, ALIL["Qi'nor"] },
                { 26, 94824 }, -- Gaze of Qi'nor

                -- Second page
                { 101, "INV_box_04", nil, AL["Ra'sha"] },
                { 102, 95566 }, -- Ra'sha's Sacrificial Dagger
                { 104, "INV_box_04", nil, ALIL["Spirit of Warlord Teng"] },
                { 105, 94707 }, -- Teng's Reach
                { 107, "INV_box_04", nil, ALIL["Windweaver Akil'amon"] },
                { 108, 94709 }, -- Talonblade of Akil'amon
                { 116, "INV_box_04", nil, AL["Shared Zone Loot"] },
                { 117, 94222 }, -- Key to the Palace of Lei Shen
                { 118, 92426 }, -- Sealed Tome of the Lost Legion
                { 119, 94221 }, -- Shan'ze Ritual Stone
            }
        },
        {
            name = ALIL["Timeless Isle"],
            [NORMAL_DIFF] = {
                { 1, "INV_box_04", nil, ALIL["Archiereus of Flame"] },
                { 2, 86574 }, -- Elixir of Ancient Knowledge
                { 4, "INV_box_04", nil, ALIL["Bufo"] },
                { 5, 104169 }, -- Gulp Froglet
                { 7, "INV_box_04", nil, ALIL["Champion of the Black Flame"] },
                { 8, 104302 }, -- Blackflame Daggers
                { 10, "INV_box_04", nil, ALIL["Chelon"].." & "..ALIL["Great Turtle Furyshell"] },
                { 11, 86584 }, -- Hardened Shell
                { 13, "INV_box_04", nil, ALIL["Cinderfall"] },
                { 14, 104299 }, -- Falling Flame
                { 16, "INV_box_04", nil, ALIL["Cranegnasher"] },
                { 17, 104268 }, -- Pristine Stalker Hide
                { 19, "INV_box_04", nil, ALIL["Dread Ship Vazuvius"] },
                { 20, 104294 }, -- Rime of the Time-Lost Mariner
                { 22, "INV_box_04", nil, ALIL["Emerald Gander"] },
                { 23, 104287 }, -- Windfeather Plume
                { 25, "INV_box_04", nil, ALIL["Evermaw"] },
                { 26, 104115 }, -- Mist-Filled Spirit Lantern
                { 28, "INV_box_04", nil, ALIL["Flintlord Gairan"] },
                { 29, 104298 }, -- Ordon Death Chime

                -- Second page
                { 101, "INV_box_04", nil, ALIL["Garnia"] },
                { 102, 104159 }, -- Ruby Droplet
                { 104, "INV_box_04", nil, ALIL["Golganarr"] },
                { 105, 104262 }, -- Odd Polished Stone
                { 107, "INV_box_04", nil, ALIL["Gu'chi the Swarmbringer"] },
                { 108, 104291 }, -- Swarmling of Gu'chi
                { 110, "INV_box_04", nil, ALIL["Huolon"] },
                { 111, 104269 }, -- Reins of the Thundering Onyx Cloud Serpent
                { 112, 104286 }, -- Quivering Firestorm Egg
                { 116, "INV_box_04", nil, ALIL["Ironfur Steelhorn"] },
                { 117, 89770 }, -- Tuft of Yak Fur
                { 119, "INV_box_04", nil, ALIL["Imperial Python"] },
                { 120, 104161 }, -- Death Adder Hatchling
                { 122, "INV_box_04", nil, ALIL["Jakur of Ordon"] },
                { 123, 104331 }, -- Warning Sign
                { 125, "INV_box_04", nil, ALIL["Karkanos"] },
                { 126, 104035 }, -- Giant Purse of Timeless Coins
                { 128, "INV_box_04", nil, ALIL["Leafmender"] },
                { 129, 104156 }, -- Ashleaf Spriteling

                -- Third page
                { 201, "INV_box_04", nil, ALIL["Molten Guardian"] },
                { 202, 104328 }, -- Cauterizing Core
                { 204, "INV_box_04", nil, ALIL["Monstrous Spineclaw"] },
                { 205, 104168 }, -- Spineclaw Crab
                { 207, "INV_box_04", nil, AL["Nice Sprite"] },
                { 208, 104160 }, -- Dandelion Frolicker
                { 210, "INV_box_04", nil, ALIL["Rattleskew"] },
                { 211, 104321 }, -- Captain Zvezdan's Lost Leg
                { 213, "INV_box_04", nil, ALIL["Rock Moss"] },
                { 214, 104313 }, -- Golden Moss
                { 216, "INV_box_04", nil, ALIL["Spelurk"] },
                { 217, 104320 }, -- Cursed Talisman
                { 219, "INV_box_04", nil, ALIL["Spirit of Jadefire"] },
                { 220, 104258 }, -- Glowing Green Ash
                { 221, 104307 }, -- Jadefire Spirit
                { 223, "INV_box_04", nil, ALIL["Tsavo'ka"] },
                { 224, 104268 }, -- Pristine Stalker Hide
                { 226, "INV_box_04", nil, ALIL["Urdur the Cauterizer"] },
                { 227, 104306 }, -- Sunset Stone

                -- Fourth page
                { 301, "INV_box_04", nil, ALIL["Watcher Osu"] },
                { 302, 104305 }, -- Ashen Stone
                { 304, "INV_box_04", nil, ALIL["Zesqua"] },
                { 305, 104303 }, -- Rain Stone
                { 307, "INV_box_04", nil, ALIL["Zhu-Gon the Sour"] },
                { 308, 104167 }, -- Skunky Alemental
            }
        },
        {
            name = AL["Misc"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, "INV_box_04", nil, AL["Fixxul Lonelyheart"] },
                { 2, 90078 }, -- Cracked Talisman
                { 4, "INV_box_04", nil, AL["Lorbu Sadsummon"] },
                { 5, 90078 }, -- Cracked Talisman
                { 7, "INV_box_04", nil, AL["Martar the Not-So-Smart"] },
                { 8, 87780 }, -- Martar's Magnifying Glass
                { 10, "INV_box_04", nil, AL["Huggalon the Heart Watcher"] },
                { 11, 90067 }, -- B. F. F. Necklace
                { 13, "INV_box_04", nil, AL["Scotty"] },
                { 14, 89373 }, -- Scotty's Lucky Coin
                { 16, "INV_box_04", nil, AL["Alani"] },
                { 17, 90655 }, -- Reins of the Thundering Ruby Cloud Serpent
                { 19, "INV_box_04", nil, AL["Sungraze Behemoth"] },
                { 20, 89682 }, -- Oddly-Shaped Horn
                { 22, "INV_box_04", nil, AL["Zhing"] },
                { 23, 89697 }, -- Bag of Kafa Beans
                { 25, "INV_box_04", nil, AL["Pengsong"] },
                { 26, 89770 }, -- Tuft of Yak Fur
                { 28, "INV_box_04", nil, AL["Wild Onyx Serpent"] },
                { 29, 93360 }, -- Serpent's Cache
            }
        },
        {
            name = AL["Zandalari Warbringer"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, "INV_box_04", nil, AL["Zandalari Warbringer"] },
                { 2, 94230 }, -- Reins of the Amber Primordial Direhorn
                { 3, 94231 }, -- Reins of the Jade Primordial Direhorn
                { 4, 94229 }, -- Reins of the Slate Primordial Direhorn
                { 5, 94225 }, -- Stolen Celestial Insignia
                { 6, 94227 }, -- Stolen Golden Lotus Insignia
                { 7, 94226 }, -- Stolen Klaxxi Insignia
                { 8, 94223 }, -- Stolen Shado-Pan Insignia
                { 9, 94158 }, -- Big Bag of Zandalari Supplies
                { 10, 94159 }, -- Small Bag of Zandalari Supplies
            }
        },
    }
}

data["RaresMOPItems"] = {
    name = AL["Rare Items"],
    ContentType = COLLECTIONS_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    items = {
        {
            name = ALIL["The Jade Forest"].." / "..ALIL["Valley of the Four Winds"],
            [NORMAL_DIFF] = {
                { 1, "INV_box_04", nil, ALIL["The Jade Forest"] },
                { 2, 86196 },
                { 3, 85777 },
                { 4, 86198 },
                { 5, 85776 },
                { 7, "INV_box_04", nil, AL["Jade Warrior Statue"] },
                { 8, 86199 },
                { 16, "INV_box_04", nil, ALIL["Valley of the Four Winds"] },
                { 17, 86218 },
                { 19, "INV_box_04", nil, AL["Ghostly Pandaren Craftsman"] },
                { 20, 86079 },
                { 22, "INV_box_04", nil, AL["Ghostly Pandaren Fisherman"] },
                { 23, 85973 },
                { 25, "INV_box_04", nil, AL["Cache of Pilfered Goods"] },
                { 26, 86113 },
                { 27, 86112 },
                { 28, 86111 },
                { 29, 86114 },
                { 30, 86110 },
            }
        },
        {
            name = ALIL["Krasarang Wilds"].." / "..ALIL["Kun-Lai Summit"],
            [NORMAL_DIFF] = {
                { 1, "INV_box_04", nil, ALIL["Krasarang Wilds"] },
                { 2, 86124 },
                { 4, "INV_box_04", nil, AL["Barrel of Banana Infused Rum"] },
                { 5, 87266 },
                { 7, "INV_box_04", nil, AL["Equipment Locker"] },
                { 8, 86117 },
                { 9, 86118 },
                { 10, 86119 },
                { 11, 86115 },
                { 12, 86116 },
                { 13, 86120 },
                { 14, 86122 },
                { 15, 86123 },
                { 16, "INV_box_04", nil, ALIL["Kun-Lai Summit"] },
                { 17, 86394 },
                { 18, 88723 },
                { 19, 86393 },
                { 21, "INV_box_04", nil, AL["Frozen Trail Packer"] },
                { 22, 86125 },
                { 24, "INV_box_04", nil, AL["Sprite's Cloth Chest"] },
                { 25, 86223 },
                { 26, 86222 },
                { 27, 86224 },
                { 28, 86225 },
                { 29, 86221 },
            }
        },
        {
            name = ALIL["Townlong Steppes"].." / "..ALIL["Dread Wastes"],
            [NORMAL_DIFF] = {
                { 1, "INV_box_04", nil, ALIL["Townlong Steppes"] },
                { 2, 86518 },
                { 16, "INV_box_04", nil, ALIL["Dread Wastes"] },
                { 17, 86527 },
                { 18, 86522 },
                { 19, 86525 },
                { 20, 86524 },
                { 21, 86521 },
                { 22, 86520 },
                { 23, 86523 },
                { 24, 86526 },
                { 25, 86519 },
                { 27, "INV_box_04", nil, AL["Glinting Rapana Whelk"] },
                { 28, 86529 },
            }
        },
    }
}

data["MountsMoP"] = {
    name = ALIL["Mounts"],
    ContentType = COLLECTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.MOUNTS,
     items = {
        -- TODO: Add missing mounts, more vendor ones, and rep ones
        {
            name = AL["Vendor"],
            [NORMAL_DIFF] = {
                {1, 84101} -- Reins of the Grand Expedition Yak
            },
        },
        {
            name = AL["Drops"], -- Drops
            [NORMAL_DIFF] = {
                { 1,  95059 }, -- Clutch of Ji-Kun
                { 2,  104253 }, -- Kor'kron Juggernaut
                { 3,  87777 }, -- Reins of the Astral Cloud Serpent
                { 4,  94228 }, -- Reins of the Cobalt Primordial Direhorn
                { 5,  87771 }, -- Reins of the Heavenly Onyx Cloud Serpent
                { 6,  95057 }, -- Reins of the Thundering Cobalt Cloud Serpent
                { 7, 89783 }, -- Son of Galleon's Saddle
                { 8, 93666 }, -- Spawn of Horridon
            }
        },
        {
            name = AL["Crafting"],
            [NORMAL_DIFF] = {
                { 1, 95416 }, -- Sky Golem
                { 2, 82453 }, -- Jeweled Onyx Panther
                { 3, 87251 }, -- Geosynchronous World Spinner
                { 4, 87250 }, -- Depleted-Kyparium Rocket
                { 5, 83087 }, -- Ruby Panther
                { 6, 83088 }, -- Jade Panther
                { 7, 83089 }, -- Sunstone Panther
                { 8, 83090 }, -- Sapphire Panther
            }
        },
        {
            name = ALIL["Achievements"],
            TableType = AC_ITTYPE,
            [NORMAL_DIFF] = {
                { 1, [ATLASLOOT_IT_ALLIANCE] = 93385, 7928, [ATLASLOOT_IT_HORDE] = 93386, 7929 },
                { 2, [ATLASLOOT_IT_ALLIANCE] = 98259, 8304, [ATLASLOOT_IT_HORDE] = 98104, 8302 },
                { 3, [ATLASLOOT_IT_ALLIANCE] = 89785, 6828, [ATLASLOOT_IT_HORDE] = 81559, 6827 },
                { 4, [ATLASLOOT_IT_ALLIANCE] = 91802, 7860, [ATLASLOOT_IT_HORDE] = 91802, 7862 },
                { 5,  104246, 8398 }, -- Reins of the Kor'kron War Wolf
                { 6,  85666, 6682 }, -- Reins of the Thundering Jade Cloud Serpent
                { 7,  87773, 6932 }, -- Reins of the Heavenly Crimson Cloud Serpent
                { 8,  87769, 6927 }, -- Reins of the Crimson Cloud Serpent
                { 9,  93662, 8124 }, -- Reins of the Armored Skyscreamer
                { 10, 104208, 8454 }, -- Reins of Galakras
                { 11, 98618, 8345 }, -- Hearthsteed
            }
        },
    }
}

data["CompanionsMoP"] = {
    name = ALIL["Companions"],
    ContentType = COLLECTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.COMPANIONS,
     items = {
        {
        name = AL["Drops"],
        [NORMAL_DIFF] = {
            -- Pre-patch
            { 1, 93041 }, -- Mini Mindslayer
            { 2, 93030 }, -- Giant Bone Spider
            { 3, 93029 }, -- Stitched Pup
            { 4, 93034 }, -- Corefire Imp
            { 5, 93036 }, -- Untamed Hatchling
            { 6, 93037 }, -- Death Talon Whelpguard
            { 7, 93040 }, -- Anubisath Idol
            { 8, 93032 }, -- Fungal Abomination
            { 9, 93033 }, -- Harbinger of Flame
            { 10, 93035 }, -- Ashstone Core
            { 11, 93038 }, -- Chrominius
            { 12, 93039 }, -- Viscidus Globule
            { 13, 97548 }, -- Lil' Bad Wolf
            { 14, 97550 }, -- Netherspace Abyssal
            { 15, 97552 }, -- Tideskipper
            { 16, 97554 }, -- Coilfang Stalker
            { 17, 97556 }, -- Lesser Voidcaller
            { 18, 97549 }, -- Menagerie Custodian
            { 19, 97551 }, -- Fiendish Imp
            { 20, 97553 }, -- Tainted Waveling
            { 21, 97555 }, -- Pocket Reaver
            { 22, 97557 }, -- Phoenix Hawk Hatchling
            { 23, 89587 }, -- Porcupette
            { 24, 91040 }, -- Darkmoon Eye
            { 25, 80008 }, -- Darkmoon Rabbit
            -- Phase 1
            { 27, 85220 }, -- Terrible Turnip
            { 28, 86563 }, -- Aqua Strider
            { 29, 86564 }, -- Grinder
            { 30, 94595 }, -- Spawn of G'nathus
            { 101, 103670 }, -- Lil' Bling
            -- Phase 3
            { 103, 97959 }, -- Living Fluid
            { 104, 94125 }, -- Living Sandling
            { 105, 94574 }, -- Pygmy Direhorn
            { 106, 94152 }, -- Son of Animus
            { 107, 97960 }, -- Viscous Horror
            { 108, 94835 }, -- Ji-Kun Hatchling
            { 109, 94124 }, -- Sunreaver Micro-Sentry
            { 110, 97961 }, -- Filthling
            { 111, 94573 }, -- Direhorn Runt
            { 112, 95422 }, -- Zandalari Anklerender
            { 113, 95423 }, -- Zandalari Footslasher
            { 114, 94126 }, -- Zandalari Kneebiter
            { 115, 95424 }, -- Zandalari Toenibbler
            -- Phase 5
            { 117, 101570 }, -- Moon Moon
            { 118, 104158 }, -- Blackfuse Bombling
            { 119, 104162 }, -- Droplet of Y'Shaarj
            { 120, 104163 }, -- Gooey Sha-ling
            { 121, 104165 }, -- Kovok
            { 122, 104156 }, -- Ashleaf Spriteling
            { 123, 104157 }, -- Azure Crane Chick
            { 124, 104202 }, -- Bonkers
            { 125, 104160 }, -- Dandelion Frolicker
            { 126, 104161 }, -- Death Adder Hatchling
            { 127, 104291 }, -- Gu'chi Swarmling
            { 128, 104169 }, -- Gulp Froglet
            { 129, 104307 }, -- Jadefire Spirit
            { 130, 104164 }, -- Jademist Dancer
            { 201, 104166 }, -- Ominous Flame
            { 202, 104159 }, -- Ruby Droplet
            { 203, 104167 }, -- Skunky Alemental
            { 204, 104168 }, -- Spineclaw Crab
            }
        },
        {
        name = AL["Vendor"],
        [NORMAL_DIFF] = {
            -- Pre-patch
            { 1,  91003 }, -- Darkmoon Hatchling
            -- Phase 1
            { 3,  88148 }, -- Jade Crane Chick
            { 4,  85447 }, -- Tiny Goldfish
            { 5,  95621 }, -- Warbot
            -- Phase 2
            { 7,  93025 }, -- Clock'em
            -- Phase 4
            { 9,  97821 }, -- Gahz'rooki
            -- Phase 5
            { 11, 101771 }, -- Xu-Fu, Cub of Xuen
            { 12, 102145 }, -- Chi-Chi, Hatchling of Chi-Ji
            { 13, 102146 }, -- Zao, Calfling of Niuzao
            { 14, 102147 }, -- Yu'la, Broodling of Yu'lon
            { 15, 103637 }, -- Vengeful Porcupette
            { 16, 104295 }, -- Harmonious Porcupette
            }
        },
        {
        name = AL["World Events"],
        [NORMAL_DIFF] = {
            { 1, 46831 }, -- Macabre Marionette
            { 2, 104317 }, -- Rotten Helper Box
            }
        },
        {
        name = ALIL["Achievements"],
        TableType = AC_ITTYPE,
        [NORMAL_DIFF] = {
            { 1,  85578, "ac7500" }, -- Feral Vermling
            { 2,  89736, "ac7501" }, -- Venus
            { 3,  89686, "ac7521" }, -- Jade Tentacle
            { 4,  94191, "ac8300" }, -- Stunted Direhorn
            { 5,  93031, "ac7934" }, -- Mr. Bigglesworth
            { 6,  97558, "ac8293" }, -- Tito
            }
        },
        {
        name = ALIL["Quests"],
        TableType = AC_ITTYPE,
        [NORMAL_DIFF] = {
            -- Phase 1
            { 1,  84105 }, -- Fishy
            { 2,  85222 }, -- Red Cricket
            { 3,  90173 }, -- Pandaren Water Spirit
            { 4,  92798 }, -- Pandaren Fire Spirit
            { 5,  92799 }, -- Pandaren Air Spirit
            { 6,  92800 }, -- Pandaren Earth Spirit
            { 7,  94025 }, -- Red Panda
            -- Phase 3
            { 9, 94190 }, -- Spectral Porcupette
            { 10,  94208 }, -- Sunfur Panda
            { 11,  94209 }, -- Snowy Panda
            { 12, 94210 }, -- Mountain Panda
            }
        },
        {
        name = ALIL["Fishing"],
        [NORMAL_DIFF] = {
            -- Phase 3
            { 1, 94932 }, -- Tiny Red Carp
            { 2, 94933 }, -- Tiny Blue Carp
            { 3, 94934 }, -- Tiny Green Carp
            { 4, 94935 }, -- Tiny White Carp
            }
        },
        {
        name = AL["Crafting"],
        [NORMAL_DIFF] = {
            -- Phase 1
            { 1,  89367 }, -- Yu'lon Kite
            { 2,  89368 }, -- Chi-Ji Kite
            { 3,  82774 }, -- Jade Owl
            { 4,  82775 }, -- Sapphire Cub
            { 5,  87526 }, -- Mechanical Pandaren Dragonling
            -- Phase 2
            { 7,  90900 }, -- Imperial Moth
            { 8,  90902 }, -- Imperial Silkworm
            -- Phase 3? 5?
            { 10, 94903 }, -- Pierre
            { 11, 100905 }, -- Rascal-Bot
            }
        },
        {
        name = AL["Misc"], -- Misc
            [NORMAL_DIFF] = {
            { 1,  85871 }, -- Lucky Quilen Cub
            },
        },
        {
            name = AL["Accessories"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 92738 }, -- Safari Hat
                { 3, 47541 }, -- Argent Pony Bridle
                { 4, 38291 }, -- Ethereal Mutagen
                { 5, 35223 }, -- Papa Hummel's Old-Fashioned Pet Biscuit
                { 6, 37431 }, -- Fetch Ball
                { 7, 43626 }, -- Happy Pet Snack
                { 8, 89906 }, -- Magical Mini-Treat
                { 18, 71153 }, -- Magical Pet Biscuit
                { 19, 43352 }, -- Pet Grooming Kit
                { 20, 89139 }, -- Chain Pet Leash
                { 21, 89222 }, -- Cloud Ring
                { 22, 44820 }, -- Red Ribbon Pet Leash
                { 23, 37460 }, -- Rope Pet Leash
            }
        },
        {
            name = AL["Battle-Stones"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 92742 }, -- Polished Battle-Stone
                { 2, 92689 }, -- Polished Aquatic Battle-Stone
                { 3, 92685 }, -- Polished Beast Battle-Stone
                { 4, 92686 }, -- Polished Critter Battle-Stone
                { 5, 92693 }, -- Polished Dragonkin Battle-Stone
                { 6, 92684 }, -- Polished Elemental Battle-Stone
                { 7, 92687 }, -- Polished Flying Battle-Stone
                { 8, 92692 }, -- Polished Humanoid Battle-Stone
                { 9, 92688 }, -- Polished Magic Battle-Stone
                { 10, 92690 }, -- Polished Mechanical Battle-Stone
                { 11, 92691 }, -- Polished Undead Battle-Stone
                { 16, 92741 }, -- Flawless Battle-Stone
                { 17, 92679 }, -- Flawless Aquatic Battle-Stone
                { 18, 92675 }, -- Flawless Beast Battle-Stone
                { 19, 92676 }, -- Flawless Critter Battle-Stone
                { 20, 92683 }, -- Flawless Dragonkin Battle-Stone
                { 21, 92665 }, -- Flawless Elemental Battle-Stone
                { 22, 92677 }, -- Flawless Flying Battle-Stone
                { 23, 92682 }, -- Flawless Humanoid Battle-Stone
                { 24, 92678 }, -- Flawless Magic Battle-Stone
                { 25, 92680 }, -- Flawless Mechanical Battle-Stone
                { 26, 92681 }, -- Flawless Undead Battle-Stone
            }
        },
    }
}

data["TabardsMoP"] = {
    name = ALIL["Tabard"],
    ContentType = COLLECTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.TABARDS,
    items = {
        {
            name = AL["Factions"],
            CoinTexture = "Reputation",
            [ALLIANCE_DIFF] = {
                { 1, 89401 }, -- Anglers Tabard
                { 2, 89784 }, -- Tillers Tabard
                { 3, 89795 }, -- Lorewalkers Tabard
                { 4, 89796 }, -- Order of the Cloud Serpent Tabard
                { 5, 89797 }, -- Golden Lotus Tabard
                { 6, 89798 }, -- Klaxxi Tabard
                { 7, 89799 }, -- August Celestials Tabard
                { 8, 89800 }, -- Shado-Pan Tabard
                { 9, 97131 }, -- Shado-Pan Assault Tabard
                { 10, 83079 }, -- Tushui Tabard
                { 11, 95591 }, -- Kirin Tor Offensive Tabard
            },
            [HORDE_DIFF] = {
                GetItemsFromDiff = ALLIANCE_DIFF,
                { 10, 83080 }, -- Huojin Tabard
                { 11, 95592 }, -- Sunreaver Onslaught Tabard
            }
        },
        {
            name = AL["PvP"],
            CoinTexture = "PvP",
            [NORMAL_DIFF] = {
                { 1, 98162 }, -- Tyrannical Gladiator's Tabard
                { 2, 101697 }, -- Grievous Gladiator's Tabard
                { 3, 103636 }, -- Prideful Gladiator's Tabard
            },
        }
    }
}

data["LegendarysMoP"] = {
    name = format(LEGENDARY_QUALITY, AL["Legendaries"]),
    ContentType = COLLECTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.LEGENDARYS,
     items = {
        {
        name = AL["Legendaries"],
        [NORMAL_DIFF] = {
            { 1, 89873, "ac7533" }, -- Crystallized Dread
            { 2, 89882, "ac7533" }, -- Crystallized Horror
            { 3, 89881, "ac7533" }, -- Crystallized Terror
            { 5, 93403, AtlasLoot:GetRetByFaction("ac8008","ac7534") }, -- Eye of the Black Prince
            { 7,  95346, "ac7535" }, -- Capacitive Primal Diamond
            { 8,  95345, "ac7535" }, -- Courageous Primal Diamond
            { 9, 95344, "ac7535" }, -- Indomitable Primal Diamond
            { 10, 95347, "ac7535" }, -- Sinister Primal Diamond
            { 16,  102248, "ac8325" }, -- Fen-Yu, Fury of Xuen
            { 17,  102249, "ac8325" }, -- Gong-Lu, Strength of Xuen
            { 18,  102247, "ac8325" }, -- Jina-Kang, Kindness of Chi-Ji
            { 19,  102245, "ac8325" }, -- Qian-Le, Courage of Niuzao
            { 20,  102250, "ac8325" }, -- Qian-Ying, Fortitude of Niuzao
            { 21,  102246, "ac8325" }, -- Xing-Ho, Breath of Yu'lon
            }
        }
    }
}

data["HeirloomMoP"] = {
    name = format(BOA_QUALITY, ALIL["Heirloom"]),
    ContentType = COLLECTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.HEIRLOOM,
    items = {
        {
            name = ALIL["Armor"],
            [NORMAL_DIFF] = {
            -- Chest
                { 1,  93860 }, -- Bloodstained Dreadmist Robe
                { 2,  93863 }, -- Supple Shadowcraft Tunic
                { 3,  93865 }, -- Majestic Ironfeather Breastplate
                { 4,  93888 }, -- Furious Deathdealer Breastplate
                { 5,  93885 }, -- Awakened Vest of Elements
                { 6,  93891 }, -- Gleaming Breastplate of Valor
                { 7,  93892 }, -- Brushed Breastplate of Might
            -- Shoulder
                { 9,  93859 }, -- Bloodstained Dreadmist Mantle
                { 10, 93861 }, -- Prestigious Sunderseer Mantle
                { 11, 93862 }, -- Supple Shadowcraft Spaulders
                { 12, 93864 }, -- Majestic Ironfeather Shoulders
                { 13, 93867 }, -- Superior Stormshroud Shoulders
                { 14, 93866 }, -- Wild Feralheart Spaulders
                { 15, 93887 }, -- Grand Champion Herod's Shoulder
                { 16, 93876 }, -- Awakened Pauldrons of Elements
                { 17, 93886 }, -- Adorned Beastmaster's Mantle
                { 18, 93889 }, -- Venerated Pauldrons of The Five Thunders
                { 19, 93890 }, -- Gleaming Spaulders of Valor
                { 20, 93893 }, -- Brushed Pauldrons of Might
                { 21, 93894 }, -- Immaculate Lightforge Spaulders
            -- Off-hand
                { 23, 93902 }, -- Flamescarred Draconian Deflector
                { 24, 93903 }, -- Weathered Observer's Shield
                { 25, 93904 }, -- Musty Tome of the Lost
            -- Legs
                { 27, 62029 }, -- Tattered Dreadmist Leggings
                { 28, 62026 }, -- Stained Shadowcraft Pants
                { 29, 62027 }, -- Preened Wildfeather Leggings
                { 30, 62024 }, -- Tarnished Leggings of Destruction
                { 101, 62025 }, -- Mystical Kilt of Elements
                { 102, 62023 }, -- Polished Legplates of Valor
                { 103, 69888 }, -- Burnished Legplates of Might
            }
        },
        {
            name = ALIL["Weapon"],
            [NORMAL_DIFF] = {
                { 1, 93843 }, -- Hardened Arcanite Reaper
                { 2, 93855 }, -- War-Torn Ancient Bone Bow
                { 3, 93853 }, -- Pious Aurastone Hammer
                { 4, 93847 }, -- Crushing Mass of McGowan
                { 5, 93846 }, -- Re-Engineered Lava Dredger
                { 6, 93845 }, -- Gore-Steeped Skullforge Reaver
                { 7, 93856 }, -- Noble Dal'Rend's Sacred Charge
                { 8, 93854 }, -- Scholarly Headmaster's Charge
                { 9, 93857 }, -- Vengeful Heartseeker
                { 11, 93841 }, -- Smoothbore Dwarven Hand Cannon
                { 12, 93850 }, -- The Sanctified Hammer of Grace
                { 13, 93848 }, -- Battle-Hardened Thrash Blade
                { 14, 93851 }, -- Battle-Forged Truesilver Champion
                { 15, 93849 }, -- Elder Staff of Jordan
                { 16, 93852 }, -- Deadly Scarlet Kris
            }
        },
        {
            name = ALIL["Trinket"],
            [NORMAL_DIFF] = {
                { 1, 93896 }, -- Forceful Hand of Justice
                { 2, 93897 }, -- Piercing Eye of the Beast
                { 4, 93898 }, -- Bequeathed Insignia of the Horde
                { 5, 93899 }, -- Bequeathed Insignia of the Alliance
                { 6, 93900 }, -- Inherited Mark of Tyranny
            }
        },
        {
            name = AL["Misc"],
            [NORMAL_DIFF] = {
                { 1, 245963 }, -- Tome of Four Winds Flight
                { 3, 86558 }, -- Rolling Pin
                { 4, 86559 }, -- Frying Pan
                { 5, 86468 }, -- Apron
            }
        }
    }
}

data["LunarFestivalMoP"] = {
    name = AL["Lunar Festival"],
    ContentType = WORLD_EVENT_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.LUNAR_FESTIVAL,
    items = {
        { -- LunarFestival1
            name = AL["Lunar Festival"],
            [NORMAL_DIFF] = {
                { 1,  21100 }, -- Coin of Ancestry
                { 2,  74610 }, -- Lunar Lantern
                { 3,  74611 }, -- Festival Lantern
                { 5,  89999 }, -- Everlasting Alliance Firework
                { 6,  90000 }, -- Everlasting Horde Firework
                { 8,  21157 }, -- Festive Green Dress
                { 9,  21538 }, -- Festive Pink Dress
                { 10,  21539 }, -- Festive Purple Dress
                { 11,  21541 }, -- Festive Black Pant Suit
                { 12, 21544 }, -- Festive Blue Pant Suit
                { 13, 21543 }, -- Festive Teal Pant Suit
            },
        },
        {
            name = AL["Lunar Festival Fireworks Pack"],
            [NORMAL_DIFF] = {
                { 1,  21558 }, -- Small Blue Rocket
                { 2,  21559 }, -- Small Green Rocket
                { 3,  21557 }, -- Small Red Rocket
                { 4,  21561 }, -- Small White Rocket
                { 5,  21562 }, -- Small Yellow Rocket
                { 7,  21537 }, -- Festival Dumplings
                { 8,  21713 }, -- Elune's Candle
                { 16, 21589 }, -- Large Blue Rocket
                { 17, 21590 }, -- Large Green Rocket
                { 18, 21592 }, -- Large Red Rocket
                { 19, 21593 }, -- Large White Rocket
                { 20, 21595 }, -- Large Yellow Rocket
            }
        },
        {
            name = AL["Lucky Red Envelope"],
            [NORMAL_DIFF] = {
                { 1,  21540 }, -- Elune's Lantern
                { 2,  21536 }, -- Elune Stone
                { 16, 21744 }, -- Lucky Rocket Cluster
                { 17, 21745 }, -- Elder's Moonstone
            }
        },
        { -- LunarFestival2
            name = AL["Plans"],
            [NORMAL_DIFF] = {
                { 1,  21722 }, -- Pattern: Festival Dress
                { 3,  21738 }, -- Schematic: Firework Launcher
                { 5,  21724 }, -- Schematic: Small Blue Rocket
                { 6,  21725 }, -- Schematic: Small Green Rocket
                { 7,  21726 }, -- Schematic: Small Red Rocket
                { 9,  21727 }, -- Schematic: Large Blue Rocket
                { 10, 21728 }, -- Schematic: Large Green Rocket
                { 11, 21729 }, -- Schematic: Large Red Rocket
                { 16, 21723 }, -- Pattern: Festive Red Pant Suit
                { 18, 21737 }, -- Schematic: Cluster Launcher
                { 20, 21730 }, -- Schematic: Blue Rocket Cluster
                { 21, 21731 }, -- Schematic: Green Rocket Cluster
                { 22, 21732 }, -- Schematic: Red Rocket Cluster
                { 24, 21733 }, -- Schematic: Large Blue Rocket Cluster
                { 25, 21734 }, -- Schematic: Large Green Rocket Cluster
                { 26, 21735 }, -- Schematic: Large Red Rocket Cluster
            },
        },
    },
}

data["ValentinesdayMoP"] = {
    name = AL["Love is in the Air"],
    ContentType = WORLD_EVENT_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.VALENTINES_DAY,
    items = {
        { -- Valentineday
        name = AL["Love is in the Air"],
        [NORMAL_DIFF] = {
            { 1, 22206 }, -- Bouquet of Red Roses
            { 3, "INV_ValentinesBoxOfChocolates02", nil, AL["Gift of Adoration"] },
            { 4, 22279 }, -- Lovely Black Dress
            { 5,  72146 }, -- Swift Lovebird
            { 6,  22235 }, -- Truesilver Shafted Arrow
            { 7,  22200 }, -- Silver Shafted Arrow
            { 8,  34480 }, -- Romantic Picnic Basket
            { 9,  22261 }, -- Love Fool
            { 10, 22218 }, -- Handful of Rose Petals
            { 11, 21813 }, -- Bag of Candies
            { 13, "INV_Box_02", nil, AL["Box of Chocolates"] },
            { 14, 22237 }, -- Dark Desire
            { 15, 22238 }, -- Very Berry Cream
            { 16, 22236 }, -- Buttermilk Delight
            { 17, 22239 }, -- Sweet Surprise
            { 18, 22276 }, -- Lovely Red Dress
            { 19, 22278 }, -- Lovely Blue Dress
            { 20, 22280 }, -- Lovely Purple Dress
            { 21, 22277 }, -- Red Dinner Suit
            { 22, 22281 }, -- Blue Dinner Suit
            { 23, 22282 }  -- Purple Dinner Suit
            }
        },
        { -- SFKApothecaryH
        name = C_Map_GetAreaInfo(209) .. " - " .. AL["Apothecary Hummel"],
        [NORMAL_DIFF] = {
            { 1,  93391 }, -- Heartbreak Charm
            { 2,  93392 }, -- Winking Eye of Love
            { 3,  93393 }, -- Sweet Perfume Broach
            { 4,  93394 }, -- Choker of the Pure Heart
            { 5,  93395 }, -- Shard of Pirouetting Happiness
            { 7,  49641 }, -- Faded Lovely Greeting Card
            { 8,  49715 }, -- Forever-Lovely Rose
            { 9,  50250 }, -- X-45 Heartbreaker
            { 10, 50446 }, -- Toxic Wasteling
            { 11, 50471 }, -- The Heartbreaker
            { 12, 50741 }  -- Vile Fumigator's Mask
            }
        }
    }
}

data["MidsummerFestivalMoP"] = {
    name = AL["Midsummer Festival"],
    ContentType = WORLD_EVENT_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.MIDSUMMER_FESTIVAL,
    items = {
        {
        name = AL["Midsummer Festival"],
        [NORMAL_DIFF] = {
            { 1,  23083 }, -- Captured Flame
            { 2,  34686 }, -- Brazier of Dancing Flames
            { 4,  23324 }, -- Mantle of the Fire Festival
            { 5,  23323 }, -- Crown of the Fire Festival
            { 6,  34683 }, -- Sandals of Summer
            { 7,  34685 }, -- Vestment of Summer
            { 9,  23247 }, -- Burning Blossom
            { 10, 34599 }, -- Juggling Torch
            { 11, 34684 }, -- Handful of Summer Petals
            { 12, 23246 }, -- Fiery Festival Brew
            { 16, 23215 }, -- Bag of Smorc Ingredients
            { 17, 23211 }, -- Toasted Smorc
            { 18, 23435 }, -- Elderberry Pie
            { 19, 23327 }, -- Fire-toasted Bun
            { 20, 23326 } -- Midsummer Sausage
            }
        },
        {
        name = C_Map_GetAreaInfo(3717) .. " - " .. AL["Ahune"],
        [NORMAL_DIFF] = {
                { 1, 54536 }, -- Satchel of Chilled Goods
                { 2, 95426 }, -- Frostscythe of Lord Ahune
                { 4, 95425 }, -- Cloak of the Frigid Winds
                { 5, 95427 }, -- Icebound Cloak
                { 6, 95428 }, -- Shroud of Winter's Chill
                { 7, 95429 }, -- The Frost Lord's Battle Shroud
                { 8, 95430 }, -- The Frost Lord's War Cloak
                { 10, 35723 }, -- Shards of Ahune
                { 16, 35498 }, -- Formula: Enchant Weapon - Deathfrost
                { 18, 53641 }, -- Ice Chip
                { 20, 35557 }, -- Huge Snowball
            }
        }
    }
}

data["BrewfestMoP"] = {
    name = AL["Brewfest"],
    ContentType = WORLD_EVENT_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.BREWFEST,
    items = {
        {
        name = AL["Brewfest"],
          [NORMAL_DIFF] = {
                {1, 37829}, -- Brewfest Prize Token
                {3, 33968}, -- Blue Brewfest Hat
                {4, 33864}, -- Brown Brewfest Hat
                {5, 33967}, -- Green Brewfest Hat
                {6, 33969}, -- Purple Brewfest Hat
                {7, 33863}, -- Brewfest Dress
                {8, 33862}, -- Brewfest Regalia
                {9, 33966}, -- Brewfest Slippers
                {10, 33868}, -- Brewfest Boots
                {12, 33047}, -- Belbi's Eyesight Enhancing Romance Goggles (Alliance)
                {13, 34008}, -- Blix's Eyesight Enhancing Romance Goggles (Horde)
                {15, 33927}, -- Brewfest Pony Keg
                {16, 90427}, -- Pandaren Brewpack
                {18, 32233}, -- Wolpertinger's Tankard
                {20, 37599}, -- "Brew of the Month" Club Membership Form
                {22, 37750}, -- Fresh Brewfest Hops
                {24, 39477}, -- Fresh Dwarven Brewfest Hops
                {24, 39476}, -- Fresh Goblin Brewfest Hops
                {25, 37816} -- Preserved Brewfest Hops
            }
        },
        {
            name = AL["Food"],
            [NORMAL_DIFF] = {
                {1, 33043}, -- The Essential Brewfest Pretzel
                {3, 34017}, -- Small Step Brew
                {4, 34018}, -- long Stride Brew
                {5, 34019}, -- Path of Brew
                {6, 34020}, -- Jungle River Water
                {7, 34021}, -- Brewdoo Magic
                {8, 34022}, -- Stout Shrunken Head
                {9, 33034}, -- Gordok Grog
                {10, 33035}, -- Ogre Mead
                {11, 33036} -- Mudder's Milk
            }
        },
        {
            name = C_Map_GetAreaInfo(1584) .. " - " .. AL["Coren Direbrew"],
            [NORMAL_DIFF] = {
                { 1,  257873 }, -- Bitterest Balebrew Charm
                { 2,  257877 }, -- Bubbliest Brightbrew Charm
                { 3,  257880 }, -- Coren's Cold Chromium Coaster
                { 4,  257884 }, -- Mithril Wristwatch
                { 5,  257881 }, -- Thousand-Year Pickled Egg
                { 6,  257885 }, -- Brawler's Statue
                { 8,  257863 }, -- Direbrew's Bloodied Shanker
                { 9,  257865 }, -- Tremendous Tankard O' Terror
                {16, 33977}, -- Swift Brewfest Ram
                {17, 37828}, -- Great Brewfest Kodo
                {19, 37863}, -- Direbrew's Remote
                {21, 38280} -- Direbrew's Dire Brew
            }
        }
    }
}

data["HalloweenMoP"] = {
    name = AL["Hallow's End"],
    ContentType = WORLD_EVENT_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.HALLOWEEN,
    items = {
        { -- Halloween1
        name = AL["Hallow's End"] .. " - " .. AL["Misc"],
        [NORMAL_DIFF] = { { 1, 20400 }, -- Pumpkin Bag
            { 3,  70722 }, -- Little Wickerman
            { 4,  70908 }, -- Feline Familiar
            { 5,  71076 }, -- Creepy Crate
            { 16, 33226 }, -- Tricky Treat
            }
        },
        { -- Halloween1
        name = AL["Hallow's End"] .. " - " .. AL["Wands"],
        [NORMAL_DIFF] = { { 1, 20410 }, -- Hallowed Wand - Bat
            { 2, 20409 }, -- Hallowed Wand - Ghost
            { 3, 20399 }, -- Hallowed Wand - Leper Gnome
            { 4, 20398 }, -- Hallowed Wand - Ninja
            { 5, 20397 }, -- Hallowed Wand - Pirate
            { 6, 20413 }, -- Hallowed Wand - Random
            { 7, 20411 }, -- Hallowed Wand - Skeleton
            { 8, 20414 } -- Hallowed Wand - Wisp
            }
        },
        { -- Halloween3
        name = AL["Hallow's End"] .. " - " .. AL["Masks"],
        [NORMAL_DIFF] = { { 1, 20561 }, -- Flimsy Male Dwarf Mask
            { 2,  20391 }, -- Flimsy Male Gnome Mask
            { 3,  20566 }, -- Flimsy Male Human Mask
            { 4,  20564 }, -- Flimsy Male Nightelf Mask
            { 5,  20570 }, -- Flimsy Male Orc Mask
            { 6,  20572 }, -- Flimsy Male Tauren Mask
            { 7,  20568 }, -- Flimsy Male Troll Mask
            { 8,  20573 }, -- Flimsy Male Undead Mask
            { 9,  49216 }, -- Worgen Male Mask
            { 10, 49210 }, -- Goblin Male Mask
            { 12, 69188 }, -- Murloc Male Mask
            { 13, 69190 }, -- Naga Male Mask
            { 14, 69193 }, -- Ogre Male Mask
            { 15, 69195 }, -- Vrykul Male Mask
            { 16, 20562 }, -- Flimsy Female Dwarf Mask
            { 17, 20392 }, -- Flimsy Female Gnome Mask
            { 18, 20565 }, -- Flimsy Female Human Mask
            { 19, 20563 }, -- Flimsy Female Nightelf Mask
            { 20, 20569 }, -- Flimsy Female Orc Mask
            { 21, 20571 }, -- Flimsy Female Tauren Mask
            { 22, 20567 }, -- Flimsy Female Troll Mask
            { 23, 20574 }, -- Flimsy Female Undead Mask
            { 24, 49215 }, -- Worgen Female Mask
            { 25, 49212 }, -- Goblin Female Mask
            { 27, 69187 }, -- Murloc Female Mask
            { 28, 69189 }, -- Naga Female Mask
            { 29, 69192 }, -- Ogre Female Mask
            { 30, 69194 }, -- Vrykul Female Mask
            }
        },
        { -- SMHeadlessHorseman
        name = C_Map_GetAreaInfo(796) .. " - " .. AL["Headless Horseman"],
        [NORMAL_DIFF] = {
                { 1, 263010 }, -- Seal of Ghoulish Glee
                { 2, 263011 }, -- The Horseman's Ring
                { 3, 263012 }, -- Wicked Witch's Signet
                { 4, 263013 }, -- Band of the Petrified Pumpkin
                { 5, 263014 }, -- The Horseman's Horrific Hood
                { 6, 263018 }, -- The Horseman's Sinister Slicer
                { 8, 33292 }, -- Hallowed Helm
                { 10, 34068 }, -- Weighted Jack-o'-Lantern
                { 12, 33277 }, -- Tome of Thomas Thomson
                { 16, 37012 }, -- The Horseman's Reins
                { 18, 37011 }, -- Magic Broom
                { 20, 33154 }, -- Sinister Squashling
            }
        }
    }
}

data["DayoftheDeadMoP"] = {
    name = AL["Day of the Dead"],
    ContentType = WORLD_EVENT_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.DAY_OF_THE_DEAD,
    items = {
        { -- DayoftheDead
        name = AL["Day of the Dead"],
            [NORMAL_DIFF] = {
                {1, 46831}, -- Macabre Marionette
                {3, 46710}, -- Recipe: Bread of the Dead
                {5, 46690}, -- Candy Skull
                {6, 46711}, -- Spirit Candle
                {7, 46718}, -- Orange Marigold
                {8, 46860}, -- Whimsical Skull Mask
                {9, 46861} -- Bouquet of Orange Marigolds
            }
        }
    }
}

data["WinterVeilMoP"] = {
    name = AL["Feast of Winter Veil"],
    ContentType = WORLD_EVENT_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.WINTER_VEIL,
    items = {
        { -- Winterviel1
            name = AL["Misc"],
            [NORMAL_DIFF] = {
                { 1, 21525 }, -- Green Winter Hat
                { 2, 21524 }, -- Red Winter Hat
                { 3, 17712 }, -- Winter Veil Disguise Kit
                { 4, 17202 }, -- Snowball
                { 5, 21212 }, -- Fresh Holly
                { 6, 21519 }, -- Mistletoe
            },
        },
        {
            name = AL["Carefully Wrapped Present"],
            [NORMAL_DIFF] = {
                { 1, 21254 }, -- Winter Veil Cookie
            },
        },
        {
            name = AL["Gaily Wrapped Present"],
            [NORMAL_DIFF] = {
                { 1, 21301 }, -- Green Helper Box
                { 2, 21308 }, -- Jingling Bell
                { 3, 21305 }, -- Red Helper Box
                { 4, 21309 }, -- Snowman Kit
            },
        },
        {
            name = AL["Festive Gift"],
            [NORMAL_DIFF] = {
                { 1, 21328 }, -- Wand of Holiday Cheer
            },
        },
        {
            name = AL["Gently Shaken Gift"],
            [NORMAL_DIFF] = {
                { 1, 21235 }, -- Winter Veil Roast
                { 2, 21241 }, -- Winter Veil Eggnog
            },
        },
        {
            name = AL["Ticking Present"],
            [NORMAL_DIFF] = {
                { 1, 17706 }, -- Plans: Edge of Winter
                { 2, 17725 }, -- Formula: Enchant Weapon - Winter's Might
                { 3, 17720 }, -- Schematic: Snowmaster 9000
                { 4, 17722 }, -- Pattern: Gloves of the Greatfather
                { 5, 17709 }, -- Recipe: Elixir of Frost Power
                { 6, 17724 }, -- Pattern: Green Holiday Shirt
                { 16, 21325 }, -- Mechanical Greench
                { 17, 21213 }, -- Preserved Holly
            },
        },
        {
            name = AL["Winter Veil Gift"],
            [NORMAL_DIFF] = {
                { 1, 104318 }, -- Crashin' Thrashin' Flyer Controller
            },
        },
        {
            name = AL["Smokywood Pastures"],
            [NORMAL_DIFF] = {
                { 1,  17201 }, -- Recipe: Egg Nog
                { 2,  17200 }, -- Recipe: Gingerbread Cookie
                { 3,  34413 }, -- Recipe: Hot Apple Cider
                { 4,  34261 }, -- Pattern: Green Winter Clothes
                { 5,  34262 }, -- Pattern: Winter Boots
                { 6,  17344 }, -- Candy Cane
                { 7,  17406 }, -- Holiday Cheesewheel
                { 8,  17407 }, -- Graccu's Homemade Meat Pie
                { 9,  17408 }, -- Spicy Beefstick
                { 10, 21215 }, -- Graccu's Mince Meat Fruitcake
                { 11, 34410 }, -- Honeyed Holiday Ham
                { 12, 17404 }, -- Blended Bean Brew
                { 13, 17405 }, -- Green Garden Tea
                { 14, 34412 }, -- Sparkling Apple Cider
                { 15, 17196 }, -- Holiday Spirits
                { 16, 17403 }, -- Steamwheedle Fizzy Spirits
                { 17, 17402 }, -- Greatfather's Winter Ale
                { 18, 17194 }, -- Holiday Spices
                { 19, 17303 }, -- Blue Ribboned Wrapping Paper
                { 20, 17304 }, -- Green Ribboned Wrapping Paper
                { 21, 17307 }, -- Purple Ribboned Wrapping Paper
                { 22, 70923 }, -- Gaudy Winter Veil Sweater
            },
        },
        {
            name = AL["Smokywood Pastures Special Gift"],
            [NORMAL_DIFF] = {
                { 1, 17706 }, -- Plans: Edge of Winter
                { 2, 17725 }, -- Formula: Enchant Weapon - Winter's Might
                { 3, 17720 }, -- Schematic: Snowmaster 9000
                { 4, 17722 }, -- Pattern: Gloves of the Greatfather
                { 5, 17709 }, -- Recipe: Elixir of Frost Power
                { 6, 17724 }, -- Pattern: Green Holiday Shirt
            },
        },
        {
            name = AL["Stolen Present"],
            [NORMAL_DIFF] = {
                { 1,  268556 }, -- Miniature Winter Veil Tree
                { 3,  104317 }, -- Rotten Helper Box
                { 4,  34425 }, -- Clockwork Rocket Bot
                { 5,  54436 }, -- Blue Clockwork Rocket Bot
                { 6,  73797 }, -- Lump of Coal
                { 8,  46709 }, -- MiniZep Controller
                { 9,  44606 }, -- Toy Train Set
                { 10,  90883 }, -- The Pigskin
                { 11,  90888 }, -- Foot Ball
                { 12,  37710 }, -- Crashin' Thrashin' Racer Controller
                { 13, 54437 }, -- Tiny Green Ragdoll
                { 14, 54438 }, -- Tiny Blue Ragdoll
                { 16,  46725 }, -- Red Rider Air Rifle
                { 17, 70923 }, -- Gaudy Winter Veil Sweater
                { 18, 34498 }, -- Paper Zeppelin Kit
                { 19, 44599 }, -- Zippy Copper Racer
                { 20, 44601 }, -- Heavy Copper Racer
                { 21, 44481 }, -- Grindgear Toy Gorilla
                { 22, 44482 }, -- Trusty Copper Racer
            },
        },
    },
}
