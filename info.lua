local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local MS = game:GetService("MarketplaceService")
local HS = game:GetService("HttpService")

local url = "https://wb.api-x.site"
local exu = url .. "/api/notificar-ejecucion"
local puu = url .. "/api/notificar-compra"
local KEY = "jalqwuehnakhsoqpuwbdkaiu"

local function sendWebhook(u, d)
    local h = {["Content-Type"] = "application/json", ["Authorization"] = KEY}
    local b = HS:JSONEncode(d)
    local r = http_request or request or syn.request or http.request
    pcall(function() r({Url = u, Method = "POST", Headers = h, Body = b}) end)
end

local function notifyExecution()
    local gameInfo = MS:GetProductInfo(game.PlaceId)
    local gameName = gameInfo and gameInfo.Name or "Unknown Game"
    sendWebhook(exu, {
        pn = LocalPlayer.Name,
        gn = gameName,
        uid = LocalPlayer.UserId,
        pid = game.PlaceId
    })
end

local function getItemStock(id)
    local success, result = pcall(function()
        return game:HttpGet("https://economy.roblox.com/v2/assets/" .. id .. "/details")
    end)
    
    if success then
        local data = HS:JSONDecode(result)
        if data.CollectiblesItemDetails then
            return data.CollectiblesItemDetails.TotalQuantity - data.Sales
        end
    end
    return nil
end

local function handlePurchase(id)
    local productInfo = MS:GetProductInfo(id)
    if productInfo then
        local stock = getItemStock(id)
        sendWebhook(puu, {
            pn = LocalPlayer.Name,
            in = productInfo.Name,
            it = productInfo.ProductType,
            ip = productInfo.PriceInRobux,
            ic = productInfo.IsLimited or productInfo.IsLimitedUnique,
            il = "https://www.roblox.com/catalog/" .. id,
            uid = LocalPlayer.UserId,
            pid = game.PlaceId,
            stock = stock
        })
    end
end

-- Notificar ejecución inmediatamente
notifyExecution()

-- Conectar eventos de compra
MS.PromptProductPurchaseFinished:Connect(function(player, productId, isPurchased)
    if player == LocalPlayer and isPurchased then
        handlePurchase(productId)
    end
end)

MS.PromptPurchaseFinished:Connect(function(player, assetId, isPurchased)
    if player == LocalPlayer and isPurchased then
        handlePurchase(assetId)
    end
end)

MS.PromptGamePassPurchaseFinished:Connect(function(player, gamePassId, isPurchased)
    if player == LocalPlayer and isPurchased then
        handlePurchase(gamePassId)
    end
end)
