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

local function handleTGSQuestReportProgress(args)
    pcall(function()
        game:GetService("ReplicatedStorage"):WaitForChild("TGSQuest_ReportProgress"):FireServer(unpack(args))
    end)
end

local function handleTricksTrickLanded(args)
    pcall(function()
        game:GetService("ReplicatedStorage"):WaitForChild("Tricks_TrickLanded"):FireServer(unpack(args))
    end)
end

local mainOptionsButton, mainOptionsFrame = UL:AddOBtn(cfrm, "Main Options")

local a = false

UL:AddTBtn(cfrm, "Farm TrickAnyGrind", false, function()
    a = not a
    while a do
        handleTGSQuestReportProgress({"TrickLand", "TrickAnyGrind", "", 1})
        wait(0.1)
    end
end)

local a = false
UL:AddTBtn(cfrm, "Farm TrickInFountain", false, function()
    a = not a
    while a do
        handleTGSQuestReportProgress({"TrickInLocation", "TrickInFountain", "", 1})
        wait()
    end
end)

local a = false
UL:AddTBtn(cfrm, "Farm TrickPopShoveIt180", false, function()
    a = not a
    while a do
        handleTGSQuestReportProgress({"TrickLand", "TrickPopShoveIt180", "", 1})
        wait()
    end
end)

local a = false
UL:AddTBtn(cfrm, "Farm PAAirTime", false, function()
    a = not a
    while a do
        handleTGSQuestReportProgress({"PlayerAction", "PAAirTime", "", 99.85398530960083})
        wait()
    end
end)

local a = false
UL:AddTBtn(cfrm, "Farm TrickHeelflip", false, function()
    a = not a
    while a do
        handleTGSQuestReportProgress({"TrickLand", "TrickHeelflip", "", 1})
        wait()
    end
end)

local a = false
UL:AddTBtn(cfrm, "Farm PARideDistance", false, function()
    a = not a
    while a do
        handleTGSQuestReportProgress({"PlayerAction", "PARideDistance", "", 99.0842413786649705})
        wait()
    end
end)

local a = false
UL:AddTBtn(mainOptionsFrame, "Farm Levels", false, function()
    a = not a
    while a do
        handleTricksTrickLanded({
            true, 2, 2, {
                { TrickName = "Kickflip", HasbeenReported = true, Value = 100000000000, IsRampTrick = true },
                { TrickName = "Heelflip", HasbeenReported = true, Value = 100000000000, IsRampTrick = true }
            }
        })
        wait()
    end
end)

local a = false
local function haa()
    while a do
        for _, C in game.Workspace.VansNew.CoinLocations:GetDescendants() do
            if C:IsA("BasePart") and C:FindFirstChild("TouchInterest") and a then
                local plr = game.Players.LocalPlayer
                firetouchinterest(plr.Character.HumanoidRootPart, C, 0)
                wait()
                firetouchinterest(plr.Character.HumanoidRootPart, C, 1)
            end
        end
        wait()
    end
end

UL:AddTBtn(mainOptionsFrame, "Farm Coins[No TP]", false, function()
    a = not a
    if a then
        haa()
    end
end)

local a = false
local function ha()
    for _, C in game.Workspace.VansNew.CoinLocations:GetDescendants() do
        if C:IsA("BasePart") and C:FindFirstChild("TouchInterest") and a then
            game.Players.LocalPlayer.Character.PrimaryPart.CFrame = C.CFrame
            wait(1)
        end
    end
    wait(0.1)
    ha()
end

UL:AddTBtn(mainOptionsFrame, "Farm Coins[TP]", false, function()
    a = not a
    if a then
        ha()
    end
end)

local a = false
local function ha()
    for _, C in game.Workspace.HiddenSymbols:GetDescendants() do
        if C:IsA("BasePart") and C:FindFirstChild("TouchInterest") and a then
            game.Players.LocalPlayer.Character.PrimaryPart.CFrame = C.CFrame
            wait(1)
        end
    end
    wait()
    ha()
end


local a = false

local function ha()
    while a do
        for _, C in game.Workspace.HiddenSymbols:GetDescendants() do
            if C:IsA("BasePart") and C:FindFirstChild("TouchInterest") and a then
                local plr = game.Players.LocalPlayer
                firetouchinterest(plr.Character.HumanoidRootPart, C, 0)
                wait()
                firetouchinterest(plr.Character.HumanoidRootPart, C, 1)
            end
        end
        wait()
    end
end



UL:AddTBtn(mainOptionsFrame, "Farm Collects[NO TP]", false, function()
    a = not a
    if a then
        ha()
    end
end)

local a = false

UL:AddTBtn(cfrm, "Auto BalanceDistance", false, function()
    a = not a
    while a do
local args = {
    [1] = "BalanceDistance",
    [2] = "GrindDistance",
    [3] = "",
    [4] = 1400
}

game:GetService("ReplicatedStorage"):WaitForChild("TGSQuest_ReportProgress"):FireServer(unpack(args))

        wait()
    end
end)

local a = false
UL:AddTBtn(cfrm, "Auto TrickInLABowl", false, function()
    a = not a
    while a do
        local args = {
    [1] = "TrickInLocation",
    [2] = "TrickInLABowl",
    [3] = "",
    [4] = 1000
}

game:GetService("ReplicatedStorage"):WaitForChild("TGSQuest_ReportProgress"):FireServer(unpack(args))

        wait()
    end
end)

local a = false
UL:AddTBtn(cfrm, "Auto Manual tacos", false, function()
    a = not a
    while a do
        local args = {
    [1] = "BalanceDistance",
    [2] = "ManualDistance",
    [3] = "",
    [4] = 20099
}

game:GetService("ReplicatedStorage"):WaitForChild("TGSQuest_ReportProgress"):FireServer(unpack(args))

        wait()
    end
end)

UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 14/08/24 ")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)
