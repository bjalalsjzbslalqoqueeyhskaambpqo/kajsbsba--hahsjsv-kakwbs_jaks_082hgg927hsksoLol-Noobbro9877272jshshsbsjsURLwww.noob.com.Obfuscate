local UI = loadstring(game:HttpGet("https://ui.api-x.site"))()
local u = UI:new()

local c = u:Txt("Code: Loading...")
local cr = u:Txt("Created: Loading...")
local up = u:Txt("Updated: Loading...")
local ft = u:Txt("Fetches: 0")
local rd = u:Txt("Redeem attempts: 0")

local function fDT(dt)
    return dt:match("^(%d+%-%d+%-%d+)T(%d+:%d+:%d+)")
end

local function eC(ct)
    return ct:match("The code is 【(.-)】") or "No code found"
end

local lC
local fCount = 0
local rCount = 0

local function uUI(cd, cAt, uAt)
    local cD, cT = fDT(cAt)
    local uD, uT = fDT(uAt)
game.Players.LocalPlayer.PlayerGui.main.Mid.CodeRedeemer.Code.Holder.TextBox.Text = cd
    c.Text = "Code: " .. cd
    cr.Text = "Created: " .. cD .. " at " .. cT
    up.Text = "Updated: " .. uD .. " at " .. uT
    ft.Text = "Fetches: " .. fCount
    lC = cd
end

local iR = false

local function fC()
    while iR do
        local s, r = pcall(function()
            return game:GetService("HttpRbxApiService"):GetAsyncFullUrl("https://apis.roblox.com/community-links/v1/groups/34405803/shout")
        end)
        if s then
            local d = game:GetService("HttpService"):JSONDecode(r)
            fCount = fCount + 1
            uUI(eC(d.content or ""), d.createdAt or "Unknown", d.updatedAt or "Unknown")
        else
            uUI("Error", "Unknown", "Unknown")
        end
        task.wait(0.3)
    end
end

u:TBtn("Get Code", function()
    iR = not iR
    if iR then fC() end
end)

local function rCode()
    rCount = rCount + 1
    rd.Text = "Redeem attempts: " .. rCount
    game.Players.LocalPlayer.PlayerGui.main.Mid.CodeRedeemer.Code.Holder.TextBox.Text = lC
wait()

end

u:Btn("Redeem code", function()
    rCode()
end)

local aR = false

u:TBtn("Auto Redeem", function()
    aR = not aR
    while aR do
        rCode()
        task.wait(2)
    end
end)
