local MUI = loadstring(game:HttpGet("https://ui.api-x.site"))()
local ui = MUI:new()

local ws = game:GetService("Workspace")
local rs = game:GetService("ReplicatedStorage")

local eM, nM, ev

local function upRefs()
    local w1 = ws:FindFirstChild("World1")
    if w1 then
        local si = w1:FindFirstChild("ScriptItems")
        if si then
            eM = si:FindFirstChild("EarthMine")
        end
    end
    
    nM = ws:FindFirstChild("Nether"):FindFirstChild("Mine")
    ev = rs:FindFirstChild("BlockMinedEvent")
end

upRefs()

local function isVB(b)
    return b and (b:IsA("BasePart") and b.Transparency < 1 or b:IsA("Model"))
end

local function mineB(b)
    local att = 0
    while isVB(b) and att < 50 do
        ev:FireServer(b)
        att = att + 1
        task.wait(0.05)
    end
end

local eTh, nTh = {}, {}

local function startM(mT)
    return task.spawn(function()
        while true do
            if not ev then upRefs() end
            local m = mT == "e" and eM or nM
            if m and ev then
                local bs = m:GetChildren()
                if #bs > 0 then
                    local b = bs[math.random(#bs)]
                    if isVB(b) then
                        mineB(b)
                    end
                end
            end
            task.wait(0.3)
        end
    end)
end

ui:Track("Earth Miners", 0, 0, 70, function(v)
    v = math.floor(v)
    while #eTh < v do
        table.insert(eTh, startM("e"))
    end
    while #eTh > v do
        task.cancel(table.remove(eTh))
    end
end)

ui:Track("Nether Miners", 0, 0, 70, function(v)
    v = math.floor(v)
    while #nTh < v do
        table.insert(nTh, startM("n"))
    end
    while #nTh > v do
        task.cancel(table.remove(nTh))
    end
end)

local iSub = ui:Sub("Info Script")
iSub:Txt("Version: 0.2")
iSub:Txt("Create: 09/0/10/24")
iSub:Txt("Update: 09/10/24")
iSub:Btn("Link YouTube", function()
   setclipboard("https://youtube.com/@onecreatorx") 
end)
iSub:Btn("Link Discord", function()
  setclipboard("https://discord.com/invite/UNJpdJx7c4")  
end)
