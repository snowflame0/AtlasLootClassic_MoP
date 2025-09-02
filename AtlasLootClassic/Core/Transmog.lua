local _G = _G
local AtlasLoot = _G.AtlasLoot
local Transmog = {}
AtlasLoot.Transmog = Transmog

local Proto = {}

-- Functions
local next, pairs = _G.next, _G.pairs

-- WoW
local TransmogGetItemInfo, GetSourceInfo, PlayerHasTransmogItemModifiedAppearance  = C_TransmogCollection.GetItemInfo, C_TransmogCollection.GetSourceInfo, C_TransmogCollection.PlayerHasTransmogItemModifiedAppearance
local TRANSMOG_UPDATE_EVENT = "TRANSMOG_SOURCE_COLLECTABILITY_UPDATE"	-- sourceID, canCollect

--[[
    nil 	cannot collect
    false	can collect, not collected
    true	can collect, collected
]]
function Proto:IsItemUnlocked(itemID, sourceID, callbackFunc, callbackArg)
	if not itemID and not sourceID then return end
	local isInfoReady, canCollect
	if itemID then
		_, sourceID = TransmogGetItemInfo(itemID)
	end
	if not sourceID then return end
    -- TODO: FIX when API works
    -- canCollect seems broken in MoP Classic? Just assume that it is collectable if info exists, for now.
	local isInfoReady = GetSourceInfo(sourceID)
    canCollect = isInfoReady.isValidSourceForPlayer

	if isInfoReady then
		if canCollect then
			canCollect = PlayerHasTransmogItemModifiedAppearance(sourceID)
		else
			canCollect = nil
		end
		if callbackFunc then
			callbackFunc(callbackArg, canCollect)
		else
			return canCollect
		end
	else
		self:AddUnknownItem(sourceID, callbackFunc, callbackArg)
	end
end

function Proto:AddUnknownItem(sourceID, callbackFunc, callbackArg)
    if not next(self.itemList) then
        self.frame:RegisterEvent(TRANSMOG_UPDATE_EVENT)
    end
    self.itemList[sourceID] = { callbackFunc, callbackArg }
end

function Proto:Clear()
    self.itemList = {}
    self.frame:UnregisterEvent(TRANSMOG_UPDATE_EVENT)
end

local function OnEvent(self, event, sourceID, canCollect)
    if sourceID and self.obj.itemList[sourceID] then
        self.obj:IsItemUnlocked(nil, sourceID, self.obj.itemList[sourceID][1], self.obj.itemList[sourceID][2])
        self.obj.itemList[sourceID] = nil
    end
    if not next(self.obj.itemList) then
        self:UnregisterEvent(TRANSMOG_UPDATE_EVENT)
    end
end

function Transmog:New()
    local tab = {}

    -- Add protos
    for k,v in pairs(Proto) do
        tab[k] = v
    end

    tab.itemList = {}


    tab.frame = CreateFrame("FRAME")
    tab.frame.obj = tab
    tab.frame:SetScript("OnEvent", OnEvent)

    return tab
end
