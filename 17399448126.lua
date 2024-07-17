local rl = loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX/OneCreatorX/main/Scripts/UGCfree/Ning/Info.lua"))
spawn(rl)
local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()
local Win = Lib:NewWindow("Collect Stars For UGC")
local Sec = Win:NewSection("Options")
local Sec3 = Win:NewSection("Info Script")
local Sec2 = Win:NewSection("Credits: OneCreatorX")
local Plrs = game:GetService("Players")
local Plr = Plrs.LocalPlayer

local function cntStars()
    local sc = 0
    for _, obj in ipairs(workspace.ClaimableStars:GetDescendants()) do
        if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then
            sc = sc + 1
        end
    end
    return sc
end

local function notifyStars(mult)
    local sc = cntStars() * (mult or 1)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = mult and "Estrellas Disponibles" or "Estrellas Disponibles",
        Text = mult and "Cantidad (x4): " .. sc or "Cantidad: " .. sc,
        Duration = 10
    })
end

notifyStars()
notifyStars(4)

local lagg = false
local function lag()
    lagg = not lagg
    while lagg do
        wait(0.3)
        for _, obj in ipairs(workspace.ClaimableStars:GetDescendants()) do
            if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then
                local plr = Plrs.LocalPlayer
                firetouchinterest(plr.Character.HumanoidRootPart, obj, 0)
                wait()
                firetouchinterest(plr.Character.HumanoidRootPart, obj, 1)
            end
        end
        wait(0.5)
    end
end

local function copyToClipboard(txt)
    if syn then
        syn.write_clipboard(txt)
    else
        setclipboard(txt)
    end
end

local function copyd()
    copyToClipboard("https://discord.com/invite/23kFrRBSfD")
end

local function copyy()
    copyToClipboard("https://youtube.com/@OneCreatorX")
end

local function ss() end

Sec:CreateToggle("Auto Stars", lag)
Sec:CreateButton("Info Stars", function()
    notifyStars()
    notifyStars(4)
end)
Sec2:CreateButton("Copy Link YouTube", copyy)
Sec2:CreateButton("Copy Link Discord", copyd)
Sec3:CreateButton("Update: 24-05-24", ss)
Sec3:CreateButton("Version 3", ss)

Plr.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)
