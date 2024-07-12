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


local tiers = workspace.Tiers
local playerName = game.Players.LocalPlayer.Name
local pattern = playerName .. "'s Tycoon"

local a

-- Función para imprimir el contenido de la propiedad Text de todos los Owner encontrados
local function printAllTycoonOwnersText(parent)
    for _, child in ipairs(parent:GetDescendants()) do
        if child:IsA("TextLabel") and child.Name == "Owner" and child.Text == pattern then
            print("Owner encontrado:", child.Text)
           a = child.Parent.Parent.Parent
        end
    end
end

-- Imprimir contenido de Text de todos los Owner dentro de Bakery en Tiers
local bakery = tiers.Bakery
print("Buscando Owners en Bakery...")
printAllTycoonOwnersText(bakery)

UL:AddTBtn(cfrm, "Auto Collect", false, function() 
ya = not ya

while ya do
local plr = game.Players.LocalPlayer
firetouchinterest(plr.Character.HumanoidRootPart, a.Collector, 0)
        wait()
        firetouchinterest(plr.Character.HumanoidRootPart, a.Collector, 1)
wait(2)
end
 end)

UL:AddTBtn(cfrm, "Auto Buttons", false, function() 
yay = not yay
while yay do

for _, obj in ipairs(a.Loaded:GetDescendants()) do
    if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then
        local parentName = obj.Parent.Name
        if parentName:find("Button") and parentName:match("^Button%d+$") then
            local plr = game.Players.LocalPlayer
            local y = obj.Position
            
            plr.Character.HumanoidRootPart.CFrame = obj.CFrame
        
wait(1)
        end
    end
            end
wait()
end
end)

UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 12/07/24 ")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)
