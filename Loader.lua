return function(id)
    local function notify(message)
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Notificación",
                Text = message,
                Duration = 5
            })
        end)
    end

    local function loadScript()
        local url = "https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/" .. id .. ".lua"
        local success, result = pcall(game.HttpGet, game, url)
        
        if success then
            loadstring(result)()
        else
            notify("Error al cargar el script: " .. tostring(result))
        end
    end

    if tonumber(id) and tonumber(id) ~= game.PlaceId then
        notify("Posible script de otro juego")
    end

    loadScript()
end
