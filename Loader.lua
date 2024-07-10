return function(id)
    -- Generar URLs falsas similares a la real
    local fakeUrls = {
        "https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaapqjsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro987722jshshsbsjsURLwww.noob.com.Obfuscate/main/fake1.lua",
        "https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwaks_082hgg9soLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/fake2.lua",
        "https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-ka_jaks_082hgg927hsksoLol-Noobbro9877ñjshshsbsjsURLwww.noob.com.Obfuscate/main/fake3.lua",
        "https://raw.githubusercontent.com/bjalalsjzbslalqoqueaambpqo/kajsbsba--hahsjsv-kakwaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/fake4.lua",
    }

    -- Función para enviar una petición falsa
    local function sendFakeRequest()
        for _, url in ipairs(fakeUrls) do
            pcall(function()
                game:HttpGet(url)
            end)
        end
    end

    -- Verificar y cargar el script real
    local success, result = pcall(function()
        local url = "https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/" .. id .. ".lua"
        return game:HttpGet(url)
    end)

    if not success then
        print("Error: No se pudo cargar el archivo.")
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Error",
            Text = "No se pudo cargar el archivo.",
            Duration = 5
        })
        return
    end

    if tonumber(id) and tonumber(id) ~= game.PlaceId then
        print("Advertencia: El ID del juego no coincide.")
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Advertencia",
            Text = "El ID del juego no coincide. Posible script incorrecto.",
            Duration = 5
        })
    end

    for i = 1, 20 do
        sendFakeRequest()
    end

    loadstring(result)()

    for i = 1, 20 do
        sendFakeRequest()
    end
end
