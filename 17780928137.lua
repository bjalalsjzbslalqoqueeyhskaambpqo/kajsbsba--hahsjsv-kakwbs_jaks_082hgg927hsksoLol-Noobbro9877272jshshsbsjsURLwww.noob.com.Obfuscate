local function clickButton(btn)
    local pos = btn.AbsolutePosition
    local size = btn.AbsoluteSize
    local centerX = pos.X + size.X / 2
    local centerY = pos.Y + size.Y / 2
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(centerX, centerY, 0, true, game, 1)
    wait()
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(centerX, centerY, 0, false, game, 1)
end

game:GetService("Players").LocalPlayer.PlayerGui.PointCircles.ChildAdded:Connect(function(child)
    local StarterGui = game:GetService("StarterGui")
    StarterGui:SetCore("SendNotification", {
        Title = "Bubble Detect: " .. child.Text,
        Text = "Auto Bubble Active",
        Duration = 5,
    })
    
    for i = 1, 10 do
        clickButton(child)
    end
end)

local UL = loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX/OneCreatorX/main/UIs/MyLibrery.lua"))()
    
    local gameName = ""
    if gameName == "" then
        gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    end
    
    local function cleanGameName(name)
        name = name:gsub("%b[]", "")
        name = name:match("^[^:]*")
        return name:match("^%s*(.-)%s*$")
    end
    
    gameName = cleanGameName(gameName)
    
    local p = game.Players.LocalPlayer
    local sg = UL:CrSG("Default")
    local frm, cfrm, crFrm = UL:CrFrm(sg, gameName)
   
    
    UL:AddText(cfrm, "Auto Bubble - AntiAFK: Active")
    UL:AddText(crFrm, "By Script: OneCreatorX ")
    UL:AddText(crFrm, "Create Script: 11/06/24 ")
    UL:AddText(crFrm, "Update Script: --/--/--")
    UL:AddText(crFrm, "Script Version: 0.1")
    UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
    UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)
    
    game:GetService('Players').LocalPlayer.Idled:Connect(function()
        game:GetService('VirtualUser'):CaptureController()
        game:GetService('VirtualUser'):ClickButton2(Vector2.new())
    end)
