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

local arg1 = 2
local arg2 = 2

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

local a = false
local moveSpeed = 50 

local function moveToTarget(targetPosition)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        warn("No se encontró el Humanoid en el personaje.")
        return
    end

    humanoid.WalkSpeed = moveSpeed
    character:MoveTo(targetPosition)
end

local function collectAndMove()
    
        local beam = hrp:FindFirstChild("HelpVisualBeam")

        if beam then
            local attachment0 = beam.Attachment0
            local attachment1 = beam.Attachment1

            if attachment0 and attachment1 then
                local playerPosition = hrp.Position
                local buttonPosition = attachment0.WorldPosition

                local direction = (buttonPosition - playerPosition).Unit
                local distance = (buttonPosition - playerPosition).Magnitude

                local targetPosition = playerPosition + (direction * distance)
                moveToTarget(targetPosition)
            end
        
    end
end


UL:AddTBtn(cfrm, "Auto Buttons - Collect", false, function()
a = not a
while a do
collectAndMove()
local args = {
    [1] = arg1,
    [2] = arg2
}

game:GetService("ReplicatedStorage"):WaitForChild("__flowNet"):WaitForChild("Tycoon"):WaitForChild("Buttons"):WaitForChild("Collect"):FireServer(unpack(args))
wait(0.5)
end
 end)


local remote = game:GetService("ReplicatedStorage"):WaitForChild("__flowNet"):WaitForChild("Tycoon"):WaitForChild("Buttons"):WaitForChild("Collect")

local mt = getrawmetatable(remote)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    local arg1 = args[1]
    local arg2 = args[2]

    return oldNamecall(self, ...)
end)

setreadonly(mt, true)

local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "First use Collecctor",
    Text = "Use Collector money",
    Duration = 5,
})

UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 16/07/24 ")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)
