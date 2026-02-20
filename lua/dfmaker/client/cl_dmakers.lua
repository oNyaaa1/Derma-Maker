print("Derma Maker Loaded")
local tbl_Frame = {}

net.Receive("SandBoxedAllowed", function()
    tbl_Frame = net.ReadTable()
end)

local function DFrameMaker(tbl,name,main_Frame)
    if name == "DFrame" then
        for k,v in pairs(tbl) do
            local frame = vgui.Create("DFrame",main_Frame)
            frame:SetSize(v.SizeW,v.SizeH)
            frame:SetPos(0,0)
            frame:SetTitle("DermaMaker")
            frame:MakePopup()
        end
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
    for k,v in pairs(tbl_Frame) do
        print(v.Main)
        local button = vgui.Create("DButton",frame1)
        button:Dock(TOP)
        button:SetHeight(25)
        button:SetText(v.Main)
        button.DoClick = function()
            DFrameMaker(tbl_Frame,v.Main,frame)
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