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

UL:AddTBtn(cfrm, "Auto Like(Win)", false, function()
    a = not a
    while a do
        local name = tostring(game.Players.LocalPlayer.Name)
        local args = {
            [1] = game:GetService("Players"):WaitForChild(name)
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ChooseFriendliest"):FireServer(unpack(args))
        wait(1)
    end
end)

UL:AddTBox(cfrm, "RNG Points use number 1-10000", function(text) 
    local args = {
        [1] = text
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UpdateHighestNumber"):FireServer(unpack(args))
end)

UL:AddBtn(cfrm, "Select Next Minigame",  function()
game.Players.LocalPlayer.PlayerGui.Main.ChooseNextFightFrame.Visible = true 
    end)


UL:AddBtn(cfrm, "GamePass Fakes",  function()
(loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX-New/TwoDev/main/Loader.lua"))())("Fake%20Parchuses%20Gamepass")
end)

UL:AddBtn(cfrm, "Auto Teddy", function()
    local teddies = {}
    
    for _, ta in ipairs(Workspace.FindMap:GetChildren()) do
        if ta.Name == "Teddy" and ta:IsA("MeshPart") then
            table.insert(teddies, ta)
        end
    end
    
    if #teddies > 0 then
        local targetTeddy = teddies[#teddies]
        p.Character:MoveTo(targetTeddy.Position)
        wait(1)
    end
end)

UL:AddTBox(cfrm, " Speed : ", function(text) 
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = text
end)

UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 03/08/24 ")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.4")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)
