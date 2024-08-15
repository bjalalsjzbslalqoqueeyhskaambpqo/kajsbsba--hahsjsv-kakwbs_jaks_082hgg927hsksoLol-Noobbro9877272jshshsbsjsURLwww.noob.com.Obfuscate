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

local spectatorEnabled = true
local a = false
UL:AddTBtn(cfrm, "Auto Tokens", false, function()
    a = not a
    while a do
pcall(function()
        for _, descendant in pairs(workspace.GameObjects:GetDescendants()) do
            if descendant.Name == "HumanoidRootPart" and descendant:IsA("BasePart") then
                local plr = game.Players.LocalPlayer
                            pcall(function()
firetouchinterest(plr.Character.HumanoidRootPart, descendant, 0)
        wait()
        firetouchinterest(plr.Character.HumanoidRootPart, descendant, 1)
                                end)
end
            end
        end)
        wait()
    end
end)

local a = false
UL:AddTBtn(cfrm, "Auto Tokens[TP]", false, function()
    a = not a
    while a do
pcall(function()
        for _, descendant in pairs(workspace.GameObjects:GetDescendants()) do
            if descendant.Name == "HumanoidRootPart" and descendant:IsA("BasePart") then
                local plr = game.Players.LocalPlayer
                            pcall(function()
plr.Character.HumanoidRootPart.CFrame = descendant.CFrame
                                end)
end
            end
        end)
        wait()
    end
end)




UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 15/08/24 ")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)


local Plrs = game:GetService("Players")
local RS = game:GetService("RunService")
local WS = game.Workspace
local specOn = true

local function createVis(p)
    local v = Instance.new("Folder")
    v.Name = p.Name .. "Vis"

    local function cPart(n)
        local pt = Instance.new("Part")
        pt.Name = n
        pt.Transparency = 1
        pt.CanCollide = false
        pt.Anchored = true
        pt.Parent = v

        local ba = Instance.new("BoxHandleAdornment")
        ba.Name = n .. "A"
        ba.Adornee = pt
        ba.AlwaysOnTop = true
        ba.ZIndex = 10
        ba.Size = pt.Size
        ba.Transparency = 0.3
        ba.Parent = pt

        return pt
    end

    cPart("T")
    cPart("H")
    cPart("LA")
    cPart("RA")
    cPart("LL")
    cPart("RL")

    local bg = Instance.new("BillboardGui")
    bg.Name = "IB"
    bg.Size = UDim2.new(0, 200, 0, 50)
    bg.StudsOffset = Vector3.new(0, 3, 0)
    bg.AlwaysOnTop = true
    bg.Parent = v

    local tl = Instance.new("TextLabel")
    tl.Name = "IT"
    tl.Size = UDim2.new(1, 0, 1, 0)
    tl.BackgroundTransparency = 1
    tl.TextScaled = true
    tl.Font = Enum.Font.SourceSansBold
    tl.TextColor3 = Color3.new(1, 1, 1)
    tl.TextStrokeTransparency = 0
    tl.TextStrokeColor3 = Color3.new(0, 0, 0)
    tl.Parent = bg

    v.Parent = WS
    return v
end

local function updateVis(p, v)
    local success, err = pcall(function()
        if not p.Character or not p.Character:FindFirstChild("HumanoidRootPart") then
            v.Parent = nil
            return
        end

        local r = p:FindFirstChild("Role")
        local isG = r and r.Value == "Ghost"
        local c = isG and Color3.new(1, 0, 0) or Color3.new(0, 0, 1)

        local function uPart(n, cp)
            local pt = v:FindFirstChild(n)
            if pt and cp then
                pt.CFrame = cp.CFrame
                pt.Size = cp.Size
                local a = pt:FindFirstChild(n .. "A")
                if a then
                    a.Size = cp.Size
                    a.Color3 = c
                end
            end
        end

        local char = p.Character
        uPart("T", char:FindFirstChild("UpperTorso"))
        uPart("H", char:FindFirstChild("Head"))
        uPart("LA", char:FindFirstChild("LeftUpperArm"))
        uPart("RA", char:FindFirstChild("RightUpperArm"))
        uPart("LL", char:FindFirstChild("LeftUpperLeg"))
        uPart("RL", char:FindFirstChild("RightUpperLeg"))

        local rp = char.HumanoidRootPart
        local bg = v:FindFirstChild("IB")
        if bg then bg.Adornee = rp end

        local d = (rp.Position - WS.CurrentCamera.CFrame.Position).Magnitude
        local it = v.IB.IT
        it.Text = string.format("%s\n%s\nD: %.1f", p.Name, r and r.Value or "Unk", d)

        v.Parent = WS
    end)
    
    if not success then
        
    end
end

local pVis = {}

local function onPA(p)
    pVis[p] = createVis(p)
end

local function onPR(p)
    if pVis[p] then
        pVis[p]:Destroy()
        pVis[p] = nil
    end
end

for _, p in ipairs(Plrs:GetPlayers()) do
    onPA(p)
end

Plrs.PlayerAdded:Connect(onPA)
Plrs.PlayerRemoving:Connect(onPR)

RS.RenderStepped:Connect(function()
    if not specOn then return end

    local success, err = pcall(function()
        local lp = Plrs.LocalPlayer
        local lpR = lp:FindFirstChild("Role")
        local isLPG = lpR and lpR.Value == "Ghost"

        for p, v in pairs(pVis) do
            if p ~= lp then
                updateVis(p, v)
                
                local char = p.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local rp = char.HumanoidRootPart
                    local r = p:FindFirstChild("Role")
                    local isPG = r and r.Value == "Ghost"
                    
                    if isLPG then
                        rp.Size = Vector3.new(20, 20, 20)
                    elseif isPG then
                        rp.Size = Vector3.new(20, 20, 20)
                    else
                        rp.Size = Vector3.new(2, 2, 1)
                    end
                end
            end
        end
    end)
    
    if not success then
        
    end
end)
