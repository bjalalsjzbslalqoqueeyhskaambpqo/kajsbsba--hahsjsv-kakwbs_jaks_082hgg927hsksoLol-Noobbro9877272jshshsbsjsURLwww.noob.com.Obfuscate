local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/abb"))()

local ui = MiniUI:new()

ui:Btn("Saludar", function()
    print("¡Hola, " .. game.Players.LocalPlayer.Name .. "!")
end)

ui:Pass("test", "test")
ui:Notify("test", 3)
ui:Txt("Bienvenido a MiniUI")

ui:TBox("Escribe tu nombre", function(text)
    print("Nombre ingresado:", text)
end)

local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        

ui:Track("Velocidad del jugador", player.Character.Humanoid.WalkSpeed, 16, 100, 1, function(value)
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = value
    end
end)
end


local mainMenu = ui:Sub("Principal")

local subMenu = mainMenu:Sub("Submenú")
subMenu:Btn("Sub 1", function() print("Sub 1") end)
subMenu:Btn("Sub 2", function() print("Sub 2") end)



wait(0.7)
infoSub = ui:Sub("Info Script")
infoSub:Txt("Version: 0.1")
infoSub:Txt("Create: 20/09/24")
infoSub:Txt("Update: -/-/-")
infoSub:Btn("Link YouTube", function()
   setclipboard("https://youtube.com/@onecreatorx") 
end)

infoSub:Btn("Link Discord", function()
  setclipboard("https://discord.com/invite/UNJpdJx7c4")  
end)
 
