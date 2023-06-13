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
    weight = 350,
    antialias = false
})

surface.CreateFont("logTitleFont", {
    font = "Roboto",
    size = 20,
    weight = 250,
    antialias = true
})

logtypes = {"All", "Connections", "Chat", "Commands", "Kills/Deaths", "Arrest", "Money", "Props", "Warrants", "Wanted"}

open = 0

function PANEL:Init()
    selectedButton = "All"
    open = open + 1

    if open > 1 then
        self:Remove()
        open = 0
    end

    panelSelf = self
    -- Side nav
    sideNav = vgui.Create("DPanel", self)

    function sideNav:Paint(w, h)
        draw.RoundedBoxEx(10, 0, 0, w, h, discordInsideGrey, false, false, true, true)
        --surface.SetDrawColor(less_white)
        --surface.DrawOutlinedRect(0, 0, w, h)
    end

    logList = vgui.Create("DScrollPanel", sideNav)

    for k, v in ipairs(logtypes) do
        logButton = vgui.Create("DButton", logList)
        logButton:SetText("")
        logButton:SetSize(ScrW() * 0.7 * 0.2, 32)
        logButton:Dock(TOP)

        if k == 1 then
            logButton:DockMargin(0, 0, 0, 0)
        end

        logButton:DockMargin(0, 10, 0, 0)
        outlineWidth = 0

        function logButton:Paint(w, h)
            if selectedButton ~= v then
                --print("Not selected")
                surface.SetDrawColor(discordInsideGrey)
                surface.DrawRect(0, 0, w, h)
                outlineWidth = 2
            else
                --print("Selected")
                surface.SetDrawColor(discordOfflineGrey)
                surface.DrawRect(1, 1, w - 2, h - 2)
                outlineWidth = 1
            end

            surface.SetDrawColor(less_white)
            surface.DrawOutlinedRect(0, 0, w, h, outlineWidth)
            draw.SimpleText(v, "categoryFont", w / 2, h / 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

        function logButton:DoClick()
            --print("Previously selected button: " .. selectedButton .. " (" .. k .. ")")
            selectedButton = v
            --print("Currently selected button: " .. selectedButton .. " (" .. k .. ")")
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

local line = "|"
local _, height = surface.GetTextSize(line)

function PANEL:Paint(w, h, s)
    draw.RoundedBoxEx(8, 0, 0, w, h, discordContrastGrey, true, true, true, true)
    draw.RoundedBoxEx(10, 0, 0, w, 45, discordMidGrey, true, true, false, false)
    surface.SetDrawColor(Color(10, 139, 199, 203))
    surface.DrawRect(ScrW() * 0.7 * 0.2, 45, w - ScrW() * 0.7 * 0.2, 25)
    draw.SimpleText("Time", "logTitleFont", ScrW() * 0.7 * 0.2 + 5, 45 + 12.5, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    draw.SimpleText("Log Info", "logTitleFont", ScrW() * 0.7 * 0.2 + 5 + 90, 45 + 12.5, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    draw.SimpleText("|", "logTitleFont", ScrW() * 0.7 * 0.2 + 5 + 74, 45 + 12.5 - height / 2.8, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    draw.SimpleTextOutlined("cLogs", "titleFont", 10, 45 - (32 + 5), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, less_white)

    for i = 1, math.floor(self:GetTall() / height + 20) do
        --print(self:GetTall() / height + 25 .. " | " .. self:GetTall() - 80) -- Never to be used again
        --print(676 / 62) -- Why did I even need this
        draw.SimpleText(line, "logTitleFont", ScrW() * 0.7 * 0.2 + 5 + 74, 45 + (i * 12.5), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end
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

function PANEL:OnRemove()
    open = 0
end

vgui.Register("clogs_Menu_Main", PANEL, "EditablePanel")