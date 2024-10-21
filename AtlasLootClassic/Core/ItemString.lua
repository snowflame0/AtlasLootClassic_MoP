local AtlasLoot = _G.AtlasLoot
local ItemString = {}
AtlasLoot.ItemString = ItemString

-- lua
local format = string.format

local ITEM_FORMAT_STRING = "item:%d:0:0:0:0:0:%d:0:0:0:0:0:0"
local ITEM_HEIRLOOM_FORMAT_STRING = "item:%d:0:0:0:0:0:0:0:%d"


function ItemString.Create(itemID, isHeirloom, suffixID)
    suffixID = tonumber(suffixID) or 0
    if isHeirloom then
        return format( ITEM_HEIRLOOM_FORMAT_STRING,
            itemID,					-- itemID
            UnitLevel("player")		-- playerLvl
        )
    else
        return format( ITEM_FORMAT_STRING,
            itemID,					-- itemID
            suffixID				-- suffixID
        )
    end
end
