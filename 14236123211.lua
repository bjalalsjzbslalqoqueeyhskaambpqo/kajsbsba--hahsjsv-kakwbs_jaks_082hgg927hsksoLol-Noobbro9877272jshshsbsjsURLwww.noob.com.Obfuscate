local UL = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/MyLibrery.lua"))()

local gN = ""
local function cGN(n)
    n = n:gsub("%b[]", ""):match("^[^:]*"):match("^%s*(.-)%s*$")
    return n
end

local p = game.Players.LocalPlayer
local sg = UL:CrSG("Defauld")
local frm, cfrm, crFrm = UL:CrFrm(sg, gN)
local pp = p:WaitForChild("PlayerGui")

local function gPG()
    return p:FindFirstChild("PlayerGui")
end

local function gWUI()
    local pg = gPG()
    if pg then
        return pg:FindFirstChild("WishingwellUI")
    end
    return nil
end

local function cSG()
    local sg = Instance.new("ScreenGui")
    sg.Name = "TimeRemainingGui"
    sg.Parent = gPG()
    sg.ResetOnSpawn = false
    return sg
end

local sg = cSG()

local function cF()
    local f = Instance.new("Frame")
    f.Name = "TimeFrame"
    f.Size = UDim2.new(0, 350, 0, 20)
    f.Position = UDim2.new(0.6, 0, 0.96, 0)
    f.BackgroundTransparency = 0.5
    f.BackgroundColor3 = Color3.new(0, 0, 0)
    f.Parent = sg
    return f
end

local f = cF()

local function cTL()
    local tl = Instance.new("TextLabel")
    tl.Name = "TimeLabel"
    tl.Size = UDim2.new(1, 0, 1, 0)
    tl.Position = UDim2.new(0, 0, 0, 0)
    tl.TextColor3 = Color3.new(1, 1, 1)
    tl.BackgroundTransparency = 1
    tl.Font = Enum.Font.SourceSansBold
    tl.TextScaled = true
    tl.Text = "No Have Wish"
    tl.Parent = f
    return tl
end

local tl = cTL()

local auto = false
local wis = "Small"
local myOB, myOF = UL:AddOBtn(cfrm, "Options Wishingwell")

UL:AddTBtn(myOF, "Auto Buy Wish", false, function() 
    auto = not auto 
    tl.Text = "No Have - Wish Auto buy: " .. tostring(auto) .. " Select: " .. wis 
end)

local function noti(title, text, duration)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration,
    })
end

UL:AddBtn(myOF, " Select Small 15 minutes - 2 Wish", function() 
    wis = "Small" 
    noti("Wish Select Small", "Proce 50 Gems", 5)
end)

UL:AddBtn(myOF, "Select Medium 1 hs - 3 Wish", function() 
    wis = "Medium"
    noti("Wish Select Medium", "Price 200 Gems", 5)
end)

UL:AddBtn(myOF, "Select Mega 3 hs - 4 Wish", function() 
    wis = "Mega" 
    noti("Wish Select Mega", "Price 1000 Gems", 5)
end)

UL:AddBtn(myOF, "Buy Wish Select", function() 
    local args = {[1] = tostring(wis)}
    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("WishingWell"):FireServer(unpack(args)) 
end)

local function uTR()
    local wui = gWUI()
    if wui then
        local wl = wui:FindFirstChild("Frame") and wui.Frame:FindFirstChild("top") and wui.Frame.top:FindFirstChild("WISH")
        if wl then
            local text = wl.Text
            local tR = text:match("<font size='200'>(%d+%s*h%s*%d+%s*m%s*%d+%s*s)%s*REMAINING!</font>") or
                       text:match("<font size='200'>(%d+%s*m%s*%d+%s*s)%s*REMAINING!</font>")
            
            if tR then
                tl.Text = "Time Wish: " .. tR .. " Auto buy: " .. tostring(auto) .. " Select: "  .. wis
            elseif text == "None. Feed me gems for a surprise!" and auto then
                local args = {[1] = tostring(wis)}
                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("WishingWell"):FireServer(unpack(args))
            else
                tl.Text = "No Have Wish:  Auto buy: " .. tostring(auto) .. " Select: "  .. wis
            end
        end
    end
end

local function cWL()
    local wui = gWUI()
    if wui then
        local wl = wui:FindFirstChild("Frame") and wui.Frame:FindFirstChild("top") and wui.Frame.top:FindFirstChild("WISH")
        if wl then
            wl:GetPropertyChangedSignal("Text"):Connect(uTR)
        end
    end
end

cWL()
uTR()

local function goi()
    local wui = gWUI()
    if wui then
        local to = wui:FindFirstChild("Frame")
        if to and to:FindFirstChild("top") and to.top:FindFirstChild("WISH") then
            local text = to.top.WISH.Text:match("^%s*(.-)%s*$"):gsub("%s+", " ")
            if text == "None. Feed me gems for a surprise!" then
                local args = {tostring(wis)}
                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("WishingWell"):FireServer(unpack(args))
            end
        end
    end
end

local function yaw()
    while true do
        if auto then
            goi()
        end
        task.wait(3)
    end
end

local function sAF(gui)
    if gui and gui:IsA("ScreenGui") then
        for _, frame in ipairs(gui:GetChildren()) do
            if frame:IsA("Frame") then
                frame.Visible = true
            end
        end
    end
end

local MOB, MOF = UL:AddOBtn(cfrm, "UI Structures")

local function showUI(uiName)
    local ui = pp:FindFirstChild(uiName)
    if ui then
        ui.Enabled = true
        sAF(ui)
    end
end

UL:AddBtn(MOF, "AltarUI", function() showUI("AltarUI") end)
UL:AddBtn(MOF, "GemShop", function() showUI("GemShop") end)
UL:AddBtn(MOF, "Hacker", function() showUI("Hacker") end)
UL:AddBtn(MOF, "PerksShop", function() showUI("PerksShop") end)
UL:AddBtn(MOF, "MergeEquipment", function() showUI("MergeEquipment") end)
UL:AddBtn(MOF, "TempleUI", function() showUI("TempleUI") end)

UL:AddBtn(MOF, "JesterUi", function() 
    showUI("JesterUi")
    noti("Visible all efects", "5s", 5)
    task.wait(0.5)
    for i = 1, 10 do
        local cf = pp.JesterUi.Frame.cardframe[i]
        local le = cf:FindFirstChild("Locked")
        if le and le.Visible then
            le.Visible = false
            task.spawn(function()
                task.wait(5)
                le.Visible = true
            end)
        end
    end
end)

local function copy(text)
    if syn then
        syn.write_clipboard(text)
    else
        setclipboard(text)
    end
end

local OP, OF = UL:AddOBtn(cfrm, "Options Items >")

local sC = nil

UL:AddTBox(OF, "Item Purchase Multiplier: 1", function(text)
    local input = tonumber(text)
    if input and input > 0 then
        sC = input
    else
        sC = nil
    end
end)

local kyo = false
UL:AddTBtn(cfrm, "Auto Get Gift time", false, function()
    kyo = not kyo
    while kyo do
        for i = 1, 12 do
            local args = {[1] = i}
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PlaytimeRewardUpdateEvent"):FireServer(unpack(args))
            task.wait(1)
        end
    end
end)

local eAS = false

local function gFN(instance)
    return instance:GetFullName()
end

local function tTS(t, indent)
    indent = indent or 0
    local result = "{\n"
    local padding = string.rep(" ", indent + 2)
    for k, v in pairs(t) do
        if typeof(v) == "Instance" then
            result = result .. padding .. tostring(k) .. " = " .. gFN(v) .. ",\n"
        elseif type(v) == "table" then
            result = result .. padding .. tostring(k) .. " = " .. tTS(v, indent + 2) .. ",\n"
        else
            result = result .. padding .. tostring(k) .. " = " .. tostring(v) .. ",\n"
        end
    end
    return result .. string.rep(" ", indent) .. "}"
end

local function dA(...)
    local dArgs = {}
    for _, arg in ipairs({...}) do
        if type(arg) == "table" then
            dArgs[#dArgs + 1] = tTS(arg)
        elseif typeof(arg) == "Instance" then
            dArgs[#dArgs + 1] = gFN(arg)
        else
            dArgs[#dArgs + 1] = tostring(arg)
        end
    end
    return dArgs
end

local remote = game.ReplicatedStorage:WaitForChild("Events"):WaitForChild("GenerateEquipment")
local mR = game.ReplicatedStorage:WaitForChild("Events"):WaitForChild("PlayerMergeEquipment")

remote.OnClientEvent:Connect(function(...)
    if eAS then 
        local args = {...}
        local dArgs = dA(...)

        local gI = {}
        for _, arg in ipairs(args) do
            if type(arg) == "table" then
                for id, item in pairs(arg) do
                    if type(item) == "table" and item.equipped == false and item.rarity ~= "Demonic" then
                        local key = item.name .. "_" .. item.rarity
                        if not gI[key] then
                            gI[key] = {}
                        end
                        table.insert(gI[key], {id = id, item = item})
                    end
                end
            end
        end

        for key, items in pairs(gI) do
            if #items >= 3 then
                local iTS = {tostring(items[1].id), tostring(items[2].id), tostring(items[3].id)}
                local args = {[1] = iTS}
                mR:FireServer(unpack(args))
            end
        end
    end
end)

UL:AddTBtn(OF, "Auto Merge Items", false, function()
    eAS = not eAS
end)

local RS = game:GetService("ReplicatedStorage")
local Events = RS:WaitForChild("Events")
local CE = Events:WaitForChild("CraftingEvent")

local iCFS = false

local function nFFS(...)
    local args = {...}
    iCFS = true
    if sC and sC > 0 then
        for i = 1, sC do
            CE:FireServer(unpack(args))
        end
    else
        CE:FireServer(unpack(args))
    end
    iCFS = false
end

local mt = getrawmetatable(game)
local oN = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    if method == "FireServer" and self == CE and not iCFS then
        task.spawn(function()
            nFFS(unpack(args))
        end)
        return oN(self, unpack(args))
    end
    return oN(self, ...)
end)

setreadonly(mt, true)

local running = false
local world = ""
local worldd

local function sOE(world)
    running = true
    while running do
        local args = {[1] = tostring(world)}
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PlayerPressedKeyOnEgg"):FireServer(unpack(args))
        task.wait(0.3)
    end
end

p.PlayerScripts:FindFirstChild("PlayerPetHandler").Enabled = false
noti("Animation Egg Oppen", "Desabled Default", 5)

UL:AddTBox(cfrm, "Auto Egg-number world or 'stop", function(value) 
    worldd = value
    if value == "" or value:lower() == "stop" then
        running = false
        noti("Stop Open Egg", "Egg opening stopped", 5)
        return
    end

    local nW = tonumber(value)
    if nW then
        world = nW
        running = false
        noti("Open Egg", "Starting to open eggs in world: " .. world, 5)
        task.wait(0.1)
        sOE(world)
    end
end)

UL:AddBtn(cfrm, "Tp Egg Worl", function()
    local tp = workspace.EggVendors[worldd]:GetModelCFrame().Position + Vector3.new(0, 15, 0)
    p.Character:MoveTo(tp)
    task.wait(0.2)
    p.Character.HumanoidRootPart.Anchored = true
    task.wait(2)
    p.Character.HumanoidRootPart.Anchored = false
end)

local ah = false
UL:AddTBtn(cfrm, "Auto Fast Train", false, function(state)
    ah = not ah
    while ah do
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("DamageIncreaseOnClickEvent"):FireServer()
        task.wait()
    end
end)

p.PlayerScripts.DeathEffectsHandler.Disabled = true
p.PlayerScripts.CameraHandler.Disabled = true

UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 20/05/24 ")
UL:AddText(crFrm, "Update Script: 17/06/24")
UL:AddText(crFrm, "Script Version: 0.7")
UL:AddBtn(crFrm, "Send text for Discord", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX/OneCreatorX/main/Scripts/MsgDev.lua"))() end)
UL:AddBtn(crFrm, "Copy link YouTube", function() copy("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() copy("https://discord.com/invite/UNJpdJx7c4") end)

local arg2, arg3 = 1, 1
local ja = false
local function ah()
    task.wait(0.1)
    if ja then
        local args = {[1] = true}
        for i = 1, 8 do
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PushEvent"):FireServer(unpack(args))
        end
        task.wait(0.5)
        p.Character:MoveTo(workspace.BreakableParts["Stage" .. arg2][arg3]:GetModelCFrame().Position)
    end
end

local mt = getrawmetatable(game)
local oN = mt.__namecall
setreadonly(mt, false)

UL:AddTBtn(cfrm, "Fast Auto Fight", false, function() 
    ja = not ja
    if not ja then
        local args = {[1] = "StopFight"}
        game:GetService("ReplicatedStorage"):WaitForChild("dEvents"):WaitForChild("AutoFight"):FireServer(unpack(args))
    else
        noti("Use Auto Fight", "Button Game for farm", 5)
    end
end)    

local RS = game:GetService("ReplicatedStorage")
local Events = RS:WaitForChild("Events")
local AF = Events:WaitForChild("AutoFight")
local oFS = AF.FireServer

local function nFS(self, ...)
    local args = {...}
    arg2 = args[2]
    arg3 = args[3]
    
    if args[1] == "StopFight" then
        return oN(self, ...)
    else
        task.spawn(ah)
        return oFS(self, unpack(args))
    end
end

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "FireServer" and self == AF then
        return nFS(self, ...)
    end
    return oN(self, ...)
end)

setreadonly(mt, true)

local wS = 40
local sD = 9
local aD = 9
local rE = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PunchEvent")

local Player = game:GetService("Players").LocalPlayer

local function fCN()
    local character = Player.Character or Player.CharacterAdded:Wait()
    local hRP = character:WaitForChild("HumanoidRootPart")
    
    local cN = nil
    local cD = math.huge

    for _, NPC in pairs(workspace.BreakableParts.Dungeon:GetChildren()) do
        if NPC:IsA("Model") and NPC.PrimaryPart then
            local distance = (NPC.PrimaryPart.Position - hRP.Position).Magnitude
            if distance < cD then
                cD = distance
                cN = NPC
            end
        end
    end

    return cN
end

local function aAM()
    local character = Player.Character or Player.CharacterAdded:Wait()
    local hRP = character:WaitForChild("HumanoidRootPart")
        
    local cN = fCN()
    if cN then
        local direction = (cN.PrimaryPart.Position - hRP.Position).unit
        local distance = (cN.PrimaryPart.Position - hRP.Position).Magnitude
        local nP = hRP.Position + direction * math.min(distance - aD, sD - 1)

        character:MoveTo(nP)
        rE:FireServer(cN)
    end
end

local a = false

local limite = 1000

UL:AddTBox(cfrm, "Number Limite Wave", function(userInput) 
    if userInput == "" then
        limite = 1000
        noti("Wave limit appl", "Max limit waves: " .. limite, 5)
    else
        limite = tonumber(userInput)
        if limite then
            noti("Wave limit appl", "Max limit waves: " .. limite, 5)
        else
            noti("Error", "Invalid input for wave limit", 5)
        end
    end
end)

local function sND()
    if a then
        task.wait(2)
        local args = {[1] = "StartDungeon"}
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("DungeonEvent"):FireServer(unpack(args))
    end
end

function Start()
    a = not a
    if a then
        local args = {[1] = "StartDungeon"}
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("DungeonEvent"):FireServer(unpack(args))
    else
        local args = {[1] = "Exit"}
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("DungeonEvent"):FireServer(unpack(args))
        task.wait(1)
        Player.PlayerGui.DungeonFinishUI.Enabled = true
    end
end

UL:AddTBtn(cfrm, "Start - Auto: Dungeon", false, function(state) 
    Start()
end)

local tREN = "PartyEvent"
local PE = RS:WaitForChild("Events"):WaitForChild(tREN)

local mt = getrawmetatable(game)
local oN = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "FireServer" and self.Name == tREN then
        task.spawn(sND)
        return oN(self, ...)
    end
    return oN(self, ...)
end)

setreadonly(mt, true)

local claim = false
local cE = nil
local eS = nil

function cUGC()
    if claim then
        local args = {cE}
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("NewUGCEvents"):WaitForChild("ClickedEventClaimButton"):FireServer(unpack(args))
    end
end

function reintentar()
    task.wait(1)
    if claim then
        if cE == nil then
            noti("Click in Event UGC", "or not Working", 5)
            reintentar()
        else
            local args = {cE}
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("NewUGCEvents"):WaitForChild("RequestEventData"):FireServer(unpack(args))
        end
    end
end

local function hRED()
    local mt = getrawmetatable(game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("NewUGCEvents"):WaitForChild("RequestEventData"))
    local oFS = mt.__namecall

    setreadonly(mt, false)

    mt.__namecall = newcclosure(function(self, ...)
        local args = {...}
        local method = getnamecallmethod()

        if method == "FireServer" and self.Name == "RequestEventData" and claim then
            cE = args[1]
        end

        return oFS(self, ...)
    end)

    setreadonly(mt, true)
end

local function hSEQS()
    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("NewUGCEvents"):WaitForChild("SendEventQuestStats").OnClientEvent:Connect(function(eventName, stats)
        if eventName == cE and claim then
            eS = stats
            
            local aQC = true
            for _, quest in pairs(stats) do
                if quest.current < quest.required then
                    aQC = false
                    task.spawn(reintentar)
                    break
                end
            end
            
            if aQC then
                task.spawn(cUGC)
            end
        end
    end)
end

UL:AddTBtn(cfrm, "Auto GET and Claim UGC", false, function(state)
    claim = not claim 
    if claim then
        reintentar()
        task.spawn(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/Auto%20Buyer(Fast%20Claim).lua"))()
        end)
    end
end)

hRED()
hSEQS()

local function oPD()
    task.wait(0.8)
    local args = {[1] = "LeaveParty"}
    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PartyEvent"):FireServer(unpack(args))
    Player.PlayerGui.DungeonFinishUI.Enabled = false
    task.wait(1)
end

local function mPH(humanoid)
    humanoid.HealthChanged:Connect(function(health)
        if health <= 0 then
            oPD()
        end
    end)
end

local function sCM(player)
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        mPH(humanoid)
    end)

    if player.Character then
        local humanoid = player.Character:WaitForChild("Humanoid")
        mPH(humanoid)
    end
end

local player = game.Players.LocalPlayer
sCM(player)

task.spawn(function()
    while true do
        local success, err = pcall(function()
            local mT = Player.PlayerGui.DungeonMain.Frame.Wave.WaveNumber.Text
            local max = tonumber(mT:match("%d+"))
            
            if a then
                if limite ~= nil and max and max <= limite then
                    aAM()
                    task.wait()
                elseif limite ~= nil and max and max >= limite and workspace:FindFirstChild("Dungeon") then
                    local args = {[1] = "Exit"}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("DungeonEvent"):FireServer(unpack(args))
                    task.wait(2)
                elseif limite ~= nil and not workspace:FindFirstChild("Dungeon") then
                    task.wait(0.8)
                    local args = {[1] = "LeaveParty"}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PartyEvent"):FireServer(unpack(args))
                    Player.PlayerGui.DungeonFinishUI.Enabled = false
                    task.wait(1)
                else
                    task.wait(0.1)
                end
            else
                task.wait(0.1)
            end
        end)
        
        if not success then
            task.wait(0.1)
        end
    end
end)

local RS = game:GetService("RunService")
local SG = game:GetService("StarterGui")

local nS = {
    buyButton = false,
    cancelButton = false
}

local function sN(title, text, duration)
    if not nS[title] then
        SG:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration,
        })
        nS[title] = true
    end
end

local function cCB(purchasePrompt)
    local cBT = nil
    local zTB = nil

    for _, descendant in ipairs(purchasePrompt:GetDescendants()) do
        if descendant:IsA("TextLabel") and descendant.Name == "Text" then
            local text = descendant.Text:lower()
            if text == "cancelar" or text == "cancel" then
                cBT = text
            elseif text == "0" then
                zTB = descendant
            end
        end
    end

    if zTB and claim then
        local bCX = zTB.AbsolutePosition.X + zTB.AbsoluteSize.X / 0.45
        local bCY = zTB.AbsolutePosition.Y + zTB.AbsoluteSize.Y / 0.45
        
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(bCX, bCY, 0, true, game, 1)
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(bCX, bCY, 0, false, game, 1)
        sN("FREE UGC Available", "Auto Claim Accept. By:OneCreatorX", 5)
    elseif cBT then
        for _, descendant in ipairs(purchasePrompt:GetDescendants()) do
            if descendant:IsA("TextLabel") and descendant.Name == "Text" and descendant.Text:lower() == cBT then
                local bCX = descendant.AbsolutePosition.X + descendant.AbsoluteSize.X / 0.45
                local bCY = descendant.AbsolutePosition.Y + descendant.AbsoluteSize.Y / 0.45
                
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(bCX, bCY, 0, true, game, 1)
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(bCX, bCY, 0, false, game, 1)
                sN("NO FREE UGC", "Auto Claim Decline. By:OneCreatorX", 5)
                break
            end
        end
    end
end

local cG = game:GetService("CoreGui")
local pP = cG:WaitForChild("PurchasePrompt")
local claimm = false

RS.Heartbeat:Connect(function()
    if claimm then
        local bF = false

        for _, descendant in ipairs(pP:GetDescendants()) do
            if descendant:IsA("TextLabel") and descendant.Name == "Text" then
                bF = true
                break
            end
        end

        if not bF then
            nS = {
                buyButton = false,
                cancelButton = false
            }
        end

        cCB(pP)
    end
end)

yaw()
