return function(id)
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

    loadstring(result)()
end
