local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UL = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/MyLibrery.lua"))()

local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
gameName = gameName:gsub("%b[]", ""):match("^[^:]*"):match("^%s*(.-)%s*$")

local p = game.Players.LocalPlayer
local sg = UL:CrSG("Default")
local frm, cfrm, crFrm = UL:CrFrm(sg, gameName)

local statusText = UL:AddText(crFrm, "Status: Unknown")

UL:AddBtn(cfrm, "Auto Buyer", function() 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX-New/TwoDev/main/Loader.lua"))()("Auto%20Buyer(Fast%20Claim)")
end)

local codes = {}

UL:AddTBox(cfrm, "Enter Codes:", function(text)
    codes = {}
    for code in text:gmatch("[^\r\n]+") do
        for c in code:gmatch("%S+") do
            table.insert(codes, c)
        end
    end
end)

local isProcessingCodes = false

UL:AddTBtn(cfrm, "Process Codes", false, function()
    isProcessingCodes = not isProcessingCodes
    local ugcService = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("UGCService"):WaitForChild("RF"):WaitForChild("ClaimItem")
    
    spawn(function()
        while isProcessingCodes do
            for _, code in ipairs(codes) do
                pcall(function()
                    ugcService:InvokeServer(tostring(code))
                end)
                wait(0.1)
            end
            wait(0.2)
        end
    end)
end)

UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 05/08/24 ")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.2")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)
