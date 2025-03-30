local expectedVersion = 6110
local currentVersion = game.PlaceVersion

if currentVersion ~= expectedVersion then
    local playerGui = game.Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = playerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.5, 0, 0.25, 0)
    frame.Position = UDim2.new(0.25, 0, 0.35, 0)
    frame.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
    frame.BackgroundTransparency = 0.2
    frame.BorderSizePixel = 0
    frame.Parent = screenGui

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0.1, 0)
    uiCorner.Parent = frame

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -10, 1, -10)
    textLabel.Position = UDim2.new(0, 5, 0, 5)
    textLabel.Text = "⚠️ Warning: Newer game version detected!\n\n" ..
    "Check in the secondary account that everything is correct!\n\n" ..
                     "Script Version: " .. expectedVersion .. "\n" ..
                     "Current Version: " .. currentVersion .. "\n\n" ..
                     "Contact Dev: OneCreatorX on YouTube or Discord for udp!"
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.BackgroundTransparency = 1
    textLabel.Parent = frame

    local uiStroke = Instance.new("UIStroke")
    uiStroke.Thickness = 2
    uiStroke.Color = Color3.fromRGB(255, 255, 255)
    uiStroke.Parent = frame

    task.wait(5)

    for i = 0, 1, 0.1 do
        frame.BackgroundTransparency = i
        textLabel.TextTransparency = i
        task.wait(0.1)
    end

    screenGui:Destroy()
end


if game.CoreGui:FindFirstChild("AF") then
    return
end

spawn(function()
    (loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX-New/TwoDev/main/Loader.lua"))())("info")
end)

local ps = game:GetService("Players")
local rs = game:GetService("ReplicatedStorage")
local ts = game:GetService("TweenService")
local uis = game:GetService("UserInputService")
local lp = ps.LocalPlayer
local fr
local vc
local ap = false
local cd = {43, 48}
local nct = 0
local fc = 100
local wt = 5
local lastStats = {fc = 0, tc = 0, dc = 0}
local hasFishingRod = false
local rodEquipped = false
local rodInBackpack = false

local st = {
    fc = 0,
    tc = 0,
    dc = 0,
    tt = 0,
    st = os.time(),
    fpm = 0,
    sf = {},
    lct = 0
}

local sg = Instance.new("ScreenGui")
sg.Name = "AF"
sg.ResetOnSpawn = false
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.Parent = game.CoreGui

local mf = Instance.new("Frame")
mf.Name = "mf"
mf.Size = UDim2.new(0, 320, 0, 330)
mf.Position = UDim2.new(0.5, -160, 0.5, -165)
mf.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
mf.BorderSizePixel = 0
mf.ClipsDescendants = true
mf.Parent = sg
mf.Active = true
mf.Draggable = true

local uc = Instance.new("UICorner")
uc.CornerRadius = UDim.new(0, 8)
uc.Parent = mf

local tb = Instance.new("Frame")
tb.Name = "tb"
tb.Size = UDim2.new(1, 0, 0, 40)
tb.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
tb.BorderSizePixel = 0
tb.Parent = mf

local uct = Instance.new("UICorner")
uct.CornerRadius = UDim.new(0, 8)
uct.Parent = tb

local ftc = Instance.new("Frame")
ftc.Size = UDim2.new(1, 0, 0.5, 0)
ftc.Position = UDim2.new(0, 0, 0.5, 0)
ftc.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
ftc.BorderSizePixel = 0
ftc.Parent = tb

local tt = Instance.new("TextLabel")
tt.Name = "tt"
tt.Size = UDim2.new(0.7, 0, 1, 0)
tt.Position = UDim2.new(0.15, 0, 0, 0)
tt.BackgroundTransparency = 1
tt.TextColor3 = Color3.fromRGB(220, 220, 255)
tt.TextSize = 20
tt.Font = Enum.Font.GothamBold
tt.Text = "🎣v4.1 (💻-📱)- by: OneCreatorX"
tt.Parent = tb

local mb = Instance.new("ImageButton")
mb.Name = "mb"
mb.Size = UDim2.new(0, 24, 0, 24)
mb.Position = UDim2.new(1, -64, 0, 8)
mb.BackgroundTransparency = 1
mb.Image = "rbxassetid://7733715400"
mb.ImageColor3 = Color3.fromRGB(220, 220, 255)
mb.Parent = tb
mb.Visible = false

local hb = Instance.new("ImageButton")
hb.Name = "hb"
hb.Size = UDim2.new(0, 24, 0, 24)
hb.Position = UDim2.new(0, 8, 0, 8)
hb.BackgroundTransparency = 1
hb.Image = "rbxassetid://7733774602"
hb.ImageColor3 = Color3.fromRGB(220, 220, 255)
hb.Parent = tb

local cf = Instance.new("Frame")
cf.Name = "cf"
cf.Size = UDim2.new(1, 0, 1, -40)
cf.Position = UDim2.new(0, 0, 0, 40)
cf.BackgroundTransparency = 1
cf.Parent = mf

local sp = Instance.new("Frame")
sp.Name = "sp"
sp.Size = UDim2.new(1, -20, 0, 120)
sp.Position = UDim2.new(0, 10, 0, 10)
sp.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
sp.BorderSizePixel = 0
sp.Parent = cf

local upc = Instance.new("UICorner")
upc.CornerRadius = UDim.new(0, 8)
upc.Parent = sp

local st1 = Instance.new("TextLabel")
st1.Name = "st1"
st1.Size = UDim2.new(1, 0, 0, 30)
st1.BackgroundTransparency = 1
st1.TextColor3 = Color3.fromRGB(220, 220, 255)
st1.TextSize = 16
st1.Font = Enum.Font.GothamBold
st1.Text = "📊 Fishing Statistics"
st1.Parent = sp

local sg1 = Instance.new("Frame")
sg1.Name = "sg1"
sg1.Size = UDim2.new(1, -20, 0, 80)
sg1.Position = UDim2.new(0, 10, 0, 30)
sg1.BackgroundTransparency = 1
sg1.Parent = sp

local fi = Instance.new("TextLabel")
fi.Name = "fi"
fi.Size = UDim2.new(0, 20, 0, 20)
fi.Position = UDim2.new(0, 0, 0, 0)
fi.BackgroundTransparency = 1
fi.TextColor3 = Color3.fromRGB(100, 200, 255)
fi.TextSize = 16
fi.Font = Enum.Font.Gotham
fi.Text = "🐟"
fi.Parent = sg1

local fcl = Instance.new("TextLabel")
fcl.Name = "fcl"
fcl.Size = UDim2.new(0.3, -30, 0, 20)
fcl.Position = UDim2.new(0, 25, 0, 0)
fcl.BackgroundTransparency = 1
fcl.TextColor3 = Color3.fromRGB(220, 220, 255)
fcl.TextSize = 14
fcl.Font = Enum.Font.Gotham
fcl.TextXAlignment = Enum.TextXAlignment.Left
fcl.Text = "0"
fcl.Parent = sg1

local fci = Instance.new("TextLabel")
fci.Name = "fci"
fci.Size = UDim2.new(0, 40, 0, 20)
fci.Position = UDim2.new(0.3, -40, 0, 0)
fci.BackgroundTransparency = 1
fci.TextColor3 = Color3.fromRGB(100, 255, 100)
fci.TextSize = 14
fci.Font = Enum.Font.Gotham
fci.TextXAlignment = Enum.TextXAlignment.Right
fci.Text = ""
fci.Parent = sg1

local ti = Instance.new("TextLabel")
ti.Name = "ti"
ti.Size = UDim2.new(0, 20, 0, 20)
ti.Position = UDim2.new(0.33, 0, 0, 0)
ti.BackgroundTransparency = 1
ti.TextColor3 = Color3.fromRGB(150, 150, 150)
ti.TextSize = 16
ti.Font = Enum.Font.Gotham
ti.Text = "🗑️"
ti.Parent = sg1

local tcl = Instance.new("TextLabel")
tcl.Name = "tcl"
tcl.Size = UDim2.new(0.3, -30, 0, 20)
tcl.Position = UDim2.new(0.33, 25, 0, 0)
tcl.BackgroundTransparency = 1
tcl.TextColor3 = Color3.fromRGB(220, 220, 255)
tcl.TextSize = 14
tcl.Font = Enum.Font.Gotham
tcl.TextXAlignment = Enum.TextXAlignment.Left
tcl.Text = "0"
tcl.Parent = sg1

local tci = Instance.new("TextLabel")
tci.Name = "tci"
tci.Size = UDim2.new(0, 40, 0, 20)
tci.Position = UDim2.new(0.66, -40, 0, 0)
tci.BackgroundTransparency = 1
tci.TextColor3 = Color3.fromRGB(100, 255, 100)
tci.TextSize = 14
tci.Font = Enum.Font.Gotham
tci.TextXAlignment = Enum.TextXAlignment.Right
tci.Text = ""
tci.Parent = sg1

local di = Instance.new("TextLabel")
di.Name = "di"
di.Size = UDim2.new(0, 20, 0, 20)
di.Position = UDim2.new(0.66, 0, 0, 0)
di.BackgroundTransparency = 1
di.TextColor3 = Color3.fromRGB(100, 200, 255)
di.TextSize = 16
di.Font = Enum.Font.Gotham
di.Text = "💎"
di.Parent = sg1

local dcl = Instance.new("TextLabel")
dcl.Name = "dcl"
dcl.Size = UDim2.new(0.34, -30, 0, 20)
dcl.Position = UDim2.new(0.66, 25, 0, 0)
dcl.BackgroundTransparency = 1
dcl.TextColor3 = Color3.fromRGB(220, 220, 255)
dcl.TextSize = 14
dcl.Font = Enum.Font.Gotham
dcl.TextXAlignment = Enum.TextXAlignment.Left
dcl.Text = "0"
dcl.Parent = sg1

local dci = Instance.new("TextLabel")
dci.Name = "dci"
dci.Size = UDim2.new(0, 40, 0, 20)
dci.Position = UDim2.new(1, -40, 0, 0)
dci.BackgroundTransparency = 1
dci.TextColor3 = Color3.fromRGB(100, 255, 100)
dci.TextSize = 14
dci.Font = Enum.Font.Gotham
dci.TextXAlignment = Enum.TextXAlignment.Right
dci.Text = ""
dci.Parent = sg1

local ci = Instance.new("TextLabel")
ci.Name = "ci"
ci.Size = UDim2.new(0, 20, 0, 20)
ci.Position = UDim2.new(0, 0, 0, 30)
ci.BackgroundTransparency = 1
ci.TextColor3 = Color3.fromRGB(220, 220, 255)
ci.TextSize = 16
ci.Font = Enum.Font.Gotham
ci.Text = "🎯"
ci.Parent = sg1

local tcl2 = Instance.new("TextLabel")
tcl2.Name = "tcl2"
tcl2.Size = UDim2.new(0.3, -30, 0, 20)
tcl2.Position = UDim2.new(0, 25, 0, 30)
tcl2.BackgroundTransparency = 1
tcl2.TextColor3 = Color3.fromRGB(220, 220, 255)
tcl2.TextSize = 14
tcl2.Font = Enum.Font.Gotham
tcl2.TextXAlignment = Enum.TextXAlignment.Left
tcl2.Text = "0"
tcl2.Parent = sg1

local ti2 = Instance.new("TextLabel")
ti2.Name = "ti2"
ti2.Size = UDim2.new(0, 20, 0, 20)
ti2.Position = UDim2.new(0.33, 0, 0, 30)
ti2.BackgroundTransparency = 1
ti2.TextColor3 = Color3.fromRGB(220, 220, 255)
ti2.TextSize = 16
ti2.Font = Enum.Font.Gotham
ti2.Text = "⏱️"
ti2.Parent = sg1

local trl = Instance.new("TextLabel")
trl.Name = "trl"
trl.Size = UDim2.new(0.67, -25, 0, 20)
trl.Position = UDim2.new(0.33, 25, 0, 30)
trl.BackgroundTransparency = 1
trl.TextColor3 = Color3.fromRGB(220, 220, 255)
trl.TextSize = 14
trl.Font = Enum.Font.Gotham
trl.TextXAlignment = Enum.TextXAlignment.Left
trl.Text = "00:00:00"
trl.Parent = sg1

local ri = Instance.new("TextLabel")
ri.Name = "ri"
ri.Size = UDim2.new(0, 20, 0, 20)
ri.Position = UDim2.new(0, 0, 0, 60)
ri.BackgroundTransparency = 1
ri.TextColor3 = Color3.fromRGB(100, 255, 100)
ri.TextSize = 16
ri.Font = Enum.Font.Gotham
ri.Text = "📈"
ri.Parent = sg1

local fpl = Instance.new("TextLabel")
fpl.Name = "fpl"
fpl.Size = UDim2.new(0.5, -30, 0, 20)
fpl.Position = UDim2.new(0, 25, 0, 60)
fpl.BackgroundTransparency = 1
fpl.TextColor3 = Color3.fromRGB(220, 220, 255)
fpl.TextSize = 14
fpl.Font = Enum.Font.Gotham
fpl.TextXAlignment = Enum.TextXAlignment.Left
fpl.Text = "0.0/min"
fpl.Parent = sg1

local nci = Instance.new("TextLabel")
nci.Name = "nci"
nci.Size = UDim2.new(0, 20, 0, 20)
nci.Position = UDim2.new(0.5, 0, 0, 60)
nci.BackgroundTransparency = 1
nci.TextColor3 = Color3.fromRGB(255, 200, 100)
nci.TextSize = 16
nci.Font = Enum.Font.Gotham
nci.Text = "⏳"
nci.Parent = sg1

local ncl = Instance.new("TextLabel")
ncl.Name = "ncl"
ncl.Size = UDim2.new(0.5, -30, 0, 20)
ncl.Position = UDim2.new(0.5, 25, 0, 60)
ncl.BackgroundTransparency = 1
ncl.TextColor3 = Color3.fromRGB(255, 200, 100)
ncl.TextSize = 14
ncl.Font = Enum.Font.Gotham
ncl.TextXAlignment = Enum.TextXAlignment.Left
ncl.Text = "0s"
ncl.Parent = sg1

local sp2 = Instance.new("Frame")
sp2.Name = "sp2"
sp2.Size = UDim2.new(1, -20, 0, 40)
sp2.Position = UDim2.new(0, 10, 0, 140)
sp2.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
sp2.BorderSizePixel = 0
sp2.Parent = cf

local usc = Instance.new("UICorner")
usc.CornerRadius = UDim.new(0, 8)
usc.Parent = sp2

local si = Instance.new("TextLabel")
si.Name = "si"
si.Size = UDim2.new(0, 24, 0, 24)
si.Position = UDim2.new(0, 10, 0, 8)
si.BackgroundTransparency = 1
si.TextColor3 = Color3.fromRGB(100, 255, 100)
si.TextSize = 18
si.Font = Enum.Font.Gotham
si.Text = "✅"
si.Parent = sp2

local sl = Instance.new("TextLabel")
sl.Name = "sl"
sl.Size = UDim2.new(1, -50, 1, 0)
sl.Position = UDim2.new(0, 40, 0, 0)
sl.BackgroundTransparency = 1
sl.TextColor3 = Color3.fromRGB(100, 255, 100)
sl.TextSize = 16
sl.Font = Enum.Font.GothamBold
sl.TextXAlignment = Enum.TextXAlignment.Left
sl.Text = "Active - Fishing..."
sl.TextScaled = true
sl.TextWrapped = true
sl.Parent = sp2

local equipBtn = Instance.new("TextButton")
equipBtn.Name = "equipBtn"
equipBtn.Size = UDim2.new(0, 80, 0, 30)
equipBtn.Position = UDim2.new(1, -90, 0.5, -15)
equipBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 180)
equipBtn.BorderSizePixel = 0
equipBtn.Text = "Equip Rod"
equipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
equipBtn.TextSize = 14
equipBtn.Font = Enum.Font.GothamBold
equipBtn.Visible = false
equipBtn.Parent = sp2

local equipBtnCorner = Instance.new("UICorner")
equipBtnCorner.CornerRadius = UDim.new(0, 6)
equipBtnCorner.Parent = equipBtn

local sp3 = Instance.new("ScrollingFrame")
sp3.Name = "sp3"
sp3.Size = UDim2.new(1, -20, 0, 130)
sp3.Position = UDim2.new(0, 10, 0, 190)
sp3.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
sp3.BorderSizePixel = 0
sp3.ScrollBarThickness = 4
sp3.ScrollBarImageColor3 = Color3.fromRGB(220, 220, 255)
sp3.CanvasSize = UDim2.new(0, 0, 0, 130)
sp3.Parent = cf

local usc2 = Instance.new("UICorner")
usc2.CornerRadius = UDim.new(0, 8)
usc2.Parent = sp3

local st2 = Instance.new("TextLabel")
st2.Name = "st2"
st2.Size = UDim2.new(1, 0, 0, 30)
st2.BackgroundTransparency = 1
st2.TextColor3 = Color3.fromRGB(220, 220, 255)
st2.TextSize = 16
st2.Font = Enum.Font.GothamBold
st2.Text = "⚙️ Settings"
st2.Parent = sp3

local src = Instance.new("Frame")
src.Name = "src"
src.Size = UDim2.new(1, -20, 0, 30)
src.Position = UDim2.new(0, 10, 0, 30)
src.BackgroundTransparency = 1
src.Parent = sp3

local srl = Instance.new("TextLabel")
srl.Name = "srl"
srl.Size = UDim2.new(0.35, 0, 1, 0)
srl.BackgroundTransparency = 1
srl.TextColor3 = Color3.fromRGB(220, 220, 255)
srl.TextSize = 14
srl.Font = Enum.Font.Gotham
srl.TextXAlignment = Enum.TextXAlignment.Left
srl.Text = "Success Rate:"
srl.Parent = src

local srf = Instance.new("Frame")
srf.Name = "srf"
srf.Size = UDim2.new(0.5, 0, 0, 20)
srf.Position = UDim2.new(0.35, 0, 0.5, -10)
srf.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
srf.BorderSizePixel = 0
srf.Parent = src

local usrc = Instance.new("UICorner")
usrc.CornerRadius = UDim.new(0, 6)
usrc.Parent = srf

local srs = Instance.new("Frame")
srs.Name = "srfs"
srs.Size = UDim2.new(1, 0, 1, 0)
srs.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
srs.BorderSizePixel = 0
srs.Parent = srf

local ussc = Instance.new("UICorner")
ussc.CornerRadius = UDim.new(0, 6)
ussc.Parent = srs

local srk = Instance.new("TextButton")
srk.Name = "srk"
srk.Size = UDim2.new(0, 20, 0, 20)
srk.Position = UDim2.new(1, -10, 0.5, -10)
srk.BackgroundColor3 = Color3.fromRGB(220, 220, 255)
srk.BorderSizePixel = 0
srk.Text = ""
srk.Parent = srf

local usrk = Instance.new("UICorner")
usrk.CornerRadius = UDim.new(1, 0)
usrk.Parent = srk

local srv = Instance.new("TextLabel")
srv.Name = "srv"
srv.Size = UDim2.new(0.15, 0, 1, 0)
srv.Position = UDim2.new(0.85, 0, 0, 0)
srv.BackgroundTransparency = 1
srv.TextColor3 = Color3.fromRGB(220, 220, 255)
srv.TextSize = 14
srv.Font = Enum.Font.Gotham
srv.Text = "100%"
srv.Parent = src

local trc = Instance.new("Frame")
trc.Name = "trc"
trc.Size = UDim2.new(1, -20, 0, 30)
trc.Position = UDim2.new(0, 10, 0, 70)
trc.BackgroundTransparency = 1
trc.Parent = sp3

local trl2 = Instance.new("TextLabel")
trl2.Name = "trl2"
trl2.Size = UDim2.new(0.35, 0, 1, 0)
trl2.BackgroundTransparency = 1
trl2.TextColor3 = Color3.fromRGB(220, 220, 255)
trl2.TextSize = 14
trl2.Font = Enum.Font.Gotham
trl2.TextXAlignment = Enum.TextXAlignment.Left
trl2.Text = "Slow fishing🐢 :"
trl2.Parent = trc

local trf = Instance.new("Frame")
trf.Name = "trf"
trf.Size = UDim2.new(0.5, 0, 0, 20)
trf.Position = UDim2.new(0.35, 0, 0.5, -10)
trf.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
trf.BorderSizePixel = 0
trf.Parent = trc

local utrc = Instance.new("UICorner")
utrc.CornerRadius = UDim.new(0, 6)
utrc.Parent = trf

local trs = Instance.new("Frame")
trs.Name = "trfs"
trs.Size = UDim2.new(0, 0, 1, 0)
trs.BackgroundColor3 = Color3.fromRGB(150, 150, 255)
trs.BorderSizePixel = 0
trs.Parent = trf

local utsc = Instance.new("UICorner")
utsc.CornerRadius = UDim.new(0, 6)
utsc.Parent = trs

local trk = Instance.new("TextButton")
trk.Name = "trk"
trk.Size = UDim2.new(0, 20, 0, 20)
trk.Position = UDim2.new(0, -10, 0.5, -10)
trk.BackgroundColor3 = Color3.fromRGB(220, 220, 255)
trk.BorderSizePixel = 0
trk.Text = ""
trk.Parent = trf

local utrk = Instance.new("UICorner")
utrk.CornerRadius = UDim.new(1, 0)
utrk.Parent = trk

local trv = Instance.new("TextLabel")
trv.Name = "trv"
trv.Size = UDim2.new(0.15, 0, 1, 0)
trv.Position = UDim2.new(0.85, 0, 0, 0)
trv.BackgroundTransparency = 1
trv.TextColor3 = Color3.fromRGB(220, 220, 255)
trv.TextSize = 14
trv.Font = Enum.Font.Gotham
trv.Text = "0%"
trv.Parent = trc

local im = false
local ih = false
local fb

local function cfb()
    local fb = Instance.new("TextButton")
    fb.Size = UDim2.new(0, 50, 0, 50)
    fb.Position = UDim2.new(0.9, -25, 0.5, -25)
    fb.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    fb.Text = "🎣"
    fb.TextSize = 24
    fb.TextColor3 = Color3.fromRGB(220, 220, 255)
    fb.Font = Enum.Font.Gotham
    fb.Active = true
    fb.Draggable = true
    
    local ufc = Instance.new("UICorner")
    ufc.CornerRadius = UDim.new(1, 0)
    ufc.Parent = fb
    
    fb.Parent = sg
    
    fb.MouseButton1Click:Connect(function()
        ih = false
        mf.Visible = true
        fb.Visible = false
    end)
    
    return fb
end

local function adjustUIForScreenSize()
    local screenSize = workspace.CurrentCamera.ViewportSize
    local screenHeight = screenSize.Y
    local screenWidth = screenSize.X
    
    local targetHeight = math.min(330, screenHeight * 0.7)
    local targetWidth = math.min(320, screenWidth * 0.8)
    
    mf.Size = UDim2.new(0, targetWidth, 0, targetHeight)
    mf.Position = UDim2.new(0.5, -targetWidth/2, 0.5, -targetHeight/2)
    
    local contentHeight = targetHeight - 40
    cf.Size = UDim2.new(1, 0, 0, contentHeight)
    
    local statsHeight = contentHeight * 0.36
    sp.Size = UDim2.new(1, -20, 0, statsHeight)
    
    local statusHeight = contentHeight * 0.12
    sp2.Size = UDim2.new(1, -20, 0, statusHeight)
    sp2.Position = UDim2.new(0, 10, 0, statsHeight + 20)
    
    local settingsHeight = contentHeight * 0.52 - 20
    sp3.Size = UDim2.new(1, -20, 0, settingsHeight)
    sp3.Position = UDim2.new(0, 10, 0, statsHeight + statusHeight + 30)
    
    sp3.CanvasSize = UDim2.new(0, 0, 0, 110)
    
    fcl.Size = UDim2.new(0.3, -30, 0, 20)
    tcl.Size = UDim2.new(0.3, -30, 0, 20)
    dcl.Size = UDim2.new(0.34, -30, 0, 20)
    
    fpl.Size = UDim2.new(0.5, -30, 0, 20)
    ncl.Size = UDim2.new(0.5, -30, 0, 20)
end

mb.MouseButton1Click:Connect(function()
    
end)

hb.MouseButton1Click:Connect(function()
    ih = true
    mf.Visible = false
    
    if not fb then
        fb = cfb()
    else
        fb.Visible = true
    end
end)

local function msd(sf, sl, kn, vl, min, max, vf, cb)
    local isDragging = false
    
    local function updateSlider(relX)
        local clamped = math.clamp(relX, 0, 1)
        sl.Size = UDim2.new(clamped, 0, 1, 0)
        kn.Position = UDim2.new(clamped, -10, 0.5, -10)
        
        local val = min + (max - min) * clamped
        vl.Text = string.format(vf, val)
        
        if cb then
            cb(val)
        end
    end
    
    sf.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            isDragging = true
            updateSlider((input.Position.X - sf.AbsolutePosition.X) / sf.AbsoluteSize.X)
        end
    end)
    
    sf.InputChanged:Connect(function(input)
        if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or
                          input.UserInputType == Enum.UserInputType.Touch) then
            updateSlider((input.Position.X - sf.AbsolutePosition.X) / sf.AbsoluteSize.X)
        end
    end)
    
    sf.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            isDragging = false
        end
    end)
    
    kn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            isDragging = true
        end
    end)
    
    kn.InputChanged:Connect(function(input)
        if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or 
                          input.UserInputType == Enum.UserInputType.Touch) then
            updateSlider((input.Position.X - sf.AbsolutePosition.X) / sf.AbsoluteSize.X)
        end
    end)
    
    kn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            isDragging = false
        end
    end)
    
    sf.TouchTap:Connect(function(touchPositions)
        if #touchPositions > 0 then
            local touchPos = touchPositions[1].Position
            if touchPos then
                updateSlider((touchPos.X - sf.AbsolutePosition.X) / sf.AbsoluteSize.X)
            end
        end
    end)
end

msd(srf, srs, srk, srv, 0, 100, "%d%%", function(v)
    fc = v
end)

msd(trf, trs, trk, trv, 0, 100, "%d%%", function(v)
    local baseTime = 43
    local maxExtension = 15
    local extension = (maxExtension * v) / 100
    cd = {baseTime, baseTime + 5 + extension}
end)

local function checkFishingRod()
    hasFishingRod = false
    rodEquipped = false
    rodInBackpack = false
    
    if lp.Character then
        local rod = lp.Character:FindFirstChild("Fishing Rod")
        if rod then
            hasFishingRod = true
            rodEquipped = true
            fr = rod:FindFirstChild("fishingRemote")
            return
        end
    end
    
    if lp.Backpack then
        local rod = lp.Backpack:FindFirstChild("Fishing Rod")
        if rod then
            hasFishingRod = true
            rodInBackpack = true
            return
        end
    end
end

local function equipFishingRod()
    if lp.Backpack then
        local rod = lp.Backpack:FindFirstChild("Fishing Rod")
        if rod and lp.Character and lp.Character:FindFirstChild("Humanoid") then
            lp.Character.Humanoid:EquipTool(rod)
        end
    end
end

equipBtn.MouseButton1Click:Connect(equipFishingRod)

local function ufr()
    local ch = lp.Character
    if ch then
        local rod = ch:FindFirstChild("Fishing Rod")
        if rod then
            fr = rod:FindFirstChild("fishingRemote")
            rodEquipped = true
            hasFishingRod = true
            rodInBackpack = false
        else
            rodEquipped = false
            checkFishingRod()
        end
    end
end

local function rat()
    local ch = lp.Character
    if ch then
        for _, tl in ipairs(ch:GetChildren()) do
            if tl:IsA("Tool") and tl.Name == "Fishing Rod" then
                lp.Character.Humanoid:UnequipTools()
                task.wait(math.random(3,6)/10)
                lp.Character.Humanoid:EquipTool(tl)
                task.wait(math.random(3,6)/10)
                tl:Activate()
            end
        end
    end
end

local lastUpdateTime = 0
local function ug()
    if not fcl or not tcl or not dcl or not tcl2 or not trl or not fpl or not ncl or not sl or not si then return end
    
    checkFishingRod()
    
    if not hasFishingRod then
        sl.Text = "No fishing rod found! Buy one first."
        sl.TextColor3 = Color3.fromRGB(255, 100, 100)
        si.TextColor3 = Color3.fromRGB(255, 100, 100)
        si.Text = "❌"
        equipBtn.Visible = false
    elseif rodInBackpack then
        sl.Text = "Fishing rod in backpack. Equip it!"
        sl.TextColor3 = Color3.fromRGB(255, 200, 100)
        si.TextColor3 = Color3.fromRGB(255, 200, 100)
        si.Text = "⚠️"
        equipBtn.Visible = true
    elseif rodEquipped and not ap then
        sl.Text = "Waiting for cast..."
        sl.TextColor3 = Color3.fromRGB(255, 200, 100)
        si.TextColor3 = Color3.fromRGB(255, 200, 100)
        si.Text = "⏳"
        equipBtn.Visible = false
        ncl.Text = "Ready"
    elseif ap then
        sl.Text = "Active - Fishing..."
        sl.TextColor3 = Color3.fromRGB(100, 255, 100)
        si.TextColor3 = Color3.fromRGB(100, 255, 100)
        si.Text = "✅"
        equipBtn.Visible = false
        
        local tl = math.max(0, nct - os.time())
        ncl.Text = tl .. "s"
    end
    
    local fishDiff = st.fc - lastStats.fc
    local trashDiff = st.tc - lastStats.tc
    local diamondDiff = st.dc - lastStats.dc
    
    fcl.Text = tostring(st.fc)
    tcl.Text = tostring(st.tc)
    dcl.Text = tostring(st.dc)
    tcl2.Text = tostring(st.tt)
    
    if fishDiff > 0 then
        fci.Text = "+" .. tostring(fishDiff)
        fci.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        fci.Text = ""
    end
    
    if trashDiff > 0 then
        tci.Text = "+" .. tostring(trashDiff)
        tci.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        tci.Text = ""
    end
    
    if diamondDiff > 0 then
        dci.Text = "+" .. tostring(diamondDiff)
        dci.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        dci.Text = ""
    end
    
    lastStats.fc = st.fc
    lastStats.tc = st.tc
    lastStats.dc = st.dc
    
    local currentTime = os.time()
    if currentTime > lastUpdateTime then
        lastUpdateTime = currentTime
        
        local tr = currentTime - st.st
        local h = math.floor(tr / 3600)
        local m = math.floor((tr % 3600) / 60)
        local s = tr % 60
        trl.Text = string.format("%02d:%02d:%02d", h, m, s)
        
        if tr > 0 then
            st.fpm = st.fc / (tr / 60)
        end
        fpl.Text = string.format("%.1f/min", st.fpm)
    end
end

local function fgd()
    local rf = rs:WaitForChild("Remotes"):WaitForChild("RemoteFunctions")
    local gd = rf:WaitForChild("GetData")
    
    local s, d = pcall(function()
        return gd:InvokeServer()
    end)
    
    if s and d then
        if d.fishingItems then
            st.fc = d.fishingItems.Fish or 0
            st.tc = d.fishingItems.Trash or 0
            st.dc = d.fishingItems.Diamond or 0
        end
        if d.fishes then
            st.tt = d.fishes
        end
    end
end

pcall(fgd)

local function af()
    if ap or not rodEquipped then return end
    ap = true
    st.tt = st.tt + 1
    
    local dt = math.random(cd[1], cd[2])
    nct = os.time() + dt
    
    local st1 = os.clock()
    repeat task.wait() until os.clock() - st1 >= dt
    
    if ap and rodEquipped and fr then
        if math.random(1, 100) <= fc then
            vc = lp.UserId * game.PlaceVersion // 30
            
            fr:FireServer({
                fishingAction = "destroyBuoy",
                validateFishing = vc
            })
            task.wait(wt / 10)
            fr:FireServer({
                fishingAction = "fish",
                validateFishing = vc
            })
        else
            rat()
        end
    end
    
    task.wait(wt / 10)
    ap = false
    if rodEquipped then
        rat()
    end
end

game:GetService("Workspace").Temp.DescendantAdded:Connect(function(instance)
    if instance.Name == lp.UserId .. ".buoy" then
        if not ap and rodEquipped then
            vc = lp.UserId * game.PlaceVersion // 30
            
            task.spawn(af)
        end
    end
end)

game:GetService("Workspace").Temp.DescendantRemoving:Connect(function(instance)
    if instance.Name == lp.UserId .. ".buoy" then
        local cm = math.floor((os.time() - st.st) / 60)
        st.sf[cm] = (st.sf[cm] or 0) + 1
        st.lct = os.time()
        
        task.wait(4)
        local tool = lp.Character and lp.Character:FindFirstChild("Fishing Rod")
        if tool and not game:GetService("Workspace").Temp:FindFirstChild(lp.UserId .. ".buoy") then
            tool:Activate()
        end
    end
end)

lp.CharacterAdded:Connect(function(character)
    rodEquipped = false
    hasFishingRod = false
    rodInBackpack = false
    fr = nil
    
    character:WaitForChild("Humanoid")
    
    task.wait(1)
    checkFishingRod()
    ufr()
end)

lp.Backpack.ChildAdded:Connect(function(item)
    if item.Name == "Fishing Rod" then
        rodInBackpack = true
        hasFishingRod = true
        rodEquipped = false
    end
end)

lp.Backpack.ChildRemoved:Connect(function(item)
    if item.Name == "Fishing Rod" then
        task.wait(0.1)
        checkFishingRod()
    end
end)

if lp.Character then
    checkFishingRod()
    ufr()
end

workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(adjustUIForScreenSize)
adjustUIForScreenSize()

task.spawn(function()
    while true do
        pcall(fgd)
        pcall(ug)
        task.wait(1)
    end
end)


game:GetService("NetworkClient").ChildRemoved:Connect(function()
            if #Players:GetPlayers() <= 1 then
                Players.LocalPlayer:Kick("\nAuto Reconnect...")
                wait()
                game:GetService("TeleportService"):Teleport(game.PlaceId, Players.LocalPlayer)
            else
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
            end
        end)
        
        game.Players.LocalPlayer.Idled:Connect(function()
            local VU = game:GetService("VirtualUser")
            VU:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            wait(1)
            VU:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end)
