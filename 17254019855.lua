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

local player = game.Players.LocalPlayer
local sg = UL:CrSG("Default")
local frm, cfrm, crFrm = UL:CrFrm(sg, gameName)

local a = false

local proximityPrompts = {}

for _, obj in ipairs(workspace:GetDescendants()) do
    if obj:IsA("ProximityPrompt") then
        table.insert(proximityPrompts, obj)
    end
end

UL:AddTBtn(cfrm, "Automatic 1", a, function(b)
    a = b 
    while a do
    spawn(function()
        if a then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("ProximityPrompt") then
                    if a then
                        fireproximityprompt(obj)
                    end
                end
            end
        end
    end)
    wait(0.2)
end
end)

local aa = false

UL:AddTBtn(cfrm, "Automatic 2", aa, function(bb)
aa = bb

end)
local remote = game:GetService("ReplicatedStorage"):WaitForChild("AnswerSalesRequest_AnswerSalesRequestEnterClientEvent")
local answerRemote = game:GetService("ReplicatedStorage"):WaitForChild("AnswerSalesRequest_ActivatedCustomerOptionButtonServer")

remote.OnClientEvent:Connect(function(_, arg2)
    if arg2  and aa then
        answerRemote:FireServer(arg2)
    end
end)

UL:AddText(crFrm, "By Script: OneCreatorX ")
    UL:AddText(crFrm, "Create Script: 25/06/24 ")
    UL:AddText(crFrm, "Update Script: --/--/--")
    UL:AddText(crFrm, "Script Version: 0.1")
    UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
    UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)
    
    game:GetService('Players').LocalPlayer.Idled:Connect(function()
        game:GetService('VirtualUser'):CaptureController()
        game:GetService('VirtualUser'):ClickButton2(Vector2.new())
    end)
