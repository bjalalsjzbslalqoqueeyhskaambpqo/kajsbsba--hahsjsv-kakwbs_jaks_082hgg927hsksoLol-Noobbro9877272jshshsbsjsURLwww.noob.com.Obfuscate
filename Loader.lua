return function(id)
    local function notify(message)
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Notify",
                Text = message,
                Duration = 5
            })
        end)
    end

    local function loadScript()
        local url = string.format("https://small-union-d76e.brunotoledo526.workers.dev//?key=%s&id=%s", "onecreatorx", id)
        local success, result = pcall(game.HttpGet, game, url)
        
        if success then
            loadstring(result)()
        else
            notify("Error loaded Script " .. tostring(result))
        end
    end

    if tonumber(id) and tonumber(id) ~= game.PlaceId then
        notify("Posible script other game")
    end

    loadScript()
end
