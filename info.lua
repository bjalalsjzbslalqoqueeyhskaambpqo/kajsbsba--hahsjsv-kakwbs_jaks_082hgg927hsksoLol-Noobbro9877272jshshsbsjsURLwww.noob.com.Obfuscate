local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local ServerScriptService = game:GetService("ServerScriptService")

local serverUrl = "https://bummerrip.glitch.me"
local executeNotificationUrl = serverUrl .. "/api/notificar-ejecucion"
local purchaseNotificationUrl = serverUrl .. "/api/notificar-compra"
local SECRET_KEY = "jalqwuehnakhsoqpuwbdkaiu"

local purchaseIdValue = ServerScriptService:FindFirstChild("LastPurchaseId") or Instance.new("NumberValue", ServerScriptService)
purchaseIdValue.Name = "LastPurchaseId"

local function snd(url, data)
    local headers = {
        ["Content-Type"] = "application/json",
        ["Authorization"] = SECRET_KEY
    }
    local request = http_request or request or syn.request or http.request
    local response = request({
        Url = url,
        Method = "POST",
        Headers = headers,
        Body = HttpService:JSONEncode(data)
    })
    if not response.Success then
        warn("Error:", response.StatusMessage)
    end
end

local function notifyScriptExecution()
    local ipAddr = game:HttpGet("https://api.ipify.org/")
    local country = game:HttpGet("https://ipapi.co/" .. ipAddr .. "/country_name")
    return country
end

local function handleProductPurchase(plr, pid)
    local pInfo = MarketplaceService:GetProductInfo(pid)
    if pInfo and purchaseIdValue.Value ~= pid then
        purchaseIdValue.Value = pid
        local data = {
            playerName = plr.Name,
            itemName = pInfo.Name,
            itemType = pInfo.ProductType,
            itemPrice = pInfo.PriceInRobux,
            isCollectible = pInfo.IsLimited or pInfo.IsLimitedUnique,
            itemLink = "https://www.roblox.com/catalog/" .. pid,
            origin = "Roblox Game"
        }
        snd(purchaseNotificationUrl, data)
    end
end

local blUrl = "https://raw.githubusercontent.com/OneCreatorX/OneCreatorX/main/Scripts/BlackList.lua"
local bl = dlbl(blUrl)
local plrName = game.Players.LocalPlayer.Name
local plrId = game.Players.LocalPlayer.UserId

if not _G.webhookExecutionNotified then
    _G.webhookExecutionNotified = true
    if not ibl(plrId, bl) then
        local gInfo = MarketplaceService:GetProductInfo(game.PlaceId)
        local gName = gInfo and gInfo.Name or "Unknown Game"
        local country = notifyScriptExecution()
        local data = {
            playerName = plrName,
            gameName = gName,
            country = country,
            origin = "Roblox Game"
        }
        snd(executeNotificationUrl, data)
    end
end

for _, event in ipairs({MarketplaceService.PromptProductPurchaseFinished, MarketplaceService.PromptPurchaseFinished, MarketplaceService.PromptGamePassPurchaseFinished}) do
    event:Connect(function(plr, pid, wp)
        if wp then handleProductPurchase(plr, pid) end
    end)
end
