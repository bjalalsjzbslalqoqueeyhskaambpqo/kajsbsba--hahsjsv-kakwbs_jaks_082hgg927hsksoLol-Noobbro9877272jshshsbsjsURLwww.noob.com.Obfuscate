local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()

local ui = MiniUI:new()



local function cntStars()
    local sc = 0
    for _, obj in ipairs(workspace.ClaimableStars:GetDescendants()) do
        if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then
            sc = sc + 1
        end
    end
    return sc
end

local function notifyStars(mult)
    local sc = cntStars() * (mult or 1)
    ui:Notify(mult and "Cantidad (x4): " .. sc or "Cantidad: " .. sc, 5)
end
notifyStars()
notifyStars(4)
ui:Notify("Use Button (Join Alone server(beta), ah sometimes u need use multi times", 20)
ui:Btn("Stars", function()
    notifyStars()
notifyStars(4)
end)

ui:TBtn(" Auto Cats", function()
a = not a
while a do
wait(0.3)
for _, obj in ipairs(workspace.ClaimableStars:GetDescendants()) do
            if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then
                local plr = game.Players.LocalPlayer
                firetouchinterest(plr.Character.HumanoidRootPart, obj, 0)
                wait()
                firetouchinterest(plr.Character.HumanoidRootPart, obj, 1)
          wait(0.3)
            end
        end
wait(0.1)
    end
end)


wait(0.7)
infoSub = ui:Sub("Info Script")
infoSub:Txt("Version: 0.3")
infoSub:Txt("Create: 06/09/24")
infoSub:Txt("Update: --/--/--")
infoSub:Btn("Link YouTube", function()
   setclipboard("https://youtube.com/@onecreatorx") 
end)

infoSub:Btn("Link Discord", function()
  setclipboard("https://discord.com/invite/UNJpdJx7c4")  
end)
 