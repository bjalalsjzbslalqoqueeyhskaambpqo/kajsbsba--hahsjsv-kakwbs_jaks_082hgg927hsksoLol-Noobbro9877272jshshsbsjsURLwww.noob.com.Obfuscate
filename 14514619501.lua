local UL = loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX/OneCreatorX/main/UIs/MyLibrery.lua"))()

local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
local cleanGameName = function(name)
    return name:gsub("%b[]", ""):match("^[^:]*"):match("^%s*(.-)%s*$")
end
gameName = cleanGameName(gameName)

local p = game.Players.LocalPlayer
local sg = UL:CrSG("Default")
local frm, cfrm, crFrm = UL:CrFrm(sg, gameName)


OB, OF = UL:AddOBtn(cfrm, "MiniGames")

UL:AddTBtn(OF, "Auto Moños", a, function(b) 
    a = b
    while a do
        wait(0.1)
        for _, h in ipairs(workspace:GetChildren()) do
            if h.Name == "Bowtie" then
                fireproximityprompt(h["Meshes/bowV1.1_Cube"].ProximityPrompt)
            end
        end
    end
end)


UL:AddTBtn(cfrm, "Collect Flowers", a, function(b) 
    a = b
    while a do
        for _, h in ipairs(workspace.Activators:GetChildren()) do
            if h.Name == "Flower" and a then
                game.Players.LocalPlayer.Character.PrimaryPart.CFrame = h.Part.CFrame
wait(0.5)
                fireproximityprompt(h.Part.ProximityPrompt)
                wait(0.2)
            end
        end
    end
end)

UL:AddTBtn(cfrm, "Collect Magic Feathers", a, function(b) 
    a = b
    while a do
wait()
        for _, h in ipairs(workspace.Feathers:GetChildren()) do
            if h.Name == "Feather" and h:FindFirstChild("Root") and a then
                game.Players.LocalPlayer.Character.PrimaryPart.CFrame = h.Root.CFrame
wait(0.5)
                fireproximityprompt(h.Root.ProximityPrompt)
                wait(0.2)
            end
        end
    end
end)

UL:AddTBtn(cfrm, "Auto Claim Gift", a, function(b) 
    a = b
    while a do
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


spawn(function()
        local a
        UL:AddTBtn(cfrm, "Auto Tasks Pets", a, function(b) 
    a = b
end)

        

local playerName = game.Players.LocalPlayer.Name
local userDirectoryName = playerName .. ":Debris"
local workspace = game:GetService("Workspace")
local replicatedStorage = game:GetService("ReplicatedStorage")

-- Tabla para almacenar los nombres de los hijos existentes
local existingChildren = {}

local function handleFileCreation(newChild)
    if newChild:IsA("Model") then
        local modelName = newChild.Name
        
        local actions = {"Fed", "Bathed", "Hugged"}
        for _, action in ipairs(actions) do
            local args = {
                {
                    "PetInteractAction",
                    "'",
                    {
                        "\1",
                        {
                            modelName,
                            action
                        }
                    },
                    "\28"
                }
            }
            
            replicatedStorage:WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
            wait(0.1)
        end
        wait()
    end
end

local function connectSignal()
    local userDirectory = workspace:FindFirstChild(userDirectoryName)
    if userDirectory then
        -- Conectar señal a cada hijo de userDirectory
        for _, child in ipairs(userDirectory:GetChildren()) do
            if not child.Name:find("_Accessories") then
                local chatList = child:FindFirstChild("RootPart"):FindFirstChild("ChatMessageUI"):FindFirstChild("ChatList")
                if chatList then
                    chatList.ChildAdded:Connect(function(newChild)
                        handleFileCreation(newChild.Parent.Parent.Parent.Parent)
                    end)
                end
                
                -- Guardar el nombre del hijo en la tabla
                existingChildren[child.Name] = true
            end
        end
    end
    

    userDirectory.ChildAdded:Connect(function(newChild)
        wait(4)

local userDirectory = workspace:FindFirstChild(userDirectoryName)
    if userDirectory then
        -- Conectar señal a cada hijo de userDirectory
        for _, child in ipairs(userDirectory:GetChildren()) do
            if not child.Name:find("_Accessories") then
                local chatList = child:FindFirstChild("RootPart"):FindFirstChild("ChatMessageUI"):FindFirstChild("ChatList")
                if chatList then
                    chatList.ChildAdded:Connect(function(newChild)
                        handleFileCreation(newChild.Parent.Parent.Parent.Parent)
                    end)
                end
                
                -- Guardar el nombre del hijo en la tabla
                existingChildren[child.Name] = true
                            end
        end
                    end
                
    end)
        end

connectSignal()

    end)

UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 29/05/24 ")
UL:AddText(crFrm, "Update Script: 29/06/24")
UL:AddText(crFrm, "Script Version: 0.2")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

spawn(function()
        while true do
            wait(0.3)
            
local function adjustAnimationSpeedInAnimator(animator)
    if animator then
        local numAnimations = #animator:GetPlayingAnimationTracks()
        for i = 1, numAnimations do
            local animationTrack = animator:GetPlayingAnimationTracks()[i]
            if animationTrack then
                -- Ajustar la velocidad de la animación a 2 veces
                animationTrack:AdjustSpeed(100)
            end
        end
    end
end

local function adjustAnimationsInObject(object)
    local animator = object:FindFirstChildOfClass("Animator")
    if animator then
        adjustAnimationSpeedInAnimator(animator)
    end
    for _, child in ipairs(object:GetChildren()) do
        adjustAnimationsInObject(child)
    end
end

    local playerName = game.Players.LocalPlayer.Name
local userDirectoryName = playerName .. ":Debris"
adjustAnimationsInObject(Workspace[userDirectoryName])
        end
    end)
