local UL = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/MyLibrery.lua"))()

local plrs = game:GetService("Players")
local rs = game:GetService("RunService")
local mps = game:GetService("MarketplaceService")

local p = plrs.LocalPlayer
local sg = UL:CrSG("Default")

local function cleanName(n)
    return n:gsub("%b[]", ""):match("^[^:]*"):match("^%s*(.-)%s*$")
end

local gName = cleanName(mps:GetProductInfo(game.PlaceId).Name)
local f, cf, crf = UL:CrFrm(sg, gName)

local active = false

local function getTycoon()
    return workspace:FindFirstChild(p.Name .. "_Tycoon")
end

local function getCashier()
    local tycoon = getTycoon()
    return tycoon and tycoon:FindFirstChild("MainItems") and tycoon.MainItems:FindFirstChild("Cashier")
end

local function moveTo(pos)
    if p.Character then
        local humanoid = p.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            
            if humanoid.Sit then
                humanoid.Sit = false
                task.wait(0.1) -- Esperar un poco para que se levante
            end

            if p.Character:FindFirstChild("HumanoidRootPart") then
                p.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
            end
        end
    end
end

local function collectCash()
    local cashier = getCashier()
    if cashier and cashier:FindFirstChild("Bank") and cashier.Bank:FindFirstChild("Outline") then
        moveTo(cashier.Bank.Outline.Position + Vector3.new(0, 2, 0))
        task.wait(0.5)
    end
end

local function activateProximities()
    local tycoon = getTycoon()
    if not tycoon then return end
    
    for _, i in tycoon:GetDescendants() do
        if i:IsA("ProximityPrompt") and i.Parent and i.Parent.Name == "UnlockedButton" then
            moveTo(i.Parent.Position + Vector3.new(0, 2, 0))
            task.wait(0.5)
            fireproximityprompt(i)
            
            repeat
                task.wait()
            until not i:IsDescendantOf(game) or not i.Parent or i.Parent.Name ~= "UnlockedButton"
            
            
            return true
        end
    end
    return false
end

local function setupUseButton()
    local connection
    connection = p.PlayerGui.ReactTree.DescendantAdded:Connect(function(d)
        if d:IsA("TextButton") and d.Name == "UseButton" then
            connection:Disconnect()
            local function fireEvents(b)
                local events = {"Activated", "MouseButton1Click", "MouseButton1Down", "MouseButton1Up", "InputBegan", "InputEnded"}
                for _, e in ipairs(events) do
                    for _, c in ipairs(getconnections(b[e])) do
                        if c.Function and c.Enabled then
                            task.spawn(c.Function)
                        end
                    end
                end
            end
            fireEvents(d)
            task.wait(0.1)
            setupUseButton()
        end
    end)
end

local function mainLoop()
    while active do
        if getTycoon() then
            collectCash()
            task.wait(1)
            if activateProximities() then
                task.wait()
            end
        end
        task.wait()
    end
end

UL:AddTBtn(cf, "Auto Tycoon", false, function()
    active = not active
    if active then
        task.spawn(mainLoop)
        setupUseButton()
    end
end)

UL:AddText(crf, "By Script: OneCreatorX")
UL:AddText(crf, "Create Script: 04/08/24")
UL:AddText(crf, "Update Script: --/--/--")
UL:AddText(crf, "Script Version: 0.6")
UL:AddBtn(crf, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crf, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

p.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

local function handleTextModalButton()
    local player = game.Players.LocalPlayer
    local textModal = player.PlayerGui:WaitForChild("UXGuis"):WaitForChild("TextModal")
    local targetButton = textModal.Frame.Footer.TextButton

    local function interactWithButton()
        if textModal.Enabled and targetButton.Visible then
            local events = {"MouseButton1Click", "MouseButton1Down", "MouseButton1Up", "Activated", "InputBegan", "InputEnded"}
            for _, eventName in ipairs(events) do
                for _, connection in pairs(getconnections(targetButton[eventName])) do
                    pcall(function()
                        connection:Fire()
                    end)
                end
            end
        end
    end

    textModal:GetPropertyChangedSignal("Enabled"):Connect(interactWithButton)
end

handleTextModalButton()
