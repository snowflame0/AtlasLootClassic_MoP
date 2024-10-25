local AtlasLoot = _G.AtlasLoot
local GUI = AtlasLoot.GUI
local ModelFrame = {}
AtlasLoot.GUI.ModelFrame = ModelFrame
local AL = AtlasLoot.Locales

-- lua
local next = next

if not HasAlternateForm then
	function HasAlternateForm()
		return false
	end
end

-- //\\
local MAX_CREATURES_PER_ENCOUNTER = 9
local BUTTON_COUNT = 0

ModelFrame.SelectedCreature = nil
ModelFrame.creatureDisplayID = nil
local Creatures = {}
local cache = {}
local buttons = {}

local function GetButtonFromCache()
	local frame = next(cache)
	if frame then
		cache[frame] = nil
	end
	return frame
end

local function ClearButtonList()
	for i = 1, #buttons do
		local button = buttons[i]
		cache[button] = true
		button.info = nil
		button:Hide()
		buttons[i] = nil
	end
end

function ModelFrame.ButtonOnClick(self)
	if ModelFrame.SelectedCreature then
		ModelFrame.SelectedCreature:Enable()
	end

	-- Only set new model actor if it's changed or isn't already set
	if self.displayInfo and (ModelFrame.creatureDisplayID ~= self.displayInfo) then
		-- TODO: Figure out another way to get modelsceneID without having to add it to data or get from EJ
		ModelFrame.frame:SetFromModelSceneID(9, true)
		local creature = ModelFrame.frame:GetActorByTag("creature");
		if creature then
			creature:SetModelByCreatureDisplayID(self.displayInfo, true);
		end
	end

	-- Update selected creature and displayed model
	ModelFrame.creatureDisplayID = self.displayInfo;
	ModelFrame.SelectedCreature = self
	self:Disable()
end

function ModelFrame:AddButton(name, desc, displayInfo)
	local button = GetButtonFromCache()
	if not button then
		BUTTON_COUNT = BUTTON_COUNT + 1
		local frameName = "AtlasLoot-GUI-ModelFrame-Button"..BUTTON_COUNT

		button = CreateFrame("Button", frameName, ModelFrame.frame, "AtlasLootCreatureButtonTemplate")
	end
	button:Show()
	buttons[#buttons+1] = button
	button.displayInfo = displayInfo
	button.name = name
	button.description = desc
	SetPortraitTextureFromCreatureDisplayID(button.creature, displayInfo)

	if #buttons == 1 then
		button:SetPoint("TOPLEFT", ModelFrame.frame, "TOPLEFT", 0, -10)
		ModelFrame.ButtonOnClick(button)
	else
		button:SetPoint("TOPLEFT", buttons[#buttons-1], "BOTTOMLEFT")
	end

	return button
end

function ModelFrame:Create()
	if self.frame then return end
	local frameName = "AtlasLoot_GUI-ModelFrame"

	self.frame = CreateFrame("ModelScene", frameName, GUI.frame, "ModelSceneMixinTemplate")
    ModelFrame.RotateLeftButton = CreateFrame("Button", nil, self.frame, "RotateOrbitCameraLeftButtonTemplate")
    ModelFrame.RotateLeftButton:SetPoint("TOPRIGHT", self.frame, "BOTTOM", -5, 35)
    ModelFrame.RotateRightButton = CreateFrame("Button", nil, self.frame, "RotateOrbitCameraRightButtonTemplate")
    ModelFrame.RotateRightButton:SetPoint("TOPLEFT", self.frame, "BOTTOM", 5, 35)
	local frame = self.frame
	frame:ClearAllPoints()
	frame:SetParent(GUI.frame)
	frame:SetPoint("TOPLEFT", GUI.frame.contentFrame.itemBG)
	frame:SetSize(560, 450)
	frame.Refresh = ModelFrame.Refresh
	frame.Clear = ModelFrame.Clear
	frame:Hide()
	ModelFrame.creatureDisplayID = 0
end

function ModelFrame:Show()
	if not ModelFrame.frame then ModelFrame:Create() end
	if not ModelFrame.frame:IsShown() or GUI.frame.contentFrame.shownFrame ~= ModelFrame.frame then
		GUI:HideContentFrame()
		ModelFrame.frame:Show()
		GUI.frame.contentFrame.shownFrame = ModelFrame.frame
	end
	if self.DisplayIDs then
		self:SetDisplayID(self.DisplayIDs)
	else
		return GUI.ItemFrame:Show()
	end
end

function ModelFrame:Refresh()
	if not ModelFrame.frame then ModelFrame:Create() end
	ModelFrame:Show()
end

--[[
	table = {
		{displayID, "name", "info"},
	}
]]--
function ModelFrame:SetDisplayID(displayID)
	if not self.frame then ModelFrame:Create() end
	ClearButtonList()
	wipe(Creatures)
	ModelFrame.SelectedCreature = nil
	if not displayID then
		ModelFrame.frame:Hide()
		return
	end
	for k,v in ipairs(displayID) do
		ModelFrame:AddButton(v[2], v[3], v[1])
	end
end

function ModelFrame.Clear()
	ClearButtonList()
	ModelFrame.frame:ClearScene();
	ModelFrame.frame:Hide()
end
