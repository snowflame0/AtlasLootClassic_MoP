local _G = getfenv(0)
-- lua
local tonumber, type = tonumber, type
local str_match, str_format = string.match, string.format
-- WoW
local GetCurrencyInfo, GetItemQualityColor, GetCurrencyLink = C_CurrencyInfo.GetCurrencyInfo, C_Item.GetItemQualityColor, GetCurrencyLink

local AtlasLoot = _G.AtlasLoot
local Currency = AtlasLoot.Button:AddType("Currency", "c")
local AL = AtlasLoot.Locales
local ClickHandler = AtlasLoot.ClickHandler
local GetAlTooltip = AtlasLoot.Tooltip.GetTooltip

local CurrencyClickHandler = nil

local QUALITY_COLORS = {}
local DUMMY_ITEM_ICON = "Interface\\Icons\\INV_Misc_QuestionMark"

ClickHandler:Add(
	"Currency",
	{
		ChatLink = { "LeftButton", "Shift" },
		WoWHeadLink = { "RightButton", "Shift" },

		types = {
			ChatLink = true,
			WoWHeadLink = true,
		},
	},
	{
		{ "ChatLink", 	AL["Chat Link"], 	AL["Add item into chat"] },
		{ "WoWHeadLink", 	AL["Show WowHead link"], 	AL["Shows a copyable link for WoWHead"] },
	}
)

local function OnInit()
    if not CurrencyClickHandler then
		CurrencyClickHandler = ClickHandler:GetHandler("Currency")
        -- create quality colors
        for i=0,7 do
            local _, _, _, itemQuality = GetItemQualityColor(i)
            QUALITY_COLORS[i] = "|c"..itemQuality
        end
    end
    Currency.CurrencyClickHandler = CurrencyClickHandler
end
AtlasLoot:AddInitFunc(OnInit)


function Currency.OnSet(button, second)
	if not button then return end

	if second and button.__atlaslootinfo.secType then
		button.secButton.CurrencyID = button.__atlaslootinfo.secType[2]
        Currency.Refresh(button.secButton)
	else
		button.CurrencyID = button.__atlaslootinfo.type[2]
		Currency.Refresh(button)
	end
end

function Currency.OnMouseAction(button, mouseButton)
	if not mouseButton then return end
	mouseButton = CurrencyClickHandler:Get(mouseButton)
	if mouseButton == "WoWHeadLink" then
		AtlasLoot.Button:OpenWoWHeadLink(button, "currency", button.CurrencyID)
    elseif mouseButton == "ChatLink" then
        AtlasLoot.Button:AddChatLink(GetCurrencyLink(button.CurrencyID, 1) or ("currency:"..button.CurrencyID))
	end
end

function Currency.OnEnter(button, owner)
	if not button.CurrencyID then return end
	local tooltip = GetAlTooltip()
	tooltip:ClearLines()
	if owner and type(owner) == "table" then
		tooltip:SetOwner(owner[1], owner[2], owner[3], owner[4])
	else
		tooltip:SetOwner(button, "ANCHOR_RIGHT", -(button:GetWidth() * 0.5), 5)
	end
	if C_CurrencyInfo.GetCurrencyInfo(button.CurrencyID) then
		tooltip:SetHyperlink(GetCurrencyLink(button.CurrencyID, 1))
		tooltip:Show()
	end
end

function Currency.OnLeave(button)
	GetAlTooltip():Hide()
end

function Currency.OnClear(button)
	button.CurrencyID = nil
	button.secButton.CurrencyID = nil

	if button.icon then
		button.icon:SetDesaturated(false)
	end
	button.secButton.icon:SetDesaturated(false)
end

function Currency.GetStringContent(str)
	return tonumber(str)
end

function Currency.Refresh(button)
	if not button.CurrencyID then return end

    -- Maybe add current/max currency display
	local currencyName, currencyTexture, currencyQuality
    local currencyInfo = GetCurrencyInfo(button.CurrencyID)
	-- Deal with currency not existing on client
	if not currencyInfo then
		currencyName, currencyTexture, currencyQuality = "", DUMMY_ITEM_ICON, 1
	else
		currencyName, currencyTexture, currencyQuality = currencyInfo.name, currencyInfo.iconFileID, currencyInfo.quality
	end

	button.RawName = currencyName

	button.overlay:Show()
	button.overlay:SetQualityBorder(currencyQuality)

	if button.type == "secButton" then
		button:SetTexture(currencyTexture)
	else
		-- ##################
		-- name
		-- ##################
		button.name:SetText(QUALITY_COLORS[currencyQuality or 0] .. currencyName)

		-- ##################
		-- icon
		-- ##################
		button.icon:SetTexture(currencyTexture)
	end

	return true
end

function Currency.ShowToolTipFrame(button)

end
