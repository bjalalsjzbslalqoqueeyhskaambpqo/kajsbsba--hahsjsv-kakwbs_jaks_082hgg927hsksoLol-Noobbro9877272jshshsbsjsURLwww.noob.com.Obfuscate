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
        local success, result = pcall(function()
            return game:GetService("HttpService"):GetAsync(url)
        end)
        
        if success then
            local loadSuccess, loadError = pcall(loadstring, result)
            if loadSuccess then
                loadError()
            else
                notify("Error al ejecutar el script: " .. tostring(loadError))
            end
        else
            notify("Error al obtener el script: " .. tostring(result))
        end
    end

    if tonumber(id) and tonumber(id) ~= game.PlaceId then
        notify("Posible script de otro juego")
    end

    loadScript()
end
