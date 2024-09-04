

local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()

local ui = MiniUI:new()

local customTitle = "Universal Join n Claim"
if ui.frame then
    for _, child in pairs(ui.frame:GetChildren()) do
        if child:IsA("TextLabel") then
            child.Text = customTitle
            break
        end
    end
end

ui:TBtn("Hide Players", function()
    a = not a
    while a do
        for _, p in ipairs(game.Players:GetChildren()) do
            if p ~= game.Players.LocalPlayer and p.Character then
                p.Character:Destroy()
            end
        end
        wait(0.1)
    end
end)

ui:TBtn("Use ProximityP", function()
    b = not b
    while b do
        local closestPrompt = nil
        local closestDistance = math.huge

        for _, pp in ipairs(game.Workspace:GetDescendants()) do
            if pp:IsA("ProximityPrompt") then
                local p = (pp.Parent.Position - game.Players.LocalPlayer.Character.PrimaryPart.Position).Magnitude
                if p < closestDistance then
                    closestDistance = p
                    closestPrompt = pp
                end
            end
        end

        if closestPrompt then
            fireproximityprompt(closestPrompt)
        end
        
        wait()
    end
end)

local ya = false
ui:TBtn("Move ProximityP", function()
ya = not ya 
while ya do
local p = game:GetService("Players").LocalPlayer
local hrp = p.Character:WaitForChild("HumanoidRootPart")

for _, d in ipairs(workspace:GetDescendants()) do
    if d:IsA("ProximityPrompt") and ya then
        hrp.CFrame = d.Parent.CFrame
wait(0.1)
fireproximityprompt(d)
wait(0.1)
    end
end

end

end)

local ya = false
ui:TBtn("Active Touch", function()
ya = not ya 
while ya do

for _, obj in ipairs(workspace:GetDescendants()) do
    if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then

local plr = game.Players.LocalPlayer
firetouchinterest(plr.Character.HumanoidRootPart, obj, 0)
        wait()
        firetouchinterest(plr.Character.HumanoidRootPart, obj, 1)
                    wait()
end end
wait(0.1)
end

end)

local p = game.Players.LocalPlayer
local pr = p.Character.HumanoidRootPart

local function d(p1, p2)
    return (p1 - p2).magnitude
end

local function s(o)
    table.sort(o, function(a, b)
        local da = d(pr.Position, a.Parent.Position)
        local db = d(pr.Position, b.Parent.Position)
        return da < db
    end)
    return o
end

local function m()
    local t = workspace:GetDescendants()
    t = s(t)

    for _, o in ipairs(t) do
        if o:IsA("BasePart") and o:FindFirstChild("TouchInterest") then
            pcall(function()
            local p = game.Players.LocalPlayer
local pr = p.Character.HumanoidRootPart

            pr.CFrame = o.Parent.CFrame
                end)
            wait(0.5)
        end
    end
end

ui:Btn("Move Touch", m)


ui:Btn("Inifnity Yield", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() 
end)

local configs = {
    keyword = "OneCreatorX",
    configured = false
}

local remoteInfo = {}
local statusText = ui:Txt("Status: Not configured")
local keywordText = ui:Txt("Code: " .. configs.keyword)

local function updateStatus(text)
    statusText.Text = "Status: " .. text
end

local function safeGetService(service)
    return game:GetService(service)
end

local function deepClone(original)
    local copy = {}
    for k, v in pairs(original) do
        if type(v) == "table" then
            copy[k] = deepClone(v)
        else
            copy[k] = v
        end
    end
    return copy
end

local function logRemoteCall(remote, method, args)
    if not configs.configured then
        for i, v in ipairs(args) do
            if type(v) == "string" and v:find(configs.keyword) then
                remoteInfo = {
                    remote = remote,
                    path = remote.GetFullName and remote:GetFullName() or "Unknown",
                    args = deepClone(args),
                    method = method,
                    index = i,
                    quoted = v:match('^".*"$') ~= nil
                }
                configs.configured = true
                updateStatus("Configured")
                break
            end
        end
    end
end

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if (method == "FireServer" or method == "InvokeServer") then
        task.spawn(function()
            logRemoteCall(self, method, args)
        end)
    end
    
    return oldNamecall(self, ...)
end))

local function sendCode(code)
    if not configs.configured then
        updateStatus("Not configured. Use Code.")
        return
    end

    local newArgs = deepClone(remoteInfo.args)
    newArgs[remoteInfo.index] = remoteInfo.quoted and '"'..code..'"' or code

    local remote = remoteInfo.remote
    local method = remoteInfo.method

    updateStatus("Sending code: " .. code)

    if method == "FireServer" then
        remote:FireServer(unpack(newArgs))
        updateStatus("Code sent: " .. code .. " (FireServer, No Res)")
    elseif method == "InvokeServer" then
        local success, result = pcall(function()
            return remote:InvokeServer(unpack(newArgs))
        end)
        if success then
            updateStatus("Code sent: " .. code .. " - Res: " .. tostring(result))
        else
            updateStatus("Error sending code: " .. code .. " - " .. tostring(result))
        end
    end
end

local function extractCodes(text)
    local codes = {}
    for line in text:gmatch("[^\r\n]+") do
        for code in line:gmatch("%S+") do
            code = code:gsub("^,+", ""):gsub(",+$", "")
            if code ~= "" then
                table.insert(codes, code)
            end
        end
    end
    return codes
end

ui:TBox("Auto Multiple Code", function(text)
    if not configs.configured then
        updateStatus("Not configured. Use Code")
        return
    end

    local codes = extractCodes(text)

    if #codes == 0 then
        updateStatus("No valid codes found")
        return
    end

    updateStatus("Found " .. #codes .. " codes. Starting to send...")

    task.spawn(function()
        for i, code in ipairs(codes) do
            sendCode(code)
            updateStatus("Sent code " .. i .. " of " .. #codes)
            task.wait(1)
        end
        updateStatus("All codes sent")
    end)
end)



wait(0.7)
infoSub = ui:Sub("Info Script")
infoSub:Txt("Version: 0.1")
infoSub:Txt("Create: 20/08/24")
infoSub:Txt("Update: -/-/-")
infoSub:Btn("Link YouTube", function()
    setclipboard("https://youtube.com/@onecreatorx") 
end)
infoSub:Btn("Link Discord", function()
    setclipboard("https://discord.com/invite/UNJpdJx7c4")  
end)
