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

local money

local function getPlayerFolder(playerId)
    return workspace:WaitForChild("Tycoons"):FindFirstChild(tostring(playerId))
end

local playerFolder = getPlayerFolder(p.UserId)

if playerFolder then
    local atmModels = {}
    for _, descendant in pairs(playerFolder:GetDescendants()) do
        if descendant:IsA("Model") and descendant.Name == "ATM" then
            table.insert(atmModels, descendant)
        end
    end

    local atmModel = atmModels[2]

    if atmModel then
        spawn(function()
UL:AddTBtn(cfrm, "Auto Collect", false, function()
    b = not b
            while b do
                local pp = p.Character.PrimaryPart.CFrame
                wait(0.1)
                p.Character.PrimaryPart.CFrame = atmModel.Screen.CFrame
                wait(0.3)
                p.Character.PrimaryPart.CFrame = pp
                wait(5)
            end


end)

        end)
        
        UL:AddTBtn(cfrm, "Auto Tycoon", false, function()
            a = not a

            while a do
                for _, child in pairs(playerFolder:GetChildren()) do
                    if string.find(child.Name, "button") then
                        local args = {
                            [1] = child
                        }
                        game:GetService("ReplicatedStorage"):WaitForChild("Behavior"):WaitForChild("Button"):WaitForChild("Pressed"):InvokeServer(unpack(args))
                        wait(1)
                    end
                end
                wait(1)
            end
        end)
    else
        print("No se encontró el segundo Model 'ATM'.")
    end
else
    print("No se encontró el folder para el jugador con ID:", p.UserId)
end


UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 17/07/24 ")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)
