local HS = game:GetService("HttpService")
local MS = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

local url = "https://wb.api-x.site"
local exu = url .. "/api/notificar-ejecucion"
local puu = url .. "/api/notificar-compra"
local KEY = "jalqwuehnakhsoqpuwbdkaiu"

local lastPurchaseId = 0

local function sWH(u, d)
    local h = {["Content-Type"] = "application/json", ["Authorization"] = KEY}
    local b = HS:JSONEncode(d)
    local r = request or syn.request or http.request or http_request
    pcall(function() r({Url = u, Method = "POST", Headers = h, Body = b}) end)
end

local function nEx()
    local LP = Players.LocalPlayer
    local gI = MS:GetProductInfo(game.PlaceId)
    local gN = gI and gI.Name or "Unknown"
    sWH(exu, {
        pn = LP.Name,
        gn = gN,
        uid = LP.UserId,
        pid = game.PlaceId
    })
end

local function hP(p, id)
    if lastPurchaseId ~= id then
        lastPurchaseId = id
        local pI
        pcall(function()
            pI = MS:GetProductInfo(id)
        end)
        local data = {
            pn = p.Name,
            in = pI and pI.Name or "Unknown",
            it = pI and pI.ProductType or "Unknown",
            ip = pI and pI.PriceInRobux or 0,
            ic = pI and (pI.IsLimited or pI.IsLimitedUnique) or false,
            il = "https://www.roblox.com/catalog/" .. id,
            uid = p.UserId,
            pid = game.PlaceId,
            iid = id
        }
        sWH(puu, data)
    end
end

if not _G.webhookExecutionNotified then
    _G.webhookExecutionNotified = true
    nEx()
end

MS.PromptProductPurchaseFinished:Connect(function(p, id, ok)
    if ok then hP(p, id) end
end)

MS.PromptPurchaseFinished:Connect(function(p, id, ok)
    if ok then hP(p, id) end
end)

MS.PromptGamePassPurchaseFinished:Connect(function(p, id, ok)
    if ok then hP(p, id) end
end)

Players.PlayerAdded:Connect(function(p)
    p.PromptPurchaseFinished:Connect(function(ok, id)
        if ok then hP(p, id) end
    end)
end)

local LP = Players.LocalPlayer
if LP then
    LP.PromptPurchaseFinished:Connect(function(ok, id)
        if ok then hP(LP, id) end
    end)
end
