local UL = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/MyLibrery.lua"))()

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


local a = false
UL:AddTBtn(cfrm, "Inject", false, function() 
a = not a

end)


local mt = getrawmetatable(game)
local old_namecall = mt.__namecall

setreadonly(mt, false)

mt.__namecall = function(self, ...)
    local method = getnamecallmethod()

    if method == "FireServer" and (self.Name == "Replicate" or self.Name == "Hook") and a then
        return nil
    end

    return old_namecall(self, ...)
end

setreadonly(mt, true)
local mt = getrawmetatable(game)
local old_namecall = mt.__namecall

setreadonly(mt, false)

mt.__namecall = function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if method == "FireServer" and args[1] == "KillBrick" and a then
        return nil
    end

    return old_namecall(self, ...)
end

setreadonly(mt, true)



UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 13/07/24 ")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)
