local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()

local ui = MiniUI:new("Sky Farm Island")

local selectedPlants = {}

local tuto = ui:Sub("Tutorial")

tuto:TBtn("Laksa Leaves", function()
if selectedPlants["Laksa Leaves"] then
            selectedPlants["Laksa Leaves"] = nil
        else
            selectedPlants["Laksa Leaves"] = true
        end
end)

tuto:TBtn("Jasmine Rice", function()
if selectedPlants["Jasmine Rice"] then
            selectedPlants["Jasmine Rice"] = nil
        else
            selectedPlants["Jasmine Rice"] = true
        end
end)

ui:Btn("Materials", function()
for _, r in game.Workspace.QuestSpawnAreas:GetDescendants() do
if r:FindFirstChild("Model") then
game.Players.LocalPlayer.Character:MoveTo(r.Position)
wait(1)
end
end
end)

local main = ui:Sub("Plants")

for _, r in game.ReplicatedStorage.Assets.CropsModel:GetChildren() do
    main:TBtn(r.Name, function()
        if selectedPlants[r.Name] then
            selectedPlants[r.Name] = nil
        else
            selectedPlants[r.Name] = true
        end
    end)
end

local function getRandomPlant()
    local plantList = {}
    for plant, _ in pairs(selectedPlants) do
        table.insert(plantList, plant)
    end
    if #plantList > 0 then
        return plantList[math.random(1, #plantList)]
    else
        return nil
    end
end


local b = false

ui:TBtn("Auto Plants", function()
b = not b

end)





ui:Btn("Collect Seed", function()
for _, we in workspace.AngPao:GetChildren() do
if we:FindFirstChild("TouchInterest") then
game.Players.LocalPlayer.Character:MoveTo(we.Position)
break
end
end
end)


local yat = false
ui:TBtn("Auto Donate", function()
yat = not yat
while yat do
local randomPlant = getRandomPlant()
                        if randomPlant then
                            local args = {
    [1] = randomPlant,
    [2] = 1
}

game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.4.7"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("DonateService"):WaitForChild("RF"):WaitForChild("DonateCrops"):InvokeServer(unpack(args))

                        else
                            
                        end
wait(0.5)
end
end)



function ya()
if not b then
wait(0.4)
ya()
end
    local function activateProximityPrompt(prompt)
        for i = 1, 10 do
            fireproximityprompt(prompt)
            wait(0.05)
        end
    end

    local function equipTool(toolName)
        local args = {
            [1] = toolName
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.4.7"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("ToolService"):WaitForChild("RF"):WaitForChild("EquipTool"):InvokeServer(unpack(args))
        wait(0.3)
    end

    local function initializePlanter(planter, cropType)
        local args = {
            [1] = planter,
            [2] = cropType
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.4.7"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("CropService"):WaitForChild("RF"):WaitForChild("RequestInitializePlanter"):InvokeServer(unpack(args))
    end

    local function checkAndRefillWater()
        local waterQuantity = tonumber(game.Players.LocalPlayer.PlayerGui.HUD.Tools.List.Watering.Quantity.Text)
        if waterQuantity and waterQuantity < 1 then
            
            game.Players.LocalPlayer.Character:MoveTo(workspace[game.Players.LocalPlayer.Name .. "Farm"].WaterGenerator:GetModelCFrame().Position)
            wait(0.4)
            fireproximityprompt(workspace[game.Players.LocalPlayer.Name .. "Farm"].WaterGenerator.ProximityPrompt)
            wait(0.7)
            return true
        end
        return false
    end

    local function checkAndRefillFertilizer()
        local waterQuantity = tonumber(game.Players.LocalPlayer.PlayerGui.HUD.Tools.List.Fertilizer.Quantity.Text)
        if waterQuantity and waterQuantity < 1 then
            
            game.Players.LocalPlayer.Character:MoveTo(workspace.FoodWasteGenerator.FoodWasteGenerator.Position)
            wait(0.4)
            fireproximityprompt(workspace.BlackFly.PrimaryPart.ProximityPrompt)
            wait(0.5)
            game.Players.LocalPlayer.Character:MoveTo(workspace.FoodWasteGenerator.FoodWasteGenerator.Position)
            wait(0.4)
            fireproximityprompt(workspace.FoodWasteGenerator.FoodWasteGenerator.ProximityPrompt)
            wait(0.7)
            return true
        end
        return false
    end

if not workspace.Plots:FindFirstChild(game.Players.LocalPlayer.Name) then
for _, ta in workspace.PlotClaimDetectors:GetChildren() do
if ta:FindFirstChild("TouchInterest") then
game.Players.LocalPlayer.Character:MoveTo(ta.Position)
wait(0.6)
break
end
wait(0.7)
end
end

    for _, e in workspace.Plots[game.Players.LocalPlayer.Name]:GetDescendants() do
        if e:IsA("ProximityPrompt") then
            local billboardGui = e.Parent:FindFirstChild("BillboardGui")
            if billboardGui then
                local infoLabel = billboardGui:FindFirstChild("Info") and billboardGui.Info:FindFirstChild("TextLabel")
                local plusIcon = billboardGui:FindFirstChild("Info") and billboardGui.Info:FindFirstChild("Plus")
                local waterIcon = billboardGui:FindFirstChild("Info") and billboardGui.Info:FindFirstChild("Water")
                local fertilizerIcon = billboardGui:FindFirstChild("Info") and billboardGui.Info:FindFirstChild("Fertilizer")
                local monitorTime = billboardGui:FindFirstChild("Clock")
                
                if monitorTime.Visible == false then
                    if infoLabel and infoLabel.Text == "READY TO HARVEST" then
                        local args = {
                            [1] = "Gardening"
                        }
                        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.4.7"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("ToolService"):WaitForChild("RF"):WaitForChild("EquipTool"):InvokeServer(unpack(args))
                        game.Players.LocalPlayer.Character:MoveTo(e.Parent.Position)
                        wait(0.7)
                        
                        activateProximityPrompt(e)
                    elseif infoLabel and infoLabel.Text == "CURRENTLY PLANTING" and plusIcon and plusIcon.Visible then
                        game.Players.LocalPlayer.Character:MoveTo(e.Parent.Position)
                        
                        equipTool("Gardening")
                        activateProximityPrompt(e)
                        local randomPlant = getRandomPlant()
                        if randomPlant then
                            initializePlanter(e.Parent.Parent, randomPlant)
                        else
                            print("No hay plantas seleccionadas para plantar")
                        end
                    elseif waterIcon and waterIcon.Visible then
                        
                        if checkAndRefillWater() then
                            wait(0.8)
                        end
                        game.Players.LocalPlayer.Character:MoveTo(e.Parent.Position)
                        equipTool("Watering")
                        activateProximityPrompt(e)
                    elseif fertilizerIcon and fertilizerIcon.Visible then
                        if checkAndRefillFertilizer() then
                            wait(0.7)
                        end
                        game.Players.LocalPlayer.Character:MoveTo(e.Parent.Position)
                        
                        equipTool("Fertilizer")
                        activateProximityPrompt(e)
                    else

                    end
                else
                    
                end
            end
        end
    end
    wait(1)
    ya()
end

wait(0.7)
infoSub = ui:Sub("Info Script")
infoSub:Txt("Version: 0.1")
infoSub:Txt("Create: 11/09/24")
infoSub:Txt("Update: -/-/-")
infoSub:Btn("Link YouTube", function()
   setclipboard("https://youtube.com/@onecreatorx") 
end)

infoSub:Btn("Link Discord", function()
  setclipboard("https://discord.com/invite/UNJpdJx7c4")  
end)
 

ya()
