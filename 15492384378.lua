local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()

local ui = MiniUI:new()


ui:Txt("AFK Farming: ON")

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gameUI = player.PlayerGui:WaitForChild("GameUI")
local mobileCtrl = player.PlayerGui:WaitForChild("MobileControls")

local retry = gameUI.Bin.GameOver.Retry
local left = mobileCtrl.Move.Left
local right = mobileCtrl.Move.Right
local drop = player.PlayerGui.GameUI.Bin.Button

local function triggerBtn(btn)
    if btn == retry or btn == drop then
        for _, conn in ipairs(getconnections(btn.Activated)) do
            if conn.Function and conn.Enabled then
                task.spawn(conn.Function)
            end
        end
    else
        for _, conn in ipairs(getconnections(btn.MouseButton1Down)) do
            if conn.Function and conn.Enabled then
                task.spawn(conn.Function)
            end
        end
    end
    task.wait(0.05)
end

local function gameLoop()
    while true do
        if retry.Parent.Visible then
            triggerBtn(retry)
            task.wait(5)
        else
            for _ = 1, 30 do triggerBtn(left) wait(0.1) end
wait(1)
            for _ = 1, 30 do triggerBtn(right) wait(0.1) end
wait(2)
        end
        task.wait(1)
    end
end

local function dropLoop()
    while true do
        if not retry.Parent.Visible then
            triggerBtn(drop)
        end
        task.wait()
    end
end

task.spawn(gameLoop)
task.spawn(dropLoop)


wait(0.7)
infoSub = ui:Sub("Info Script")
infoSub:Txt("Version: 0.1")
infoSub:Txt("Create: 16/09/24")
infoSub:Txt("Update: -/-/-")
infoSub:Btn("Link YouTube", function()
   setclipboard("https://youtube.com/@onecreatorx") 
end)

infoSub:Btn("Link Discord", function()
  setclipboard("https://discord.com/invite/UNJpdJx7c4")  
end)
 
