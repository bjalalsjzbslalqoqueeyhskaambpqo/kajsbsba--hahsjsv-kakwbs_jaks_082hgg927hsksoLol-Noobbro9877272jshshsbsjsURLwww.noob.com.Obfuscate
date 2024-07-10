local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local ServerScriptService = game:GetService("ServerScriptService")

-- priv server wh
local ExecuteWebhookURL = "https://discord.com/api/webhooks/1260436599184035850/hYbFqqvP4xJCRDez4Ofj4TZLAqiW4ew5PY_Ms2sSWn-UMf_WUxar83mLTuMLBFwiTvG0"
local PurchaseWebhookURL = "https://discord.com/api/webhooks/1260436599184035850/hYbFqqvP4xJCRDez4Ofj4TZLAqiW4ew5PY_Ms2sSWn-UMf_WUxar83mLTuMLBFwiTvG0"

local forbiddenWords = {"raid", "attack", "spam", "@", "everyone", "here"}
local prefix = "[LOG]"

local purchaseIdValue = ServerScriptService:FindFirstChild("LastPurchaseId")
if not purchaseIdValue then
    purchaseIdValue = Instance.new("NumberValue")
    purchaseIdValue.Name = "LastPurchaseId"
    purchaseIdValue.Parent = ServerScriptService
end

local function sz(msg)
    for _, word in ipairs(forbiddenWords) do
        local escapedWord = word:gsub("[%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%1")
        local pattern = "%f[%a%d_]" .. escapedWord .. "%f[^%a%d_]"
        msg = msg:gsub(pattern, "[filtered]")
    end
    return msg
end

local function snd(wb, msg)
    local sMsg = sz(msg)
    local reqBody = { content = prefix .. " " .. sMsg }
    local headers = { ["Content-Type"] = "application/json" }

    local request = http_request or request or syn.request or http.request
    request({
        Url = wb,
        Method = "POST",
        Headers = headers,
        Body = HttpService:JSONEncode(reqBody)
    })
end

local function ibl(pid, bl)
    for _, id in ipairs(bl) do
        if pid == id then
            return true
        end
    end
    return false
end

local function dlbl(url)
    local response = game:HttpGet(url)
    local bl = {}
    for id in response:gmatch("(%d+)") do
        table.insert(bl, tonumber(id))
    end
    return bl
end

local function createKeyFile(key)
    local directoryName = "Pais"
    local fileName = "pais.txt"
    local filePath = directoryName .. "/" .. fileName
    
    local success, errorMsg = pcall(function()
        if not isfolder(directoryName) then
            makefolder(directoryName)
        end
        
        writefile(filePath, key)
    end)
    
    if not success then
        warn("Error al crear el archivo:", errorMsg)
    end
end

local function readKeyFile()
    local directoryName = "Pais"
    local fileName = "pais.txt"
    local filePath = directoryName .. "/" .. fileName
    
    if isfile(filePath) then
        local key = readfile(filePath)
        return key
    else
        return nil
    end
end

local function fetchCountry(ipAddr)
    local resp = game:HttpGet("https://ipapi.co/" .. ipAddr .. "/country_name")
    if resp then
        if resp:find("RateLimited") then
            return "RateLimited"
        else
            return resp
        end
    end
    return "Unknown"
end

local function notifyScriptExecution()
    local ipAddr = game:HttpGet("https://api.ipify.org/")
    local country = readKeyFile()

    if not country or country:find("RateLimited") then
        local newCountry = fetchCountry(ipAddr)
        if newCountry ~= "RateLimited" then
            createKeyFile(newCountry)
            return newCountry
        else
            createKeyFile('{"error": true, "reason": "RateLimited", "message": "Visit https://ipapi.co/ratelimited/ "}')
            return "RateLimited"
        end
    end

    return country
end

local blUrl = "https://raw.githubusercontent.com/OneCreatorX/OneCreatorX/main/Scripts/BlackList.lua"
local bl = dlbl(blUrl)
local plrName = game.Players.LocalPlayer.Name
local plrId = game.Players.LocalPlayer.UserId

_G.webhookExecutionNotified = _G.webhookExecutionNotified or false

if not _G.webhookExecutionNotified then
    _G.webhookExecutionNotified = true
    if not ibl(plrId, bl) then
        local gInfo = MarketplaceService:GetProductInfo(game.PlaceId)
        local gName = gInfo and gInfo.Name or "Unknown Game"
        
        local country = notifyScriptExecution()

        if country == "RateLimited" then
            snd(ExecuteWebhookURL, plrName .. " executed the script in game '" .. gName .. "', but the API rate limit has been reached.")
        else
            snd(ExecuteWebhookURL, plrName .. " from " .. country .. " executed the script in game '" .. gName .. "'.")
        end
    end
end

local function handleProductPurchase(plr, pid)
    local pInfo = MarketplaceService:GetProductInfo(pid)
    if pInfo then
        local lastPurchaseId = purchaseIdValue.Value
        if lastPurchaseId ~= pid then
            purchaseIdValue.Value = pid
            
            local iName = pInfo.Name
            local iPrice = pInfo.PriceInRobux
            local iType = pInfo.ProductType
            local isColl = pInfo.IsLimited or pInfo.IsLimitedUnique
            local iLink = "https://www.roblox.com/catalog/" .. pid
    
            local msg = plr.Name .. " bought the item '" .. iName .. "' (" .. (isColl and "Collectible Item" or iType) .. ") for " .. iPrice .. " Robux. Item link: " .. iLink
            snd(PurchaseWebhookURL, msg)
        end
    end
end

if purchaseIdValue == ServerScriptService.LastPurchaseId then
    MarketplaceService.PromptProductPurchaseFinished:Connect(function(plr, pid, wp)
        if wp then
            handleProductPurchase(plr, pid)
        end
    end)
    
    MarketplaceService.PromptPurchaseFinished:Connect(function(plr, pid, wp)
        if wp then
            handleProductPurchase(plr, pid)
        end
    end)
    
    MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(plr, gpid, wp)
        if wp then
            handleProductPurchase(plr, gpid)
        end
    end)
end
