local ALName, ALPrivate = ...

local _G = getfenv(0)
local AtlasLoot = _G.AtlasLoot
local Addons = AtlasLoot.Addons
local AL = AtlasLoot.Locales
local News = Addons:RegisterNewAddon("News")

local LibSharedMedia = LibStub("LibSharedMedia-3.0")

function News.Init()
    AtlasLoot.SlashCommands:Add("news", News.Open, "/al news - News")
end
AtlasLoot:AddInitFunc(News.Init)


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

local function FrameOnShow(self)

end

local function News_LinkOnClick(self)
    -- TODO FIX
    News.GUI.linkButton:HighlightText()
end

local function News_HideCheckboxOnClick(self)
    -- TODO ADD FUNCTIONALITY
end

function News:Open()
    if not News.GUI then
        local frameName = "AtlasLoot_News-Frame"

        local frame = CreateFrame("Frame", frameName, UIParent, _G.BackdropTemplateMixin and "BackdropTemplate" or nil)
        frame:ClearAllPoints()
        frame:SetPoint("CENTER")
        frame:SetSize(400,300)
        frame:SetMovable(true)
        frame:EnableMouse(true)
        frame:RegisterForDrag("LeftButton")
        frame:RegisterForDrag("LeftButton", "RightButton")
        frame:SetScript("OnMouseDown", FrameOnDragStart)
        frame:SetScript("OnMouseUp", FrameOnDragStop)
        frame:SetScript("OnShow", FrameOnShow)
        frame:SetToplevel(true)
        frame:SetClampedToScreen(true)
        frame:SetBackdrop(ALPrivate.BOX_BACKDROP)
        frame:SetBackdropColor(0.45, 0.45, 0.45, 1)
        frame:SetScale(1)
        frame:Hide()
        --tinsert(UISpecialFrames, frameName)	-- allow ESC close

        frame.CloseButton = CreateFrame("Button", frameName.."-CloseButton", frame, "UIPanelCloseButton")
        frame.CloseButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 3, 2)

        frame.titleFrame = AtlasLoot.GUI.CreateTextWithBg(frame, 0, 0)
        frame.titleFrame:SetPoint("TOPLEFT", frame, 5, -5)
        frame.titleFrame:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -27, -23)
        frame.titleFrame:SetBackdropColor(0.05, 0.05, 0.05, 1)
        frame.titleFrame:SetFont(LibSharedMedia:Fetch("font", "Friz Quadrata TT"), 12)
        frame.titleFrame.text:SetText(AL["AtlasLoot"].." "..C_AddOns.GetAddOnMetadata(ALName, "Version").." - "..AL["News"])
        frame.titleFrame.text:SetTextColor(1, 1, 1, 1)

        frame.content = CreateFrame("Frame", nil, frame)
        frame.content:SetPoint("TOPLEFT", frame.titleFrame, "BOTTOMLEFT", 0, -5)
        frame.content:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -5, 5)

        local scrollFrame = CreateFrame("ScrollFrame", frameName.."-scroll", frame.content)
        scrollFrame:EnableMouse(true)
        scrollFrame:EnableMouseWheel(true)
        scrollFrame:SetPoint("TOPLEFT", frame.titleFrame, "BOTTOMLEFT", 2, -5)
        scrollFrame:SetPoint("BOTTOMRIGHT", frame.content, "BOTTOMRIGHT", -23, 20)
        --scrollFrame:SetScript("OnMouseWheel", NewsScroll_OnMouseWheel)
        frame.content.scrollFrame = scrollFrame

        scrollFrame.editBox = CreateFrame("EditBox", nil, scrollFrame)
        scrollFrame.editBox:SetMultiLine(true)
        scrollFrame.editBox:SetAutoFocus(false)
        scrollFrame.editBox:SetPoint("TOPLEFT", scrollFrame, "TOPLEFT", 0, 0)
        scrollFrame.editBox:SetPoint("BOTTOMRIGHT", scrollFrame, "BOTTOMRIGHT", 0 ,0)
        scrollFrame.editBox:SetTextColor(1, 1, 1, 1)
        scrollFrame.editBox:SetFontObject("ChatFontNormal")
        scrollFrame.editBox:SetText("test\ntest\ntest\ntest\ntest\ntest\ntest\nmucho queso\nhellopp")
        scrollFrame.editBox:SetWidth(400)
        scrollFrame.editBox:SetHeight(300)
        scrollFrame:SetScrollChild(scrollFrame.editBox)
        --scrollFrame.editBox:Disable()
        scrollFrame.editBoxbg = scrollFrame.editBox:CreateTexture(nil, "BACKGROUND")
        scrollFrame.editBoxbg:SetAllPoints(scrollFrame.editBox)
        scrollFrame.editBoxbg:SetColorTexture(0, 0, 0, 0.5)

        scrollFrame.scrollbar = CreateFrame("Slider", frameName.."-scrollbar", scrollFrame, "UIPanelScrollBarTemplate")
        scrollFrame.scrollbar:SetPoint("TOPLEFT", scrollFrame, "TOPRIGHT", 6, -16)
        scrollFrame.scrollbar:SetPoint("BOTTOMLEFT", scrollFrame, "BOTTOMRIGHT", 6, 16)
        scrollFrame.scrollbar:SetValueStep(1)
        scrollFrame.scrollbar:SetValue(0)
        scrollFrame.scrollbar:SetWidth(16)
        scrollFrame.scrollbar.obj = scrollFrame

        scrollFrame.scrollbg = scrollFrame:CreateTexture(nil, "BACKGROUND")
        scrollFrame.scrollbg:SetAllPoints(scrollFrame.scrollbar)
        scrollFrame.scrollbg:SetColorTexture(0, 0, 0, 0.5)

        frame.content.option = AtlasLoot.GUI.CreateCheckBox()
        frame.content.option:SetParPoint("TOPLEFT", frame.content.scrollFrame, "BOTTOMRIGHT", -175, 0)
        frame.content.option:SetText(AL["Don't show again for this version."])
        frame.content.option:SetOnClickFunc(News_HideCheckboxOnClick)
        frame.content.option:SetChecked(AtlasLoot:GetDb().activeList[2])

        frame.linkButton = CreateFrame("EditBox", nil, frame.content)
        frame.linkButton:SetWidth(160)
        frame.linkButton:SetHeight(16)
        frame.linkButton:SetAutoFocus(false)
        frame.linkButton:SetJustifyH("CENTER")
        frame.linkButton:SetPoint("TOPLEFT", scrollFrame, "BOTTOMLEFT", 0, -3)
        frame.linkButton:SetTextColor(1, 1, 1, 1)
        frame.linkButton:SetFontObject("ChatFontSmall")
        frame.linkButton:SetText("buymeacoffee.com/snowflame0")
        frame.linkButton:SetScript("OnMouseDown", News_LinkOnClick)
        frame.linkbg = frame.linkButton:CreateTexture(nil, "BACKGROUND")
        frame.linkbg:SetAllPoints(frame.linkButton)
        frame.linkbg:SetColorTexture(0, 0, 0, 0.5)

        News.GUI = frame
    elseif News.GUI:IsShown() then
        News.GUI:Hide()
        return
    end

    News.GUI:Show()
end
