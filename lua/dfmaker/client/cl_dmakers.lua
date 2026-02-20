print("Derma Maker Loaded")
local curate = 0
local frames = nil
local selected = {}
local function DFrameMaker(name,main_Frame)
    if curate >= CurTime() then return end
    curate = CurTime() + 1
    
    if name == "DFrame"  then
        if IsValid(frames) then frames:Remove() end
        frames = vgui.Create("DFrame",main_Frame)
        frames:SetSize(600,400)
        frames:SetPos(0,0)
        frames:SetTitle("DermaMaker")
        selected[#selected + 1] = frames
    end
    if name == "DButton" and IsValid(frames) then
        local button = vgui.Create("DButton",frames)
        button:Dock(TOP)
        button:SetHeight(25)
        button:SetText(name)
        button.DoClick = function(s)
        end			
        selected[#selected + 1] = button
    end
end

concommand.Add("derma_creat0r", function(pl)
    local frame = vgui.Create("DFrame")
    frame:SetSize(ScrW(),ScrH())
    frame:SetPos(0,0)
    frame:SetTitle("DermaMaker")
    frame:MakePopup()
    frame.Paint = function(s,w,h)
        draw.RoundedBox(0,0,0,w,h,Color(0,0,0,100))
    end
    
    local frame1 = vgui.Create("DPanel",frame)
    frame1:SetSize(ScrW() / 2 - 500,ScrH() - 30)
    frame1:SetPos(0,25)
    frame1.Paint = function(s,w,h)
        draw.RoundedBox(0,0,0,w,h,Color(64,64,64,100))
    end
    
    for k,v in pairs({"DFrame","DButton"}) do
        local button = vgui.Create("DButton",frame1)
        button:Dock(TOP)
        button:SetHeight(25)
        button:SetText(v)
        button.DoClick = function(s)
            DFrameMaker(v,frame)
        end
    end

    local frame2 = vgui.Create("DPanel",frame)
    frame2:Dock(RIGHT)
    frame2:SetSize(ScrW() / 2 - 500,ScrH())
    frame2:DockMargin(0,0,0,0)
    frame2.Paint = function(s,w,h)
        draw.RoundedBox(0,0,0,w,h,Color(0,0,0,188))
    end

    local frame3 = vgui.Create("DPanel",frame2)
    frame3:Dock(RIGHT)
    frame3:SetSize(ScrW() / 2 - 500,295)
    frame3:DockMargin(0,0,0,600)
    frame3.Paint = function(s,w,h)
        draw.RoundedBox(0,0,0,w,h,Color(60,60,60,100))
    end
end)