local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()
local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
local Win = Lib:NewWindow(gameName)
local Sec = Win:NewSection("Options")
local Sec2 = Win:NewSection("Credits: OneCreatorX")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local rl = loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX/OneCreatorX/main/Scripts/UGCfree/Ning/Info.lua"))
spawn(rl)

local function copyToClipboard(text)
    if syn then
        syn.write_clipboard(text)
    else
        setclipboard(text)
    end
end

local dance = false
function dancing()
    dance = not dance
end

Sec:CreateToggle("Auto Dancing", dancing)

Sec2:CreateButton("Copy Link YouTube", function() copyToClipboard("Link YouTube") end)
Sec2:CreateButton("Copy Link Discord", function() copyToClipboard("Link Discord") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

local st = workspace.StageTouch.StageTouch
function a()
    while true do
        pcall(function()
            if dance then
                if dance then
                    firetouchinterest(Player.Character.HumanoidRootPart, st, 0)
                    local id = math.random(2, 20) 
                    Player.Character.DanceId.Value = id
                    wait(1)
                    local args = {
                        [1] = id - 1
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("DanceEvent"):FireServer(unpack(args))
                    dance = false
                        wait(17)
                         dance = true
                else
                    wait(0.5)
                end
            else
                wait(0.5)
            end
        end)
    end
end

a()
