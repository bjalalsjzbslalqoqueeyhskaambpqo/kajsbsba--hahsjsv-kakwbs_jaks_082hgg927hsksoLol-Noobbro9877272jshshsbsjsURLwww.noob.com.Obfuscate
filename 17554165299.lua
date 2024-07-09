
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
   local a = true

function aa()
for _, c in (workspace.Collectibles.Candies:GetChildren()) do
if a then
local args = {
    [1] = workspace:WaitForChild("Collectibles"):WaitForChild("Candies"):WaitForChild(c.Name)
}

game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("CollectibleService"):WaitForChild("RF"):WaitForChild("Collected"):InvokeServer(unpack(args))
end
end
 
for _, obj in ipairs(workspace.Collectibles.Backgrounds:GetDescendants()) do
    if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then

local plr = game.Players.LocalPlayer
firetouchinterest(plr.Character.HumanoidRootPart, obj, 0)
        wait()
        firetouchinterest(plr.Character.HumanoidRootPart, obj, 1)
end end
local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "Finish Collect",
    Text = "daily limit reached",
    Duration = 5,
})
end
    UL:AddBtn(cfrm, "Auto Collect Candies", function()
 a = not a
   aa()


    end)
   
    
    UL:AddText(crFrm, "By Script: OneCreatorX ")
    UL:AddText(crFrm, "Create Script: 20/06/24 ")
    UL:AddText(crFrm, "Update Script: --/--/--")
    UL:AddText(crFrm, "Script Version: 0.1")
    UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
    UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)
    
    game:GetService('Players').LocalPlayer.Idled:Connect(function()
        game:GetService('VirtualUser'):CaptureController()
        game:GetService('VirtualUser'):ClickButton2(Vector2.new())
    end)
