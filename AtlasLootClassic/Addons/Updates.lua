local ALName, ALPrivate = ...

local _G = getfenv(0)
local AtlasLoot = _G.AtlasLoot
local Addons = AtlasLoot.Addons
local AL = AtlasLoot.Locales
local Updates = Addons:RegisterNewAddon("News")

local LibSharedMedia = LibStub("LibSharedMedia-3.0")

---
--- NOTE:
--- Update Text for version 5.0.0
---
local update_version = 5.00
local update_text = {
    "Welcome to the Initial release of AtlasLootClassic |cFF33FFBDMoP|r! Lots of things are still underworks. Thanks for your patience and support :)",
    "|cFF33FFBDFactions|r, |cFF33FFBDCollections|r, and |cFF33FFBDCrafting|r modules are mostly complete",
    "|cFF33FFBDDungeons and Raids|r module missing SoO and Celestial dungeons",
    "|cFF33FFBDPvP|r module only displays sets right now",
    "Missing information will be added when I have time and I'm not busy leveling",
    "If you encounter any serious bugs, please open an issue on the GitHub (|cFF3366CCgithub.com/snowflame0/AtlasLootClassic_MoP|r) page for best chances of me seeing it",
    "Finally, if you appreciate all of the hard work, feel free to donate at the link below (click, CTRL+A, and CTRL+C to copy)"
}
local donation_link = "buymeacoffee.com/snowflame0"

function Updates.Init()
    AtlasLoot.SlashCommands:Add("news", Updates.Open, "/al news - News about latest version")
    -- Show update message if needed
    Updates:CheckUpdate()
end
AtlasLoot:AddInitFunc(Updates.Init)


--################################
-- GUI
--################################
local function FrameOnDragStart(self, arg1)
    if arg1 == "LeftButton" then
        self:StartMoving()
    end
end

local function FrameOnDragStop(self)
    self:StopMovingOrSizing()
end

local function Updates_HideCheckboxOnClick(self, value)
    -- TODO ADD FUNCTIONALITY
    AtlasLoot.dbGlobal.HideUntilUpdate = value
end

function Updates:Open()
    if not Updates.GUI then
        local frameName = "AtlasLoot_News-Frame"

        local frame = CreateFrame("Frame", frameName, UIParent, _G.BackdropTemplateMixin and "BackdropTemplate" or nil)
        frame:ClearAllPoints()
        frame:SetPoint("CENTER")
        frame:SetSize(500,400)
        frame:SetMovable(true)
        frame:EnableMouse(true)
        frame:SetToplevel(true)
        frame:SetFrameStrata("HIGH")
        frame:RegisterForDrag("LeftButton")
        frame:RegisterForDrag("LeftButton", "RightButton")
        frame:SetScript("OnMouseDown", FrameOnDragStart)
        frame:SetScript("OnMouseUp", FrameOnDragStop)
        frame:SetToplevel(true)
        frame:SetClampedToScreen(true)
        frame:SetBackdrop(ALPrivate.BOX_BACKDROP)
        frame:SetBackdropColor(0.45, 0.45, 0.45, 1)
        frame:SetScale(1)
        frame:Hide()

        frame.CloseButton = CreateFrame("Button", frameName.."-CloseButton", frame, "UIPanelCloseButton")
        frame.CloseButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 3, 2)

        frame.titleFrame = AtlasLoot.GUI.CreateTextWithBg(frame, 0, 0)
        frame.titleFrame:SetPoint("TOPLEFT", frame, 5, -5)
        frame.titleFrame:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -27, -23)
        frame.titleFrame:SetBackdropColor(0.05, 0.05, 0.05, 1)
        frame.titleFrame:SetFont(LibSharedMedia:Fetch("font", "Friz Quadrata TT"), 12)
        frame.titleFrame.text:SetText(AL["AtlasLoot"] .. " " .. "|cFF33FFBD" .. AtlasLoot.__addonversion .. "|r")
        frame.titleFrame.text:SetTextColor(1, 1, 1, 1)

        frame.content = CreateFrame("Frame", nil, frame)
        frame.content:SetPoint("TOPLEFT", frame.titleFrame, "BOTTOMLEFT", 0, -5)
        frame.content:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -5, 5)

        frame.content.editBox1 = CreateFrame("EditBox", nil, frame.content)
        frame.content.editBox1:SetMultiLine(true)
        frame.content.editBox1:SetAutoFocus(false)
        frame.content.editBox1:SetPoint("TOPLEFT", frame.content, "TOPLEFT", 5, 0)
        frame.content.editBox1:SetPoint("BOTTOMRIGHT", frame.content, "TOPRIGHT", -5 ,-50)
        frame.content.editBox1:SetTextColor(1, 1, 1, 1)
        frame.content.editBox1:SetFontObject("ChatFontNormal")
        frame.content.editBox1:SetJustifyH("CENTER")
        frame.content.editBox1:SetTextInsets(5, 0, 0, 5)
        frame.content.editBox1:Disable()
        frame.content.editBoxbg1 = frame.content.editBox1:CreateTexture(nil, "BACKGROUND")
        frame.content.editBoxbg1:SetAllPoints(frame.content.editBox1)
        frame.content.editBoxbg1:SetColorTexture(0, 0, 0, 0.5)

        frame.content.editBox2 = CreateFrame("EditBox", nil, frame.content)
        frame.content.editBox2:SetMultiLine(true)
        frame.content.editBox2:SetAutoFocus(false)
        frame.content.editBox2:SetPoint("TOPLEFT", frame.content.editBox1, "BOTTOMLEFT", 0, 0)
        frame.content.editBox2:SetPoint("BOTTOMRIGHT", frame.content, "BOTTOMRIGHT", -5 ,25)
        frame.content.editBox2:SetTextColor(1, 1, 1, 1)
        frame.content.editBox2:SetFontObject("ChatFontNormal")
        frame.content.editBox2:SetJustifyH("LEFT")
        frame.content.editBox2:SetTextInsets(5, 0, 0, 5)
        frame.content.editBox2:Disable()
        frame.content.editBoxbg2 = frame.content.editBox2:CreateTexture(nil, "BACKGROUND")
        frame.content.editBoxbg2:SetAllPoints(frame.content.editBox2)
        frame.content.editBoxbg2:SetColorTexture(0, 0, 0, 0.5)

        -- Text
        local text = ""
        if (update_text) then
            for i, v in ipairs(update_text) do
                if i ~= 1 then
                    text = text .. "|TInterface\\QUESTFRAME\\UI-Quest-BulletPoint:12:12:0:0|t " .. v .. "\n\n";
                end
            end
        end
        frame.content.editBox1:SetText("\n" .. update_text[1] .. "\n")
        frame.content.editBox2:SetText(text)

        frame.linkButton = CreateFrame("EditBox", nil, frame.content)
        frame.linkButton:SetWidth(200)
        frame.linkButton:SetHeight(20)
        frame.linkButton:SetAutoFocus(false)
        frame.linkButton:SetJustifyH("CENTER")
        frame.linkButton:SetPoint("TOPLEFT", frame.content.editBox2, "BOTTOMLEFT", 0, -3)
        frame.linkButton:SetTextColor(1, 1, 1, 1)
        frame.linkButton:SetFontObject("ChatFontNormal")
        frame.linkButton:SetText(donation_link)
        frame.linkButton:HighlightText()
        frame.linkbg = frame.linkButton:CreateTexture(nil, "BACKGROUND")
        frame.linkbg:SetAllPoints(frame.linkButton)
        frame.linkbg:SetColorTexture(0, 0, 0, 0.5)

        frame.option = AtlasLoot.GUI.CreateCheckBox()
        frame.option:SetParPoint("TOPLEFT", frame.content.editBox2, "BOTTOMRIGHT", -170, 0)
        frame.option:SetText(AL["Don't show again for this version."])
        frame.option:SetOnClickFunc(Updates_HideCheckboxOnClick)
        frame.option:SetChecked(AtlasLoot.dbGlobal.HideUntilUpdate)

        Updates.GUI = frame
    elseif Updates.GUI:IsShown() then
        Updates.GUI:Hide()
        return
    end

    Updates.GUI:Show()
end

function Updates:CheckUpdate()
    if AtlasLoot.dbGlobal.LastVersionShown then
        if AtlasLoot.dbGlobal.LastVersionShown < update_version then
            Updates:Open()
            AtlasLoot.dbGlobal.LastVersionShown = update_version
        elseif AtlasLoot.dbGlobal.LastVersionShown == update_version and not AtlasLoot.dbGlobal.HideUntilUpdate then
            Updates:Open()
        end
    else
        Updates:Open()
        AtlasLoot.dbGlobal.LastVersionShown = update_version
    end
end