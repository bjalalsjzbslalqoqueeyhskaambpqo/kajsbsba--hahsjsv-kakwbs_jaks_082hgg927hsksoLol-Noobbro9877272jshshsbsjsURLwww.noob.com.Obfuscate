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
UL:AddTBtn(cfrm, "Farm Coins", false, function()
    a = not a
    while a do
        for _, farm in pairs(workspace:FindFirstChild("Destructible"):FindFirstChild("Gummycitydestroy"):GetChildren()) do
            if a then
                local args = {
                    [1] = farm:FindFirstChild("HitBox")
                }

                game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("BreakTheCrate"):FireServer(unpack(args))
                wait(0.1)
            end
            wait()
        end
        wait()
    end
end)

UL:AddBtn(cfrm, "Join Event", function()
    p.Character:MoveTo(Vector3.new(356, 70, -119))
end)

UL:AddBtn(cfrm, "Buy Ticket", function()
    p.Character:MoveTo(Vector3.new(417, 60, -117))
end)

local b = false
UL:AddTBtn(cfrm, "Auto Bubbles Event", false, function()
    b = not b
    while b do
        for _, bubbles in pairs(workspace.BubbleContainer:GetChildren()) do
            if b then
                local args = {
                    [1] = tostring(bubbles.Name)
                }

                game:GetService("ReplicatedStorage"):WaitForChild("BubbleUpShared"):WaitForChild("RemoteEvents"):WaitForChild("BubbleTouched"):FireServer(unpack(args))
                wait()
            end
            wait()
        end
        wait(0.1)
    end
end)

UL:AddText(crFrm, "By Script: OneCreatorX")
UL:AddText(crFrm, "Create Script: 03/07/24")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)
