print("Derma Maker Loaded")
local curate = 0
local frames = nil
local selected = {}
local selected2 = {}

function NumSlider(frame,text,f2,min,max,func)
    local Scratch = vgui.Create( "DNumberScratch", f2 )
    Scratch:Dock(LEFT)
    Scratch:SetText( text )
    Scratch:SetValue( 5 )
    Scratch:SetMin( min )
    Scratch:SetMax( max )
    Scratch.OnValueChanged = function( self, value )
        print(value)
        func(value)
    end
    return Scratch
end

function SelectMenu(name,frame,f2)
    if name == "DFrame" then
        selected2[#selected2 + 1] = NumSlider(frame,"Width",f2,0,800,function(value) frame:SetWidth(value) end)
    end
end

local function DFrameMaker(name,main_Frame,f3,f2)
        if curate >= CurTime() then return end
        curate = CurTime() + 1
        
    if name == "DFrame" then
        if IsValid(frames) then 
            frames:Remove() 
            for k,v in pairs(selected) do v:Remove() end
        end
        frames = vgui.Create("DFrame",main_Frame)
        frames:SetSize(600,400)
        frames:SetPos(0,0)
        frames:SetTitle("DermaMaker")
        
        local buttonz = vgui.Create("DButton",f3)
        buttonz:Dock(TOP)
        buttonz:SetHeight(25)
        buttonz:SetText("DFrame")
        buttonz.DoClick = function(s)
            for k,v in pairs(selected2) do if IsValid(v) then v:Remove() end end
            SelectMenu("DFrame",frames,f2)
        end
        selected[#selected + 1] = buttonz
    end
    
    if name == "DButton" and IsValid(frames) then
        local button = vgui.Create("DButton",frames)
        button:Dock(TOP)
        button:SetHeight(25)
        button:SetText(name)
        button.DoClick = function(s)
        end			
        
        local buttonz = vgui.Create("DButton",f3)
        buttonz:Dock(TOP)
        buttonz:SetHeight(25)
        buttonz:SetText("DButton")
        buttonz.DoClick = function(s)
            SelectMenu("DButton",button,f2)
        end
        selected[#selected + 1] = buttonz
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
    frame1:Dock(FILL)
    frame1:SetSize(ScrW() / 2 - 500,ScrH() - 30)
    frame1:DockMargin(0,0,1000,0)
    frame1.Paint = function(s,w,h)
        draw.RoundedBox(0,0,0,w,h,Color(64,64,64,100))
    end
    frame1:InvalidateLayout(true)
    
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

    for k,v in pairs({"DFrame","DButton"}) do
        local button = vgui.Create("DButton",frame1)
        button:Dock(TOP)
        button:SetHeight(25)
        button:SetText(v)
        button.DoClick = function(s)
            DFrameMaker(v,frame,frame3,frame2)
        end
    end

   
    
end)