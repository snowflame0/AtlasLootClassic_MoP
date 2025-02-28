local ALName, ALPrivate = ...

local AtlasLoot = _G.AtlasLoot
local Token = {}
AtlasLoot.Data.Token = Token
local AL = AtlasLoot.Locales

local type, pairs = type, pairs
local format = format

local TOKE_NUMBER_RANGE = 900000

local TOKEN_FORMAT_STRING = "|cff00ff00"..AL["L-Click"]..":|r %s"
local TOKEN_TYPE_DEFAULT = 1
local TOKEN_TYPE_TEXT = {
    [0]  = nil,	-- empty
    [1]  = format(TOKEN_FORMAT_STRING, AL["Show additional items."]), -- default
    [2]  = format(TOKEN_FORMAT_STRING, AL["Show possible items."]),
    [3]  = format(TOKEN_FORMAT_STRING, AL["Show quest rewards."]),
    [4]  = format(TOKEN_FORMAT_STRING, AL["Quest objective."]),
    [5]  = format(TOKEN_FORMAT_STRING, AL["Reagent for..."]),
    [6]  = format(TOKEN_FORMAT_STRING, AL["Token for..."]),
    [7]  = format(TOKEN_FORMAT_STRING, AL["Bought with..."]),
    [8]  = format(TOKEN_FORMAT_STRING, AL["Token for..."]), -- same as '6' but with itemDesc added
    [9]  = format(TOKEN_FORMAT_STRING, AL["Show loot."]),
    [10] = format(TOKEN_FORMAT_STRING, AL["Show Achievements."]),
    [11] = format(TOKEN_FORMAT_STRING, AL["Contains."]),
    -- classes get set with the init
    -- "DRUID", "HUNTER", "MAGE", "PALADIN", "PRIEST", "ROGUE", "SHAMAN", "WARLOCK", "WARRIOR", "DEATHKNIGHT"
}

local TOKEN_TYPE_ADD_ITEM_DESCRIPTION = {
    [7] = true,
    [8] = true,
    [9] = true,
}

local ICONS = ALPrivate.CLASS_ICON_PATH_ITEM_DB

local TOKEN, TOKEN_DATA = AtlasLoot:GetGameVersionDataTable()

TOKEN_DATA.CLASSIC = {
    -- [itemID] = { itemID or {itemID, count} }
    -- optional: type=0 		-	select the desc from the TOKEN_TYPE_TEXT table
    -- optional: itemID == 0 	-	creates a new line
    -- Dire Maul books
    [18401] = { 18348 },	-- Foror's Compendium of Dragon Slaying
    [18362] = { 18469, type = "PRIEST" },	-- Holy Bologna: What the Light Won't Tell You
    [18358] = { 18468, type = "MAGE" },		-- The Arcanist's Cookbook
    [18360] = { 18467, type = "WARLOCK" },	-- Harnessing Shadows
    [18356] = { 18465, type = "ROGUE" },	-- Garona: A Study on Stealth and Treachery
    [18364] = { 18470, type = "DRUID" },	-- The Emerald Dream
    [18361] = { 18473, type = "HUNTER" },	-- The Greatest Race of Hunters
    [18363] = { 18471, type = "SHAMAN" },	-- Frost Shock and You
    [18359] = { 18472, type = "PALADIN" },	-- The Light and How to Swing It
    [18357] = { 18466, type = "WARRIOR" },	-- Codex of Defense
    [18333] = { 18330, 0, 18333, 18335, {14344, 4}, {12753, 2}, type = 4 },	-- Libram of Focus
    [11733] = { 11642, 0, 11733, 11754, 8411, {11952, 4}, type = 4 },		-- Libram of Constitution
    [18334] = { 18331, 0, 18334, 18335, {14344, 2}, 12735, type = 4  },		-- Libram of Protection
    [18332] = { 18329, 0, 18332, 18335, {14344, 2}, {12938, 2}, type = 4 },	-- Libram of Rapidity
    [11736] = { 11644, 0, 11736, 11754, 11751, {11567, 4}, type = 4 },		-- Libram of Resilience
    [11732] = { 11622, 0, 11732, 11754, 11752, 8424, type = 4 },			-- Libram of Rumination
    [11734] = { 11643, 0, 11734, 11754, 11753, {11564, 4}, type = 4 },		-- Libram of Tenacity
    [11737] = { 11647, 11648, 11649, 11645, 11646, 0, 11737, 11754, {11951, 4}, {11563, 4}, type = 4 },	-- Libram of Voracity

    --- Darkmoon cards
    -- Portals / Darkmoon Card: Twisting Nether
    [19277] = { 19277, 19290, 0, 19276, 19278, 19279, 19280, 19281, 19282, 19283, 19284 },	-- Portals Deck
    [19276] = 19277,	-- Ace of Portals
    [19278] = 19277,	-- Two of Portals
    [19279] = 19277,	-- Three of Portals
    [19280] = 19277,	-- Four of Portals
    [19281] = 19277,	-- Five of Portals
    [19282] = 19277,	-- Six of Portals
    [19283] = 19277,	-- Seven of Portals
    [19284] = 19277,	-- Eight of Portals

    -- Elementals / Darkmoon Card: Maelstrom
    [19267] = { 19267, 19289, 0, 19268, 19269, 19270, 19271, 19272, 19273, 19274, 19275 },	-- Elementals Deck
    [19268] = 19267,	-- Ace of Elementals
    [19269] = 19267,	-- Two of Elementals
    [19270] = 19267,	-- Three of Elementals
    [19271] = 19267,	-- Four of Elementals
    [19272] = 19267,	-- Five of Elementals
    [19273] = 19267,	-- Six of Elementals
    [19274] = 19267,	-- Seven of Elementals
    [19275] = 19267,	-- Eight of Elementals

    -- Warlords / Darkmoon Card: Heroism
    [19257] = { 19257, 19287, 0, 19258, 19259, 19260, 19261, 19262, 19263, 19264, 19265 },	-- Warlords Deck
    [19258] = 19257,	-- Ace of Warlords
    [19259] = 19257,	-- Two of Warlords
    [19260] = 19257,	-- Three of Warlords
    [19261] = 19257,	-- Four of Warlords
    [19262] = 19257,	-- Five of Warlords
    [19263] = 19257,	-- Six of Warlords
    [19264] = 19257,	-- Seven of Warlords
    [19265] = 19257,	-- Eight of Warlords

    -- Beasts / Darkmoon Card: Blue Dragon
    [19228] = { 19228, 19288, 0, 19227, 19230, 19231, 19232, 19233, 19234, 19235, 19236 },	-- Beasts Deck
    [19227] = 19228,	-- Ace of Beasts
    [19230] = 19228,	-- Two of Beasts
    [19231] = 19228,	-- Three of Beasts
    [19232] = 19228,	-- Four of Beasts
    [19233] = 19228,	-- Five of Beasts
    [19234] = 19228,	-- Six of Beasts
    [19235] = 19228,	-- Seven of Beasts
    [19236] = 19228,	-- Eight of Beasts

    -- Zul'Gurub
    [19724] = { ICONS.HUNTER, 19831, 0, ICONS.ROGUE, 19834, 0, ICONS.PRIEST, 19841, type = 6 },		-- Primal Hakkari Aegis
    [19717] = { ICONS.WARRIOR, 19824, 0, ICONS.ROGUE, 19836, 0, ICONS.SHAMAN, 19830, type = 6 },	-- Primal Hakkari Armsplint
    [19716] = { ICONS.PALADIN, 19827, 0, ICONS.HUNTER, 19833, 0, ICONS.MAGE, 19846, type = 6 },		-- Primal Hakkari Bindings
    [19719] = { ICONS.WARRIOR, 19823, 0, ICONS.ROGUE, 19835, 0, ICONS.SHAMAN, 19829, type = 6 },	-- Primal Hakkari Girdle
    [19723] = { ICONS.WARRIOR, 19822, 0, ICONS.MAGE, 20034, 0, ICONS.WARLOCK, 20033, type = 6 },	-- Primal Hakkari Kossack
    [19720] = { ICONS.PRIEST, 19842, 0, ICONS.WARLOCK, 19849, 0, ICONS.DRUID, 19839, type = 6 },	-- Primal Hakkari Sash
    [19721] = { ICONS.PALADIN, 19826, 0, ICONS.HUNTER, 19832, 0, ICONS.MAGE, 19845, type = 6 },		-- Primal Hakkari Shawl
    [19718] = { ICONS.PRIEST, 19843, 0, ICONS.WARLOCK, 19848, 0, ICONS.DRUID, 19840, type = 6 },	-- Primal Hakkari Stanchion
    [19722] = { ICONS.PALADIN, 19825, 0, ICONS.SHAMAN, 19828, 0, ICONS.DRUID, 19838, type = 6 },	-- Primal Hakkari Tabard

    -- AQ40
    [21237] = { 21268, 21273, 21275, type = 6 },			-- Imperial Qiraji Regalia
    [21232] = { 21242, 21244, 21272, 21269, type = 6 },	-- Imperial Qiraji Armaments
    [20928] = { ICONS.WARRIOR, 21330, 21333, 0, ICONS.HUNTER, 21367, 21365, 0, ICONS.ROGUE, 21361, 21359, 0, ICONS.PRIEST, 21350, 21349, type = 6  }, -- Qiraji Bindings of Command
    [20932] = { ICONS.PALADIN, 21391, 21388, 0, ICONS.SHAMAN, 21376, 21373, 0, ICONS.MAGE, 21345, 21344, 0, ICONS.WARLOCK, 21335, 21338, 0, ICONS.DRUID, 21354, 21355, type = 6 }, -- Qiraji Bindings of Dominance
    [20930] = { ICONS.PALADIN, 21387, 0, ICONS.HUNTER, 21366, 0, ICONS.ROGUE, 21360, 0, ICONS.SHAMAN, 21372, 0, ICONS.DRUID, 21353, type = 6 }, -- Vek'lor's Diadem
    [20926] = { ICONS.WARRIOR, 21329, 0, ICONS.PRIEST, 21348, 0, ICONS.MAGE, 21347, 0, ICONS.WARLOCK, 21337, type = 6 }, -- Vek'nilash's Circlet
    [20927] = { ICONS.WARRIOR, 21332, 0, ICONS.ROGUE, 21362, 0, ICONS.PRIEST, 21352, 0, ICONS.MAGE, 21346, type = 6 }, -- Ouro's Intact Hide
    [20931] = { ICONS.PALADIN, 21390, 0, ICONS.HUNTER, 21368, 0, ICONS.SHAMAN, 21375, 0, ICONS.WARLOCK, 21336, 0, ICONS.DRUID, 21356, type = 6 }, -- Skin of the Great Sandworm
    [20929] = { ICONS.WARRIOR, 21331, 0, ICONS.PALADIN, 21389, 0, ICONS.HUNTER, 21370, 0, ICONS.ROGUE, 21364, 0, ICONS.SHAMAN, 21374, type = 6 }, -- Carapace of the Old God
    [20933] = { ICONS.PRIEST, 21351, 0, ICONS.MAGE, 21343, 0, ICONS.WARLOCK, 21334, 0, ICONS.DRUID, 21357, type = 6 }, -- Husk of the Old God

    -- AQ20
    [20888] = { ICONS.HUNTER, 21402, 0, ICONS.ROGUE, 21405, 0, ICONS.PRIEST, 21411, 0, ICONS.WARLOCK, 21417, type = 6 },							-- Qiraji Ceremonial Ring
    [20884] = { ICONS.WARRIOR, 21393, 0, ICONS.PALADIN, 21396, 0, ICONS.SHAMAN, 21399, 0, ICONS.MAGE, 21414, 0, ICONS.DRUID, 21408, type = 6 },		-- Qiraji Magisterial Ring
    [20885] = { ICONS.WARRIOR, 21394, 0, ICONS.ROGUE, 21406, 0, ICONS.PRIEST, 21412, 0, ICONS.MAGE, 21415, type = 6 },								-- Qiraji Martial Drape
    [20889] = { ICONS.PALADIN, 21397, 0, ICONS.HUNTER, 21403, 0, ICONS.SHAMAN, 21400, 0, ICONS.WARLOCK, 21418, 0, ICONS.DRUID, 21409, type = 6 },	-- Qiraji Regal Drape
    [20890] = { ICONS.PRIEST, 21410, 0, ICONS.MAGE, 21413, 0, ICONS.WARLOCK, 21416, 0, ICONS.DRUID, 21407, type = 6 },								-- Qiraji Ornate Hilt
    [20886] = { ICONS.WARRIOR, 21392, 0, ICONS.PALADIN, 21395, 0, ICONS.HUNTER, 21401, 0, ICONS.ROGUE, 21404, 0, ICONS.SHAMAN, 21398, type = 6  },	-- Qiraji Spiked Hilt

    -- Tier 3
    [22360] = { ICONS.PALADIN, 22428, 0, ICONS.HUNTER, 22438, 0, ICONS.SHAMAN, 22466, 0, ICONS.DRUID, 22490, type = 6 }, -- Desecrated Headpiece
    [22361] = { ICONS.PALADIN, 22429, 0, ICONS.HUNTER, 22439, 0, ICONS.SHAMAN, 22467, 0, ICONS.DRUID, 22491, type = 6 }, -- Desecrated Spaulders
    [22350] = { ICONS.PALADIN, 22425, 0, ICONS.HUNTER, 22436, 0, ICONS.SHAMAN, 22464, 0, ICONS.DRUID, 22488, type = 6 }, -- Desecrated Tunic
    [22362] = { ICONS.PALADIN, 22424, 0, ICONS.HUNTER, 22443, 0, ICONS.SHAMAN, 22471, 0, ICONS.DRUID, 22495, type = 6 }, -- Desecrated Wristguards
    [22364] = { ICONS.PALADIN, 22426, 0, ICONS.HUNTER, 22441, 0, ICONS.SHAMAN, 22469, 0, ICONS.DRUID, 22493, type = 6 }, -- Desecrated Handguards
    [22363] = { ICONS.PALADIN, 22431, 0, ICONS.HUNTER, 22442, 0, ICONS.SHAMAN, 22470, 0, ICONS.DRUID, 22494, type = 6 }, -- Desecrated Girdle
    [22359] = { ICONS.PALADIN, 22427, 0, ICONS.HUNTER, 22437, 0, ICONS.SHAMAN, 22465, 0, ICONS.DRUID, 22489, type = 6 }, -- Desecrated Legguards
    [22365] = { ICONS.PALADIN, 22430, 0, ICONS.HUNTER, 22440, 0, ICONS.SHAMAN, 22468, 0, ICONS.DRUID, 22492, type = 6 }, -- Desecrated Boots
    [22367] = { ICONS.PRIEST, 22514, 0, ICONS.MAGE ,22498, 0, ICONS.WARLOCK, 22506, type = 6 },	-- Desecrated Circlet
    [22368] = { ICONS.PRIEST, 22515, 0, ICONS.MAGE ,22499, 0, ICONS.WARLOCK, 22507, type = 6 },	-- Desecrated Shoulderpads
    [22351] = { ICONS.PRIEST, 22512, 0, ICONS.MAGE ,22496, 0, ICONS.WARLOCK, 22504, type = 6 }, -- Desecrated Robe
    [22369] = { ICONS.PRIEST, 22519, 0, ICONS.MAGE ,22503, 0, ICONS.WARLOCK, 22511, type = 6 }, -- Desecrated Bindings
    [22371] = { ICONS.PRIEST, 22517, 0, ICONS.MAGE ,22501, 0, ICONS.WARLOCK, 22509, type = 6 },	-- Desecrated Gloves
    [22370] = { ICONS.PRIEST, 22518, 0, ICONS.MAGE ,22502, 0, ICONS.WARLOCK, 22510, type = 6 },	-- Desecrated Belt
    [22366] = { ICONS.PRIEST, 22513, 0, ICONS.MAGE ,22497, 0, ICONS.WARLOCK, 22505, type = 6 }, -- Desecrated Leggings
    [22372] = { ICONS.PRIEST, 22516, 0, ICONS.MAGE ,22500, 0, ICONS.WARLOCK, 22508, type = 6 }, -- Desecrated Sandals
    [22353] = { ICONS.WARRIOR, 22418, 0, ICONS.ROGUE, 22478, type = 6 }, -- Desecrated Helmet
    [22354] = { ICONS.WARRIOR, 22419, 0, ICONS.ROGUE, 22479, type = 6 }, -- Desecrated Pauldrons
    [22349] = { ICONS.WARRIOR, 22416, 0, ICONS.ROGUE, 22476, type = 6 }, -- Desecrated Breastplate
    [22355] = { ICONS.WARRIOR, 22423, 0, ICONS.ROGUE, 22483, type = 6 }, -- Desecrated Bracers
    [22357] = { ICONS.WARRIOR, 22421, 0, ICONS.ROGUE, 22481, type = 6 }, -- Desecrated Gauntlets
    [22356] = { ICONS.WARRIOR, 22422, 0, ICONS.ROGUE, 22482, type = 6 }, -- Desecrated Waistguard
    [22352] = { ICONS.WARRIOR, 22417, 0, ICONS.ROGUE, 22477, type = 6 }, -- Desecrated Legplates
    [22358] = { ICONS.WARRIOR, 22420, 0, ICONS.ROGUE, 22480, type = 6 }, -- Desecrated Sabatons

    -- Gem Sacks
    [17962] = { 12361, 7971, 13926, {1529, "1-2"}, {7909, "1-3"}, {7910, "1-3"}, {3864, "1-3"}, type = 2 },		-- Blue Sack of Gems
    [17963] = { 12364, 7971, {1529, "1-3"}, {7909, "1-3"}, {7910, "1-3"}, {3864, "1-3"}, type = 2 },			-- Green Sack of Gems
    [17964] = { 12800, 7971, {1529, "1-3"}, {7909, "1-3"}, {7910, "1-3"}, {3864, "1-3"}, type = 2 },			-- Gray Sack of Gems
    [17965] = { 12363, 7971, {1529, "1-3"}, {7909, "1-3"}, {7910, "1-3"}, {3864, "1-3"}, type = 2 },			-- Yellow Sack of Gems
    [17969] = { 12799, 7971, 13926, {1529, "1-3"}, {7909, "1-3"}, {7910, "1-3"}, {3864, "1-3"}, type = 2 },		-- Red Sack of Gems
    [11938] = {
        17962, 12361, 7971, 13926, {1529, "1-2"}, {7909, "1-3"}, {7910, "1-3"}, {3864, "1-3"}, 0,
        17963, 12364, 7971, {1529, "1-3"}, {7909, "1-3"}, {7910, "1-3"}, {3864, "1-3"}, 0,
        17964, 12800, 7971, {1529, "1-3"}, {7909, "1-3"}, {7910, "1-3"}, {3864, "1-3"}, 0,
        17965, 12363, 7971, {1529, "1-3"}, {7909, "1-3"}, {7910, "1-3"}, {3864, "1-3"}, 0,
        17969, 12799, 7971, 13926, {1529, "1-3"}, {7909, "1-3"}, {7910, "1-3"}, {3864, "1-3"},
        type = 2,
    },

    -- Misc Bags
    [21156] = { 20858, 20859, 20860, 20861, 20862, 20863, 20864, 20865, type = 2 },						-- Scarab Bag
    [12033] = { 7910, 1529, 7909, 12361, 1705, 12799, 7971, 5500, 12800, 1206, 12364, type = 2 },		-- Thaurissan Family Jewels

    -- Misc
    [11086] = { 9372, 0, 9379, 11086 }, -- Jang'thraze the Protector
    [9379] =  11086, -- Sang'thraze the Deflector
    [18784] = { 12725, 0, 18783, 18784 }, -- Top Half of Advanced Armorsmithing: Volume III
    [18783] = 18784, -- Bottom Half of Advanced Armorsmithing: Volume III
    [18780] = { 12727, 0, 18779, 18780 }, -- Top Half of Advanced Armorsmithing: Volume I
    [18779] = 18780, -- Bottom Half of Advanced Armorsmithing: Volume I
    [12731] = { 12752, 12757, 12756 }, -- Pristine Hide of the Beast
    [18782] = { 12726, 0, 18781, 18782 }, -- Top Half of Advanced Armorsmithing: Volume II
    [18781] = { 12726, 0, 18781, 18782 }, -- Bottom Half of Advanced Armorsmithing: Volume II
    [21813] = { 21816, 21817, 21818, 21819, 21820, 21821, 21822, 21823, type = 2}, -- Bag of Candies
    [19697] = { {19696, 4} }, -- Bounty of the Harvest
    [18564] = { 19019, 0, 18563, 18564, 19017 }, -- Bindings of the Windseeker <right>
    [18563] = 18564, -- Bindings of the Windseeker <left>
    [19017] = 18564, -- Essence of the Firelord
    [17204] = { 17182 }, -- Eye of Sulfuras
    [18703] = { 18714, 18713, 18715 }, -- Ancient Petrified Leaf
    [18646] = { 18665, 18646, 0, 18608, 18609 }, -- The Eye of Divinity
    [18665] = 18646, -- The Eye of Shadow
    [17074] = { 17074, 17223 }, -- Shadowstrike
    [17223] = 17074, -- Thunderstrike
    [18608] = { 18608, 18609 }, -- Benediction
    [18609] = 18608, -- Anathema
    [7733] = { 7733, 0, 7740, 7741 }, -- Staff of Prehistoria
    [7740] = 7733, -- Gni'kiv Medallion
    [7741] = 7733, -- The Shaft of Tsol
    [12845] = { 17044, 17045, type = 4 }, -- Medallion of Faith
    [17771] = { 17771, 0, 18562, {12360,10}, 17010, {18567,3} }, -- Elementium Bar

    -- Quests
    [10441] = { 10657, 10658, type = 3 }, -- Glowing Shard
    [6283] = { 6335, 4534, type = 3 }, -- The Book of Ur
    [16782] = { 16886, 16887, type = 3 }, -- Strange Water Globe
    [9326] = { 9588, type = 3 }, -- Grime-Encrusted Ring
    [17008] = { 17043, 17042, 17039, type = 3 }, -- Small Scroll
    [10454] = { 10455, type = 3 }, -- Essence of Eranikus
    [12780] = { 13966, 13968, 13965, type = 3 }, -- General Drakkisath's Command
    [7666] = { 7673, type = 3 }, -- Shattered Necklace
    [19003] = { 19383, 19384, 19366, type = 3 }, -- Head of Nefarian
    [18423] = { 18404, 18403, 18406, type = 3 }, -- Head of Onyxia
    [20644] = { 20600, type = 3 }, -- Shrouded in Nightmare

    -- Quest objective
    [18705] = { 18713, type = 4 }, -- Mature Black Dragon Sinew
    [18704] = { 18714, type = 4 }, -- Mature Blue Dragon Sinew
    [12871] = { 12895, 0, 12903, 12945, type = 4 }, -- Chromatic Carapace
    [18706] = { {18706, 12}, 0, 19024, type = 4 }, -- Arena Master

    [22523] = { 22523, 22524, 0,
    22689, 22690, 22681, 22680, 22688, 22679, 0,
    22667, 22668, 22657, 22659, 22678, 22656, type = 4 }, -- Insignia of the Dawn
    [22524] = 22523, -- Insignia of the Crusade

    -- Naxxramas
    [22520] = { 23207, 23206, type = 3 }, -- The Phylactery of Kel'Thuzad

    -- AQ40
    [21221] = { 21712, 21710, 21709, type = 3 }, -- Amulet of the Fallen God
    [21762] = { 21156, 20876, 20879, 20875, 20878, 20881, 20877, 20874, 20882 }, -- Greater Scarab Coffer Key

    -- AQ20
    [21220] = { 21504, 21507, 21505, 21506, type = 3 }, -- Head of Ossirian the Unscarred

    -- ZG
    [19802] = { 19950, 19949, 19948, type = 3 }, -- Heart of Hakkar
    [19939] = { 19939, 19940, 19941, 19942, 0,
    ICONS.WARLOCK, ICONS.PRIEST, ICONS.MAGE, ICONS.ROGUE, ICONS.DRUID, ICONS.HUNTER, ICONS.SHAMAN, ICONS.WARRIOR, ICONS.PALADIN, 0,
    19819, 19820, 19818, 19814, 19821, 19816, 19817, 19813, 19815, 0,
    19957, 19958, 19959, 19954, 19955, 19953, 19956, 19951, 19952 }, -- Gri'lek's Blood
    [19940] = 19939, -- Renataki's Tooth
    [19941] = 19939, -- Wushoolay's Mane
    [19942] = 19939, -- Hazza'rah's Dream Thread
    -- ZG / Punctured Voodoo Doll
    [19820] = 19939, [19818] = 19939, [19819] = 19939, [19814] = 19939, [19821] = 19939, [19816] = 19939, [19817] = 19939, [19815] = 19939, [19813] = 19939,

    -- Reagent for...
    [12811] = { "prof20034", "prof22750", "prof25079", 0, "prof18456", "prof16990", "prof23632", "prof23633", type = 5 }, -- Righteous Orb
    [20381] = { "prof24703", type = 5 }, -- Dreamscale Breastplate
    [12753] = { "prof22928", "prof27830", type = 5 }, -- Dreamscale Breastplate
    [17203] = { "prof21161", type = 5 }, -- Sulfuron Ingot
    [15410] = { "prof19106", "prof19093", type = 5 }, -- Scale of Onyxia

    -- Atiesh
    [22727] = { { 22726, 40 }, 22727, 22734, 22733, 0, 22631, 22589, 22630, 22632 }, -- Frame of Atiesh
    [22726] = 22727, -- Splinter of Atiesh
    [22734] = 22727, -- Base of Atiesh
    [22733] = 22727, -- Staff Head of Atiesh
    [22737] = 22727, -- Atiesh / Use item

    -- UBRS key
    [12219] = { 12219, 12336, 12335, 12337, 0, 12344 }, -- Unadorned Seal of Ascension
    [12336] = 12219, -- Gemstone of Spirestone
    [12335] = 12219, -- Gemstone of Smolderthorn
    [12337] = 12219, -- Gemstone of Bloodaxe

    --- Cenarion Circle Dailies
    -- Exalted
    [21188] = { "f609rep8", 0, {20802, 15}, {20800, 20}, {20801, 20}, 21508 }, -- Fist of Cenarius
    [21180] = 21188, -- Earthstrike
    [21190] = 21188, -- Wrath of Cenarius
    -- Revered
    [21184] = { "f609rep7", 0, {20802, 15}, {20800, 20}, {20801, 17}, 21515 }, -- Deeprock Bracers
    [21186] = 21184, -- Rockfury Bracers
    [21185] = 21184, -- Earthcalm Orb
    [21189] = 21184, -- Might of Cenarius
    -- Honored
    [21181] = { "f609rep6", 0, {20802, 7}, {20800, 4}, {20801, 4} }, -- Grace of Earth
    [21183] = 21181, -- Earthpower Vest
    [21182] = 21181, -- Band of Earthen Might
    -- Friendly
    [21178] = { "f609rep5", 0, {20802, 5}, {20800, 3}, {20801, 7} }, -- Gloves of Earthen Power
    [21187] = 21178, -- Earthweave Cloak
    [21179] = 21178, -- Band of Earthen Wrath
}

if AtlasLoot:GameVersion_GE(AtlasLoot.BC_VERSION_NUM) then
    TOKEN_DATA.BCC = {
        --- T4
        -- Head
        [29760] = { ICONS.PALADIN, 29061, 29068, 29073, 0, ICONS.ROGUE, 29044, 0, ICONS.SHAMAN, 29028, 29035, 29040, type = 6 }, -- Helm of the Fallen Champion
        [29761] = { ICONS.WARRIOR, 29011, 29021, 0, ICONS.PRIEST, 29049, 29058, 0, ICONS.DRUID, 29086, 29093, 29098, type = 6 }, -- Helm of the Fallen Defender
        [29759] = { ICONS.HUNTER, 29081, 0, ICONS.MAGE, 29076, 0, ICONS.WARLOCK, 28963, type = 6 }, -- Helm of the Fallen Hero
        -- Shoulder
        [29763] = { ICONS.PALADIN, 29064, 29070, 29075, 0, ICONS.ROGUE, 29047, 0, ICONS.SHAMAN, 29037, 29031, 29043, type = 6 }, -- Pauldrons of the Fallen Champion
        [29764] = { ICONS.WARRIOR, 29016, 29023, 0, ICONS.PRIEST, 29054, 29060, 0, ICONS.DRUID, 29100, 29095, 29089, type = 6 }, -- Pauldrons of the Fallen Defender
        [29762] = { ICONS.HUNTER, 29084, 0, ICONS.MAGE, 29079, 0, ICONS.WARLOCK, 28967, type = 6 }, -- Pauldrons of the Fallen Hero
        -- Chest
        [29754] = { ICONS.PALADIN, 29071, 29066, 29062, 0, ICONS.ROGUE, 29045, 0, ICONS.SHAMAN, 29038, 29033, 29029, type = 6 }, -- Chestguard of the Fallen Champion
        [29753] = { ICONS.WARRIOR, 29012, 29019, 0, ICONS.PRIEST, 29050, 29056, 0, ICONS.DRUID, 29087, 29091, 29096, type = 6 }, -- Chestguard of the Fallen Defender
        [29755] = { ICONS.HUNTER, 29082, 0, ICONS.MAGE, 29077, 0, ICONS.WARLOCK, 28964, type = 6 }, -- Chestguard of the Fallen Hero
        -- Hands
        [29757] = { ICONS.PALADIN, 29065, 29067, 29072, 0, ICONS.ROGUE, 29048, 0, ICONS.SHAMAN, 29032, 29034, 29039, type = 6 }, -- Gloves of the Fallen Champion
        [29758] = { ICONS.WARRIOR, 29017, 29020, 0, ICONS.PRIEST, 29055, 29057, 0, ICONS.DRUID, 29090, 29092, 29097, type = 6 }, -- Gloves of the Fallen Defender
        [29756] = { ICONS.HUNTER, 29085, 0, ICONS.MAGE, 29080, 0, ICONS.WARLOCK, 28968, type = 6 }, -- Gloves of the Fallen Hero
        --Legs
        [29766] = { ICONS.PALADIN, 29074, 29063, 29069, 0, ICONS.ROGUE, 29046, 0, ICONS.SHAMAN, 29030, 29036, 29042, type = 6 }, -- Leggings of the Fallen Champion
        [29767] = { ICONS.WARRIOR, 29022, 29015, 0, ICONS.PRIEST, 29059, 29053, 0, ICONS.DRUID, 29094, 29099, 29088, type = 6 }, -- Leggings of the Fallen Defender
        [29765] = { ICONS.HUNTER, 29083, 0, ICONS.MAGE, 29078, 0, ICONS.WARLOCK, 28966, type = 6 }, -- Leggings of the Fallen Hero

        --- T5
        -- Head
        [30242] = { ICONS.PALADIN, 30125, 30136, 30131, 0, ICONS.ROGUE, 30146, 0, ICONS.SHAMAN, 30166, 30171, 30190, type = 6 }, -- Helm of the Vanquished Champion
        [30243] = { ICONS.WARRIOR, 30120, 30115, 0, ICONS.PRIEST, 30161, 30152, 0, ICONS.DRUID, 30228, 30219, 30233, type = 6 }, -- Helm of the Vanquished Defender
        [30244] = { ICONS.HUNTER, 30141, 0, ICONS.MAGE, 30206, 0, ICONS.WARLOCK, 30212, type = 6 }, -- Helm of the Vanquished Hero
        -- Shoulder
        [30248] = { ICONS.PALADIN, 30127, 30133, 30138, 0, ICONS.ROGUE, 30149, 0, ICONS.SHAMAN, 30168, 30173, 30194, type = 6 }, -- Pauldrons of the Vanquished Champion
        [30249] = { ICONS.WARRIOR, 30117, 30122, 0, ICONS.PRIEST, 30154, 30163, 0, ICONS.DRUID, 30221, 30230, 30235, type = 6 }, -- Pauldrons of the Vanquished Defender
        [30250] = { ICONS.HUNTER, 30143, 0, ICONS.MAGE, 30210, 0, ICONS.WARLOCK, 30215, type = 6 }, -- Pauldrons of the Vanquished Hero
        -- Chest
        [30236] = { ICONS.PALADIN, 30123, 30129, 30134, 0, ICONS.ROGUE, 30144, 0, ICONS.SHAMAN, 30164, 30169, 30185, type = 6 }, -- Chestguard of the Vanquished Champion
        [30237] = { ICONS.WARRIOR, 30113, 30118, 0, ICONS.PRIEST, 30150, 30159, 0, ICONS.DRUID, 30216, 30222, 30231, type = 6 }, -- Chestguard of the Vanquished Defender
        [30238] = { ICONS.HUNTER, 30139, 0, ICONS.MAGE, 30196, 0, ICONS.WARLOCK, 30214, type = 6 }, -- Chestguard of the Vanquished Hero
        -- Hands
        [30239] = { ICONS.PALADIN, 30130, 30135, 30124, 0, ICONS.ROGUE, 30145, 0, ICONS.SHAMAN, 30189, 30165, 30170, type = 6 }, -- Gloves of the Vanquished Champion
        [30240] = { ICONS.WARRIOR, 30114, 30119, 0, ICONS.PRIEST, 30160, 30151, 0, ICONS.DRUID, 30223, 30217, 30232, type = 6 }, -- Gloves of the Vanquished Defender
        [30241] = { ICONS.HUNTER, 30140, 0, ICONS.MAGE, 30205, 0, ICONS.WARLOCK, 30211, type = 6 }, -- Gloves of the Vanquished Hero
        -- Legs
        [30245] = { ICONS.PALADIN, 30132, 30137, 30126, 0, ICONS.ROGUE, 30148, 0, ICONS.SHAMAN, 30172, 30167, 30192, type = 6 }, -- Leggings of the Vanquished Champion
        [30246] = { ICONS.WARRIOR, 30121, 30116, 0, ICONS.PRIEST, 30153, 30162, 0, ICONS.DRUID, 30229, 30220, 30234, type = 6 }, -- Leggings of the Vanquished Defender
        [30247] = { ICONS.HUNTER, 30142, 0, ICONS.MAGE, 30207, 0, ICONS.WARLOCK, 30213, type = 6 }, -- Leggings of the Vanquished Hero

        --- T6
        -- Head
        [31097] = { ICONS.PALADIN, 30987, 30988, 30989, 0, ICONS.PRIEST, 31063, 31064, 0, ICONS.WARLOCK, 31051, type = 6 }, -- Helm of the Forgotten Conqueror
        [31096] = { ICONS.ROGUE, 31027, 0, ICONS.MAGE, 31056, 0, ICONS.DRUID, 31037, 31040, 31039, type = 6 }, -- Helm of the Forgotten Vanquisher
        [31095] = { ICONS.WARRIOR, 30972, 30974, 0, ICONS.HUNTER, 31003, 0, ICONS.SHAMAN, 31012, 31014, 31015, type = 6 }, -- Helm of the Forgotten Protector
        -- Shoulders
        [31101] = { ICONS.PALADIN, 30996, 30997, 30998, 0, ICONS.PRIEST, 31069, 31070, 0, ICONS.WARLOCK, 31054, type = 6 }, -- Pauldrons of the Forgotten Conqueror
        [31102] = { ICONS.ROGUE, 31030, 0, ICONS.MAGE, 31059, 0, ICONS.DRUID, 31047, 31048, 31049, type = 6 }, -- Pauldrons of the Forgotten Vanquisher
        [31103] = { ICONS.WARRIOR, 30979, 30980, 0, ICONS.HUNTER, 31006, 0, ICONS.SHAMAN, 31022, 31023, 31024, type = 6 }, -- Pauldrons of the Forgotten Protector
        -- Chest
        [31089] = { ICONS.PALADIN, 30990, 30991, 30992, 0, ICONS.PRIEST, 31065, 31066, 0, ICONS.WARLOCK, 31052, type = 6 }, -- Chestguard of the Forgotten Conqueror
        [31090] = { ICONS.ROGUE, 31028, 0, ICONS.MAGE, 31057, 0, ICONS.DRUID, 31041, 31042, 31043, type = 6 }, -- Chestguard of the Forgotten Vanquisher
        [31091] = { ICONS.WARRIOR, 30975, 30976, 0, ICONS.HUNTER, 31004, 0, ICONS.SHAMAN, 31016, 31017, 31018, type = 6 }, -- Chestguard of the Forgotten Protector
        -- Hands
        [31092] = { ICONS.PALADIN, 30982, 30983, 30985, 0, ICONS.PRIEST, 31060, 31061, 0, ICONS.WARLOCK, 31050, type = 6 }, -- Gloves of the Forgotten Conqueror
        [31093] = { ICONS.ROGUE, 31026, 0, ICONS.MAGE, 31055, 0, ICONS.DRUID, 31032, 31034, 31035, type = 6 }, -- Gloves of the Forgotten Vanquisher
        [31094] = { ICONS.WARRIOR, 30969, 30970, 0, ICONS.HUNTER, 31001, 0, ICONS.SHAMAN, 31007, 31008, 31011, type = 6 }, -- Gloves of the Forgotten Protector
        -- Legs
        [31098] = { ICONS.PALADIN, 30993, 30994, 30995, 0, ICONS.PRIEST, 31067, 31068, 0, ICONS.WARLOCK, 31053, type = 6 }, -- Leggings of the Forgotten Conqueror
        [31099] = { ICONS.ROGUE, 31029, 0, ICONS.MAGE, 31058, 0, ICONS.DRUID, 31044, 31045, 31046, type = 6 }, -- Leggings of the Forgotten Vanquisher
        [31100] = { ICONS.WARRIOR, 30977, 30978, 0, ICONS.HUNTER, 31005, 0, ICONS.SHAMAN, 31019, 31020, 31021, type = 6 }, -- Leggings of the Forgotten Protector
        -- Wrist
        [34848] = { ICONS.PALADIN, 34431, 34432, 34433, 0, ICONS.PRIEST, 34434, 34435, 0, ICONS.WARLOCK, 34436, type = 6 }, -- Bracers of the Forgotten Conqueror
        [34852] = { ICONS.ROGUE, 34448, 0, ICONS.MAGE, 34447, 0, ICONS.DRUID, 34444, 34445, 34446, type = 6 }, -- Bracers of the Forgotten Vanquisher
        [34851] = { ICONS.WARRIOR, 34441, 34442, 0, ICONS.HUNTER, 34443, 0, ICONS.SHAMAN, 34437, 34438, 34439, type = 6 }, -- Bracers of the Forgotten Protector
        -- Belt
        [34853] = { ICONS.PALADIN, 34485, 34487, 34488, 0, ICONS.PRIEST, 34527, 34528, 0, ICONS.WARLOCK, 34541, type = 6 }, -- Belt of the Forgotten Conqueror
        [34855] = { ICONS.ROGUE, 34558, 0, ICONS.MAGE, 34557, 0, ICONS.DRUID, 34554, 34555, 34556, type = 6 }, -- Belt of the Forgotten Vanquisher
        [34854] = { ICONS.WARRIOR, 34546, 34547, 0, ICONS.HUNTER, 34549, 0, ICONS.SHAMAN, 34542, 34543, 34545, type = 6 }, -- Belt of the Forgotten Protector
        -- Boots
        [34856] = { ICONS.PALADIN, 34559, 34560, 34561, 0, ICONS.PRIEST, 34562, 34563, 0, ICONS.WARLOCK, 34564, type = 6 }, -- Boots of the Forgotten Conqueror
        [34858] = { ICONS.ROGUE, 34575, 0, ICONS.MAGE, 34574, 0, ICONS.DRUID, 34571, 34572, 34573, type = 6 }, -- Boots of the Forgotten Vanquisher
        [34857] = { ICONS.WARRIOR, 34568, 34569, 0, ICONS.HUNTER, 34570, 0, ICONS.SHAMAN, 34565, 34566, 34567, type = 6 }, -- Boots of the Forgotten Protector

        --- Sunwell Sunmote tokens
        -- Cloth
        [34399] = { 34399, 0, {34664, "1"}, {34233, "1"}, type = 7 }, -- Robes of Ghostly Hatred
        [34233] = { 34399, 0, {34664, "1"}, {34233, "1"}, type = 8 }, -- Robes of Faltered Light
        [34406] = { 34406, 0, {34664, "1"}, {34342, "1"}, type = 7 }, -- Gloves of Tyri's Power
        [34342] = { 34406, 0, {34664, "1"}, {34342, "1"}, type = 8 }, -- Handguards of the Dawn
        [34405] = { 34405, 0, {34664, "1"}, {34339, "1"}, type = 7 }, -- Helm of Arcane Purity
        [34339] = { 34405, 0, {34664, "1"}, {34339, "1"}, type = 8 }, -- Cowl of Light's Purity
        [34386] = { 34386, 0, {34664, "1"}, {34170, "1"}, type = 7 }, -- Pantaloons of Growing Strife
        [34170] = { 34386, 0, {34664, "1"}, {34170, "1"}, type = 8 }, -- Pantaloons of Calming Strife
        [34393] = { 34393, 0, {34664, "1"}, {34202, "1"}, type = 7 }, -- Shoulderpads of Knowledge's Pursuit
        [34202] = { 34393, 0, {34664, "1"}, {34202, "1"}, type = 8 }, -- Shawl of Wonderment

        -- Leather
        [34397] = { 34397, 0, {34664, "1"}, {34211, "1"}, type = 7 }, -- Bladed Chaos Tunic
        [34211] = { 34397, 0, {34664, "1"}, {34211, "1"}, type = 8 }, -- Harness of Carnal Instinct
        [34398] = { 34398, 0, {34664, "1"}, {34212, "1"}, type = 7 }, -- Utopian Tunic of Elune
        [34212] = { 34398, 0, {34664, "1"}, {34212, "1"}, type = 8 }, -- Sunglow Vest
        [34408] = { 34408, 0, {34664, "1"}, {34234, "1"}, type = 7 }, -- Gloves of the Forest Drifter
        [34234] = { 34408, 0, {34664, "1"}, {34234, "1"}, type = 8 }, -- Shadowed Gauntlets of Paroxysm
        [34407] = { 34407, 0, {34664, "1"}, {34351, "1"}, type = 7 }, -- Tranquil Moonlight Wraps
        [34351] = { 34407, 0, {34664, "1"}, {34351, "1"}, type = 8 }, -- Tranquil Majesty Wraps
        [34403] = { 34403, 0, {34664, "1"}, {34245, "1"}, type = 7 }, -- Cover of Ursoc the Mighty
        [34245] = { 34403, 0, {34664, "1"}, {34245, "1"}, type = 8 }, -- Cover of Ursol the Wise
        [34404] = { 34404, 0, {34664, "1"}, {34244, "1"}, type = 7 }, -- Mask of the Fury Hunter
        [34244] = { 34404, 0, {34664, "1"}, {34244, "1"}, type = 8 }, -- Duplicitous Guise
        [34384] = { 34384, 0, {34664, "1"}, {34169, "1"}, type = 7 }, -- Breeches of Natural Splendor
        [34169] = { 34384, 0, {34664, "1"}, {34169, "1"}, type = 8 }, -- Breeches of Natural Aggression
        [34385] = { 34385, 0, {34664, "1"}, {34188, "1"}, type = 7 }, -- Leggings of the Immortal Beast
        [34188] = { 34385, 0, {34664, "1"}, {34188, "1"}, type = 8 }, -- Leggings of the Immortal Night
        [34392] = { 34392, 0, {34664, "1"}, {34195, "1"}, type = 7 }, -- Demontooth Shoulderpads
        [34195] = { 34392, 0, {34664, "1"}, {34195, "1"}, type = 8 }, -- Shoulderpads of Vehemence
        [34391] = { 34391, 0, {34664, "1"}, {34209, "1"}, type = 7 }, -- Spaulders of Devastation
        [34209] = { 34391, 0, {34664, "1"}, {34209, "1"}, type = 8 }, -- Spaulders of Reclamation

        -- Mail
        [34402] = { 34402, 0, {34664, "1"}, {34332, "1"}, type = 7 }, -- Cover of Ursoc the Mighty
        [34332] = { 34402, 0, {34664, "1"}, {34332, "1"}, type = 8 }, -- Cowl of Gul'dan
        [34396] = { 34396, 0, {34664, "1"}, {34229, "1"}, type = 7 }, -- Garments of Crashing Shores
        [34229] = { 34396, 0, {34664, "1"}, {34229, "1"}, type = 8 }, -- Garments of Serene Shores
        [34390] = { 34390, 0, {34664, "1"}, {34208, "1"}, type = 7 }, -- Erupting Epaulets
        [34208] = { 34390, 0, {34664, "1"}, {34208, "1"}, type = 8 }, -- Equilibrium Epaulets
        [34409] = { 34409, 0, {34664, "1"}, {34350, "1"}, type = 7 }, -- Gauntlets of the Ancient Frostwolf
        [34350] = { 34409, 0, {34664, "1"}, {34350, "1"}, type = 8 }, -- Gauntlets of the Ancient Shadowmoon
        [34383] = { 34383, 0, {34664, "1"}, {34186, "1"}, type = 7 }, -- Kilt of Spiritual Reconstruction
        [34186] = { 34383, 0, {34664, "1"}, {34186, "1"}, type = 8 }, -- Chain Links of the Tumultuous Storm

        -- Plate
        [34401] = { 34401, 0, {34664, "1"}, {34243, "1"}, type = 7 }, -- Helm of Uther's Resolve
        [34243] = { 34401, 0, {34664, "1"}, {34243, "1"}, type = 8 }, -- Helm of Burning Righteousness
        [34400] = { 34400, 0, {34664, "1"}, {34345, "1"}, type = 7 }, -- Crown of Dath'Remar
        [34345] = { 34400, 0, {34664, "1"}, {34345, "1"}, type = 8 }, -- Crown of Anasterian
        [34389] = { 34389, 0, {34664, "1"}, {34193, "1"}, type = 7 }, -- Spaulders of the Thalassian Defender
        [34193] = { 34389, 0, {34664, "1"}, {34193, "1"}, type = 8 }, -- Spaulders of the Thalassian Savior
        [34388] = { 34388, 0, {34664, "1"}, {34192, "1"}, type = 7 }, -- Pauldrons of Berserking
        [34192] = { 34388, 0, {34664, "1"}, {34192, "1"}, type = 8 }, -- Pauldrons of Perseverance
        [34395] = { 34395, 0, {34664, "1"}, {34216, "1"}, type = 7 }, -- Noble Judicator's Chestguard
        [34216] = { 34395, 0, {34664, "1"}, {34216, "1"}, type = 8 }, -- Heroic Judicator's Chestguard
        [34394] = { 34394, 0, {34664, "1"}, {34215, "1"}, type = 7 }, -- Breastplate of Agony's Aversion
        [34215] = { 34394, 0, {34664, "1"}, {34215, "1"}, type = 8 }, -- Warharness of Reckless Fury
        [34382] = { 34382, 0, {34664, "1"}, {34167, "1"}, type = 7 }, -- Judicator's Legguards
        [34167] = { 34382, 0, {34664, "1"}, {34167, "1"}, type = 8 }, -- Legplates of the Holy Juggernaut
        [34381] = { 34381, 0, {34664, "1"}, {34180, "1"}, type = 7 }, -- Felstrength Legplates
        [34180] = { 34381, 0, {34664, "1"}, {34180, "1"}, type = 8 }, -- Felfury Legplates

    --- Misc
    -- Magtheridon's Lair
        [32385] = { 28791, 28790, 28793, 28792, type = 3 }, -- Magtheridon's Head
        [34846] = { -- Black Sack of Gems
        {32230,"1-3"}, {32249,"1-3"}, {32228,"1-3"}, {32229,"1-3"}, {32231,"1-3"}, {32227,"1-3"}, 0, -- Epic
        {23441,"1-2"}, {23437,"1-2"}, {23436,"1-2"}, {23438,"1-2"}, {23440,"1-2"}, {23439,"1-2"}, -- Blue
        type = 2 },

    -- Tempest Keep
    [32405] = { 30018, 30017, 30007, 30015 }, -- Verdant Sphere

    -- Motes
    [22574] = { {22574,"10"}, 0, 21884 }, -- Mote of Fire
    [22576] = { {22576,"10"}, 0, 22457 }, -- Mote of Mana
    [22573] = { {22573,"10"}, 0, 22452 }, -- Mote of Earth
    [22572] = { {22572,"10"}, 0, 22451 }, -- Mote of Air
    [22575] = { {22575,"10"}, 0, 21886 }, -- Mote of Life
    [22578] = { {22578,"10"}, 0, 21885 }, -- Mote of Water

    --- Darkmoon cards
    -- Furies Deck / Darkmoon Card: Vengeance
    [31907] = { 31907, 31858, 0, 31901, 31909, 31908, 31904, 31903, 31906, 31905, 31902 },
    [31901] = 31907, [31909] = 31907, [31908] = 31907, [31904] = 31907, [31903] = 31907, [31906] = 31907, [31905] = 31907, [31902] = 31907,

    -- Blessings Deck / Darkmoon Card: Crusade
    [31890] = { 31890, 31856, 0, 31882, 31889, 31888, 31885, 31884, 31887, 31886, 31883 },
    [31882] = 31890, [31889] = 31890, [31888] = 31890, [31885] = 31890, [31884] = 31890, [31887] = 31890, [31886] = 31890, [31883] = 31890,

    -- Storms Deck / Darkmoon Card: Wrath
    [31891] = { 31891, 31857, 0, 31892, 31900, 31899, 31895, 31894, 31898, 31896, 31893 },
    [31892] = 31891, [31900] = 31891, [31899] = 31891, [31899] = 31891, [31895] = 31891, [31898] = 31891, [31896] = 31891, [31893] = 31891,

    -- Lunacy Deck / Darkmoon Card: Madness
    [31914] = { 31914, 31859, 0, 31910, 31918, 31917, 31913, 31912, 31916, 31915, 31911 },
    [31910] = 31914, [31918] = 31914, [31917] = 31914, [31913] = 31914, [31912] = 31914, [31916] = 31914, [31915] = 31914, [31911] = 31914,

    -- Brewfest
    [33016] = { 33017, 33018, 33019, 33020, 33021 }, -- Blue Brewfest Stein
    [32912] = { 32917, 32918, 32920, 32915, 32919 }, -- Yellow Brewfest Stein
}
end

if AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM) then
    TOKEN_DATA.WRATH = {
        -- The Oculus
        [52676] = {{47241,"2"}, 43953, 0,
        {36918,"1-3"}, {36921,"1-3"}, {36924,"1-3"}, {36927,"1-3"}, {36930,"1-3"}, {36933,"1-3"}, type = 2
    }, -- Cache of the Ley-Guardian

    -- Battered Hilt
    [50380] = {50047, 50046, 50049, 50048, type = 3}, -- horde
    [50379] = 50380, -- alli

    -- Key to the Focusing Iris
    [44569] = {44582, type = 3}, -- 10man
    [44577] = {44581, type = 3}, -- 25man

    -- Heart of Magic / Malygos
    [44650] = {44658, 44657, 44659, 44660, type = 3}, -- 10man
    [44651] = {44661, 44662, 44664, 44665, type = 3}, -- 25man

    --- T7 / 10Man
    -- Head
    [40616] = { ICONS.PALADIN, 39628, 39635, 39640, 0, ICONS.PRIEST, 39514, 39521, 0, ICONS.WARLOCK, 39496, type = 6}, -- Helm of the Lost Conqueror
    [40617] = { ICONS.WARRIOR, 39605, 39610, 0, ICONS.HUNTER, 39578, 0, ICONS.SHAMAN, 39583, 39594, 39602, type = 6}, -- Helm of the Lost Protector
    [40618] = { ICONS.ROGUE, 39561, 0, ICONS.DEATHKNIGHT, 39619, 39625, 0, ICONS.MAGE, 39491, 0, ICONS.DRUID, 39531, 39545, 39553, type = 6}, -- Helm of the Lost Vanquisher
    -- Shoulders
    [40622] = { ICONS.PALADIN, 39631, 39637, 39642, 0, ICONS.PRIEST, 39518, 39529, 0, ICONS.WARLOCK, 39499, type = 6}, -- Spaulders of the Lost Conqueror
    [40623] = { ICONS.WARRIOR, 39608, 39613, 0, ICONS.HUNTER, 39581, 0, ICONS.SHAMAN, 39590, 39596, 39604, type = 6}, -- Spaulders of the Lost Protector
    [40624] = { ICONS.ROGUE, 39565, 0, ICONS.DEATHKNIGHT, 39621, 39627, 0, ICONS.MAGE, 39494, 0, ICONS.DRUID, 39542, 39548, 39556, type = 6}, -- Spaulders of the Lost Vanquisher
    -- Chest
    [40610] = { ICONS.PALADIN, 39629, 39633, 39638, 0, ICONS.PRIEST, 39515, 39523, 0, ICONS.WARLOCK, 39497, type = 6}, -- Chestguard of the Lost Conqueror
    [40611] = { ICONS.WARRIOR, 39606, 39611, 0, ICONS.HUNTER, 39579, 0, ICONS.SHAMAN, 39588, 39592, 39597, type = 6}, -- Chestguard of the Lost Protector
    [40612] = { ICONS.ROGUE, 39558, 0, ICONS.DEATHKNIGHT, 39617, 39623, 0, ICONS.MAGE, 39492, 0, ICONS.DRUID, 39538, 39547, 39554, type = 6}, -- Chestguard of the Lost Vanquisher
    -- Hands
    [40613] = { ICONS.PALADIN, 39632, 39634, 39639, 0, ICONS.PRIEST, 39519, 39530, 0, ICONS.WARLOCK, 39500, type = 6}, -- Gloves of the Lost Conqueror
    [40614] = { ICONS.WARRIOR, 39609, 39622, 0, ICONS.HUNTER, 39582, 0, ICONS.SHAMAN, 39591, 39593, 39601, type = 6}, -- Gloves of the Lost Protector
    [40615] = { ICONS.ROGUE, 39560, 0, ICONS.DEATHKNIGHT, 39618, 39624, 0, ICONS.MAGE, 39495, 0, ICONS.DRUID, 39543, 39544, 39557, type = 6}, -- Gloves of the Lost Vanquisher
    -- Leggings
    [40619] = { ICONS.PALADIN, 39630, 39636, 39641, 0, ICONS.PRIEST, 39517, 39528, 0, ICONS.WARLOCK, 39498, type = 6}, -- Leggings of the Lost Conqueror
    [40620] = { ICONS.WARRIOR, 39607, 39612, 0, ICONS.HUNTER, 39580, 0, ICONS.SHAMAN, 39589, 39595, 39603, type = 6}, -- Leggings of the Lost Protector
    [40621] = { ICONS.ROGUE, 39564, 0, ICONS.DEATHKNIGHT, 39620, 39626, 0, ICONS.MAGE, 39493, 0, ICONS.DRUID, 39539, 39546, 39555, type = 6}, -- Leggings of the Lost Vanquisher

    --- T7 / 25Man
    -- Head
    [40631] = { ICONS.PALADIN, 40571, 40576, 40581, 0, ICONS.PRIEST, 40447, 40456, 0, ICONS.WARLOCK, 40421, type = 6}, -- Crown of the Lost Conqueror
    [40632] = { ICONS.WARRIOR, 40528, 40546, 0, ICONS.HUNTER, 40505, 0, ICONS.SHAMAN, 40510, 40516, 40521, type = 6}, -- Crown of the Lost Protector
    [40633] = { ICONS.ROGUE, 40499, 0, ICONS.DEATHKNIGHT, 40554, 40565, 0, ICONS.MAGE, 40416, 0, ICONS.DRUID, 40461, 40467, 40473, type = 6}, -- Crown of the Lost Vanquisher
    -- Shoulders
    [40637] = { ICONS.PALADIN, 40573, 40578, 40584, 0, ICONS.PRIEST, 40450, 40459, 0, ICONS.WARLOCK, 40424, type = 6}, -- Mantle of the Lost Conqueror
    [40638] = { ICONS.WARRIOR, 40530, 40548, 0, ICONS.HUNTER, 40507, 0, ICONS.SHAMAN, 40513, 40518, 40524, type = 6}, -- Mantle of the Lost Protector
    [40639] = { ICONS.ROGUE, 40502, 0, ICONS.DEATHKNIGHT, 40557, 40568, 0, ICONS.MAGE, 40419, 0, ICONS.DRUID, 40465, 40470, 40494, type = 6}, -- Mantle of the Lost Vanquisher
    -- Chest
    [40625] = { ICONS.PALADIN, 40569, 40574, 40579, 0, ICONS.PRIEST, 40449, 40458, 0, ICONS.WARLOCK, 40423, type = 6}, -- Breastplate of the Lost Conqueror
    [40626] = { ICONS.WARRIOR, 40525, 40544, 0, ICONS.HUNTER, 40503, 0, ICONS.SHAMAN, 40508, 40514, 40523, type = 6}, -- Breastplate of the Lost Protector
    [40627] = { ICONS.ROGUE, 40495, 0, ICONS.DEATHKNIGHT, 40550, 40559, 0, ICONS.MAGE, 40418, 0, ICONS.DRUID, 40463, 40469, 40471, type = 6}, -- Breastplate of the Lost Vanquisher
    -- Hands
    [40628] = { ICONS.PALADIN, 40570, 40575, 40580, 0, ICONS.PRIEST, 40445, 40454, 0, ICONS.WARLOCK, 40420, type = 6}, -- Gauntlets of the Lost Conqueror
    [40629] = { ICONS.WARRIOR, 40527, 40545, 0, ICONS.HUNTER, 40504, 0, ICONS.SHAMAN, 40509, 40515, 40520, type = 6}, -- Gauntlets of the Lost Protector
    [40630] = { ICONS.ROGUE, 40496, 0, ICONS.DEATHKNIGHT, 40552, 40563, 0, ICONS.MAGE, 40415, 0, ICONS.DRUID, 40460, 40466, 40472, type = 6}, -- Gauntlets of the Lost Vanquisher
    -- Leggings
    [40634] = { ICONS.PALADIN, 40572, 40577, 40583, 0, ICONS.PRIEST, 40448, 40457, 0, ICONS.WARLOCK, 40422, type = 6}, -- Legplates of the Lost Conqueror
    [40635] = { ICONS.WARRIOR, 40529, 40547, 0, ICONS.HUNTER, 40506, 0, ICONS.SHAMAN, 40512, 40517, 40522, type = 6}, -- Legplates of the Lost Protector
    [40636] = { ICONS.ROGUE, 40500, 0, ICONS.DEATHKNIGHT, 40556, 40567, 0, ICONS.MAGE, 40417, 0, ICONS.DRUID, 40462, 40468, 40493, type = 6}, -- Legplates of the Lost Vanquisher

    --- T8 / 10Man
    -- Head
    [45647] = { ICONS.PALADIN, 45372, 45377, 45382, 0, ICONS.PRIEST, 45386, 45391, 0, ICONS.WARLOCK, 45417, type = 6}, -- Helm of the Wayward Conqueror
    [45648] = { ICONS.WARRIOR, 45425, 45431, 0, ICONS.HUNTER, 45361, 0, ICONS.SHAMAN, 45402, 45408, 45412, type = 6}, -- Helm of the Wayward Protector
    [45649] = { ICONS.ROGUE, 45398, 0, ICONS.DEATHKNIGHT, 45336, 45342, 0, ICONS.MAGE, 45365, 0, ICONS.DRUID, 45346, 45356, 46313, type = 6}, -- Helm of the Wayward Vanquisher
    -- Shoulders
    [45659] = { ICONS.PALADIN, 45373, 45380, 45385, 0, ICONS.PRIEST, 45390, 45393, 0, ICONS.WARLOCK, 45422, type = 6}, -- Spaulders of the Wayward Conqueror
    [45660] = { ICONS.WARRIOR, 45428, 45433, 0, ICONS.HUNTER, 45363, 0, ICONS.SHAMAN, 45404, 45410, 45415, type = 6}, -- Spaulders of the Wayward Protector
    [45661] = { ICONS.ROGUE, 45400, 0, ICONS.DEATHKNIGHT, 45339, 45344, 0, ICONS.MAGE, 45369, 0, ICONS.DRUID, 45349, 45352, 45359, type = 6}, -- Spaulders of the Wayward Vanquisher
    -- Chest
    [45635] = { ICONS.PALADIN, 45374, 45375, 45381, 0, ICONS.PRIEST, 45389, 45395, 0, ICONS.WARLOCK, 45421, type = 6}, -- Chestguard of the Wayward Conqueror
    [45636] = { ICONS.WARRIOR, 45424, 45429, 0, ICONS.HUNTER, 45364, 0, ICONS.SHAMAN, 45405, 45411, 45413, type = 6}, -- Chestguard of the Wayward Protector
    [45637] = { ICONS.ROGUE, 45396, 0, ICONS.DEATHKNIGHT, 45335, 45340, 0, ICONS.MAGE, 45368, 0, ICONS.DRUID, 45348, 45354, 45358, type = 6}, -- Chestguard of the Wayward Vanquisher
    -- Hands
    [45644] = { ICONS.PALADIN, 45370, 45376, 45383, 0, ICONS.PRIEST, 45387, 45392, 0, ICONS.WARLOCK, 45419, type = 6}, -- Gloves of the Wayward Conqueror
    [45645] = { ICONS.WARRIOR, 45426, 45430, 0, ICONS.HUNTER, 45360, 0, ICONS.SHAMAN, 45401, 45406, 45414, type = 6}, -- Gloves of the Wayward Protector
    [45646] = { ICONS.ROGUE, 45397, 0, ICONS.DEATHKNIGHT, 45337, 45341, 0, ICONS.MAGE, 46131, 0, ICONS.DRUID, 45345, 45351, 45355, type = 6}, -- Gloves of the Wayward Vanquisher
    -- Leggings
    [45650] = { ICONS.PALADIN, 45371, 45379, 45384, 0, ICONS.PRIEST, 45388, 45394, 0, ICONS.WARLOCK, 45420, type = 6}, -- Leggings of the Wayward Conqueror
    [45651] = { ICONS.WARRIOR, 45427, 45432, 0, ICONS.HUNTER, 45362, 0, ICONS.SHAMAN, 45403, 45409, 45416, type = 6}, -- Leggings of the Wayward Protector
    [45652] = { ICONS.ROGUE, 45399, 0, ICONS.DEATHKNIGHT, 45338, 45343, 0, ICONS.MAGE, 45367, 0, ICONS.DRUID, 45347, 45353, 45357, type = 6}, -- Leggings of the Wayward Vanquisher

    --- T8 / 25Man
    -- Head
    [45638] = { ICONS.PALADIN, 46156, 46175, 46180, 0, ICONS.PRIEST, 46172, 46197, 0, ICONS.WARLOCK, 46140, type = 6}, -- Crown of the Wayward Conqueror
    [45639] = { ICONS.WARRIOR, 46151, 46166, 0, ICONS.HUNTER, 46143, 0, ICONS.SHAMAN, 46201, 46209, 46212, type = 6}, -- Crown of the Wayward Protector
    [45640] = { ICONS.ROGUE, 46125, 0, ICONS.DEATHKNIGHT, 46115, 46120, 0, ICONS.MAGE, 46129, 0, ICONS.DRUID, 46161, 46184, 46191, type = 6}, -- Crown of the Wayward Vanquisher
    -- Shoulders
    [45656] = { ICONS.PALADIN, 46152, 46177, 46182, 0, ICONS.PRIEST, 46165, 46190, 0, ICONS.WARLOCK, 46136, type = 6}, -- Mantle of the Wayward Conqueror
    [45657] = { ICONS.WARRIOR, 46149, 46167, 0, ICONS.HUNTER, 46145, 0, ICONS.SHAMAN, 46203, 46204, 46211, type = 6}, -- Mantle of the Wayward Protector
    [45658] = { ICONS.ROGUE, 46127, 0, ICONS.DEATHKNIGHT, 46117, 46122, 0, ICONS.MAGE, 46134, 0, ICONS.DRUID, 46157, 46187, 46196, type = 6}, -- Mantle of the Wayward Vanquisher
    -- Chest
    [45632] = { ICONS.PALADIN, 46154, 46173, 46178, 0, ICONS.PRIEST, 46168, 46193, 0, ICONS.WARLOCK, 46137, type = 6}, -- Breastplate of the Wayward Conqueror
    [45633] = { ICONS.WARRIOR, 46146, 46162, 0, ICONS.HUNTER, 46141, 0, ICONS.SHAMAN, 46198, 46205, 46206, type = 6}, -- Breastplate of the Wayward Protector
    [45634] = { ICONS.ROGUE, 46123, 0, ICONS.DEATHKNIGHT, 46111, 46118, 0, ICONS.MAGE, 46130, 0, ICONS.DRUID, 46159, 46186, 46194, type = 6}, -- Breastplate of the Wayward Vanquisher
    -- Hands
    [45641] = { ICONS.PALADIN, 46155, 46174, 46179, 0, ICONS.PRIEST, 46163, 46188, 0, ICONS.WARLOCK, 46135, type = 6}, -- Gauntlets of the Wayward Conqueror
    [45642] = { ICONS.WARRIOR, 46148, 46164, 0, ICONS.HUNTER, 46142, 0, ICONS.SHAMAN, 46199, 46200, 46207, type = 6}, -- Gauntlets of the Wayward Protector
    [45643] = { ICONS.ROGUE, 46124, 0, ICONS.DEATHKNIGHT, 46113, 46119, 0, ICONS.MAGE, 46132, 0, ICONS.DRUID, 46158, 46183, 46189, type = 6}, -- Gauntlets of the Wayward Vanquisher
    -- Leggings
    [45653] = { ICONS.PALADIN, 46153, 46176, 46181, 0, ICONS.PRIEST, 46170, 46195, 0, ICONS.WARLOCK, 46139, type = 6}, -- Legplates of the Wayward Conqueror
    [45654] = { ICONS.WARRIOR, 46150, 46169, 0, ICONS.HUNTER, 46144, 0, ICONS.SHAMAN, 46202, 46208, 46210, type = 6}, -- Legplates of the Wayward Protector
    [45655] = { ICONS.ROGUE, 46126, 0, ICONS.DEATHKNIGHT, 46116, 46121, 0, ICONS.MAGE, 46133, 0, ICONS.DRUID, 46160, 46185, 46192, type = 6}, -- Legplates of the Wayward Vanquisher

    --- ## WrathOnyxiasLair
    [49644] = {49485, 49486, 49487, type = 3}, -- Head of Onyxia
    [49294] = { {36919, "1-2"}, {36922, "1-3"}, {36931, "1-3"}, {36928, "1-3"}, {36934, "1-3"}, {36925, "1-3"}, type = 2 },	-- Ashen Sack of Gems
    ["WrathOnyxiaClassItems10"] = {
        ICONS.WARLOCK, 49315, 0, ICONS.PRIEST, 49316, 49317, 0, ICONS.MAGE, 49318, 0,
        ICONS.ROGUE, 49322, 0, ICONS.DRUID, 49327, 49328, 49326, 0,
        ICONS.HUNTER, 49319, 0, ICONS.SHAMAN, 49331, 49330, 49329, 0,
        ICONS.WARRIOR, 49320, 49321, 0, ICONS.PALADIN, 49323, 49325, 49324, 0, ICONS.DEATHKNIGHT, 49333, 49332,
        type = 9
    },
    ["WrathOnyxiaClassItems25"] = {
        ICONS.WARLOCK, 49484, 0, ICONS.PRIEST, 49482, 49483, 0, ICONS.MAGE, 49481, 0,
        ICONS.ROGUE, 49477, 0, ICONS.DRUID, 49472, 49473, 49471, 0,
        ICONS.HUNTER, 49480, 0, ICONS.SHAMAN, 49469, 49468, 49470, 0,
        ICONS.WARRIOR, 49479, 49478, 0, ICONS.PALADIN, 49476, 49475, 49474, 0, ICONS.DEATHKNIGHT, 49467, 49466,
        type = 9
    },

    ["Tier7TitanRuneTokens"] = {
        40616, 40617, 40618, 0,
        40622, 40623, 40624, 0,
        40619, 40620, 40621, 0,
        type = 9
    },
    ["Tier8TitanRuneTokens"] = {
        45647, 45648, 45649, 0,
        45635, 45636, 45637, 0,
        45659, 45660, 45661, 0,
        45650, 45651, 45652, 0,
        45644, 45645, 45646, 0,
        type = 9
    },

    --- Val'anyr
    [45038] = { { 45038, 30 }, 45039, 45896, 0, 46017 }, -- Fragment of Val'anyr
    [45039] = 45038, -- Shattered Fragments of Val'anyr
    [45896] = 45038, -- Unbound Fragments of Val'anyr
    [46017] = 45038, -- Val'anyr, Hammer of Ancient Kings

    --- Algalon Quest
    [46052] = { 46320, 46321, 46322, 46323, type = 3 }, -- Reply-Code Alpha / 10man
    [46053] = { 45588, 45618, 45608, 45614, type = 3 }, -- Reply-Code Alpha / 25man

    --- Algalon Key
    -- 10 man
    [45796] = { 45788, 45786, 45787, 45784, 0, 45796, type = 4 }, -- Celestial Planetarium Key / 10man
    [45788] = 45796, [45786] = 45796, [45787] = 45796, [45784] = 45796,
    -- 25 man
    [45798] = { 45814, 45815, 45816, 45817, 0, 45798, type = 4 }, -- Celestial Planetarium Key / 25man
    [45814] = 45798, [45815] = 45798, [45816] = 45798, [45817] = 45798,

    ["AC_UlduarFlameLeviathan10"] = {"ac2913", "ac2914", "ac2915", "ac3056", 0, "ac2911", "ac2909", "ac2907", "ac2905", type = 10},
    ["AC_UlduarFlameLeviathan25"] = {"ac2918", "ac2916", "ac2917", "ac3057", 0, "ac2912", "ac2910", "ac2908", "ac2906", type = 10},

    ["AC_UlduarXTDeconstructor10"] = {"ac3058", "ac2937", "ac2931", "ac2934", "ac2933", type = 10},
    ["AC_UlduarXTDeconstructor25"] = {"ac3059", "ac2938", "ac2932", "ac2936", "ac2935", type = 10},

    ["AC_UlduarCouncil10"] = {"ac2945", "ac2947", "ac2939", "ac2941", "ac2940", type = 10},
    ["AC_UlduarCouncil25"] = {"ac2946", "ac2948", "ac2942", "ac2944", "ac2943", type = 10},

    ["AC_UlduarFreya10"] = {"ac2980", "ac2985", "ac2982", "ac2979", 0, "ac3177", "ac3178", "ac3179", type = 10},
    ["AC_UlduarFreya25"] = {"ac2981", "ac2984", "ac2983", "ac3118", 0, "ac3185", "ac3186", "ac3187", type = 10},

    ["AC_UlduarHodir10"] = {"ac2961", "ac2967", "ac3182", "ac2963", "ac2969", type = 10},
    ["AC_UlduarHodir25"] = {"ac2962", "ac2968", "ac3184", "ac2965", "ac2970", type = 10},

    ["AC_UlduarYoggSaron10"] = {"ac3159", "ac3158", "ac3141", "ac3157", "ac3008", 0, "ac3012", "ac3015", "ac3009", "ac3014", type = 10},
    ["AC_UlduarYoggSaron25"] = {"ac3164", "ac3163", "ac3162", "ac3161", "ac3010", 0, "ac3013", "ac3016", "ac3011", "ac3017", type = 10},

    -- TODO: T9 and T10 token drops never implemented

    --- ## Shadowmourne
    [50274] = { {50274,"50"}, {49908,"25"}, 49869, 50226, 50231, 0, 49888, 49623, 0, 51315, 52200, 52201, 52251, 52252, 52253 }, -- Shadowfrost Shard
    [49869] = 50274, -- Light's Vengeance
    [50226] = 50274, -- Festergut's Acidic Blood
    [50231] = 50274, -- Rotface's Acidic Blood
    [49623] = 50274, -- Shadowmourne
    [51315] = 50274, -- Sealed Chest
    [52200] = 50274, -- Reins of the Crimson Deathcharger
    [52201] = 50274, -- Muradin's Favor
    [52251] = 50274, -- Jaina's Locket
    [52252] = 50274, -- Tabard of the Lightbringer
    [52253] = 50274, -- Sylvanas' Music Box

    --- ## VaultofArchavon
    --- Archavon the Stone Watcher
    -- Warlock
    ["VoA_A_WARLOCK_10"] = {39497, 39500, 39498, 0, 42001, 42015, 42003, type = 9},
    ["VoA_A_WARLOCK_25"] = {40423, 40420, 40422, 0, 41997, 42016, 42004, type = 9},
    -- Priest
    ["VoA_A_PRIEST_10_H"] = {39515, 39519, 39517, 0, 41857, 41872, 41862, type = 9},
    ["VoA_A_PRIEST_10_D"] = {39523, 39530, 39528, 0, 41919, 41938, 41925, type = 9},
    ["VoA_A_PRIEST_25_H"] = {40449, 40445, 40448, 0, 41858, 41873, 41863, type = 9},
    ["VoA_A_PRIEST_25_D"] = {40458, 40454, 40457, 0, 41920, 41939, 41926, type = 9},
    -- Rogue
    ["VoA_A_ROGUE_10"] = {39558, 39560, 39564, 0, 41648, 41765, 41653, type = 9},
    ["VoA_A_ROGUE_25"] = {40495, 40496, 40500, 0, 41649, 41766, 41654, type = 9},
    -- Hunter
    ["VoA_A_HUNTER_10"] = {39579, 39582, 39580, 0, 41085, 41141, 41203, type = 9},
    ["VoA_A_HUNTER_25"] = {40503, 40504, 40506, 0, 41086, 41142, 41204, type = 9},
    -- Warrior
    ["VoA_A_WARRIOR_10_D"] = {39606, 39609, 39607, 0, 40783, 40801, 40840, type = 9},
    ["VoA_A_WARRIOR_10_T"] = {39611, 39622, 39612, type = 9},
    ["VoA_A_WARRIOR_25_D"] = {40525, 40527, 40529, 0, 40786, 40804, 40844, type = 9},
    ["VoA_A_WARRIOR_25_T"] = {40544, 40545, 40547, type = 9},
    -- Deathknight
    ["VoA_A_DEATHKNIGHT_10_D"] = {39617, 39618, 39620, 0, 40781, 40803, 40841, type = 9},
    ["VoA_A_DEATHKNIGHT_10_T"] = {39623, 39624, 39626, type = 9},
    ["VoA_A_DEATHKNIGHT_25_D"] = {40550, 40552, 40556, 0, 40784, 40806, 40845, type = 9},
    ["VoA_A_DEATHKNIGHT_25_T"] = {40559, 40563, 40567, type = 9},
    -- Mage
    ["VoA_A_MAGE_10"] = {39492, 39495, 39493, 0, 41950, 41969, 41957, type = 9},
    ["VoA_A_MAGE_25"] = {40418, 40415, 40417, 0, 41951, 41970, 41958, type = 9},
    -- Druid
    ["VoA_A_DRUID_10_DR"] = {39547, 39544, 39546, 0, 41314, 41291, 41302, type = 9},
    ["VoA_A_DRUID_25_DR"] = {40469, 40466, 40468, 0, 41315, 41292, 41303, type = 9},
    ["VoA_A_DRUID_10_D"] = {39554, 39557, 39555, 0, 41659, 41771, 41665, type = 9},
    ["VoA_A_DRUID_25_D"] = {40471, 40472, 40493, 0, 41660, 41772, 41666, type = 9},
    ["VoA_A_DRUID_10_H"]  = {39538, 39543, 39539, 0, 41308, 41284, 41296, type = 9},
    ["VoA_A_DRUID_25_H"]  = {40463, 40460, 40462, 0, 41309, 41286, 41297, type = 9},
    -- Shaman
    ["VoA_A_SHAMAN_10_DR"] = {39592, 39593, 39595, 0, 40989, 41005, 41031, type = 9},
    ["VoA_A_SHAMAN_25_DR"] = {40514, 40515, 40517, 0, 40991, 41006, 41032, type = 9},
    ["VoA_A_SHAMAN_10_D"] = {39597, 39601, 39603, 0, 41079, 41135, 41162, type = 9},
    ["VoA_A_SHAMAN_25_D"] = {40523, 40520, 40522, 0, 41080, 41136, 41198, type = 9},
    ["VoA_A_SHAMAN_10_H"]  = {39588, 39591, 39589, 0, 40988, 40999, 41025, type = 9},
    ["VoA_A_SHAMAN_25_H"]  = {40508, 40509, 40512, 0, 40990, 41000, 41026, type = 9},
    -- Paladin
    ["VoA_A_PALADIN_10_H"] = {39629, 39632, 39630, 0, 40904, 40925, 40937, type = 9},
    ["VoA_A_PALADIN_25_H"] = {40569, 40570, 40572, 0, 40905, 40926, 40938, type = 9},
    ["VoA_A_PALADIN_10_D"] = {39633, 39634, 39636, 0, 40782, 40802, 40842, type = 9},
    ["VoA_A_PALADIN_25_D"] = {40574, 40575, 40577, 0, 40785, 40805, 40846, type = 9},
    ["VoA_A_PALADIN_10_T"] = {39638, 39639, 39641, type = 9},
    ["VoA_A_PALADIN_25_T"] = {40579, 40580, 40583, type = 9},

    --- Emalon the Storm Watcher
    -- Warlock
    ["VoA_E_WARLOCK_10"] = {45419, 45420, 0, 42016, 42004, type = 9},
    ["VoA_E_WARLOCK_25"] = {46135, 46139, 0, 42017, 42005, type = 9},
    -- Priest
    ["VoA_E_PRIEST_10_H"] = {45387, 45388, 0, 41873, 41863, type = 9},
    ["VoA_E_PRIEST_10_D"] = {45392, 45394, 0, 41939, 41926, type = 9},
    ["VoA_E_PRIEST_25_H"] = {46188, 46195, 0, 41874, 41864, type = 9},
    ["VoA_E_PRIEST_25_D"] = {46163, 46170, 0, 41940, 41927, type = 9},
    -- Rogue
    ["VoA_E_ROGUE_10"] = {45397, 45399, 0, 41766, 41654, type = 9},
    ["VoA_E_ROGUE_25"] = {46124, 46126, 0, 41767, 41655, type = 9},
    -- Hunter
    ["VoA_E_HUNTER_10"] = {45360, 45362, 0, 41142, 41204, type = 9},
    ["VoA_E_HUNTER_25"] = {46142, 46144, 0, 41143, 41205, type = 9},
    -- Warrior
    ["VoA_E_WARRIOR_10_D"] = {45430, 45432, 0, 40804, 40844, type = 9},
    ["VoA_E_WARRIOR_10_T"] = {45426, 45427, type = 9},
    ["VoA_E_WARRIOR_25_D"] = {46148, 46150, 0, 40807, 40847, type = 9},
    ["VoA_E_WARRIOR_25_T"] = {46164, 46169, type = 9},
    -- Deathknight
    ["VoA_E_DEATHKNIGHT_10_D"] = {45341, 45343, 0, 40806, 40845, type = 9},
    ["VoA_E_DEATHKNIGHT_10_T"] = {45337, 45338, type = 9},
    ["VoA_E_DEATHKNIGHT_25_D"] = {46113, 46116, 0, 46119, 46121, type = 9},
    ["VoA_E_DEATHKNIGHT_25_T"] = {40809, 40848, type = 9},
    -- Mage
    ["VoA_E_MAGE_10"] = {46131, 45367, 0, 41970, 41958, type = 9},
    ["VoA_E_MAGE_25"] = {46132, 46133, 0, 41971, 41959, type = 9},
    -- Druid
    ["VoA_E_DRUID_10_DR"] = {45351, 45353, 0, 41314, 41291, type = 9},
    ["VoA_E_DRUID_10_D"] = {45355, 45357, 0, 41659, 41771, type = 9},
    ["VoA_E_DRUID_10_H"]  = {45345, 45347, 0, 41308, 41284, type = 9},
    ["VoA_E_DRUID_25_DR"] = {46189, 46192, 0, 41293, 41304, type = 9},
    ["VoA_E_DRUID_25_D"] = {46158, 46160, 0, 41773, 41667, type = 9},
    ["VoA_E_DRUID_25_H"]  = {46183, 46185, 0, 41287, 41298, type = 9},
    -- Shaman
    ["VoA_E_SHAMAN_10_DR"] = {45406, 45409, 0, 41006, 41032, type = 9},
    ["VoA_E_SHAMAN_10_D"] = {45414, 45416, 0, 41136, 41198, type = 9},
    ["VoA_E_SHAMAN_10_H"]  = {45401, 45403, 0, 41000, 41026, type = 9},
    ["VoA_E_SHAMAN_25_DR"] = {46207, 46210, 0, 41007, 41033, type = 9},
    ["VoA_E_SHAMAN_25_D"] = {46200, 46208, 0, 41137, 41199, type = 9},
    ["VoA_E_SHAMAN_25_H"]  = {46199, 46202, 0, 41001, 41027, type = 9},
    -- Paladin
    ["VoA_E_PALADIN_10_H"] = {45370, 45371, 0, 40926, 40938, type = 9},
    ["VoA_E_PALADIN_10_D"] = {45376, 45379, 0, 40805, 40846, type = 9},
    ["VoA_E_PALADIN_10_T"] = {45383, 45384, type = 9},
    ["VoA_E_PALADIN_25_H"] = {46179, 46181, 0, 40927, 40939, type = 9},
    ["VoA_E_PALADIN_25_D"] = {46155, 46153, 0, 40808, 40849, type = 9},
    ["VoA_E_PALADIN_25_T"] = {46174, 46176, type = 9},

    --- Koralon the Flame Watcher (Alliance)
    -- Non-ClassSet-Items
    ["VoA_K_CLOTH_10"] = {41909, 41898, 41903, 0, 41893, 41881, 41885, type = 9},
    ["VoA_K_LEATHER_10"] = {41640, 41630, 41635, 0, 41625, 41617, 41621, 0, 41840, 41832, 41836, type = 9},
    ["VoA_K_MAIL_10"] = {41065, 41070, 41075, 0, 41060, 41051, 41055, 0, 41225, 41235, 41230, type = 9},
    ["VoA_K_PLATE_10"] = {40983, 40976, 40977, 0, 40889, 40881, 40882, type = 9},
    ["VoA_K_BACK_10"] = {42071, 42073, 42069, 42072, 42070, 0, 42074, 42075, type = 9},
    ["VoA_K_NECK_10"] = {42037, 42039, 42036, 42040, 42038, 0, 46373, 42034, 42035, type = 9},
    ["VoA_K_FINGER_10"] = {42116, 0, 42117, type = 9},
    ["VoA_K_CLOTH_25"] = {41910, 41899, 41904, 0, 41894, 41882, 41886, 0, 49181, 49179, 49183, type = 9},
    ["VoA_K_LEATHER_25"] = {41641, 41631, 41636, 0, 41626, 41618, 41622, 0, 41841, 41833, 41837, type = 9},
    ["VoA_K_MAIL_25"] = {41066, 41071, 41076, 0, 41061, 41052, 41056, 0, 41226, 41236, 41231, type = 9},
    ["VoA_K_PLATE_25"] = {40984, 40978, 40979, 0, 40890, 40883, 40884, type = 9},
    ["VoA_K_BACK_25"] = {42078, 42080, 42076, 42079, 42077, 0, 42081, 42082, type = 9},
    ["VoA_K_NECK_25"] = {42044, 42046, 42043, 42047, 42045, 0, 46374, 42041, 42042, type = 9},
    ["VoA_K_FINGER_25"] = {42118, 0, 42119, type = 9},
    -- Warlock
    ["VoA_KA_WARLOCK_10"] = {47783, 47785, 0, 42017, 42005, type = 9},
    ["VoA_KA_WARLOCK_25"] = {47782, 47780, 0, 42018, 42006, type = 9},
    -- Priest
    ["VoA_KA_PRIEST_10_H"] = {47982, 47980, 0, 41874, 41864, type = 9},
    ["VoA_KA_PRIEST_10_D"] = {48072, 48074, 0, 41940, 41927, type = 9},
    ["VoA_KA_PRIEST_25_H"] = {47983, 47985, 0, 41875, 41865, type = 9},
    ["VoA_KA_PRIEST_25_D"] = {48077, 48079, 0, 41941, 41928, type = 9},
    -- Rogue
    ["VoA_KA_ROGUE_10"] = {48222, 48220, 0, 41767, 41655, type = 9},
    ["VoA_KA_ROGUE_25"] = {48224, 48226, 0, 41768, 41656, type = 9},
    -- Hunter
    ["VoA_KA_HUNTER_10"] = {48254, 48252, 0, 41143, 41205, type = 9},
    ["VoA_KA_HUNTER_25"] = {48256, 48258, 0, 41144, 41206, type = 9},
    -- Warrior
    ["VoA_KA_WARRIOR_10_D"] = {48375, 48373, 0, 40807, 40847, type = 9},
    ["VoA_KA_WARRIOR_10_T"] = {48449, 48445, type = 9},
    ["VoA_KA_WARRIOR_25_D"] = {48377, 48379, 0, 40810, 40850, type = 9},
    ["VoA_KA_WARRIOR_25_T"] = {48452, 48446, type = 9},
    -- Deathknight
    ["VoA_KA_DEATHKNIGHT_10_D"] = {48480, 48476, 0, 40809, 40848, type = 9},
    ["VoA_KA_DEATHKNIGHT_10_T"] = {48537, 48533, type = 9},
    ["VoA_KA_DEATHKNIGHT_25_D"] = {48482, 48484, 0, 40811, 40851, type = 9},
    ["VoA_KA_DEATHKNIGHT_25_T"] = {48539, 48541, type = 9},
    -- Mage
    ["VoA_KA_MAGE_10"] = {47752, 47750, 0, 41971, 41959, type = 9},
    ["VoA_KA_MAGE_25"] = {47753, 47755, 0, 41972, 41960, type = 9},
    -- Druid
    ["VoA_KA_DRUID_10_DR"] = {48162, 48160, 0, 41293, 41304, type = 9},
    ["VoA_KA_DRUID_10_D"] = {48213, 48215, 0, 41773, 41667, type = 9},
    ["VoA_KA_DRUID_10_H"]  = {48132, 48130, 0, 41287, 41298, type = 9},
    ["VoA_KA_DRUID_25_DR"] = {48163, 48165, 0, 41294, 41305, type = 9},
    ["VoA_KA_DRUID_25_D"] = {48212, 48210, 0, 41774, 41668, type = 9},
    ["VoA_KA_DRUID_25_H"]  = {48133, 48135, 0, 41288, 41299, type = 9},
    -- Shaman
    ["VoA_KA_SHAMAN_10_DR"] = {48312, 48314, 0, 41007, 41033, type = 9},
    ["VoA_KA_SHAMAN_10_D"] = {48342, 48344, 0, 41137, 41199, type = 9},
    ["VoA_KA_SHAMAN_10_H"]  = {48284, 48282, 0, 41001, 41027, type = 9},
    ["VoA_KA_SHAMAN_25_DR"] = {48317, 48319, 0, 41008, 41034, type = 9},
    ["VoA_KA_SHAMAN_25_D"] = {48347, 48349, 0, 41138, 41200, type = 9},
    ["VoA_KA_SHAMAN_25_H"]  = {48286, 48288, 0, 41002, 41028, type = 9},
    -- Paladin
    ["VoA_KA_PALADIN_10_H"] = {48574, 48568, 0, 40927, 40939, type = 9},
    ["VoA_KA_PALADIN_10_D"] = {48603, 48605, 0, 40808, 40849, type = 9},
    ["VoA_KA_PALADIN_10_T"] = {48633, 48635, type = 9},
    ["VoA_KA_PALADIN_25_H"] = {48576, 48578, 0, 40928, 40940, type = 9},
    ["VoA_KA_PALADIN_25_D"] = {48608, 48610, 0, 40812, 40852, type = 9},
    ["VoA_KA_PALADIN_25_T"] = {48640, 48638, type = 9},
    -- Koralon the Flame Watcher (Horde)
    -- Warlock
    ["VoA_KH_WARLOCK_10"] = {47802, 47800, 0, 42017, 42005, type = 9},
    ["VoA_KH_WARLOCK_25"] = {47803, 47805, 0, 42018, 42006, type = 9},
    -- Priest
    ["VoA_KH_PRIEST_10_H"] = {48067, 48069, 0, 41874, 41864, type = 9},
    ["VoA_KH_PRIEST_10_D"] = {48097, 48099, 0, 41940, 41927, type = 9},
    ["VoA_KH_PRIEST_25_H"] = {48066, 48064, 0, 41875, 41865, type = 9},
    ["VoA_KH_PRIEST_25_D"] = {48096, 48094, 0, 41941, 41928, type = 9},
    -- Rogue
    ["VoA_KH_ROGUE_10"] = {48244, 48246, 0, 41767, 41655, type = 9},
    ["VoA_KH_ROGUE_25"] = {48241, 48239, 0, 41768, 41656, type = 9},
    -- Hunter
    ["VoA_KH_HUNTER_10"] = {48276, 48278, 0, 41143, 41205, type = 9},
    ["VoA_KH_HUNTER_25"] = {48273, 48271, 0, 41144, 41206, type = 9},
    -- Warrior
    ["VoA_KH_WARRIOR_10_D"] = {48387, 48389, 0, 40807, 40847, type = 9},
    ["VoA_KH_WARRIOR_10_T"] = {48457, 48459, type = 9},
    ["VoA_KH_WARRIOR_25_D"] = {48392, 48394, 0, 40810, 40850, type = 9},
    ["VoA_KH_WARRIOR_25_T"] = {48462, 48464, type = 9},
    -- Deathknight
    ["VoA_KH_DEATHKNIGHT_10_D"] = {48502, 48504, 0, 40809, 40848, type = 9},
    ["VoA_KH_DEATHKNIGHT_10_T"] = {48559, 48561, type = 9},
    ["VoA_KH_DEATHKNIGHT_25_D"] = {48499, 48497, 0, 40811, 40851, type = 9},
    ["VoA_KH_DEATHKNIGHT_25_T"] = {48556, 48554, type = 9},
    -- Mage
    ["VoA_KH_MAGE_10"] = {47773, 47775, 0, 41971, 41959, type = 9},
    ["VoA_KH_MAGE_25"] = {47772, 47770, 0, 41972, 41960, type = 9},
    -- Druid
    ["VoA_KH_DRUID_10_DR"] = {48183, 48185, 0, 41293, 41304, type = 9},
    ["VoA_KH_DRUID_10_D"] = {48192, 48190, 0, 41773, 41667, type = 9},
    ["VoA_KH_DRUID_10_H"]  = {48153, 48155, 0, 41287, 41298, type = 9},
    ["VoA_KH_DRUID_25_DR"] = {48182, 48180, 0, 41294, 41305, type = 9},
    ["VoA_KH_DRUID_25_D"] = {48193, 48195, 0, 41774, 41668, type = 9},
    ["VoA_KH_DRUID_25_H"]  = {48152, 48150, 0, 41288, 41299, type = 9},
    -- Shaman
    ["VoA_KH_SHAMAN_10_DR"] = {48337, 48339, 0, 41007, 41033, type = 9},
    ["VoA_KH_SHAMAN_10_D"] = {48367, 48369, 0, 41137, 41199, type = 9},
    ["VoA_KH_SHAMAN_10_H"]  = {48296, 48298, 0, 41001, 41027, type = 9},
    ["VoA_KH_SHAMAN_25_DR"] = {48334, 48332, 0, 41008, 41034, type = 9},
    ["VoA_KH_SHAMAN_25_D"] = {48364, 48362, 0, 41138, 41200, type = 9},
    ["VoA_KH_SHAMAN_25_H"]  = {48301, 48303, 0, 41002, 41028, type = 9},
    -- Paladin
    ["VoA_KH_PALADIN_10_H"] = {48598, 48596, 0, 40927, 40939, type = 9},
    ["VoA_KH_PALADIN_10_D"] = {48630, 48628, 0, 40808, 40849, type = 9},
    ["VoA_KH_PALADIN_10_T"] = {48653, 48655, type = 9},
    ["VoA_KH_PALADIN_25_H"] = {48593, 48591, 0, 40928, 40940, type = 9},
    ["VoA_KH_PALADIN_25_D"] = {48625, 48623, 0, 40812, 40852, type = 9},
    ["VoA_KH_PALADIN_25_T"] = {48658, 48660, type = 9},

    --- Toravon the Ice Watcher
    -- Non-ClassSet-Items
    ["VoA_T_CLOTH_10"] = {41910, 41899, 41904, 0, 41894, 41882, 41886, 0, 49181, 49179, 49183, type = 9},
    ["VoA_T_LEATHER_10"] = {41641, 41631, 41636, 0, 41626, 41618, 41622, 0, 41841, 41833, 41837, type = 9},
    ["VoA_T_MAIL_10"] = {41066, 41071, 41076, 0, 41061, 41052, 41056, 0, 41226, 41236, 41231, type = 9},
    ["VoA_T_PLATE_10"] = {40984, 40978, 40979, 0, 40890, 40883, 40884, type = 9},
    ["VoA_T_BACK_10"] = {42078, 42080, 42076, 42079, 42077, 0, 42081, 42082, type = 9},
    ["VoA_T_NECK_10"] = {42044, 42046, 42043, 42047, 42045, 0, 46374, 42041, 42042, type = 9},
    ["VoA_T_FINGER_10"] = {42118, 0, 42119, type = 9},
    ["VoA_T_CLOTH_25"] = {51329, 51327, 51328, 0, 51367, 51365, 51366, 0, 51339, 51337, 51338, type = 9},
    ["VoA_T_LEATHER_25"] = {51345, 51343, 51344, 0, 51342, 51340, 51341, 0, 51370, 51368, 51369, type = 9},
    ["VoA_T_MAIL_25"] = {51376, 51374, 51375, 0, 51373, 51371, 51372, 0, 51352, 51350, 51351, type = 9},
    ["VoA_T_PLATE_25"] = {51361, 51359, 51360, 0, 51364, 51362, 51363, type = 9},
    ["VoA_T_BACK_25"] = {51334, 51348, 51330, 51346, 51332, 0, 51354, 51356, type = 9},
    ["VoA_T_NECK_25"] = {51335, 51349, 51331, 51347, 51333, 0, 51353, 51355, 51357, type = 9},
    ["VoA_T_FINGER_25"] = {51336, 0, 51358, type = 9},
    -- Warlock
    ["VoA_T_WARLOCK_10"] = {50240, 50242, 0, 42018, 42006, type = 9},
    ["VoA_T_WARLOCK_25"] = {51209, 51207, 0, 51537, 51539, type = 9},
    -- Priest
    ["VoA_T_PRIEST_10_H"] = {50766, 50769, 0, 41875, 41865, type = 9},
    ["VoA_T_PRIEST_10_D"] = {50391, 50393, 0, 41941, 41928, type = 9},
    ["VoA_T_PRIEST_25_H"] = {51179, 51177, 0, 51483, 51485, type = 9},
    ["VoA_T_PRIEST_25_D"] = {51183, 51181, 0, 51488, 51490, type = 9},
    -- Rogue
    ["VoA_T_ROGUE_10"] = {50088, 50090, 0, 41768, 41656, type = 9},
    ["VoA_T_ROGUE_25"] = {51188, 51186, 0, 51493, 51495, type = 9},
    -- Hunter
    ["VoA_T_HUNTER_10"] = {50114, 50116, 0, 41144, 41206, type = 9},
    ["VoA_T_HUNTER_25"] = {51154, 51152, 0, 51459, 51461, type = 9},
    -- Warrior
    ["VoA_T_WARRIOR_10_D"] = {50079, 50081, 0, 40810, 40850, type = 9},
    ["VoA_T_WARRIOR_10_T"] = {50849, 50847, type = 9},
    ["VoA_T_WARRIOR_25_D"] = {51213, 51211, 0, 51542, 51544, type = 9},
    ["VoA_T_WARRIOR_25_T"] = {51217, 51216, type = 9},
    -- Deathknight
    ["VoA_T_DEATHKNIGHT_10_D"] = {50095, 50097, 0, 40811, 40851, type = 9},
    ["VoA_T_DEATHKNIGHT_10_T"] = {50856, 50854, type = 9},
    ["VoA_T_DEATHKNIGHT_25_D"] = {51128, 51126, 0, 51414, 51416, type = 9},
    ["VoA_T_DEATHKNIGHT_25_T"] = {51132, 51131, type = 9},
    -- Mage
    ["VoA_T_MAGE_10"] = {50275, 50277, 0, 41972, 41960, type = 9},
    ["VoA_T_MAGE_25"] = {51159, 51157, 0, 51464, 51466, type = 9},
    -- Druid
    ["VoA_T_DRUID_10_DR"] = {50822, 50820, 0, 41294, 41305, type = 9},
    ["VoA_T_DRUID_10_D"] = {50827, 50825, 0, 41774, 41668, type = 9},
    ["VoA_T_DRUID_10_H"]  = {50107, 50109, 0, 41288, 41299, type = 9},
    ["VoA_T_DRUID_25_DR"] = {51148, 51146, 0, 51434, 51436, type = 9},
    ["VoA_T_DRUID_25_D"] = {51144, 51142, 0, 51426, 51428, type = 9},
    ["VoA_T_DRUID_25_H"]  = {51138, 51136, 0, 51420, 51422, type = 9},
    -- Shaman
    ["VoA_T_SHAMAN_10_DR"] = {50842, 50844, 0, 41008, 41034, type = 9},
    ["VoA_T_SHAMAN_10_D"] = {50831, 50833, 0, 41138, 41200, type = 9},
    ["VoA_T_SHAMAN_10_H"]  = {50836, 50838, 0, 41002, 41028, type = 9},
    ["VoA_T_SHAMAN_25_DR"] = {51201, 51203, 0, 51510, 51512, type = 9},
    ["VoA_T_SHAMAN_25_D"] = {51196, 51198, 0, 51504, 51506, type = 9},
    ["VoA_T_SHAMAN_25_H"]  = {51191, 51193, 0, 51498, 51500, type = 9},
    -- Paladin
    ["VoA_T_PALADIN_10_H"] = {50868, 50866, 0, 40928, 40940, type = 9},
    ["VoA_T_PALADIN_10_D"] = {50327, 50325, 0, 40812, 40852, type = 9},
    ["VoA_T_PALADIN_10_T"] = {50863, 50861, type = 9},
    ["VoA_T_PALADIN_25_H"] = {51169, 51168, 0, 51469, 51471, type = 9},
    ["VoA_T_PALADIN_25_D"] = {51163, 51161, 0, 51475, 51477, type = 9},
    ["VoA_T_PALADIN_25_T"] = {51172, 51171, type = 9},

    --- Darkmoon cards
    -- Chaos Deck / Darkmoon Card: Berserker!
    [44276] = { 44276, 42989, 0, 44277, 44278, 44279, 44280, 44281, 44282, 44284, 44285 },
    [44277] = 44276, [44278] = 44276, [44279] = 44276, [44280] = 44276, [44281] = 44276, [44282] = 44276, [44284] = 44276, [44285] = 44276,

    -- Prisms Deck / Darkmoon Card: Illusion
    [44259] = { 44259, 42988, 0, 44260, 44261, 44262, 44263, 44264, 44265, 44266, 44267 },
    [44260] = 44259, [44261] = 44259, [44262] = 44259, [44263] = 44259, [44264] = 44259, [44265] = 44259, [44266] = 44259, [44267] = 44259,

    -- Undeath Deck / Darkmoon Card: Death
    [44294] = { 44294, 42990, 0, 44286, 44287, 44288, 44289, 44290, 44291, 44292, 44293 },
    [44286] = 44294, [44287] = 44294, [44288] = 44294, [44289] = 44294, [44290] = 44294, [44291] = 44294, [44292] = 44294, [44293] = 44294,

    -- Lunacy Deck / Darkmoon Card: Greatness
    [44326] = { 44326, 44253, 42987, 44254, 44255, 0, 44268, 44269, 44270, 44271, 44272, 44273, 44274, 44275 },
    [44268] = 44326, [44269] = 44326, [44270] = 44326, [44271] = 44326, [44272] = 44326, [44273] = 44326, [44274] = 44326, [44275] = 44326,
}
end

if AtlasLoot:GameVersion_GE(AtlasLoot.CATA_VERSION_NUM) then
    TOKEN_DATA.CATA = {
        -- Volcanic Deck / Darkmoon Card: Volcano
        [62021] = { 62021, 62047, 0, 61988, 61989, 61990, 61991, 61992, 61993, 61994, 61995 },
        [61988] = 62021, [61989] = 62021, [61990] = 62021, [61991] = 62021, [61992] = 62021, [61993] = 62021, [61994] = 62021, [61995] = 62021,

        -- Tsunami Deck / Darkmoon Card: Tsunami
        [62044] = { 62044, 62050, 0, 62012, 62013, 62014, 62015, 62016, 62017, 62018, 62019	},
        [62012] = 62044, [62013] = 62044, [62014] = 62044, [62015] = 62044, [62016] = 62044, [62017] = 62044, [62018] = 62044, [62019] = 62044,

        -- Hurricane Deck / Darkmoon Card: Hurricane
        [62045] = { 62045, 62049, 62051, 0, 62004, 62005, 62006, 62007, 62008, 62009, 62010, 62011	},
        [62004] = 62045, [62005] = 62045, [62006] = 62045, [62007] = 62045, [62008] = 62045, [62009] = 62045, [62010] = 62045, [62011] = 62045,

        -- Earthquake Deck / Darkmoon Card: Earthquake
        [62046] = { 62046, 62048, 0, 61996, 61997, 61998, 61999, 62000, 62001, 62002, 62003	},
        [61996] = 62046, [61997] = 62046, [61998] = 62046, [61999] = 62046, [62000] = 62046, [62001] = 62046, [62002] = 62046, [62003] = 62046,

        --- T11 / Normal
        -- Head
        [63683] = { ICONS.PALADIN, 60346, 60359, 60356, 0, ICONS.PRIEST, 60258, 60256, 0, ICONS.WARLOCK, 60249, type = 6}, -- Helm of the Forlorn Conqueror
        [63684] = { ICONS.WARRIOR, 60325, 60328, 0, ICONS.HUNTER, 60303, 0, ICONS.SHAMAN, 60308, 60320, 60315, type = 6}, -- Helm of the Forlorn Protector
        [63682] = { ICONS.ROGUE, 60299, 0, ICONS.DEATHKNIGHT, 60341, 60351, 0, ICONS.MAGE, 60243, 0, ICONS.DRUID, 60286, 60277, 60282, type = 6}, -- Helm of the Forlorn Vanquisher
        -- Shoulders
        [64315] = { ICONS.PALADIN, 60348, 60362, 60358, 0, ICONS.PRIEST, 60262, 60253, 0, ICONS.WARLOCK, 60252, type = 6}, -- Mantle of the Forlorn Conqueror
        [64316] = { ICONS.WARRIOR, 60327, 60331, 0, ICONS.HUNTER, 60306, 0, ICONS.SHAMAN, 60311, 60322, 60317, type = 6}, -- Mantle of the Forlorn Protector
        [64314] = { ICONS.ROGUE, 60302, 0, ICONS.DEATHKNIGHT, 60343, 60353, 0, ICONS.MAGE, 60246, 0, ICONS.DRUID, 60289, 60279, 60284, type = 6}, -- Mantle of the Forlorn Vanquisher
        --- T11 / Heroic
        -- Head
        [65001] = { ICONS.PALADIN, 65216, 65221, 65226, 0, ICONS.PRIEST, 65230, 65235, 0, ICONS.WARLOCK, 65260, type = 6}, -- Crown of the Forlorn Conqueror
        [65000] = { ICONS.WARRIOR, 65266, 65271, 0, ICONS.HUNTER, 65206, 0, ICONS.SHAMAN, 65246, 65251, 65256, type = 6}, -- Crown of the Forlorn Protector
        [65002] = { ICONS.ROGUE, 65241, 0, ICONS.DEATHKNIGHT, 65181, 65186, 0, ICONS.MAGE, 65210, 0, ICONS.DRUID, 65190, 65195, 65200, type = 6}, -- Crown of the Forlorn Vanquisher
        -- Shoulders
        [65088] = { ICONS.PALADIN, 65218, 65223, 65228, 0, ICONS.PRIEST, 65233, 65238, 0, ICONS.WARLOCK, 65263, type = 6}, -- Shoulders of the Forlorn Conqueror
        [65087] = { ICONS.WARRIOR, 65268, 65273, 0, ICONS.HUNTER, 65208, 0, ICONS.SHAMAN, 65248, 65253, 65258, type = 6}, -- Shoulders of the Forlorn Protector
        [65089] = { ICONS.ROGUE, 65243, 0, ICONS.DEATHKNIGHT, 65183, 65188, 0, ICONS.MAGE, 65213, 0, ICONS.DRUID, 65193, 65198, 65203, type = 6}, -- Shoulders of the Forlorn Vanquisher
        -- Chest
        [67423] = { ICONS.PALADIN, 65214, 65219, 65224, 0, ICONS.PRIEST, 65232, 65237, 0, ICONS.WARLOCK, 65262, type = 6}, -- Chest of the Forlorn Conqueror
        [67424] = { ICONS.WARRIOR, 65264, 65269, 0, ICONS.HUNTER, 65204, 0, ICONS.SHAMAN, 65244, 65249, 65254, type = 6}, -- Chest of the Forlorn Protector
        [67425] = { ICONS.ROGUE, 65239, 0, ICONS.DEATHKNIGHT, 65179, 65184, 0, ICONS.MAGE, 65212, 0, ICONS.DRUID, 65192, 65197, 65202, type = 6}, -- Chest of the Forlorn Vanquisher
        -- Hands
        [67429] = { ICONS.PALADIN, 65215, 65220, 65225, 0, ICONS.PRIEST, 65229, 65234, 0, ICONS.WARLOCK, 65259, type = 6}, -- Gauntlets of the Forlorn Conqueror
        [67430] = { ICONS.WARRIOR, 65265, 65270, 0, ICONS.HUNTER, 65205, 0, ICONS.SHAMAN, 65245, 65250, 65255, type = 6}, -- Gauntlets of the Forlorn Protector
        [67431] = { ICONS.ROGUE, 65240, 0, ICONS.DEATHKNIGHT, 65180, 65185, 0, ICONS.MAGE, 65209, 0, ICONS.DRUID, 65189, 65194, 65199, type = 6}, -- Gauntlets of the Forlorn Vanquisher
        -- Leggings
        [67428] = { ICONS.PALADIN, 65217, 65222, 65227, 0, ICONS.PRIEST, 65231, 65236, 0, ICONS.WARLOCK, 65261, type = 6}, -- Leggings of the Forlorn Conqueror
        [67427] = { ICONS.WARRIOR, 65267, 65272, 0, ICONS.HUNTER, 65207, 0, ICONS.SHAMAN, 65247, 65252, 65257, type = 6}, -- Leggings of the Forlorn Protector
        [67426] = { ICONS.ROGUE, 65242, 0, ICONS.DEATHKNIGHT, 65182, 65187, 0, ICONS.MAGE, 65211, 0, ICONS.DRUID, 65191, 65196, 65201, type = 6}, -- Leggings of the Forlorn Vanquisher

        --- T12 / Normal
        -- Head
        [71675] = { ICONS.PALADIN, 71065, 71093, 70948, 0, ICONS.PRIEST, 71272, 71277, 0, ICONS.WARLOCK, 71282, type = 6}, -- Helm of the Fiery Conqueror
        [71682] = { ICONS.WARRIOR, 71070, 70944, 0, ICONS.HUNTER, 71051, 0, ICONS.SHAMAN, 71298, 71303, 71293, type = 6}, -- Helm of the Fiery Protector
        [71668] = { ICONS.ROGUE, 71047, 0, ICONS.DEATHKNIGHT, 71060, 70954, 0, ICONS.MAGE, 71287, 0, ICONS.DRUID, 71098, 71103, 71108, type = 6}, -- Helm of the Fiery Vanquisher
        -- Shoulders
        [71681] = { ICONS.PALADIN, 71067, 71095, 70946, 0, ICONS.PRIEST, 71275, 71280, 0, ICONS.WARLOCK, 71285, type = 6}, -- Mantle of the Fiery Conqueror
        [71688] = { ICONS.WARRIOR, 71072, 70941, 0, ICONS.HUNTER, 71053, 0, ICONS.SHAMAN, 71300, 71305, 71295, type = 6}, -- Mantle of the Fiery Protector
        [71674] = { ICONS.ROGUE, 71049, 0, ICONS.DEATHKNIGHT, 71062, 70951, 0, ICONS.MAGE, 71290, 0, ICONS.DRUID, 71101, 71106, 71111, type = 6}, -- Mantle of the Fiery Vanquisher

        --- T12 / Heroic
        -- Head
        [71677] = { ICONS.PALADIN, 71514, 71519, 71524, 0, ICONS.PRIEST, 71528, 71533, 0, ICONS.WARLOCK, 71595, type = 6}, -- Crown of the Fiery Conqueror
        [71684] = { ICONS.WARRIOR, 71599, 71606, 0, ICONS.HUNTER, 71503, 0, ICONS.SHAMAN, 71544, 71549, 71554, type = 6}, -- Crown of the Fiery Protector
        [71670] = { ICONS.ROGUE, 71539, 0, ICONS.DEATHKNIGHT, 71478, 71483, 0, ICONS.MAGE, 71508, 0, ICONS.DRUID, 71488, 71492, 71497, type = 6}, -- Crown of the Fiery Vanquisher
        -- Shoulders
        [71680] = { ICONS.PALADIN, 71516, 71521, 71526, 0, ICONS.PRIEST, 71531, 71536, 0, ICONS.WARLOCK, 71598, type = 6}, -- Shoulders of the Fiery Conqueror
        [71687] = { ICONS.WARRIOR, 71603, 71608, 0, ICONS.HUNTER, 71505, 0, ICONS.SHAMAN, 71546, 71551, 71556, type = 6}, -- Shoulders of the Fiery Protector
        [71673] = { ICONS.ROGUE, 71541, 0, ICONS.DEATHKNIGHT, 71480, 71485, 0, ICONS.MAGE, 71511, 0, ICONS.DRUID, 71490, 71495, 71500, type = 6}, -- Shoulders of the Fiery Vanquisher
        -- Chest
        [71679] = { ICONS.PALADIN, 71512, 71517, 71522, 0, ICONS.PRIEST, 71530, 71535, 0, ICONS.WARLOCK, 71597, type = 6}, -- Chest of the Fiery Conqueror
        [71686] = { ICONS.WARRIOR, 71600, 71604, 0, ICONS.HUNTER, 71501, 0, ICONS.SHAMAN, 71542, 71547, 71552, type = 6}, -- Chest of the Fiery Protector
        [71672] = { ICONS.ROGUE, 71537, 0, ICONS.DEATHKNIGHT, 71476, 71481, 0, ICONS.MAGE, 71510, 0, ICONS.DRUID, 71486, 71494, 71499, type = 6}, -- Chest of the Fiery Vanquisher
        -- Hands
        [71676] = { ICONS.PALADIN, 71513, 71518, 71523, 0, ICONS.PRIEST, 71527, 71532, 0, ICONS.WARLOCK, 71594, type = 6}, -- Gauntlets of the Fiery Conqueror
        [71683] = { ICONS.WARRIOR, 71601, 71605, 0, ICONS.HUNTER, 71502, 0, ICONS.SHAMAN, 71543, 71548, 71553, type = 6}, -- Gauntlets of the Fiery Protector
        [71669] = { ICONS.ROGUE, 71538, 0, ICONS.DEATHKNIGHT, 71477, 71482, 0, ICONS.MAGE, 71507, 0, ICONS.DRUID, 71487, 71491, 71496, type = 6}, -- Gauntlets of the Fiery Vanquisher
        -- Leggings
        [71678] = { ICONS.PALADIN, 71515, 71520, 71525, 0, ICONS.PRIEST, 71529, 71534, 0, ICONS.WARLOCK, 71596, type = 6}, -- Leggings of the Fiery Conqueror
        [71685] = { ICONS.WARRIOR, 71602, 71607, 0, ICONS.HUNTER, 71504, 0, ICONS.SHAMAN, 71545, 71550, 71555, type = 6}, -- Leggings of the Fiery Protector
        [71671] = { ICONS.ROGUE, 71540, 0, ICONS.DEATHKNIGHT, 71479, 71484, 0, ICONS.MAGE, 71509, 0, ICONS.DRUID, 71489, 71493, 71498, type = 6}, -- Leggings of the Fiery Vanquisher

        --- T13 / Normal
        -- Head
        [78182] = { ICONS.PALADIN, 76767, 77005, 76876, 0, ICONS.PRIEST, 76358, 76347, 0, ICONS.WARLOCK, 76342, type = 6}, -- Crown of Corrupted Conq
        [78177] = { ICONS.WARRIOR, 76990, 76983, 0, ICONS.HUNTER, 77030, 0, ICONS.SHAMAN, 76758, 77037, 77042, type = 6}, -- Crown of Corrupted Protector
        [78172] = { ICONS.ROGUE, 77025, 0, ICONS.DEATHKNIGHT, 77010, 76976, 0, ICONS.MAGE, 76213, 0, ICONS.DRUID, 76750, 77019, 77015, type = 6}, -- Crown of Corrupted Vanquisher
        -- Shoulders
        [78180] = { ICONS.PALADIN, 76769, 77007, 76878, 0, ICONS.PRIEST, 76361, 76344, 0, ICONS.WARLOCK, 76339, type = 6}, -- Shoulders of the Corrupted Conqueror
        [78170] = { ICONS.ROGUE, 77027, 0, ICONS.DEATHKNIGHT, 77012, 76978, 0, ICONS.MAGE, 76216, 0, ICONS.DRUID, 76753, 77022, 77017, type = 6}, -- Shoulders of the Corrupted Vanquisher
        [78175] = { ICONS.WARRIOR, 76992, 76987, 0, ICONS.HUNTER, 77032, 0, ICONS.SHAMAN, 76760, 77035, 77044, type = 6}, -- Shoulders of the Corrupted Protector
        -- Chest
        [78184] = { ICONS.PALADIN, 76765, 77003, 76874, 0, ICONS.PRIEST, 76360, 76345, 0, ICONS.WARLOCK, 76340, type = 6}, -- Chest of the Corrupted Conqueror
        [78179] = { ICONS.WARRIOR, 76988, 76984, 0, ICONS.HUNTER, 77028, 0, ICONS.SHAMAN, 76756, 77039, 77040, type = 6}, -- Chest of Corrupted Protector
        [78174] = { ICONS.ROGUE, 77023, 0, ICONS.DEATHKNIGHT, 77008, 76974, 0, ICONS.MAGE, 76215, 0, ICONS.DRUID, 76752, 77021, 77013, type = 6}, -- Chest of Corrupted Vanquisher
        -- Gloves
        [78183] = { ICONS.PALADIN, 76766, 77004, 76875, 0, ICONS.PRIEST, 76357, 76348, 0, ICONS.WARLOCK, 76343, type = 6}, -- Gloves of the Corrupted Conqueror
        [78178] = { ICONS.WARRIOR, 76989, 76985, 0, ICONS.HUNTER, 77029, 0, ICONS.SHAMAN, 76757, 77038, 77041, type = 6}, -- Gloves of Corrupted Protector
        [78173] = { ICONS.ROGUE, 77024, 0, ICONS.DEATHKNIGHT, 77009, 76975, 0, ICONS.MAGE, 76212, 0, ICONS.DRUID, 76749, 77018, 77014, type = 6}, -- Gloves of Corrupted Vanquisher
        -- Legs
        [78181] = { ICONS.PALADIN, 76768, 77006, 76877, 0, ICONS.PRIEST, 76359, 76346, 0, ICONS.WARLOCK, 76341, type = 6}, -- Legs of the Corrupted Conqueror
        [78176] = { ICONS.WARRIOR, 76991, 76986, 0, ICONS.HUNTER, 77031, 0, ICONS.SHAMAN, 76759, 77036, 77043, type = 6}, -- Legs of Corrupted Protector
        [78171] = { ICONS.ROGUE, 77026, 0, ICONS.DEATHKNIGHT, 77011, 76977, 0, ICONS.MAGE, 76214, 0, ICONS.DRUID, 76751, 77020, 77016, type = 6}, -- Legs of Corrupted Vanquisher

        --- T13 / Heroic
        -- Head
        [78850] = { ICONS.PALADIN, 78692, 78695, 78693, 0, ICONS.PRIEST, 78700, 78703, 0, ICONS.WARLOCK, 78702, type = 6}, -- Crown of Corrupted Conq
        [78852] = { ICONS.ROGUE, 78699, 0, ICONS.DEATHKNIGHT, 78697, 78687, 0, ICONS.MAGE, 78701, 0, ICONS.DRUID, 78690, 78696, 78694, type = 6}, -- Crown of Corrupted Vanquisher
        [78851] = { ICONS.WARRIOR, 78689, 78688, 0, ICONS.HUNTER, 78698, 0, ICONS.SHAMAN, 78691, 78685, 78686, type = 6}, -- Crown of Corrupted Protector
        -- Shoulders
        [78859] = { ICONS.PALADIN, 78746, 78745, 78742, 0, ICONS.PRIEST, 78747, 78750, 0, ICONS.WARLOCK, 78749, type = 6}, -- Shoulders of the Corrupted Conqueror
        [78861] = { ICONS.ROGUE, 78738, 0, ICONS.DEATHKNIGHT, 78751, 78736, 0, ICONS.MAGE, 78748, 0, ICONS.DRUID, 78740, 78744, 78743, type = 6}, -- Shoulders of the Corrupted Vanquisher
        [78860] = { ICONS.WARRIOR, 78734, 78735, 0, ICONS.HUNTER, 78737, 0, ICONS.SHAMAN, 78739, 78741, 78733, type = 6}, -- Shoulders of the Corrupted Protector
        -- Chest
        [78847] = { ICONS.PALADIN, 78726, 78732, 78727, 0, ICONS.PRIEST, 78728, 78731, 0, ICONS.WARLOCK, 78730, type = 6}, -- Chest of the Corrupted Conqueror
        [78848] = { ICONS.WARRIOR, 78658, 78657, 0, ICONS.HUNTER, 78661, 0, ICONS.SHAMAN, 78725, 78723, 78724, type = 6}, -- Chest of Corrupted Protector
        [78849] = { ICONS.ROGUE, 78664, 0, ICONS.DEATHKNIGHT, 78663, 78659, 0, ICONS.MAGE, 78729, 0, ICONS.DRUID, 78660, 78662, 78665, type = 6}, -- Chest of Corrupted Vanquisher
        -- Gloves
        [78853] = { ICONS.PALADIN, 78673, 78677, 78675, 0, ICONS.PRIEST, 78683, 78682, 0, ICONS.WARLOCK, 78681, type = 6}, -- Gloves of the Corrupted Conqueror
        [78854] = { ICONS.WARRIOR, 78669, 78668, 0, ICONS.HUNTER, 78674, 0, ICONS.SHAMAN, 78666, 78672, 78667, type = 6}, -- Gloves of Corrupted Protector
        [78855] = { ICONS.ROGUE, 78679, 0, ICONS.DEATHKNIGHT, 78670, 78678, 0, ICONS.MAGE, 78671, 0, ICONS.DRUID, 78680, 78676, 78684, type = 6}, -- Gloves of Corrupted Vanquisher
        -- Legs
        [78856] = { ICONS.PALADIN, 78717, 78715, 78712, 0, ICONS.PRIEST, 78719, 78722, 0, ICONS.WARLOCK, 78721, type = 6}, -- Legs of the Corrupted Conqueror
        [78857] = { ICONS.WARRIOR, 78705, 78706, 0, ICONS.HUNTER, 78709, 0, ICONS.SHAMAN, 78718, 78711, 78704, type = 6}, -- Legs of Corrupted Protector
        [78858] = { ICONS.ROGUE, 78708, 0, ICONS.DEATHKNIGHT, 78716, 78707, 0, ICONS.MAGE, 78720, 0, ICONS.DRUID, 78710, 78714, 78713, type = 6}, -- Legs of Corrupted Vanquisher

        --- Dragonwrath
        [71141] = { {71141,"25"}, {65893,"3"}, {69815,"1000"}, 69848, 0, 71084, 71085, 71086}, -- Eternal Ember
        [69815] = 71141, -- Seething Cinder
        [50226] = 71141, -- Festergut's Acidic Blood
        [50231] = 71141, -- Rotface's Acidic Blood
        [71084] = 71141, -- Branch of Nordrassil
        [71085] = 71141, -- Runestaff of Nordrassil
        [71086] = 71141, -- Dragonwrath, Tarecgosa's Rest
        [69848] = 71141, -- Heart of Flame

        --- Fangs of the Father
        [77951] = { {77951,"333"}, {77952,"60"}, 78352, 0, 77945, 77947, 77949, 0, 77946, 77948, 77950}, -- Shadowy Gem
        [77952] = 77951, -- Elementium Gem Cluster
        [78352] = 77951, -- Fragment of Deathwing's Jaw
        [77945] = 77951, -- Fear
        [77946] = 77951, -- Vengeance
        [77947] = 77951, -- The Sleeper
        [77948] = 77951, -- The Dreamer
        [77949] = 77951, -- Golad, Twilight of Aspects
        [77950] = 77951, -- Tiriosh, Nightmare of Ages

        --- Items with suffixes from Throne
        [68132] = {"i68132suf-131","i68132suf-129","i68132suf-114","i68132suf-130","i68132suf-138","i68132suf-132",type=2}, -- Intellect Sword H
        [68127] = {"i68127suf-131","i68127suf-129","i68127suf-114","i68127suf-130","i68127suf-138","i68127suf-132",type=2}, -- Intellect Sword N
        [68130] = {"i68130suf-136","i68130suf-133","i68130suf-137","i68130suf-135",type=2}, -- Agility Sword H
        [68129] = {"i68129suf-136","i68129suf-133","i68129suf-137","i68129suf-135",type=2}, -- Agility Sword N
        [68131] = {"i68131suf-121","i68131suf-122","i68131suf-120","i68131suf-118",type=2}, -- Strength Sword H
        [68128] = {"i68128suf-121","i68128suf-122","i68128suf-120","i68128suf-118",type=2}, -- Strength Sword N
        [65383] = {"i65383suf-189","i65383suf-190","i65383suf-191","i65383suf-192","i65383suf-193","i65383suf-194",type=2}, -- Soul Breath Leggings H
        [63507] = {"i63507suf-183","i63507suf-184","i63507suf-185","i63507suf-186","i63507suf-187","i63507suf-188",type=2}, -- Soul Breath Leggings N
        [69881] = {"i69881suf-131","i69881suf-129","i69881suf-114","i69881suf-130","i69881suf-138","i69881suf-132",type=2}, -- Planetary Drape H
        [69835] = {"i69835suf-131","i69835suf-129","i69835suf-114","i69835suf-130","i69835suf-138","i69835suf-132",type=2}, -- Planetary Drape N
        [65373] = {"i65373suf-131","i65373suf-129","i65373suf-114","i65373suf-130","i65373suf-138","i65373suf-132",type=2}, -- Planetary Band H
        [63494] = {"i63494suf-131","i63494suf-129","i63494suf-114","i63494suf-130","i63494suf-138","i63494suf-132",type=2}, -- Planetary Band N
        [69882] = {"i69882suf-131","i69882suf-129","i69882suf-114","i69882suf-130","i69882suf-138","i69882suf-132",type=2}, -- Planetary Amulet H
        [69830] = {"i69830suf-131","i69830suf-129","i69830suf-114","i69830suf-130","i69830suf-138","i69830suf-132",type=2}, -- Planetary Amulet N
        [65376] = {"i65376suf-229","i65376suf-230","i65376suf-231","i65376suf-232",type=2}, -- Soul Breath Belt H
        [63498] = {"i63498suf-212","i63498suf-213","i63498suf-214","i63498suf-215",type=2}, -- Soul Breath Belt N
        [65374] = {"i65374suf-229","i65374suf-230","i65374suf-231","i65374suf-232",type=2}, -- Gale Rouser Belt H
        [63497] = {"i63497suf-212","i63497suf-213","i63497suf-214","i63497suf-215",type=2}, -- Gale Rouser Belt N
        [65384] = {"i65384suf-191","i65384suf-192","i65384suf-193","i65384suf-194",type=2}, -- Gale Rouser Leggings H
        [63506] = {"i63506suf-185","i63506suf-186","i63506suf-187","i63506suf-188",type=2}, -- Gale Rouser Leggings N
        [65377] = {"i65377suf-229","i65377suf-230","i65377suf-231","i65377suf-232",type=2}, -- Lightning Well Belt H
        [63496] = {"i63496suf-212","i63496suf-213","i63496suf-214","i63496suf-215",type=2}, -- Lightning Well Belt N
        [65386] = {"i65386suf-191","i65386suf-192","i65386suf-193","i65386suf-194",type=2}, -- Lightning Well Leggings H
        [63505] = {"i63505suf-185","i63505suf-186","i63505suf-187","i63505suf-188",type=2}, -- Lightning Well Leggings N
        [65382] = {"i65382suf-121","i65382suf-122","i65382suf-120","i65382suf-118",type=2}, -- Cloudburst Ring H
        [63499] = {"i63499suf-121","i63499suf-122","i63499suf-120","i63499suf-118",type=2}, -- Cloudburst Ring N
        [69879] = {"i69879suf-121","i69879suf-122","i69879suf-120","i69879suf-118",type=2}, -- Cloudburst Cloak H
        [69834] = {"i69834suf-121","i69834suf-122","i69834suf-120","i69834suf-118",type=2}, -- Cloudburst Cloak N
        [69885] = {"i69885suf-121","i69885suf-122","i69885suf-120","i69885suf-118",type=2}, -- Cloudburst Neck H
        [69829] = {"i69829suf-121","i69829suf-122","i69829suf-120","i69829suf-118",type=2}, -- Cloudburst Neck N
        [65369] = {"i65369suf-220","i65369suf-221","i65369suf-222","i65369suf-223",type=2}, -- Sky Strider Belt H
        [63490] = {"i63490suf-203","i63490suf-204","i63490suf-205","i63490suf-206",type=2}, -- Sky Strider Belt N
        [65379] = {"i65379suf-173","i65379suf-174","i65379suf-175","i65379suf-176",type=2}, -- Sky Strider Greaves H
        [63500] = {"i63500suf-169","i63500suf-170","i63500suf-171","i63500suf-172",type=2}, -- Sky Strider Greaves N
        [65371] = {"i65371suf-216","i65371suf-217","i65371suf-218","i65371suf-219",type=2}, -- Wind Stalker Belt H
        [63493] = {"i63493suf-233","i63493suf-234","i63493suf-235","i63493suf-236",type=2}, -- Wind Stalker Belt N
        [65381] = {"i65381suf-199","i65381suf-200","i65381suf-201","i65381suf-202",type=2}, -- Wind Stalker Leggings H
        [63503] = {"i63503suf-195","i63503suf-196","i63503suf-197","i63503suf-198",type=2}, -- Wind Stalker Leggings N
        [65368] = {"i65368suf-216","i65368suf-217","i65368suf-218","i65368suf-219",type=2}, -- Star Chaser Belt H
        [63492] = {"i63492suf-233","i63492suf-234","i63492suf-235","i63492suf-236",type=2}, -- Star Chaser Belt N
        [65378] = {"i65378suf-199","i65378suf-200","i65378suf-201","i65378suf-202",type=2}, -- Star Chaser Legs H
        [63502] = {"i63502suf-195","i63502suf-196","i63502suf-197","i63502suf-198",type=2}, -- Star Chaser Legs N
        [65367] = {"i65367suf-136","i65367suf-133","i65367suf-137","i65367suf-135",type=2}, -- Mistral Circle H
        [63488] = {"i63488suf-136","i63488suf-133","i63488suf-137","i63488suf-135",type=2}, -- Mistral Circle N
        [69884] = {"i69884suf-136","i69884suf-133","i69884suf-137","i69884suf-135",type=2}, -- Mistral Drape H
        [69831] = {"i69831suf-136","i69831suf-133","i69831suf-137","i69831suf-135",type=2}, -- Mistral Drape N
        [69880] = {"i69880suf-136","i69880suf-133","i69880suf-137","i69880suf-135",type=2}, -- Mistral Pendant H
        [69827] = {"i69827suf-136","i69827suf-133","i69827suf-137","i69827suf-135",type=2}, -- Mistral Pendant N
        [65372] = {"i65372suf-128","i65372suf-125","i65372suf-127",type=2}, -- Permafrost Signet H
        [63489] = {"i63489suf-128","i63489suf-125","i63489suf-127",type=2}, -- Permafrost Signet N
        [69878] = {"i69878suf-128","i69878suf-125","i69878suf-127",type=2}, -- Permafrost Cape H
        [69833] = {"i69833suf-128","i69833suf-125","i69833suf-127",type=2}, -- Permafrost Cape N
        [69883] = {"i69883suf-128","i69883suf-125","i69883suf-127",type=2}, -- Permafrost Choker H
        [69828] = {"i69828suf-128","i69828suf-125","i69828suf-127",type=2}, -- Permafrost Signet N
        [65370] = {"i65370suf-207","i65370suf-208","i65370suf-209",type=2}, -- Thunder Wall Belt H
        [63491] = {"i63491suf-224","i63491suf-225","i63491suf-226",type=2}, -- Thunder Wall Belt N
        [65380] = {"i65380suf-180","i65380suf-181","i65380suf-182",type=2}, -- Thunder Wall Legs H
        [63501] = {"i63501suf-177","i63501suf-178","i63501suf-179",type=2}, -- Thunder Wall Legs N
        [65375] = {"i65375suf-229","i65375suf-230","i65375suf-231","i65375suf-232",type=2}, -- Tempest Keeper Belt H
        [63495] = {"i63495suf-212","i63495suf-213","i63495suf-214","i63495suf-215",type=2}, -- Tempest Keeper Belt N
        [65385] = {"i65385suf-191","i65385suf-192","i65385suf-193","i65385suf-194",type=2}, -- Tempest Keeper Legs H
        [63504] = {"i63504suf-185","i63504suf-186","i63504suf-187","i63504suf-188",type=2}, -- Tempest Keeper Legs N
        --- ## Baradin Hold
        --- Argaloth
        -- Non-ClassSet-Items
        ["BH_A_CLOTH"] = {60628, 60626, 60630, 0, 60635, 60637, 60636, 0, 60634, 60612, 60613, type = 9},
        ["BH_A_LEATHER"] = {60591, 60589, 60587, 0, 60594, 60586, 60593, 0, 60611, 60583, 60607, 0, 60582, 60580, 60581, type = 9},
        ["BH_A_MAIL"] = {60559, 60555, 60557, 0, 60565, 60564, 60554, 0, 60535, 60533, 60534, 0, 60569, 60536, 60567, type = 9},
        ["BH_A_PLATE"] = {60512, 60508, 60509, 0, 60523, 60521, 60513, 0, 60520, 60505, 60516, 0, 60541, 60539, 60540, type = 9},
        ["BH_A_BACK"] = {60783, 60779, 0, 60776, 60778, 0, 60786, 60788, 60787, type = 9},
        ["BH_A_NECK"] = {60669, 60668, 0, 60673, 60670, 0, 60662, 60661, 60664, type = 9},
        ["BH_A_FINGER"] = {60658, 60659, 0, 60651, 60650, 0, 60647, 60645, 60649, type = 9},
        -- trinkets alliance
        ["BH_AA_TRINKET"] = {61033, 61035, 61034, 0, 61026, 61031, 61032, 0, 60794, 60799, 60800, 0, 61047, 61045, 61046, type = 9},
        -- trinkets horde
        ["BH_AH_TRINKET"] = {61033, 61035, 61034, 0, 61026, 61031, 61032, 0, 60801, 60806, 60807, 0, 61047, 61045, 61046, type = 9},
        -- warlock
        ["BH_A_WARLOCK"] = {60248, 60250, 0, 60478, 60480, type = 9},
        -- Priest
        ["BH_A_PRIEST_H"] = {60275, 60261, 0, 60468, 60470, type = 9},
        ["BH_A_PRIEST_D"] = {60257, 60255, 0, 60476, 60475, type = 9},
        -- Rogue
        ["BH_A_ROGUE"] = {60298, 60300, 0, 60459, 60461, type = 9},
        -- Hunter
        ["BH_A_HUNTER"] = {60307, 60305, 0, 60424, 60426, type = 9},
        -- Warrior
        ["BH_A_WARRIOR_D"] = {60326, 60324, 0, 60419, 60421, type = 9},
        ["BH_A_WARRIOR_T"] = {60332, 60330, type = 9},
        -- Deathknight
        ["BH_A_DEATHKNIGHT_D"] = {60340, 60342, 0, 60409, 60411, type = 9},
        ["BH_A_DEATHKNIGHT_T"] = {60350, 60352, type = 9},
        -- Mage
        ["BH_A_MAGE"] = {60247, 60245, 0, 60463, 60465, type = 9},
        -- Druid
        ["BH_A_DRUID_DR"] = {60285, 60283, 0, 60453, 60455, type = 9},
        ["BH_A_DRUID_D"] = {60290, 60288, 0, 60443, 60445, type = 9},
        ["BH_A_DRUID_H"] = {60280, 60278, 0, 60448, 60450, type = 9},
        -- Shaman
        ["BH_A_SHAMAN_DR"] = {60314, 60316, 0, 60439, 60441, type = 9},
        ["BH_A_SHAMAN_D"] = {60319, 60321, 0, 60434, 60436, type = 9},
        ["BH_A_SHAMAN_H"] = {60312, 60310, 0, 60429, 60431, type = 9},
        -- Paladin
        ["BH_A_PALADIN_H"] = {60363, 60361, 0, 60602, 60604, type = 9},
        ["BH_A_PALADIN_D"] = {60345, 60347, 0, 60414, 60416, type = 9},
        ["BH_A_PALADIN_T"] = {60355, 60357, type = 9},

        --- Occu'thar
        -- Non-ClassSet-Items
        ["BH_O_CLOTH"] = {70363, 70362, 70364, 0, 70366, 70368, 70367, 0, 70365, 70360, 70361, type = 9},
        ["BH_O_LEATHER"] = {70350, 70349, 70348, 0, 70352, 70347, 70351, 0, 70359, 70346, 70358, 0, 70345, 70343, 70344, type = 9},
        ["BH_O_MAIL"] = {70338, 70336, 70337, 0, 70340, 70339, 70335, 0, 70330, 70328, 70329, 0, 70342, 70331, 70341, type = 9},
        ["BH_O_PLATE"] = {70327, 70320, 70321, 0, 70322, 70326, 70323, 0, 70325, 70319, 70324, 0, 70334, 70332, 70333, type = 9},
        ["BH_O_BACK"] = {70386, 70385, 0, 70383, 70384, 0, 70387, 70389, 70388, type = 9},
        ["BH_O_NECK"] = {70380, 70379, 0, 70382, 70381, 0, 70377, 70376, 70378, type = 9},
        ["BH_O_FINGER"] = { 70374, 70375, 0, 70373, 70372, 0, 70370, 70369, 70371,type = 9},
        -- trinkets alliance
        ["BH_OA_TRINKET"] = {70399, 70401, 70400, 0, 70396, 70397, 70398, 0, 70390, 70391, 70392, 0, 70404, 70402, 70403, type = 9},
        -- trinkets horde
        ["BH_OH_TRINKET"] = {70399, 70401, 70400, 0, 70396, 70397, 70398, 0, 70393, 70394, 70395, 0, 70404, 70402, 70403, type = 9},
        -- warlock
        ["BH_O_WARLOCK"] = {71281, 71283, 0, 70314, 70316, type = 9},
        -- Priest
        ["BH_O_PRIEST_H"] = {71271, 71273, 0, 70304, 70306, type = 9},
        ["BH_O_PRIEST_D"] = {71276, 71278, 0, 70309, 70311, type = 9},
        -- Rogue
        ["BH_O_ROGUE"] = {71046, 71048, 0, 70301, 70297, type = 9},
        -- Hunter
        ["BH_O_HUNTER"] = {71050, 71052, 0, 70260, 70262, type = 9},
        -- Warrior
        ["BH_O_WARRIOR_D"] = {71069, 71071, 0, 70255, 70257, type = 9},
        ["BH_O_WARRIOR_T"] = {70943, 70942, type = 9},
        -- Deathknight
        ["BH_O_DEATHKNIGHT_D"] = {71059, 71061, 0, 70245, 70247, type = 9},
        ["BH_O_DEATHKNIGHT_T"] = {70953, 70952, type = 9},
        -- Mage
        ["BH_O_MAGE"] = {71286, 71288, 0, 70299, 70301, type = 9},
        -- Druid
        ["BH_O_DRUID_DR"] = {71107, 71109, 0, 70289, 70291, type = 9},
        ["BH_O_DRUID_D"] = {71097, 71099, 0, 70279, 70281, type = 9},
        ["BH_O_DRUID_H"] = {71102, 71104, 0, 70284, 70286, type = 9},
        -- Shaman
        ["BH_O_SHAMAN_DR"] = {71292, 71294, 0, 70275, 70277, type = 9},
        ["BH_O_SHAMAN_D"] = {71302, 71304, 0, 70270, 70272, type = 9},
        ["BH_O_SHAMAN_H"] = {71297, 71299, 0, 70265, 70267, type = 9},
        -- Paladin
        ["BH_O_PALADIN_H"] = {71092, 71094, 0, 70354, 70356, type = 9},
        ["BH_O_PALADIN_D"] = {71064, 71066, 0, 70250, 70252, type = 9},
        ["BH_O_PALADIN_T"] = {70949, 70947, type = 9},

        --- Alizabal, Mistress of Hate
        -- Non-ClassSet-Items
        ["BH_AL_CLOTH"] = {73633, 73638, 73635, 0, 73631, 73637, 73634, 0, 73632, 73639, 73636, type = 9},
        ["BH_AL_LEATHER"] = {73528, 73532, 73531, 0, 73529, 73533, 73530, 0, 73600, 73602, 73601, 0, 73608, 73610, 73609, type = 9},
        ["BH_AL_MAIL"] = {73586, 73590, 73587, 0, 73585, 73589, 73588, 0, 73518, 73522, 73520, 0, 73519, 73507, 73677, type = 9},
        ["BH_AL_PLATE"] = {73550, 73555, 73553, 0, 73551, 73554, 73552, 0, 73562, 73566, 73564, 0, 73561, 73565, 73563,  type = 9},
        ["BH_AL_BACK"] = {73647, 73646, 0, 73495, 73494, 0, 73629, 73628, 73630, type = 9},
        ["BH_AL_NECK"] = {73645, 73644, 0, 73492, 73493, 0, 73627, 73626, 73625, type = 9},
        ["BH_AL_FINGER"] = { 73640, 73641, 0, 73488, 73489, 0, 73622, 73623, 73621, type = 9},
        -- trinkets alliance
        ["BH_ALA_TRINKET"] = {73648, 73498, 73496, 0, 73593, 73591, 73592, 0, 73539, 73535, 73536, 0, 73643, 73497, 73491, type = 9},
        -- trinkets horde
        ["BH_ALH_TRINKET"] = {73648, 73498, 73496, 0, 73593, 73591, 73592, 0, 73538, 73534, 73537, 0, 73643, 73497, 73491, type = 9},
        -- warlock
        ["BH_AL_WARLOCK"] = {76343, 76341, 0, 73487, 73485, type = 9},
        -- Priest
        ["BH_AL_PRIEST_H"] = {76357, 76359, 0, 73549, 73547, type = 9},
        ["BH_AL_PRIEST_D"] = {76348, 76346, 0, 73544, 73542, type = 9},
        -- Rogue
        ["BH_AL_ROGUE"] = {77024, 77026, 0, 73526, 73524, type = 9},
        -- Hunter
        ["BH_AL_HUNTER"] = {77029, 77031, 0, 73583, 73581, type = 9},
        -- Warrior
        ["BH_AL_WARRIOR_D"] = {76985, 76986, 0, 73481, 73479, type = 9},
        ["BH_AL_WARRIOR_T"] = {76989, 76991, type = 9},
        -- Deathknight
        ["BH_AL_DEATHKNIGHT_D"] = {76975, 76977, 0, 73619, 73617, type = 9},
        ["BH_AL_DEATHKNIGHT_T"] = {77009, 77011, type = 9},
        -- Mage
        ["BH_AL_MAGE"] = {76212, 76214, 0, 73576, 73574, type = 9},
        -- Druid
        ["BH_AL_DRUID_DR"] = {77018, 77020, 0, 73599, 73597, type = 9},
        ["BH_AL_DRUID_D"] = {77014, 77016, 0, 73615, 73613, type = 9},
        ["BH_AL_DRUID_H"] = {76749, 76751, 0, 73607, 73605, type = 9},
        -- Shaman
        ["BH_AL_SHAMAN_DR"] = {77038, 77036, 0, 73505, 73503, type = 9},
        ["BH_AL_SHAMAN_D"] = {77041, 77043, 0, 73511, 73509, type = 9},
        ["BH_AL_SHAMAN_H"] = {76757, 76759, 0, 73516, 73514, type = 9},
        -- Paladin
        ["BH_AL_PALADIN_H"] = {76766, 76768, 0, 73559, 73557, type = 9},
        ["BH_AL_PALADIN_D"] = {76875, 76877, 0, 73570, 73568, type = 9},
        ["BH_AL_PALADIN_T"] = {77004, 77006, type = 9},
        --- Misc
        [44951] = { { 41119, "24-40" }, type = 11 },
        [74034] = { {74034, 12}, 0, 74035, type = 3 }, -- Pit Fighter
        --- Darkmoon Faire Achievements
        ["AC_DarkmoonFaire"] = {"ac6019", "ac6020", "ac6021", "ac6022", "ac6023", "ac6024", "ac6025", "ac6026", "ac6027", "ac6028", "ac6029", "ac6030", "ac6031", "ac6032", type = 10},
        --- Protocol Inferno Satchels
        [232947] = {"i69879suf-121","i69879suf-122","i69879suf-120","i69879suf-118",type=2}, -- Satchel of the Cloudburst Cloak
        [232968] = {"i65378suf-199","i65378suf-200","i65378suf-201","i65378suf-202",type=2}, -- Satchel of the Star Chaser Legguards
        [232953] = {"i65386suf-191","i65386suf-192","i65386suf-193","i65386suf-194",type=2}, -- Satchel of the Lightning Well Legguards
        [232969] = {"i65375suf-229","i65375suf-230","i65375suf-231","i65375suf-232",type=2}, -- Satchel of the Tempest Keeper Belt
        [232954] = {"i65367suf-136","i65367suf-133","i65367suf-137","i65367suf-135",type=2}, -- Satchel of the Mistral Circle
        [232955] = {"i69884suf-136","i69884suf-133","i69884suf-137","i69884suf-135",type=2}, -- Satchel of the Mistral Drape
        [232952] = {"i65377suf-229","i65377suf-230","i65377suf-231","i65377suf-232",type=2}, -- Satchel of the Lightning Well Belt
        [232963] = {"i65369suf-220","i65369suf-221","i65369suf-222","i65369suf-223",type=2}, -- Satchel of the Sky Strider Belt
        [232973] = {"i65371suf-216","i65371suf-217","i65371suf-218","i65371suf-219",type=2}, -- Satchel of the Wind Stalker Belt
        [232964] = {"i65379suf-173","i65379suf-174","i65379suf-175","i65379suf-176",type=2}, -- Satchel of the Sky Strider Greaves
        [232965] = {"i65376suf-229","i65376suf-230","i65376suf-231","i65376suf-232",type=2}, -- Satchel of the Soul Breath Belt
        [232948] = {"i69885suf-121","i69885suf-122","i69885suf-120","i69885suf-118",type=2}, -- Satchel of the Cloudburst Necklace
        [232971] = {"i65370suf-207","i65370suf-208","i65370suf-209",type=2}, -- Satchel of the Thunder Wall Belt
        [232966] = {"i65383suf-189","i65383suf-190","i65383suf-191","i65383suf-192","i65383suf-193","i65383suf-194",type=2}, -- Satchel of the Soul Breath Leggings
        [232970] = {"i65385suf-191","i65385suf-192","i65385suf-193","i65385suf-194",type=2}, -- Satchel of the Tempest Keeper Leggings
        [232958] = {"i69883suf-128","i69883suf-125","i69883suf-127",type=2}, -- Satchel of the Permafrost Choker
        [232972] = {"i65380suf-180","i65380suf-181","i65380suf-182",type=2}, -- Satchel of the Thunder Wall Greaves
        [232949] = {"i65382suf-121","i65382suf-122","i65382suf-120","i65382suf-118",type=2}, -- Satchel of the Cloudburst Ring
        [232974] = {"i65381suf-199","i65381suf-200","i65381suf-201","i65381suf-202",type=2}, -- Satchel of the Wind Stalker Leggings
        [232967] = {"i65368suf-216","i65368suf-217","i65368suf-218","i65368suf-219",type=2}, -- Satchel of the Star Chaser Belt
        [232961] = {"i65373suf-131","i65373suf-129","i65373suf-114","i65373suf-130","i65373suf-138","i65373suf-132",type=2}, -- Satchel of the Planetary Band
        [232962] = {"i69881suf-131","i69881suf-129","i69881suf-114","i69881suf-130","i69881suf-138","i69881suf-132",type=2},  -- Satchel of the Planetary Drape
        [232951] = {"i65384suf-191","i65384suf-192","i65384suf-193","i65384suf-194",type=2}, -- Satchel of the Gale Rouser Leggings
        [232956] = {"i69880suf-136","i69880suf-133","i69880suf-137","i69880suf-135",type=2}, -- Satchel of the Mistral Pendant
        [232950] = {"i65374suf-229","i65374suf-230","i65374suf-231","i65374suf-232",type=2}, -- Satchel of the Gale Rouser Belt
        [232957] = {"i69878suf-128","i69878suf-125","i69878suf-127",type=2}, -- Satchel of the Permafrost Cape
        [232959] = {"i65372suf-128","i65372suf-125","i65372suf-127",type=2}, -- Satchel of the Permafrost Signet
        [232960] = {"i69882suf-131","i69882suf-129","i69882suf-114","i69882suf-130","i69882suf-138","i69882suf-132",type=2}, -- Satchel of the Planetary Amulet
        --- Firelands random enchantment items
        [71421] = {"i71421suf-260","i71421suf-261","i71421suf-262","i71421suf-263","i71421suf-264","i71421suf-271",type=2}, -- Flickering Cowl H
        [71011] = {"i71011suf-265","i71011suf-266","i71011suf-267","i71011suf-268","i71011suf-269","i71011suf-270",type=2}, -- Flickering Cowl N
        [71458] = {"i71458suf-275","i71458suf-276","i71458suf-277",type=2}, -- Flickering Handguards H
        [70917] = {"i70917suf-272","i70917suf-273","i70917suf-274",type=2}, -- Flickering Handguards N
        [71450] = {"i71450suf-284","i71450suf-285","i71450suf-286","i71450suf-287",type=2}, -- Flickering Shoulderpads H
        [71025] = {"i71025suf-280","i71025suf-281","i71025suf-282","i71025suf-283",type=2}, -- Flickering Shoulderpads N
        [71403] = {"i71403suf-292","i71403suf-293","i71403suf-294","i71403suf-295",type=2}, -- Flickering Shoulders H
        [71030] = {"i71030suf-288","i71030suf-289","i71030suf-290","i71030suf-291",type=2}, -- Flickering Shoulders N
        [71428] = {"i71428suf-133","i71428suf-135","i71428suf-136","i71428suf-137",type=2}, -- Flickering Wristbands H
        [70735] = {"i70735suf-133","i70735suf-135","i70735suf-136","i70735suf-137",type=2}, -- Flickering Wristbands N
        -- Elemental Rune Twilight
        [239111] = {"i71421suf-260","i71421suf-261","i71421suf-262","i71421suf-263","i71421suf-264","i71421suf-271",type=2}, -- Satchel of the Flickering Cowl
        [239112] = {"i71403suf-292","i71403suf-293","i71403suf-294","i71403suf-295",type=2}, -- Satchel of the Flickering Shoulders
        [239113] = {"i71428suf-133","i71428suf-135","i71428suf-136","i71428suf-137",type=2}, -- Satchel of the Flickering Wristbands
        [239114] = {"i71458suf-275","i71458suf-276","i71458suf-277",type=2}, -- Satchel of the Flickering Handguards
        [239220] = {"i71450suf-284","i71450suf-285","i71450suf-286","i71450suf-287",type=2}, -- Satchel of the Flickering Shoulderpads
        ["Tier13ElementalRuneTokens"] = {
            78869, 78870, 78868, 0,
            78875, 78876, 78874, 0,
            78863, 78864, 78862, 0,
            78866, 78867, 78865, 0,
            78872, 78873, 78871, 0,
            type = 9
        },
    }
end

local function Init()
    local coloredClassNames = AtlasLoot:GetColoredClassNames()

    for k, v in pairs(TOKEN) do
        if TOKEN[v] then
            TOKEN[k] = TOKEN[v]
        end
    end

    for className, cClassName in pairs(coloredClassNames) do
        TOKEN_TYPE_TEXT[className] = format(TOKEN_FORMAT_STRING, cClassName)
    end
end
AtlasLoot:AddInitFunc(Init)

function Token.IsToken(itemID)
    return TOKEN[itemID or 0] and true or false
end

function Token.GetTokenData(itemID)
    return TOKEN[itemID or 0] and TOKEN[itemID or 0] or nil
end

function Token.GetTokenDescription(itemID)
    return ( itemID and TOKEN[itemID] ) and TOKEN_TYPE_TEXT[TOKEN[itemID].type or TOKEN_TYPE_DEFAULT] or nil
end

function Token.GetTokenType(itemID)
    return ( itemID and TOKEN[itemID] ) and (TOKEN[itemID].type or TOKEN_TYPE_DEFAULT) or nil
end

function Token.TokenTypeAddDescription(itemID)
    return ( itemID and TOKEN[itemID] ) and TOKEN_TYPE_ADD_ITEM_DESCRIPTION[TOKEN[itemID].type or TOKEN_TYPE_DEFAULT] or false
end

function Token.GetTokenDummyNumberRange()
    return TOKE_NUMBER_RANGE
end

-- "DRUID", "HUNTER", "MAGE", "PALADIN", "PRIEST", "ROGUE", "SHAMAN", "WARLOCK", "WARRIOR", "DEATHKNIGHT"
-- AtlasLoot.Data.Token.GetClassItemsForToken(45654, "WARRIOR")
function Token.GetClassItemsForToken(tokenItemID, className)
    if not tokenItemID or not TOKEN[tokenItemID] then return end
    if not className or not ICONS[className] then return end

    local classTokens = {}
    local isClassToken = false
    for i, token in ipairs(TOKEN[tokenItemID]) do
        if isClassToken then
            if token == 0 then
                break
            else
                classTokens[#classTokens+1] = token
            end
        elseif token == ICONS[className] then
            isClassToken = true
        end
    end

    return #classTokens > 0 and classTokens or nil
end

-- TOKEN_TYPE_ADD_ITEM_DESCRIPTION
--@debug@
function Token.GetFullTokenTable()
    return TOKEN
end
--@end-debug@
