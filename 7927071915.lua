local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()

local ui = MiniUI:new()

local function moverJugadorAAsientoCercano()
    local jugador = game.Players.LocalPlayer
    local personaje = jugador.Character
    if not personaje then return end

    local raiz = personaje:FindFirstChild("HumanoidRootPart")
    if not raiz then return end

    local posicionJugador = raiz.Position
    local distanciaMaxima = 70

    for _, asiento in pairs(workspace:GetDescendants()) do
        if asiento:IsA("Seat") and 
           asiento.Parent:FindFirstChild("Meshes/Toro Base") and 
           not asiento:FindFirstChild("SeatWeld") then
            
            local distancia = (asiento.Position - posicionJugador).Magnitude
            if distancia <= distanciaMaxima and not personaje.Humanoid.Sit then
                raiz.CFrame = asiento.CFrame * CFrame.new(0, 1, 0)
                return
            end
        end
    end
end

local a = false
ui:TBtn("Auto Seat", function()
    a = not a
        game.Players.LocalPlayer.Character:MoveTo(Vector.new("74, 31, 244")
    while a do
        moverJugadorAAsientoCercano()
        wait(0.5)
    end
end)

local function moverYGolpearPinata()
    local jugador = game.Players.LocalPlayer
    local personaje = jugador.Character
    if not personaje then return end
    local raiz = personaje:FindFirstChild("HumanoidRootPart")
    if not raiz then return end
    local pinata = workspace.PinataModel:FindFirstChild("Pinata")
    if pinata then
        raiz.CFrame = pinata.CFrame
        local clickDetector = pinata:FindFirstChild("ClickDetector")
        if clickDetector then
            clickDetector.MaxActivationDistance = 9000
            fireclickdetector(clickDetector)
        end
    end
end

local b = false
ui:TBtn("Auto Hit Piñata", function()
    b = not b
    while b do
        pcall(function()
            moverYGolpearPinata()
        end)
        wait()
    end
end)

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
 
