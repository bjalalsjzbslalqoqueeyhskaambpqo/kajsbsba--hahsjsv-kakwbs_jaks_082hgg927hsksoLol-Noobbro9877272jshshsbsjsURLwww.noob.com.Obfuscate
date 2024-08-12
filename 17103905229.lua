spawn(function()
function eliminarObjeto(objeto)
    for _, hijo in ipairs(objeto:GetDescendants()) do
        if hijo:IsA("BasePart") then
            hijo:Destroy()
        end
    end
    objeto:Destroy()
end

local terreno = workspace.Map.Terrain
if terreno then
    if terreno:FindFirstChild("Mountains") then
        eliminarObjeto(terreno.Mountains)
    end
    if terreno:FindFirstChild("Rocks") then
        eliminarObjeto(terreno.Rocks)
    end
end

function dentroDelCubo(punto, centro, tamano)
    return math.abs(punto.X - centro.X) <= tamano.X/2 and
           math.abs(punto.Y - centro.Y) <= tamano.Y/2 and
           math.abs(punto.Z - centro.Z) <= tamano.Z/2
end

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local alturaInicial = character.HumanoidRootPart.Position.Y

local hearts = workspace.Map.Interactable.Hearts:GetChildren()
for _, heart in ipairs(hearts) do
    if heart:IsA("BasePart") then
        local eliminar = false
        if terreno.Mountains then
            for _, mountain in ipairs(terreno.Mountains:GetChildren()) do
                if mountain:IsA("BasePart") and dentroDelCubo(heart.Position, mountain.Position, mountain.Size) then
                    eliminar = true
                    break
                end
            end
        end
        if not eliminar and terreno.Rocks then
            for _, rock in ipairs(terreno.Rocks:GetChildren()) do
                if rock:IsA("BasePart") and dentroDelCubo(heart.Position, rock.Position, rock.Size) then
                    eliminar = true
                    break
                end
            end
        end
        if not eliminar and heart.Position.Y >= alturaInicial and heart.Position.Y <= alturaInicial + 90 then
            eliminar = true
        end
        if eliminar then
            heart:Destroy()
        end
    end
end

end)

pcall(function()
        for _, f in ipairs(workspace.Map.Interactable:GetDescendants()) do
            if f.Name == "GroupChest" or f.Name == "SpinWheel" then
                f:Destroy()
            end
        end

        workspace.Map.Decorations:Destroy()
        workspace.nightLights:Destroy()
        workspace.BillboardGui:Destroy()
        workspace.Map.Leaderboards:Destroy()

        local function destroySpecificObjects(parent)
            for _, child in ipairs(parent:GetChildren()) do
                if child.ClassName == "Model" and child.Name == "Model" then
                    child:Destroy()
                elseif child.ClassName == "MeshPart" and child.Name == "MeshPart" then
                    child:Destroy()
                elseif child.ClassName == "Part" and child.Name == "Part" then
                    child:Destroy()
                end
                destroySpecificObjects(child)
            end
        end

        for _, f in ipairs(workspace.Map.Interactable.MushroomHouses:GetDescendants()) do
            if f:IsA("Folder") and f.Name == "Other" then
                f:Destroy()
            end
        end
workspace.Map.Interactable.Other:Destroy()
Workspace.Billboards:Destroy()
Workspace.BillboardGui:Destroy()
workspace.nightLights:Destroy()
        destroySpecificObjects(workspace)
        
    end)
spawn(function()
        pcall(function()

local function findObject(parent, name)
    for _, child in ipairs(parent:GetChildren()) do
        if child.Name:lower() == name:lower() then
            return child
        end
    end
    return nil
end

local map = workspace:FindFirstChild("Map")
if not map then

    return
end

local ugcshop = findObject(map, "ugcshop")
if not ugcshop then
    
    return
end

local success, errmsg = pcall(function()
    ugcshop:Destroy()
end)

if not success then
    print("Error al destruir 'ugcshop': " .. errmsg)
else
    
end
    end)
end)

    local workspace = game:GetService("Workspace")
    local mapTerrain = workspace:WaitForChild("Map"):WaitForChild("Terrain")

    for _, obj in ipairs(mapTerrain:GetChildren()) do
        if not obj:IsA("Model") then
            obj:Destroy()
        end
    end



P = game:GetService("PathfindingService")
Pl = game:GetService("Players")
R = game:GetService("RunService")
L = Pl.LocalPlayer

a = false
s = 40
ph = 0
ht = 8
pt = 8
rt = 1

ct = nil
c = nil
h = nil
r = nil

function uc()
    c = L.Character
    h = c and c:FindFirstChildOfClass("Humanoid")
    r = c and c:FindFirstChild("HumanoidRootPart")
end

function gp(s, g)
    p = P:CreatePath({AgentRadius = 5, AgentHeight = 5, AgentCanJump = true, Costs = {Water = 20, Grass = 5}})
    p:ComputeAsync(s, g)
    return p.Status == Enum.PathStatus.Success and p:GetWaypoints() or nil
end

function sp(wp)
    simple = {wp[1]}
    for i = 2, #wp - 1 do
        if (wp[i].Position - simple[#simple].Position).Magnitude > pt then
            table.insert(simple, wp[i])
        end
    end
    table.insert(simple, wp[#wp])
    return simple
end

function mt(t)
    if not r or not h then return false end
    wp = gp(r.Position, t)
    if not wp then
        h:MoveTo(t)
        if (r.Position - t).Magnitude <= rt then return true end
        if (r.Position - t).Magnitude <= rt * 2 and t.Y > r.Position.Y + 3 then
            h.Jump = true
        end
        return false
    end
    for _, w in ipairs(sp(wp)) do
        if not a or ct ~= t then return false end
        h:MoveTo(w.Position)
        if w.Action == Enum.PathWaypointAction.Jump then h.Jump = true end
        if (r.Position - t).Magnitude <= rt then return true end
        if t.Y > r.Position.Y + 3 and (r.Position - Vector3.new(t.X, r.Position.Y, t.Z)).Magnitude <= rt then
            h.Jump = true
        end
    end
    return (r.Position - t).Magnitude <= rt
end

function sph()
    ph = r and r.Position.Y or 0
end

function aht()
    for _, heart in ipairs(workspace.Map.Interactable.Hearts:GetChildren()) do
        if heart:IsA("BasePart") then
            heart.Transparency = math.abs(heart.Position.Y - ph) <= ht and 0 or 1
        end
    end
end

function gnh()
    if not r then return nil end
    nh, nd = nil, math.huge
    for _, heart in ipairs(workspace.Map.Interactable.Hearts:GetChildren()) do
        if heart:IsA("BasePart") and heart.Transparency == 0 then
            d = (heart.Position - r.Position).Magnitude
            if d < nd then
                nh, nd = heart, d
            end
        end
    end
    return nh
end

function gncm()
    if not r then return nil end
    nm, nd = nil, math.huge
    for _, h in ipairs(workspace.Map.Interactable.MushroomHouses:GetChildren()) do
        if h.Touch.interactablePlatform.BillboardGui.Frame.TextLabel.Text == "Claim" then
            d = (h.Touch.interactablePlatform.Position - r.Position).Magnitude
            if d < nd then
                nm, nd = h, d
            end
        end
    end
    return nm
end

function ci()
    while a do
        uc()
        if not r or not h then
            wait(1)
            continue
        end
        m = gncm()
        if m then
            ct = m.Touch.interactablePlatform.Position
            if mt(ct) then
                firetouchinterest(r, m.Touch.interactablePlatform, 0)
                firetouchinterest(r, m.Touch.interactablePlatform, 1)
            end
        else
            heart = gnh()
            if heart then
                ct = heart.Position
                if mt(ct) then
                    heart:Destroy()
                end
            end
        end
        R.Heartbeat:Wait()
    end
end

function tc()
    a = not a
    if a then
        uc()
        sph()
        aht()
        task.spawn(ci)
    end
end


L.CharacterAdded:Connect(function(char)
    wait(1)
    uc()
    sph()
    aht()
    if h then h.WalkSpeed = s end
end)

workspace.Map.Interactable.Hearts.ChildAdded:Connect(function(child)
    if child:IsA("BasePart") then
        child.Transparency = math.abs(child.Position.Y - ph) <= ht and 0 or 1
    end
end)

L.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

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


UL:AddTBtn(cfrm, "Auto Walk Collect", false, tc)

UL:AddTBox(cfrm, "Speed use: 40-45", function(v) 
 s = tonumber(v) or s
    if h then h.WalkSpeed = s end
end)


UL:AddTBox(cfrm, "Height Tolerance: 3-10", function(ju) 
 ht = tonumber(ju) or ht
    aht()
end)

UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 12/08/24 ")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddText(crFrm, "Safe %: 100")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

pcall(function()
    local NetworkClient = game:GetService("NetworkClient")
    local Players = game:GetService("Players")
    local TeleportService = game:GetService("TeleportService")

    local PlaceId = game.GameId
    local localPlayer = Players.LocalPlayer

    NetworkClient.ChildRemoved:Connect(function(child)
        local PlaceId = game.PlaceId
        local JobId = game.JobId
        local TeleportService = game:GetService("TeleportService")

        if #game.Players:GetPlayers() <= 1 then
            game.Players.LocalPlayer:Kick("\nRejoining...")
            wait()

                    TeleportService:Teleport(PlaceId, game.Players.LocalPlayer)
        else
            TeleportService:TeleportToPlaceInstance(PlaceId, JobId, game.Players.LocalPlayer)
        end
    end)
end)

local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "Warn Speed ",
    Text = "do not use speed that causes (baibai)",
    Duration = 5,
})
local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "Advertencia",
    Text = "No Usar velocidad que provoque el (baibai)",
    Duration = 5,
})


spawn(function()
        local mt = getrawmetatable(game)
local old_index = mt.__index

setreadonly(mt, false)

mt.__index = function(instance, index)
    if tostring(instance) == "Humanoid" and index == "WalkSpeed" then
        return 16
    end
    return old_index(instance, index)
end

setreadonly(mt, true)
    end)
uc()
sph()
aht()
