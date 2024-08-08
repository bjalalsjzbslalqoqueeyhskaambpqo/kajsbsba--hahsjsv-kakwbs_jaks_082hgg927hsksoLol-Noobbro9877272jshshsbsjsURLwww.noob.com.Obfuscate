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


UL:AddTBtn(cfrm, "Auto Tasks", false, function()

a = not a
while a do
fireproximityprompt(workspace.ScriptableObjects.EventAssets.Scoops.Counter.ProximityPrompt)
wait(2)
fireproximityprompt(workspace.ScriptableObjects.EventAssets.Scoops.Ingredients.Dairy.Root.ProximityPrompt)
fireproximityprompt(workspace.ScriptableObjects.EventAssets.Scoops.Ingredients.Dough.Root.ProximityPrompt)
fireproximityprompt(workspace.ScriptableObjects.EventAssets.Scoops.Ingredients.Fruit.Root.ProximityPrompt)
fireproximityprompt(workspace.ScriptableObjects.EventAssets.Scoops.Ingredients.Meat.Root.ProximityPrompt)
fireproximityprompt(workspace.ScriptableObjects.EventAssets.Scoops.Ingredients.Sauce.Root.ProximityPrompt)
fireproximityprompt(workspace.ScriptableObjects.EventAssets.Scoops.Ingredients.Veggies.Root.ProximityPrompt)
wait(1)
fireproximityprompt(Workspace.ScriptableObjects.EventAssets.Scoops.Machines.IceCream.ProximityPrompt)
wait(7)
fireproximityprompt(Workspace.ScriptableObjects.EventAssets.Scoops.Machines.IceCream.ProximityPrompt)
wait(2)
fireproximityprompt(workspace.ScriptableObjects.EventAssets.Scoops.Counter.ProximityPrompt)
wait(5)
end
wait()

 end)


UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 08/08/24 ")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)
