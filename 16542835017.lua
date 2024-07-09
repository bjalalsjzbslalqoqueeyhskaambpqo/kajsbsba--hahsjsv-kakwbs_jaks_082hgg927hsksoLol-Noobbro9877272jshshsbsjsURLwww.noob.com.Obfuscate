
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

UL:AddTBtn(cfrm, "Auto Obby-Tasks", a, function(b) 
    a = b
    while a do
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then
                local plr = game.Players.LocalPlayer
                firetouchinterest(plr.Character.HumanoidRootPart, obj, 0)
                wait()
                firetouchinterest(plr.Character.HumanoidRootPart, obj, 1)
                wait(0.5)

                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and obj:FindFirstChild("ProximityPrompt") then
                        local plr = game.Players.LocalPlayer
                        fireproximityprompt(obj.ProximityPrompt)
                    end
                end
            end
        end
        wait(1)
    end
end)

UL:AddTBtn(cfrm, "Auto Spin - Auto Claim UGC", k, function(b) 
    k = b
    while k do
        local args = {
            [1] = {}
        }

        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UGC"):WaitForChild("UseSpin"):FireServer(unpack(args))
        wait(2)
    end
end)
spawn(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX-New/TwoDev/main/Auto%20Claim%20UGC.lua"))()
    end)

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
