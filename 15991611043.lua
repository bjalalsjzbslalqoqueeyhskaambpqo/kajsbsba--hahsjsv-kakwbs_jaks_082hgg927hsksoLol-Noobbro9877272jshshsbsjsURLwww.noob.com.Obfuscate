local UL = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/MyLibrery.lua"))()
local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

local function cleanGameName(name)
    name = name:gsub("%b[]", "")
    name = name:match("^[^:]*")
    return name:match("^%s*(.-)%s*$")
end

gameName = cleanGameName(gameName)
local p = game.Players.LocalPlayer
local sg = UL:CrSG("Default")
local frm, cfrm, crFrm = UL:CrFrm(sg, gameName)

local eggs = game.Workspace.Map.Eggs:GetChildren()

table.sort(eggs, function(a, b)
    local aValue = a:FindFirstChild("EggValue") and a.EggValue.Value or 0
    local bValue = b:FindFirstChild("EggValue") and b.EggValue.Value or 0
    return aValue < bValue
end)

local eggsPerFrame = 7
local numFrames = math.ceil(#eggs / eggsPerFrame)

for i = 1, numFrames do
    local startIndex = (i - 1) * eggsPerFrame + 1
    local endIndex = math.min(i * eggsPerFrame, #eggs)
    local mainOptionsButton, mainOptionsFrame = UL:AddOBtn(cfrm, "Fast Open Eggs " .. startIndex .. "-" .. endIndex)
    
    for j = startIndex, endIndex do
        local child = eggs[j]
        if child and child:FindFirstChild("EggValue") then
            local buttonName = child.Name .. " (" .. child.EggValue.Value .. ")"
            UL:AddTBtn(mainOptionsFrame, buttonName, false, function() 
                local name = child.Name
                local er = false
                er = not er
                while er do
                    local args = {
                        [1] = tostring(name),
                        [2] = 1
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Egg"):InvokeServer(unpack(args))
                    wait(0.1)
                end
            end)
        end
    end
end

local active = false

local damage = game.Players.LocalPlayer.Data.PlayerData.Damage
local mt = getrawmetatable(damage)
local old_index = mt.__index

setreadonly(mt, false)

mt.__index = function(instance, index)
    if index == "Value" and active then
        return 900
    end
    return old_index(instance, index)
end

setreadonly(mt, true)

local tp = false
UL:AddTBtn(cfrm, "Inject All", false, function() 
    active = not active 
end)


local eggg = false
UL:AddTBtn(cfrm, "Auto Hit Block", false, function() 
    eggg = not eggg
    while eggg do
        local area = workspace:WaitForChild("BreakablesByArea")
        for _, obj in ipairs(area:GetDescendants()) do
            if obj:IsA("ClickDetector") then
                obj.MaxActivationDistance = 10000
                spawn(function()
                    pcall(function()
                        if tp and obj.Parent.Transparency == 0 and not obj.Parent.BillboardGui.Frame.HealthText.Text:find("Cooldown") then
                            p.Character.PrimaryPart.CFrame = obj.Parent.CFrame + Vector3.new(0, 2, 0)
                        end
                    end)
                end)
                fireclickdetector(obj)
                wait()
            end
        end
    end
end)
UL:AddTBtn(cfrm, "TP Block", false, function() 
    tp = not tp
end)

UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 20/06/24 ")
UL:AddText(crFrm, "Update Script: 13/07/24")
UL:AddText(crFrm, "Script Version: 0.5")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)
