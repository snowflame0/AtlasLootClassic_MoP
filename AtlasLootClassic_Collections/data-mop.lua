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

data["AugustStoneFragmentsMoP"] = {
    name = format(AL["'%s' Vendor"], format(EPIC_QUALITY, C_CurrencyInfo.GetCurrencyInfo(3350)["name"])),
    ContentType = VENDOR_CONTENT,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    items = {{
        name = ALIL["Armor"] .. " - " .. ALIL["Cloth"],
        [VENDOR_DIFF] = {
            { 1, 86788 }, -- Hood of Blind Eyes
            { 2, 86828 }, -- Twisting Wind Bracers
            { 3, 89982 }, -- Shoulderpads of Twisted Fate
            { 4, 86888 }, -- Sandals of the Blackest Night
            { 5, 86884 }, -- Belt of Embodied Terror
            { 6, 86758 }, -- Imperial Ghostbinder's Robes
            { 7, 86839 }, -- Xaril's Hood of Intoxicating Vapors
            { 8, 86809 }, -- Hood of Focused Energy
            { 9, 86787 }, -- Undying Shadow Grips
            { 10, 86770 }, -- Shadowsummoner Spaulders
            { 11, 89966 }, -- Claws of Amethyst
            { 12, 86747 }, -- Jade Dust Leggings
            { 13, 86908 }, -- Dreadwoven Leggings of Failure
            { 14, 86765 }, -- Sandals of the Severed Soul
            { 15, 89984 }, -- Robes of Pinioned Eyes
            { 16, 89959 }, -- Shoulders of Foaming Fluids
            { 17, 89953 }, -- Scent-Soaked Sandals
            { 18, 89973 }, -- Galaxyfire Girdle
            { 19, 86815 }, -- Attenuating Bracers
            { 20, 86798 }, -- Orbital Belt
            { 21, 86895 }, -- Healer's Belt of Final Winter
            { 22, 86892 }, -- Robes of the Unknown Fear
            { 23, 86819 }, -- Gloves of Grasping Claws
            { 24, 86897 }, -- Sorcerer's Belt of Final Winter
            { 25, 86896 }, -- Invoker's Belt of Final Winter
            { 26, 86867 }, -- Leggings of Shadow Infestation
            { 27, 86825 }, -- Boots of the Blowing Wind
            { 28, 86911 }, -- Robes of Torn Nightmares
            { 29, 86836 }, -- Sandals of the Unbidden
            { 30, 86875 }, -- Cuffs of the Corrupted Waters
            { 101, 86857 }, -- Belt of Malleable Amber
            { 102, 89965 }, -- Ruby-Linked Girdle
            { 103, 86844 }, -- Gleaming Moth Cuffs
            { 104, 86841 }, -- Shining Cicada Bracers
            { 105, 86850 }, -- Darting Damselfly Cuffs
        }
    },
    {
        name = ALIL["Armor"] .. " - " .. ALIL["Leather"],
        [VENDOR_DIFF] = {
            { 1, 86898 }, -- Weaver's Cord of Eternal Autumn
            { 2, 86743 }, -- Stoneflesh Leggings
            { 3, 86786 }, -- Bracers of Dark Thoughts
            { 4, 86763 }, -- Netherrealm Shoulderpads
            { 5, 86878 }, -- Asani's Uncleansed Sandals
            { 6, 86821 }, -- Bracers of Unseen Strikes
            { 7, 86834 }, -- Bonebreaker Gauntlets
            { 8, 86811 }, -- Boots of the Still Breath
            { 9, 86808 }, -- Magnetized Leggings
            { 10, 86797 }, -- Phasewalker Striders
            { 11, 86899 }, -- Stalker's Cord of Eternal Autumn
            { 12, 86768 }, -- Spaulders of the Divided Mind
            { 13, 86750 }, -- Tomb Raider's Girdle
            { 14, 86746 }, -- Stonebound Cinch
            { 15, 86838 }, -- Robes of Eighty Lights
            { 16, 86804 }, -- Crown of Opportunistic Strikes
            { 17, 89985 }, -- Wrap of Instant Petrification
            { 18, 89961 }, -- Shadow Heart Spaulders
            { 19, 89957 }, -- Hood of Stilled Winds
            { 20, 86859 }, -- Treads of Deadly Secretions
            { 21, 86912 }, -- Clutches of Dying Hope
            { 22, 86757 }, -- Hood of Cursed Dreams
            { 23, 86795 }, -- Chestguard of Total Annihilation
            { 24, 89970 }, -- Bracers of Violent Meditation
            { 25, 89980 }, -- Gauntlets of the Shadow's Caress
            { 26, 89978 }, -- Legguards of Failing Purification
            { 27, 86817 }, -- Gauntlets of Undesired Gifts
            { 28, 89983 }, -- Fear-Blackened Leggings
            { 29, 86843 }, -- Smooth Beetle Wristbands
            { 30, 86845 }, -- Pearlescent Butterfly Wristbands
        }
    },
    {
        name = ALIL["Armor"] .. " - " .. ALIL["Mail"],
        [VENDOR_DIFF] = {
            { 1, 86745 }, -- Sixteen-Fanged Crown
            { 2, 86900 }, -- Binder's Chain of Unending Summer
            { 3, 86877 }, -- Lightning Prisoner's Boots
            { 4, 86866 }, -- Crown of the Doomed Empress
            { 5, 86818 }, -- Mail of Screaming Secrets
            { 6, 86882 }, -- Sunwrought Mail Hauberk
            { 7, 86826 }, -- Bracers of Tempestuous Fury
            { 8, 86740 }, -- Stonemaw Armguards
            { 9, 86861 }, -- Monstrous Stompers
            { 10, 86901 }, -- Ranger's Chain of Unending Summer
            { 11, 86855 }, -- Wingslasher Pauldrons
            { 12, 89986 }, -- Shadowgrip Girdle
            { 13, 86784 }, -- Meng's Treads of Insanity
            { 14, 86769 }, -- Leggings of Imprisoned Will
            { 15, 86800 }, -- Shoulders of Empyreal Focus
            { 16, 86842 }, -- Luminescent Firefly Wristguards
            { 17, 86781 }, -- Subetai's Pillaging Leggings
            { 18, 86749 }, -- Wildfire Worldwalkers
            { 19, 87826 }, -- Grips of Terra Cotta
            { 20, 89979 }, -- Waterborne Shoulderguards
            { 21, 89955 }, -- Sword Dancer's Leggings
            { 22, 87823 }, -- Zor'lok's Fizzing Chestguard
            { 23, 86833 }, -- Grips of the Leviathan
            { 24, 89977 }, -- Enameled Grips of Solemnity
            { 25, 89964 }, -- Stonefang Chestguard
            { 26, 86847 }, -- Jagged Hornet Bracers
            { 27, 86761 }, -- Fetters of Death
            { 28, 89975 }, -- Dreadeye Gaze
            { 29, 89962 }, -- Hood of Dark Dreams
            { 30, 90739 }, -- Kaz'tik's Stormseizer Gauntlets
            { 101, 89960 }, -- Vestments of Steaming Ichor
            { 102, 86755 }, -- Chain of Shadow
        }
    },
    {
        name = ALIL["Armor"] .. " - " .. ALIL["Plate"],
        [VENDOR_DIFF] = {
            { 1, 86852 }, -- Impaling Treads
            { 2, 86904 }, -- Patroller's Girdle of Endless Spring
            { 3, 86902 }, -- Mender's Girdle of Endless Spring
            { 4, 86742 }, -- Jasper Clawfeet
            { 5, 86751 }, -- Bracers of Six Oxen
            { 6, 86868 }, -- Bracers of Defiled Earth
            { 7, 86756 }, -- Legplates of Sagacious Shadows
            { 8, 89974 }, -- Crown of Keening Stars
            { 9, 89969 }, -- Bonded Soul Bracers
            { 10, 89954 }, -- Warbelt of Sealed Pods
            { 11, 86822 }, -- Waistplate of Overwhelming Assault
            { 12, 86860 }, -- Shoulderpads of Misshapen Life
            { 13, 86854 }, -- Articulated Legplates
            { 14, 86903 }, -- Protector's Girdle of Endless Spring
            { 15, 86803 }, -- Jang-xi's Devastating Legplates
            { 16, 86876 }, -- Casque of Expelled Corruption
            { 17, 86870 }, -- Deepwater Greatboots
            { 18, 86832 }, -- Garalon's Hollow Skull
            { 19, 86807 }, -- Spaulders of the Emperor's Rage
            { 20, 86779 }, -- Breastplate of the Kings' Guard
            { 21, 86752 }, -- Nullification Greathelm
            { 22, 86744 }, -- Heavenly Jade Greatboots
            { 23, 86766 }, -- Bindings of Ancient Spirits
            { 24, 89981 }, -- Grasps of Serpentine Might
            { 25, 89976 }, -- Chestguard of Eternal Vigilance
            { 26, 86785 }, -- Girdle of Delirious Visions
            { 27, 86780 }, -- Shoulderguards of the Unflanked
            { 28, 86760 }, -- Sollerets of Spirit Splitting
            { 29, 89958 }, -- Garalon's Graven Carapace
            { 30, 86837 }, -- Grasps of Panic
            { 101, 86794 }, -- Starcrusher Gauntlets
            { 102, 86793 }, -- Star-Stealer Waistguard
            { 103, 89963 }, -- Legplates of Regal Reinforcement
            { 104, 89956 }, -- Pauldrons of the Broken Blade
            { 105, 86887 }, -- Sollerets of Instability
            { 106, 86823 }, -- Windblade Talons
            { 107, 86816 }, -- Chestplate of the Forbidden Tower
            { 108, 86846 }, -- Inlaid Cricket Bracers
            { 109, 86891 }, -- Cuirass of the Animated Protector
            { 110, 86849 }, -- Plated Locust Bracers
            { 111, 86848 }, -- Serrated Wasp Bracers
        }
    },
    {
        name = AL["Cloak"],
        [VENDOR_DIFF] = {
            { 1, 86753 }, -- Cloak of Peacock Feathers
            { 2, 89971 }, -- Mindshard Drape
            { 3, 86812 }, -- Hisek's Chrysanthemum Cape
            { 4, 86827 }, -- Drape of Gathering Clouds
            { 5, 86874 }, -- Cloak of Overwhelming Corruption
            { 6, 86748 }, -- Cape of Three Lanterns
            { 7, 86883 }, -- Daybreak Drape
            { 8, 86840 }, -- Stormwake Mistcloak
            { 9, 86831 }, -- Legbreaker Greatcloak
            { 10, 86782 }, -- Arrow Breaking Windcloak
            { 11, 86853 }, -- Cloak of Raining Blades
        }
    },
    {
        name = ALIL["Weapon"],
        [VENDOR_DIFF] = {
            { 1, 86909 }, -- Regail's Crackling Dagger
            { 2, 86910 }, -- Spiritsever
            { 3, 86862 }, -- Un'sok's Amber Scalpel
            { 4, 86741 }, -- Dagger of the Seven Stars
            { 5, 86864 }, -- Claws of Shek'zeer
            { 6, 86762 }, -- "Gara'kal, Fist of the Spiritbinder"
            { 7, 86789 }, -- "Elegion, the Fanged Crescent"
            { 8, 86865 }, -- "Kri'tak, Imperial Scepter of the Swarm"
            { 9, 86806 }, -- "Tihan, Scepter of the Sleeping Emperor"
            { 10, 86886 }, -- "Loshan, Terror Incarnate"
            { 11, 86863 }, -- Scimitar of Seven Stars
            { 12, 86906 }, -- "Kilrak, Jaws of Terror"
            { 13, 86777 }, -- "Screaming Tiger, Qiang's Unbreakable Polearm"
            { 14, 86893 }, -- "Jin'ya, Orb of the Waterspeaker"
            { 15, 86879 }, -- "Gao-Rei, Staff of the Legendary Protector"
            { 16, 86889 }, -- "Taoren, the Soul Burner"
            { 17, 86801 }, -- "Fang Kung, Spark of Titans"
            { 18, 86796 }, -- Torch of the Celestial Spark
            { 19, 86905 }, -- "Shin'ka, Execution of Dominion"
            { 20, 86799 }, -- Starshatter
        }
    },
    {
        name = ALIL["Off Hand"] .. "/" .. ALIL["Shield"],
        [VENDOR_DIFF] = {
            { 1, 89426 }, -- Fan of Fiery Winds
            { 2, 86829 }, -- Tornado-Summoning Censer
        }
    },
    {
        name = ALIL["Neck"],
        [VENDOR_DIFF] = {
            { 1, 86754 }, -- Amulet of Seven Curses
            { 2, 86824 }, -- Choker of the Unleashed Storm
            { 3, 86810 }, -- Worldwaker Cabochon
            { 4, 86856 }, -- Korven's Amber-Sealed Beetle
            { 5, 86776 }, -- Amulet of the Hidden Kings
            { 6, 89952 }, -- Pheromone-Coated Choker
            { 16, 86739 }, -- Beads of the Mogu'shi
            { 17, 86759 }, -- Soulgrasp Choker
            { 18, 86872 }, -- Kaolan's Withering Necklace
            { 19, 86783 }, -- Zian's Choker of Coalesced Shadow
            { 20, 86835 }, -- Necklace of Congealed Weaknesses
            { 21, 86871 }, -- Shackle of Eversparks
        }
    },
    {
        name = ALIL["Finger"],
        [VENDOR_DIFF] = {
            { 1, 86814 }, -- Fragment of Fear Made Flesh
            { 2, 89967 }, -- Feng's Seal of Binding
            { 3, 86869 }, -- Regail's Band of the Endless
            { 4, 86851 }, -- Painful Thorned Ring
            { 5, 86873 }, -- Watersoul Signet
            { 6, 86858 }, -- Seal of the Profane
            { 7, 89968 }, -- Feng's Ring of Dreams
            { 8, 86820 }, -- Ring of the Bladed Tempest
            { 9, 86830 }, -- Ring of the Shattered Shell
            { 10, 86880 }, -- Dread Shadow Ring
            { 11, 86767 }, -- Circuit of the Frail Soul
            { 12, 86813 }, -- Vizier's Ruby Signet
            { 13, 89972 }, -- Band of Bursting Novas
        }
    },
    {
        name = ALIL["Trinket"],
        [VENDOR_DIFF] = {
            { 1, 86792 }, -- Light of the Cosmos
            { 2, 86907 }, -- Essence of Terror
            { 3, 86890 }, -- Terror in the Mists
            { 4, 86791 }, -- Bottle of Infinite Stars
            { 5, 86885 }, -- Spirits of the Sun
            { 6, 86802 }, -- Lei Shen's Final Orders
            { 7, 86881 }, -- Stuff of Nightmares
            { 8, 86894 }, -- Darkmist Vortex
            { 9, 86790 }, -- Vial of Dragon's Blood
            { 10, 86805 }, -- Qin-xi's Polarizing Seal
            { 11, 86772 }, -- Jade Bandit Figurine
            { 12, 86775 }, -- Jade Warlord Figurine
            { 13, 86774 }, -- Jade Courtesan Figurine
            { 14, 86771 }, -- Jade Charioteer Figurine
            { 15, 86773 }, -- Jade Magistrate Figurine
        }
    },
    {
        name = AL["Token"],
        [VENDOR_DIFF] = {
            { 1, 89274 }, -- Helm of the Shadowy Conqueror
            { 2, 89275 }, -- Helm of the Shadowy Protector
            { 3, 89273 }, -- Helm of the Shadowy Vanquisher
            { 5, 89277 }, -- Shoulders of the Shadowy Conqueror
            { 6, 89278 }, -- Shoulders of the Shadowy Protector
            { 7, 89276 }, -- Shoulders of the Shadowy Vanquisher
            { 9, 89265 }, -- Chest of the Shadowy Conqueror
            { 10, 89266 }, -- Chest of the Shadowy Protector
            { 11, 89264 }, -- Chest of the Shadowy Vanquisher
            { 16, 89271 }, -- Gauntlets of the Shadowy Conqueror
            { 17, 89272 }, -- Gauntlets of the Shadowy Protector
            { 18, 89270 }, -- Gauntlets of the Shadowy Vanquisher
            { 20, 89268 }, -- Leggings of the Shadowy Conqueror
            { 21, 89269 }, -- Leggings of the Shadowy Protector
            { 22, 89267 }, -- Leggings of the Shadowy Vanquisher
        }
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
            { 1,  93040 }, -- Anubisath Idol
            { 2,  86563 }, -- Aqua Strider
            { 3, 104156 }, -- Ashleaf Spriteling
            { 4,  93035 }, -- Ashstone Core
            { 5, 104157 }, -- Azure Crane Chick
            { 6, 104158 }, -- Blackfuse Bombling
            { 7, 104202 }, -- Bonkers
            { 8,  93038 }, -- Chrominius
            { 9,  97554 }, -- Coilfang Stalker
            { 10, 93034 }, -- Corefire Imp
            { 11, 104160 }, -- Dandelion Frolicker
            { 12, 91040 }, -- Darkmoon Eye
            { 13, 80008 }, -- Darkmoon Rabbit
            { 14, 104161 }, -- Death Adder Hatchling
            { 15, 93037 }, -- Death Talon Whelpguard
            { 16, 94573 }, -- Direhorn Runt
            { 17, 104162 }, -- Droplet of Y'Shaarj
            { 18, 97551 }, -- Fiendish Imp
            { 19, 97961 }, -- Filthling
            { 20, 93032 }, -- Fungal Abomination
            { 21, 93030 }, -- Giant Bone Spider
            { 22, 104163 }, -- Gooey Sha-ling
            { 23, 86564 }, -- Grinder
            { 24, 104291 }, -- Gu'chi Swarmling
            { 25, 104169 }, -- Gulp Froglet
            { 26, 93033 }, -- Harbinger of Flame
            { 27, 104307 }, -- Jadefire Spirit
            { 28, 104164 }, -- Jademist Dancer
            { 29, 94835 }, -- Ji-Kun Hatchling
            { 30, 104165 }, -- Kovok
            { 101, 97556 }, -- Lesser Voidcaller
            { 102, 97548 }, -- Lil' Bad Wolf
            { 103, 103670 }, -- Lil' Bling
            { 104, 97959 }, -- Living Fluid
            { 105, 94125 }, -- Living Sandling
            { 106, 97549 }, -- Menagerie Custodian
            { 107, 93041 }, -- Mini Mindslayer
            { 108, 101570 }, -- Moon Moon
            { 109, 97550 }, -- Netherspace Abyssal
            { 110, 104166 }, -- Ominous Flame
            { 111, 97557 }, -- Phoenix Hawk Hatchling
            { 112, 97555 }, -- Pocket Reaver
            { 113, 89587 }, -- Porcupette
            { 114, 94574 }, -- Pygmy Direhorn
            { 115, 104159 }, -- Ruby Droplet
            { 116, 104167 }, -- Skunky Alemental
            { 117, 94152 }, -- Son of Animus
            { 118, 94595 }, -- Spawn of G'nathus
            { 119, 104168 }, -- Spineclaw Crab
            { 120, 93029 }, -- Stitched Pup
            { 121, 94124 }, -- Sunreaver Micro-Sentry
            { 122, 97553 }, -- Tainted Waveling
            { 123, 85220 }, -- Terrible Turnip
            { 124, 97552 }, -- Tideskipper
            { 125, 93036 }, -- Untamed Hatchling
            { 126, 93039 }, -- Viscidus Globule
            { 127, 97960 }, -- Viscous Horror
            { 128, 95422 }, -- Zandalari Anklerender
            { 129, 95423 }, -- Zandalari Footslasher
            { 130, 94126 }, -- Zandalari Kneebiter
            { 201, 95424 }, -- Zandalari Toenibbler
            }
        },
        {
        name = AL["Vendor"],
        [NORMAL_DIFF] = {
            { 1,  102145 }, -- Chi-Chi, Hatchling of Chi-Ji
            { 2,  93025 }, -- Clock'em
            { 3,  91003 }, -- Darkmoon Hatchling
            { 4,  97821 }, -- Gahz'rooki
            { 5,  104295 }, -- Harmonious Porcupette
            { 6,  88148 }, -- Jade Crane Chick
            { 7,  85447 }, -- Tiny Goldfish
            { 8,  103637 }, -- Vengeful Porcupette
            { 9,  101771 }, -- Xu-Fu, Cub of Xuen
            { 10, 102147 }, -- Yu'la, Broodling of Yu'lon
            { 11, 102146 }, -- Zao, Calfling of Niuzao
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
            { 2,  89686, "ac7521" }, -- Jade Tentacle
            { 3,  93031, "ac7934" }, -- Mr. Bigglesworth
            { 4,  94191, "ac8300" }, -- Stunted Direhorn
            { 5,  97558, "ac8293" }, -- Tito
            { 16, 89736, "ac7501" }, -- Venus
            }
        },
        {
        name = ALIL["Quests"],
        TableType = AC_ITTYPE,
        [NORMAL_DIFF] = {
            { 1,  84105 }, -- Fishy
            { 2,  94210 }, -- Mountain Panda
            { 3,  92799 }, -- Pandaren Air Spirit
            { 4,  92800 }, -- Pandaren Earth Spirit
            { 5,  92798 }, -- Pandaren Fire Spirit
            { 6,  90173 }, -- Pandaren Water Spirit
            { 7,  85222 }, -- Red Cricket
            { 8,  94025 }, -- Red Panda
            { 9,  94209 }, -- Snowy Panda
            { 10, 94190 }, -- Spectral Porcupette
            { 11, 94208 }, -- Sunfur Panda
            }
        },
        {
        name = ALIL["Fishing"],
        [NORMAL_DIFF] = {
            { 1, 94933 }, -- Tiny Blue Carp
            { 2, 94934 }, -- Tiny Green Carp
            { 3, 94932 }, -- Tiny Red Carp
            { 4, 94935 }, -- Tiny White Carp
            }
        },
        {
        name = AL["Crafting"],
        [NORMAL_DIFF] = {
            { 1,  89368 }, -- Chi-Ji Kite
            { 2,  90900 }, -- Imperial Moth
            { 3,  90902 }, -- Imperial Silkworm
            { 4,  82774 }, -- Jade Owl
            { 5,  87526 }, -- Mechanical Pandaren Dragonling
            { 6,  94903 }, -- Pierre
            { 7, 100905 }, -- Rascal-Bot
            { 8,  82775 }, -- Sapphire Cub
            { 9,  89367 }, -- Yu'lon Kite
            }
        },
        {
        name = AL["Misc"], -- Misc
            [NORMAL_DIFF] = {
            { 1,  85871 }, -- Lucky Quilen Cub
            },
        }
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
            { 1, 102245 }, -- Qian-Le, Courage of Niuzao
            { 2, 102246 }, -- Xing-Ho, Breath of Yu'lon
            { 3, 102247 }, -- Jina-Kang, Kindness of Chi-Ji
            { 4, 102248 }, -- Fen-Yu, Fury of Xuen
            { 5, 102249 }, -- Gong-Lu, Strength of Xuen
            { 6, 102250 }, -- Qian-Ying, Fortitude of Niuzao
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
                { 1,  87576 }, -- Bitterest Balebrew Charm
                { 2,  87575 }, -- Bubbliest Brightbrew Charm
                { 3,  87574 }, -- Coren's Cold Chromium Coaster
                { 4,  87572 }, -- Mithril Wristwatch
                { 5,  87573 }, -- Thousand-Year Pickled Egg
                { 6,  87571 }, -- Brawler's Statue
                { 8,  107217 }, -- Direbrew's Bloodied Shanker
                { 9,  107218 }, -- Tremendous Tankard O' Terror
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
                { 1, 88168 }, -- Seal of Ghoulish Glee
                { 2, 88169 }, -- The Horseman's Ring
                { 3, 88166 }, -- Wicked Witch's Signet
                { 4, 88167 }, -- Band of the Petrified Pumpkin
                { 5, 87569 }, -- The Horseman's Horrific Hood
                { 6, 87570 }, -- The Horseman's Sinister Slicer
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
            name = AL["Smokywood Pastures Special Gift"],
            [NORMAL_DIFF] = {
                { 1,  17706 }, -- Plans: Edge of Winter
                { 2,  17725 }, -- Formula: Enchant Weapon - Winter's Might
                { 3,  17720 }, -- Schematic: Snowmaster 9000
                { 4,  17722 }, -- Pattern: Gloves of the Greatfather
                { 5,  17709 }, -- Recipe: Elixir of Frost Power
                { 6,  17724 }, -- Pattern: Green Holiday Shirt
                { 16, 21325 }, -- Mechanical Greench
                { 17, 21213 }, -- Preserved Holly
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
                { 10, 34410 }, -- Honeyed Holiday Ham
                { 11, 17404 }, -- Blended Bean Brew
                { 12, 17405 }, -- Green Garden Tea
                { 13, 34412 }, -- Sparkling Apple Cider
                { 14, 17196 }, -- Holiday Spirits
                { 15, 17403 }, -- Steamwheedle Fizzy Spirits
                { 16, 17402 }, -- Greatfather's Winter Ale
                { 17, 17194 }, -- Holiday Spices
                { 18, 17303 }, -- Blue Ribboned Wrapping Paper
                { 19, 17304 }, -- Green Ribboned Wrapping Paper
                { 20, 17307 }, -- Purple Ribboned Wrapping Paper
            },
        },
        {
            name = AL["Stolen Present"],
            [NORMAL_DIFF] = {
                { 1,  93625 }, -- Miniature Winter Veil Tree
                { 3,  104317 }, -- Rotten Helper Box
                { 4,  34425 }, -- Clockwork Rocket Bot
                { 5,  54436 }, -- Blue Clockwork Rocket Bot
                { 6,  73797 }, -- Lump of Coal
                { 8,  104318 }, -- Crashin' Thrashin' Flyer Controller
                { 9,  46709 }, -- MiniZep Controller
                { 10,  44606 }, -- Toy Train Set
                { 11,  90883 }, -- The Pigskin
                { 12,  90888 }, -- Foot Ball
                { 13,  37710 }, -- Crashin' Thrashin' Racer Controller
                { 14, 54437 }, -- Tiny Green Ragdoll
                { 15, 54438 }, -- Tiny Blue Ragdoll
                { 17,  46725 }, -- Red Rider Air Rifle
                { 18, 34498 }, -- Paper Zeppelin Kit
                { 19, 44599 }, -- Zippy Copper Racer
                { 20, 44601 }, -- Heavy Copper Racer
                { 21, 44481 }, -- Grindgear Toy Gorilla
                { 22, 44482 }, -- Trusty Copper Racer
            },
        },
    },
}
