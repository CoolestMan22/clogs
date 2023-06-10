local PANEL = {}
print("Creating panel")
white_ish = Color(200, 200, 200)
less_white = Color(100, 100, 100)
discordDarkGrey = Color(32, 34, 37)
discordMidGrey = Color(47, 49, 54)
discordOfflineGrey = Color(116, 127, 141)
discordContrastGrey = Color(34, 35, 39)
discordGreen = Color(67, 181, 129)
blue = Color(67, 173, 181)
reddish = Color(168, 77, 77)
discordInsideGrey = Color(52, 55, 60)

surface.CreateFont("titleFont", {
    font = "Roboto",
    size = 28,
    weight = 500,
    antialias = true
})

surface.CreateFont("categoryFont", {
    font = "Roboto",
    size = 20,
    weight = 500,
    antialias = true
})

clogs.logtypes = {
    "Connections";
    "Chat";
    "Commands";
    "Kills/Deaths";
    "Arrest";
    "Money";
    "Props";
    "Warrants";
    "Wanted";
}

local LogCount = #clogs.logtypes

local leftArrow = Material("materials/left_arrow.png", "smooth")
local rightArrow = Material("materials/right_arrow.png", "smooth")
open = 0

function PANEL:Init()
    open = open + 1

    if open > 1 then
        self:Remove()
        open = 0
    end

    panelSelf = self
    -- Side nav
    sideNav = vgui.Create("DPanel", self)

    function sideNav:Paint(w, h)
        surface.SetDrawColor(discordInsideGrey)
        surface.DrawRect(0, 0, w, h)
        --surface.SetDrawColor(less_white)
        --surface.DrawOutlinedRect(0, 0, w, h)
    end

    logList = vgui.Create("DScrollPanel", sideNav)

    for i = 1, LogCount do
        local logType = clogs.logtypes[i]
        local logButton = vgui.Create("DButton", logList)
        logButton:SetText("")
        logButton:SetSize(ScrW() * 0.7 * 0.2, 32)
        logButton:SetPos(0, (i - 1) * 32)
        logButton.logType = logType

        function logButton:Paint(w, h)
            surface.SetDrawColor(discordInsideGrey)
            surface.DrawRect(0, 0, w, h)
            surface.SetDrawColor(less_white)
            surface.DrawOutlinedRect(0, 0, w - 10, h, 1)
            draw.SimpleTextOutlined(logButton.logType, "categoryFont", w / 2, h / 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, less_white)
        end

        function logButton:DoClick()
            print("Clicked " .. logButton.logType)
        end
    end

    -- Close Button
    closeButton = vgui.Create("DButton", self)
    closeButton:SetText("")
    print("Self size: " .. self:GetWide() .. " " .. self:GetTall())
    print("Close button pos: " .. closeButton:GetPos())
    closeButton:SetZPos(32767) -- max zpos for close button :)

    function closeButton:DoClick()
        print("Clicked")
        panelSelf:Remove()
    end

    function closeButton:Paint(w, h)
        surface.SetDrawColor(reddish)
        surface.DrawRect(0, 0, w, h)
    end
end

function PANEL:Paint(w, h, s)
    surface.SetDrawColor(discordDarkGrey)
    surface.DrawRect(0, 0, w, h)
    surface.SetDrawColor(discordMidGrey)
    surface.DrawRect(0, 0, w, 45)
    draw.SimpleTextOutlined("cLogs", "titleFont", 10, 45 - (32 + 5), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, less_white)
end

function PANEL:PerformLayout(w, h)
    self:SetSize(ScrW() * 0.7, ScrH() * 0.7)
    self:Center()
    self:MakePopup()
    closeButton:SetSize(32, 32)
    closeButton:SetPos(ScrW() * 0.7 - 48, 45 - (32 + 5))
    sideNav:SetSize(ScrW() * 0.7 * 0.2, ScrH() * 0.7 - 45)
    sideNav:SetPos(0, 45)
    logList:SetSize(sideNav:GetWide() - 10, sideNav:GetTall() - 10)
    logList:SetPos(5, 5)
end

function PANEL:Think()
end

vgui.Register("clogs_Menu_Main", PANEL, "EditablePanel")