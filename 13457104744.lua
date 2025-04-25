local function b()
local weTracker = Instance.new("IntValue")
weTracker.Name = "CurrentCheckpoint"
weTracker.Value = 1
weTracker.Parent = workspace
task.wait(0.3)
local plr = game:GetService("Players")
local mps = game:GetService("MarketplaceService")
local gui = game:GetService("CoreGui")

local lp = plr.LocalPlayer
local ui = Instance.new("ScreenGui")
ui.Name = "afg"
ui.ResetOnSpawn = false
ui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ui.Parent = gui

local pnl = Instance.new("Frame")
pnl.Name = "pnl"
pnl.Size = UDim2.new(0, 250, 0, 120)
pnl.Position = UDim2.new(0.85, -125, 0.1, 0)
pnl.BackgroundColor3 = Color3.fromRGB(242, 244, 245)
pnl.BorderSizePixel = 2
pnl.BorderColor3 = Color3.fromRGB(211, 211, 211)
pnl.Parent = ui

local pnlCrn = Instance.new("UICorner")
pnlCrn.CornerRadius = UDim.new(0, 6)
pnlCrn.Parent = pnl

local hdr = Instance.new("Frame")
hdr.Name = "hdr"
hdr.Size = UDim2.new(1, 0, 0, 40)
hdr.BackgroundColor3 = Color3.fromRGB(255, 71, 66)
hdr.BorderSizePixel = 0
hdr.Parent = pnl

local hdrCrn = Instance.new("UICorner")
hdrCrn.CornerRadius = UDim.new(0, 6)
hdrCrn.Parent = hdr

local hdrFix = Instance.new("Frame")
hdrFix.Name = "hdrFix"
hdrFix.Size = UDim2.new(1, 0, 0, 10)
hdrFix.Position = UDim2.new(0, 0, 1, -10)
hdrFix.BackgroundColor3 = Color3.fromRGB(255, 71, 66)
hdrFix.BorderSizePixel = 0
hdrFix.ZIndex = 0
hdrFix.Parent = hdr

local ttl = Instance.new("TextLabel")
ttl.Name = "ttl"
ttl.Size = UDim2.new(1, 0, 0, 25)
ttl.Position = UDim2.new(0, 0, 0, 5)
ttl.BackgroundTransparency = 1
ttl.Font = Enum.Font.GothamBold
ttl.Text = "Auto Farm - By OneCreatorX"
ttl.TextColor3 = Color3.fromRGB(255, 255, 255)
ttl.TextSize = 14
ttl.Parent = hdr

local ver = Instance.new("TextLabel")
ver.Name = "ver"
ver.Size = UDim2.new(1, 0, 0, 15)
ver.Position = UDim2.new(0, 0, 0, 25)
ver.BackgroundTransparency = 1
ver.Font = Enum.Font.Gotham
ver.Text = "v0.1"
ver.TextColor3 = Color3.fromRGB(255, 255, 255)
ver.TextTransparency = 0.2
ver.TextSize = 12
ver.Parent = hdr

local cnt = Instance.new("Frame")
cnt.Name = "cnt"
cnt.Size = UDim2.new(1, -20, 0, 70)
cnt.Position = UDim2.new(0, 10, 0, 45)
cnt.BackgroundTransparency = 1
cnt.Parent = pnl

local gml = Instance.new("TextLabel")
gml.Name = "gml"
gml.Size = UDim2.new(1, 0, 0, 15)
gml.Position = UDim2.new(0, 0, 0, 0)
gml.BackgroundTransparency = 1
gml.Font = Enum.Font.GothamSemibold
gml.Text = "CURRENT GAME"
gml.TextColor3 = Color3.fromRGB(120, 120, 120)
gml.TextSize = 11
gml.TextXAlignment = Enum.TextXAlignment.Left
gml.Parent = cnt

local gmp = Instance.new("Frame")
gmp.Name = "gmp"
gmp.Size = UDim2.new(1, 0, 0, 40)
gmp.Position = UDim2.new(0, 0, 0, 20)
gmp.BackgroundColor3 = Color3.fromRGB(248, 248, 248)
gmp.BorderSizePixel = 1
gmp.BorderColor3 = Color3.fromRGB(224, 224, 224)
gmp.Parent = cnt

local gmpCrn = Instance.new("UICorner")
gmpCrn.CornerRadius = UDim.new(0, 4)
gmpCrn.Parent = gmp

local gif = Instance.new("Frame")
gif.Name = "gif"
gif.Size = UDim2.new(0, 30, 0, 30)
gif.Position = UDim2.new(0, 5, 0, 5)
gif.BackgroundColor3 = Color3.fromRGB(224, 224, 224)
gif.Parent = gmp

local gifCrn = Instance.new("UICorner")
gifCrn.CornerRadius = UDim.new(0, 4)
gifCrn.Parent = gif

local ico = Instance.new("TextLabel")
ico.Name = "ico"
ico.Size = UDim2.new(1, 0, 1, 0)
ico.BackgroundTransparency = 1
ico.Font = Enum.Font.GothamBold
ico.Text = "🎮"
ico.TextColor3 = Color3.fromRGB(80, 80, 80)
ico.TextSize = 16
ico.Parent = gif

local gnm = Instance.new("TextLabel")
gnm.Name = "gnm"
gnm.Size = UDim2.new(1, -45, 0, 20)
gnm.Position = UDim2.new(0, 40, 0, 5)
gnm.BackgroundTransparency = 1
gnm.Font = Enum.Font.GothamBold
gnm.Text = "Loading..."
gnm.TextColor3 = Color3.fromRGB(50, 50, 50)
gnm.TextSize = 12
gnm.TextXAlignment = Enum.TextXAlignment.Left
gnm.Parent = gmp

local stf = Instance.new("Frame")
stf.Name = "stf"
stf.Size = UDim2.new(0, 50, 0, 15)
stf.Position = UDim2.new(0, 40, 0, 22)
stf.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
stf.Parent = gmp

local stfCrn = Instance.new("UICorner")
stfCrn.CornerRadius = UDim.new(0, 3)
stfCrn.Parent = stf

local stl = Instance.new("TextLabel")
stl.Name = "stl"
stl.Size = UDim2.new(1, 0, 1, 0)
stl.BackgroundTransparency = 1
stl.Font = Enum.Font.GothamBold
stl.Text = "ACTIVE"
stl.TextColor3 = Color3.fromRGB(255, 255, 255)
stl.TextSize = 9
stl.Parent = stf

local std = Instance.new("TextLabel")
std.Name = "std"
std.Size = UDim2.new(0, 70, 0, 15)
std.Position = UDim2.new(0, 95, 0, 22)
std.BackgroundTransparency = 1
std.Font = Enum.Font.Gotham
std.Text = "Auto-farming"
std.TextColor3 = Color3.fromRGB(120, 120, 120)
std.TextSize = 9
std.TextXAlignment = Enum.TextXAlignment.Left
std.Parent = gmp

local prg = Instance.new("Frame")
prg.Name = "prg"
prg.Size = UDim2.new(1, 0, 0, 20)
prg.Position = UDim2.new(0, 0, 1, -20)
prg.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
prg.BorderSizePixel = 0
prg.Parent = pnl

local prgCrn = Instance.new("UICorner")
prgCrn.CornerRadius = UDim.new(0, 4)
prgCrn.Parent = prg

local prgTxt = Instance.new("TextLabel")
prgTxt.Name = "prgTxt"
prgTxt.Size = UDim2.new(1, 0, 1, 0)
prgTxt.BackgroundTransparency = 1
prgTxt.Font = Enum.Font.Gotham
prgTxt.Text = "Status: Running | Checkpoint: 1/11"
prgTxt.TextColor3 = Color3.fromRGB(120, 120, 120)
prgTxt.TextSize = 10
prgTxt.Parent = prg

local ok, gpi = pcall(function()
    return mps:GetProductInfo(game.PlaceId, Enum.InfoType.Asset)
end)

if ok then
    gnm.Text = gpi.Name
else
    gnm.Text = "Unknown Game"
end

local beam = workspace:WaitForChild("EventPartFolder"):WaitForChild("StartPart"):WaitForChild("Beam")

repeat
	task.wait()
until beam.Enabled == false


local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local primaryPart = character:WaitForChild("HumanoidRootPart")

local function d(cframe)
    primaryPart.CFrame = cframe
end


local function updateCheckpoint()
    local model = workspace.EventPartFolder:FindFirstChild(tostring(workspace.CurrentCheckpoint.Value))
    if model then
        ReplicatedStorage.RemoteMessenger.SendData:FireServer("CheckPointUpdate", model)
    end
end

task.spawn(function()
    while true do
        updateCheckpoint()
        task.wait()
    end
end)

local pausas = {
    [1] = 12,
    [2] = 13,
    [3] = 15,
    [4] = 16,
    [5] = 1,
    [6] = 1,
    [7] = 9,
    [8] = 2,
    [9] = 16,
    [10] = 10,
    [11] = 1,
}

for i = 1, 11 do
prgTxt.Text = "Status: Running | Checkpoint: " .. i .. "/11"
    weTracker.Value = i
    local model = workspace:WaitForChild("EventPartFolder"):FindFirstChild(tostring(i))
    if model then
        d(model.PrimaryPart.CFrame)
        task.wait(pausas[i] or 5)

        local current = workspace.CurrentCheckpoint.Value
        if current == 4 then
            d(CFrame.new(270, -12, -715))
            task.wait(2)
        elseif current == 6 then
            d(CFrame.new(-322, 420, -1043))
            task.wait(2)
            elseif current == 8 then
            d(CFrame.new(-1062, -201, -1122))
            task.wait(2)
        elseif current == 10 then
            d(CFrame.new(-996, -135, -621))
            task.wait(2)
        elseif current == 11 then
            d(CFrame.new(-603, -190, 891))
            task.wait(2)
        end
    end
end
wait(1)

game.Players.LocalPlayer:Kick("Join main game")
wait(1)
game:GetService("TeleportService"):Teleport(13457104744)
end

local function a()
local plr = game:GetService("Players")
local mps = game:GetService("MarketplaceService")
local gui = game:GetService("CoreGui")

local lp = plr.LocalPlayer
local ui = Instance.new("ScreenGui")
ui.Name = "afg"
ui.ResetOnSpawn = false
ui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ui.Parent = gui

local pnl = Instance.new("Frame")
pnl.Name = "pnl"
pnl.Size = UDim2.new(0, 250, 0, 120)
pnl.Position = UDim2.new(0.85, -125, 0.1, 0)
pnl.BackgroundColor3 = Color3.fromRGB(242, 244, 245)
pnl.BorderSizePixel = 2
pnl.BorderColor3 = Color3.fromRGB(211, 211, 211)
pnl.Parent = ui

local pnlCrn = Instance.new("UICorner")
pnlCrn.CornerRadius = UDim.new(0, 6)
pnlCrn.Parent = pnl

local hdr = Instance.new("Frame")
hdr.Name = "hdr"
hdr.Size = UDim2.new(1, 0, 0, 40)
hdr.BackgroundColor3 = Color3.fromRGB(255, 71, 66)
hdr.BorderSizePixel = 0
hdr.Parent = pnl

local hdrCrn = Instance.new("UICorner")
hdrCrn.CornerRadius = UDim.new(0, 6)
hdrCrn.Parent = hdr

local hdrFix = Instance.new("Frame")
hdrFix.Name = "hdrFix"
hdrFix.Size = UDim2.new(1, 0, 0, 10)
hdrFix.Position = UDim2.new(0, 0, 1, -10)
hdrFix.BackgroundColor3 = Color3.fromRGB(255, 71, 66)
hdrFix.BorderSizePixel = 0
hdrFix.ZIndex = 0
hdrFix.Parent = hdr

local ttl = Instance.new("TextLabel")
ttl.Name = "ttl"
ttl.Size = UDim2.new(1, 0, 0, 25)
ttl.Position = UDim2.new(0, 0, 0, 5)
ttl.BackgroundTransparency = 1
ttl.Font = Enum.Font.GothamBold
ttl.Text = "Auto Farm - By OneCreatorX"
ttl.TextColor3 = Color3.fromRGB(255, 255, 255)
ttl.TextSize = 14
ttl.Parent = hdr

local ver = Instance.new("TextLabel")
ver.Name = "ver"
ver.Size = UDim2.new(1, 0, 0, 15)
ver.Position = UDim2.new(0, 0, 0, 25)
ver.BackgroundTransparency = 1
ver.Font = Enum.Font.Gotham
ver.Text = "v0.1"
ver.TextColor3 = Color3.fromRGB(255, 255, 255)
ver.TextTransparency = 0.2
ver.TextSize = 12
ver.Parent = hdr

local cnt = Instance.new("Frame")
cnt.Name = "cnt"
cnt.Size = UDim2.new(1, -20, 0, 70)
cnt.Position = UDim2.new(0, 10, 0, 45)
cnt.BackgroundTransparency = 1
cnt.Parent = pnl

local gml = Instance.new("TextLabel")
gml.Name = "gml"
gml.Size = UDim2.new(1, 0, 0, 15)
gml.Position = UDim2.new(0, 0, 0, 0)
gml.BackgroundTransparency = 1
gml.Font = Enum.Font.GothamSemibold
gml.Text = "CURRENT GAME"
gml.TextColor3 = Color3.fromRGB(120, 120, 120)
gml.TextSize = 11
gml.TextXAlignment = Enum.TextXAlignment.Left
gml.Parent = cnt

local gmp = Instance.new("Frame")
gmp.Name = "gmp"
gmp.Size = UDim2.new(1, 0, 0, 40)
gmp.Position = UDim2.new(0, 0, 0, 20)
gmp.BackgroundColor3 = Color3.fromRGB(248, 248, 248)
gmp.BorderSizePixel = 1
gmp.BorderColor3 = Color3.fromRGB(224, 224, 224)
gmp.Parent = cnt

local gmpCrn = Instance.new("UICorner")
gmpCrn.CornerRadius = UDim.new(0, 4)
gmpCrn.Parent = gmp

local gif = Instance.new("Frame")
gif.Name = "gif"
gif.Size = UDim2.new(0, 30, 0, 30)
gif.Position = UDim2.new(0, 5, 0, 5)
gif.BackgroundColor3 = Color3.fromRGB(224, 224, 224)
gif.Parent = gmp

local gifCrn = Instance.new("UICorner")
gifCrn.CornerRadius = UDim.new(0, 4)
gifCrn.Parent = gif

local ico = Instance.new("TextLabel")
ico.Name = "ico"
ico.Size = UDim2.new(1, 0, 1, 0)
ico.BackgroundTransparency = 1
ico.Font = Enum.Font.GothamBold
ico.Text = "🎮"
ico.TextColor3 = Color3.fromRGB(80, 80, 80)
ico.TextSize = 16
ico.Parent = gif

local gnm = Instance.new("TextLabel")
gnm.Name = "gnm"
gnm.Size = UDim2.new(1, -45, 0, 20)
gnm.Position = UDim2.new(0, 40, 0, 5)
gnm.BackgroundTransparency = 1
gnm.Font = Enum.Font.GothamBold
gnm.Text = "Loading..."
gnm.TextColor3 = Color3.fromRGB(50, 50, 50)
gnm.TextSize = 12
gnm.TextXAlignment = Enum.TextXAlignment.Left
gnm.Parent = gmp

local stf = Instance.new("Frame")
stf.Name = "stf"
stf.Size = UDim2.new(0, 50, 0, 15)
stf.Position = UDim2.new(0, 40, 0, 22)
stf.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
stf.Parent = gmp

local stfCrn = Instance.new("UICorner")
stfCrn.CornerRadius = UDim.new(0, 3)
stfCrn.Parent = stf

local stl = Instance.new("TextLabel")
stl.Name = "stl"
stl.Size = UDim2.new(1, 0, 1, 0)
stl.BackgroundTransparency = 1
stl.Font = Enum.Font.GothamBold
stl.Text = "ACTIVE"
stl.TextColor3 = Color3.fromRGB(255, 255, 255)
stl.TextSize = 9
stl.Parent = stf

local std = Instance.new("TextLabel")
std.Name = "std"
std.Size = UDim2.new(0, 70, 0, 15)
std.Position = UDim2.new(0, 95, 0, 22)
std.BackgroundTransparency = 1
std.Font = Enum.Font.Gotham
std.Text = "Auto-farming"
std.TextColor3 = Color3.fromRGB(120, 120, 120)
std.TextSize = 9
std.TextXAlignment = Enum.TextXAlignment.Left
std.Parent = gmp

local prg = Instance.new("Frame")
prg.Name = "prg"
prg.Size = UDim2.new(1, 0, 0, 20)
prg.Position = UDim2.new(0, 0, 1, -20)
prg.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
prg.BorderSizePixel = 0
prg.Parent = pnl

local prgCrn = Instance.new("UICorner")
prgCrn.CornerRadius = UDim.new(0, 4)
prgCrn.Parent = prg

local btn = Instance.new("TextButton")
btn.Name = "prgBtn"
btn.Size = UDim2.new(1, 0, 1, 0)
btn.BackgroundTransparency = 1
btn.Text = "Fast Spin"
btn.TextColor3 = Color3.fromRGB(120, 120, 120)
btn.TextSize = 10
btn.Parent = prg

btn.MouseButton1Click:Connect(function()
	for i = 1, 1000 do
		local args = {
			[1] = "UgcSpinTry"
		}
		game:GetService("ReplicatedStorage"):WaitForChild("RemoteMessenger"):WaitForChild("GetData"):InvokeServer(unpack(args))
	end
end)




local ok, gpi = pcall(function()
    return mps:GetProductInfo(game.PlaceId, Enum.InfoType.Asset)
end)

if ok then
    gnm.Text = gpi.Name
else
    gnm.Text = "Unknown Game"
end

local function updChk(cp, tp)
    prgTxt.Text = "Status: Running"
end 
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local primaryPart = character:WaitForChild("HumanoidRootPart")

    for _, r in workspace.LobbyFolder.HardMode:GetChildren() do
        r.TouchPart.CFrame = primaryPart.CFrame
        task.wait()
    end
    while true do
    local args = {
    [1] = "GlitchToytopia",
    [2] = "GlitchToytopia"
}

game:GetService("ReplicatedStorage"):WaitForChild("VoteEvent"):FireServer(unpack(args))

    
    wait()
    end
end



local Marketplace = game:GetService("MarketplaceService")

local success, info = pcall(function()
    return Marketplace:GetProductInfo(game.PlaceId, Enum.InfoType.Asset)
end)

if not success then
    warn("No se pudo obtener la información del juego:", info)
    return
end

local nombreMinuscula = info.Name:lower()
local palabraClave = "toytopia"

nombreMinuscula = nombreMinuscula:match("^%s*(.-)%s*$")

if nombreMinuscula:find(palabraClave, 1, true) then
    b()
else
    
    a()
end
