local MUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()

local ui = MUI:new("Raise a Rainbacorn")
local ex = ui:Sub("Extra")

local plrs = game:GetService("Players")
local ts = game:GetService("TweenService")
local vim = game:GetService("VirtualInputManager")
local uis = game:GetService("UserInputService")

local lp = plrs.LocalPlayer

local tn = {"Bush1", "Bush2", "Bush3", "Bush4"}
local sC, sM, sF = 20, 50, 100
local isM, cT, cD = false, nil, false
local vUI = {}
local isA = false

local function tUI(h)
    if h then
        for _, g in ipairs(lp.PlayerGui:GetChildren()) do
            if g:IsA("ScreenGui") and g.Enabled then
                vUI[g] = true
                g.Enabled = false
            end
        end
        lp.PlayerGui:SetTopbarTransparency(1)
    else
        for g, _ in pairs(vUI) do
            if g.Parent then
                g.Enabled = true
            end
        end
        lp.PlayerGui:SetTopbarTransparency(0)
        vUI = {}
    end
end

local function fCam(t, c)
    local cam = workspace.CurrentCamera
    local tp = t:GetPrimaryPartCFrame().Position
    local cp = c.HumanoidRootPart.Position
    local o = (tp - cp).Unit * 5
    cam.CFrame = CFrame.new(cp + o, tp)
end

local function sClick()
    local cam = workspace.CurrentCamera
    local vs = cam.ViewportSize
    local cx, cy = vs.X / 2, vs.Y / 2
    vim:SendMouseButtonEvent(cx, cy, 0, true, game, 1)
    wait(0.1)
    vim:SendMouseButtonEvent(cx, cy, 0, false, game, 1)
end

local function mAA()
    if not isA or isM then return end
    
    local c = lp.Character
    if not c then return end
    local hrp = c:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local cT, cD = nil, math.huge
    for _, v in pairs(workspace:GetDescendants()) do
        for _, n in ipairs(tn) do
            if v:IsA("Model") and v.Name == n then
                local d = (v:GetPrimaryPartCFrame().Position - hrp.Position).Magnitude
                if d < cD then cT, cD = v, d end
            end
        end
    end
    
    if not cT then return end
    if cT == cT and cD < 3 then return end
    
    cT = cT
    isM = true
    tUI(true)

    local s = cD < 50 and sC or (cD < 200 and sM or sF)
    local t = cD / s

    local tw = ts:Create(hrp, TweenInfo.new(t, Enum.EasingStyle.Linear), {CFrame = cT:GetPrimaryPartCFrame()})
    tw:Play()
    tw.Completed:Wait()

    local cam = workspace.CurrentCamera
    local oCS = cam.CameraSubject
    local oCT = cam.CameraType
    local oCF = cam.CFrame

    cam.CameraType = Enum.CameraType.Scriptable

    for _, pt in pairs(c:GetDescendants()) do
        if pt:IsA("BasePart") then
            pt.CanCollide = false
            pt.Transparency = 1
        end
    end

    cD = false
    local cCon = uis.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            cD = true
        end
    end)

    local at = 0
    while not cD and at < 5 do
        fCam(cT, c)
        wait(0.5)
        sClick()
        wait(0.5)
        at = at + 1
        
        if not cD then
            local o = Vector3.new(math.random(-1, 1), math.random(-1, 1), math.random(-1, 1)).Unit * 2
            cam.CFrame = cam.CFrame * CFrame.new(o)
        end
    end

    cCon:Disconnect()

    for _, pt in pairs(c:GetDescendants()) do
        if pt:IsA("BasePart") then
            pt.CanCollide = true
            pt.Transparency = 0
        end
    end

    cam.CameraSubject = oCS
    cam.CameraType = oCT
    cam.CFrame = oCF
    
    tUI(false)
    isM = false
end

local pg = lp:WaitForChild("PlayerGui")
local ig = pg:WaitForChild("MainMenu"):WaitForChild("Root"):WaitForChild("Inventory"):WaitForChild("MainWindow")
local iG = ig:WaitForChild("ItemGrid")

local function sItem(item)
    local bf = item:FindFirstChild("Background")
    if bf and bf:IsA("Frame") then
        local esv = item:FindFirstChild("IsActive")
        if esv then
            esv:Destroy()
        end

        local eb = bf:FindFirstChild("StatusButton")
        if eb then
            eb:Destroy()
        end

        local sv = Instance.new("BoolValue")
        sv.Name = "IsActive"
        sv.Value = false
        sv.Parent = item

        local tb = Instance.new("TextButton")
        tb.Name = "StatusButton"
        tb.Size = UDim2.new(1, 0, 0.2, 0)
        tb.Position = UDim2.new(0, 0, 0, 0)
        tb.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        tb.Text = "Auto [OFF]"
        tb.TextColor3 = Color3.new(1, 1, 1)
        tb.TextStrokeTransparency = 0.8
        tb.Parent = bf

        local function uBtn()
            tb.BackgroundColor3 = sv.Value and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
            tb.Text = sv.Value and "Auto [ON]" or "Auto [OFF]"
        end

        sv.Changed:Connect(uBtn)
        tb.MouseButton1Click:Connect(function()
            sv.Value = not sv.Value
        end)

        uBtn()
    end
end

for _, item in pairs(iG:GetChildren()) do
    sItem(item)
end

iG.ChildAdded:Connect(sItem)

spawn(function()
    local rs = game:GetService("ReplicatedStorage")
    local dre = rs:WaitForChild("dataRemoteEvent")

    local act = {
        ["hug"] = "Hugged",
        ["bath"] = "Bathed",
        ["hungry"] = "Fed"
    }

    local ac = 15
    local pat = {}
    local ap = {}

    local function sas(pn, a)
        local args = {
            [1] = {
                [1] = "PetInteractAction",
                [2] = "'",
                [3] = {
                    [1] = "\1",
                    [2] = {
                        [1] = tostring(pn),
                        [2] = a
                    }
                },
                [4] = "\28"
            }
        }
        dre:FireServer(unpack(args))
    end

    local function dp(pn)
        local args = {
            [1] = {
                [1] = {
                    ["GUID"] = pn,
                    ["Category"] = "Pet"
                },
                [2] = "4"
            }
        }
        dre:FireServer(unpack(args))
    end

    local function ep(pn)
        local args = {
            [1] = {
                [1] = {
                    ["GUID"] = pn,
                    ["Category"] = "Pet"
                },
                [2] = "4"
            }
        }
        dre:FireServer(unpack(args))
    end

    local function fpn(i)
        while i and not i:IsA("Model") do
            i = i.Parent
        end
        if i and i:IsA("Model") then
            return i.Name
        end
        return "Unknown"
    end

    local function uap()
        ap = {}
        for _, item in pairs(iG:GetChildren()) do
            local bf = item:FindFirstChild("Background")
            if bf and bf:IsA("Frame") then
                local sv = item:FindFirstChild("IsActive")
                if sv and sv.Value then
                    table.insert(ap, item.Name)
                end
            end
        end
    end

    local function ipe(pn)
        local item = iG:FindFirstChild(pn)
        if item then
            local bf = item:FindFirstChild("Background")
            if bf and bf:IsA("Frame") then
                return bf:FindFirstChild("Equipped") ~= nil
            end
        end
        return false
    end

    local function fnuap()
        for _, pn in ipairs(ap) do
            if not ipe(pn) then
                return pn
            end
        end
        return nil
    end

    local function pcm()
        local udn = lp.Name .. ":Debris"
        local ud = workspace:FindFirstChild(udn)

        if not ud then
            return
        end

        while true do
            wait(0.1)
            uap()

            for _, child in ipairs(ud:GetDescendants()) do
                if child.Name == "ChatList" then
                    local cm = child:GetChildren()
                    if #cm >= 2 then
                        local sc = cm[2]
                        if sc:IsA("Frame") then
                            local tl = sc:FindFirstChildOfClass("TextLabel")
                            if tl then
                                local mt = tl.Text:lower()
                                local cpn = fpn(sc)

                                for key, action in pairs(act) do
                                    if mt:find(key) then
                                        local ct = tick()
                                        local lat = pat[cpn]

                                        if not lat or (ct - lat >= ac) then
                                            sas(cpn, action)
                                            pat[cpn] = ct
                                            ui:Notify("Pet Interaction: Waiting for server response", 3)
                                            wait(8)  

                                            local np = fnuap()

                                            if np then
                                                dp(cpn)
                                                ui:Notify("Rotating Pet: Deequipping Current Pet", 5)
                                                wait(5) 
                                                ep(np)
                                                ui:Notify("Rotating Pet: Equipping New", 5)
                                            else
                                                ui:Notify("No Pets Active: continue", 5)
                                            end

                                            break
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    spawn(pcm)
end)

spawn(function()
    while true do
        wait(0.3)
        
        local function aasa(a)
            if a then
                local na = #a:GetPlayingAnimationTracks()
                for i = 1, na do
                    local at = a:GetPlayingAnimationTracks()[i]
                    if at then
                        at:AdjustSpeed(100)
                    end
                end
            end
        end

        local function aaio(o)
            local a = o:FindFirstChildOfClass("Animator")
            if a then
                aasa(a)
            end
            for _, child in ipairs(o:GetChildren()) do
                aaio(child)
            end
        end

        local pn = game.Players.LocalPlayer.Name
        local udn = pn .. ":Debris"
        aaio(workspace[udn])
    end
end)
local b = false 
ex:TBtn("Collect Flowers", function(b) 
                b = not b
    while b do
        for _, h in ipairs(workspace.Activators:GetChildren()) do
            if h.Name == "Flower" and b then
                lp.Character.PrimaryPart.CFrame = h.Part.CFrame
                wait(0.5)
                fireproximityprompt(h.Part.ProximityPrompt)
                wait(0.2)
            end
        end
    end
end)

local b = false 
ex:TBtn("Collect Magic Feathers", function(b) 
        b = not b
    while b do
        for _, h in ipairs(workspace.Feathers:GetChildren()) do
            if h.Name == "Feather" and h:FindFirstChild("Root") and b then
                lp.Character.PrimaryPart.CFrame = h.Root.CFrame
                wait(0.5)
                fireproximityprompt(h.Root.ProximityPrompt)
                wait(0.2)
            end
        end
    end
end)

local b = false 
ui:TBtn("Auto Claim Gift", function(b) 
                b = not b
    while b do
        for i = 1, 9 do
            local args = {
                [1] = {
                    [1] = {
                        [1] = "\1",
                        [2] = "BERRIES_" .. i .. "00"
                    },
                    [2] = "9"
                }
            }
            game:GetService("ReplicatedStorage"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
            wait(1)
        end
    end
end)
local b = false 
ui:TBtn("Auto Bush Raiwb", function(b) 
                b = not b
    isA = b
    while isA do
        mAA()
        wait(1)
    end
end)

local b = false 
ui:TBtn("Auto Egg Secret", function(b)
    while b do
        local args = {
            [1] = {
                [1] = {
                    [1] = "\1",
                    [2] = "66111113-6A42-49B3-8F1E-2C5C5B646B57"
                },
                [2] = "G"
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
        wait(2)
    end
end)

ex:Btn("TP Secret Zone", function()
    lp.Character:MoveTo(Vector3.new(1356, 10, -3447))
    lp.Character.PrimaryPart.Anchored = true
    wait(3)
    lp.Character.PrimaryPart.Anchored = false
end)

ui:Notify("Auto Tasks Pet: Default Active", 5)

wait(0.7)
local is = ui:Sub("Info Script")
is:Txt("Version: 0.8")
is:Txt("Create: 20/07/24")
is:Txt("Update: 07/09/24")
is:Btn("Link YouTube", function()
   setclipboard("https://youtube.com/@onecreatorx") 
end)

is:Btn("Link Discord", function()
  setclipboard("https://discord.com/invite/UNJpdJx7c4")  
end)

lp.Idled:Connect(function()
    vim:CaptureController()
    vim:ClickButton2(Vector2.new())
end)
