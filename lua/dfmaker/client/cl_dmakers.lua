print("Derma Maker Loaded")
local curate = 0
local frames = nil
local selected = {}
local selected2 = {}

function NumSlider(frame,text,f2,min,max,func)
    local val = nil
    local Scratch = vgui.Create( "DNumSlider", f2 )
    Scratch:Dock(TOP)
    Scratch:SetText( text )
    Scratch:SetValue( 200 )
    Scratch:SetMin( min )
    Scratch:SetMax( max )
    Scratch.OnValueChanged = function( self, value )
        func(value)
        val = value
    end
    return Scratch
end

local curr_SizeW = 800
local curr_SizeH = 600

function SelectMenu(name,frame,f2)
    if name == "DFrame" then
        selected2[#selected2 + 1] = NumSlider(frame,"Width",f2,100,ScrW(),function(value) frame:SetWidth(value) curr_SizeW = value end)
        selected2[#selected2 + 1] = NumSlider(frame,"Height",f2,100,ScrH(),function(value) frame:SetHeight(value) curr_SizeH = value end)
    end
    
    if name == "DPanel" then
        selected2[#selected2 + 1] = NumSlider(frame,"DockMarginLeft",f2,100,ScrW(),function(value) frame:DockMargin(value,0,0,0) frame:SetWidth(curr_SizeW)  frame:SetHeight(curr_SizeH) end)
        selected2[#selected2 + 1] = NumSlider(frame,"DockMarginRight",f2,100,ScrW(),function(value) frame:DockMargin(0,0,value,0) frame:SetWidth(curr_SizeW)  frame:SetHeight(curr_SizeH) end)
        selected2[#selected2 + 1] = NumSlider(frame,"DockMarginUp",f2,100,ScrW(),function(value) frame:DockMargin(0,value,0,0) frame:SetWidth(curr_SizeW)  frame:SetHeight(curr_SizeH) end)
        selected2[#selected2 + 1] = NumSlider(frame,"DockMarginDown",f2,100,ScrW(),function(value) frame:DockMargin(0,0,0,value) frame:SetWidth(curr_SizeW)  frame:SetHeight(curr_SizeH) end)
    end
end

local function DFrameMaker(name,main_Frame,f3,f2)
        if curate >= CurTime() then return end
        curate = CurTime() + 0.2
        
    if name == "DFrame" then
        if IsValid(frames) then 
            frames:Remove() 
            for k,v in pairs(selected) do v:Remove() end
        end

        frames = vgui.Create("DFrame",main_Frame)
        frames:SetSize(600,400)
        frames:SetPos(0,0)
        frames:SetTitle("DermaMaker")
        frames:Center()
        frames.OnClose = function()
            for k,v in pairs(selected) do v:Remove() end
        end
        
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
    
    if name == "DPanel" and IsValid(frames) then
        local dpanel = vgui.Create("DPanel",frames)
        dpanel:Dock(FILL)
        

        local buttonz = vgui.Create("DButton",f3)
        buttonz:Dock(TOP)
        buttonz:SetHeight(25)
        buttonz:SetText("DPanel")
        buttonz.DoClick = function(s)
            for k,v in pairs(selected2) do if IsValid(v) then v:Remove() end end
            SelectMenu("DPanel",dpanel,f2)
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
            for k,v in pairs(selected2) do if IsValid(v) then v:Remove() end end
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
    frame3:Dock(FILL)
    frame3:SetSize(ScrW() / 2 - 500,295)
    frame3:DockMargin(0,0,0,600)
    frame3.Paint = function(s,w,h)
        draw.RoundedBox(0,0,0,w,h,Color(64,64,64,100))
    end

    local frame4 = vgui.Create("DPanel",frame2)
    frame4:Dock(FILL)
    frame4:DockMargin(0,270,0,0)
    frame4.Paint = function(s,w,h)
        draw.RoundedBox(0,0,0,w,h,Color(64,64,64,100))
    end


    for k,v in pairs({"DFrame","DPanel","DButton"}) do
        local button = vgui.Create("DButton",frame1)
        button:Dock(TOP)
        button:SetHeight(25)
        button:SetText(v)
        button.DoClick = function(s)
            DFrameMaker(v,frame,frame3,frame4)
        end
    end

   
    
end)