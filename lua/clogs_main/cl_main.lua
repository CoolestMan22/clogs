local PANEL = {}
print("Creating panel")

function PANEL:Init()
    if IsValid(frame) then
        frame:Remove()
    end

    -- Main Frame
    frame = vgui.Create("DFrame")
    frame:SetSize(ScrW() * 0.5, ScrH() * 0.5)
    frame:Center()
    frame:SetTitle(" ")
    frame:ShowCloseButton(false)
    frame:MakePopup()
    frame:DockPadding(0, 0, 0, 0)

    -- Close Button
    local closeButton = vgui.Create("DButton", frame)
    closeButton:SetText("")
    closeButton:SetSize(32, 32)
    closeButton:SetPos(panelWidth - 32 - 8, 0 + 8)
    closeButton:SetZPos(32767) -- max zpos for close button :)

    function closeButton:DoClick()
        frame:Remove()
    end

    function closeButton:Paint(w, h)
        surface.SetDrawColor(reddish)
        surface.DrawRect(0, 0, w, h)
    end
end

function PANEL:Paint(w, h, s)
    surface.SetDrawColor(0, 0, 0)
    surface.DrawRect(0, 0, w, h)
end

function PANEL:Think()
end

vgui.Register("clogs_Menu_Main", PANEL, "EditablePanel")