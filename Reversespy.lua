local RS = game:GetService("ReplicatedStorage")
local P = game:GetService("Players").LocalPlayer

local rData = {}
local selR = nil
local blkR = {}
local rCount = {}

local function cInst(cls, props, par)
    local i = Instance.new(cls)
    for p, v in pairs(props) do i[p] = v end
    if par then i.Parent = par end
    return i
end

local function dCmp(t1, t2)
    if type(t1) ~= type(t2) then return false end
    if type(t1) ~= "table" then return t1 == t2 end
    
    for k, v in pairs(t1) do
        if not dCmp(v, t2[k]) then return false end
    end
    
    for k, v in pairs(t2) do
        if t1[k] == nil then return false end
    end
    
    return true
end

local function tStr(t, d)
    if t == nil then return "nil" end
    if type(t) ~= "table" then return tostring(t) end
    d = d or 1
    local ind = string.rep("  ", d)
    local r = "{\n"
    for k, v in pairs(t) do
        r = r .. ind .. tostring(k) .. " = "
        if type(v) == "table" then
            r = r .. tStr(v, d + 1)
        else
            r = r .. tostring(v)
        end
        r = r .. ",\n"
    end
    r = r .. string.rep("  ", d-1) .. "}"
    return r
end

local function gPath(inst)
    local p = inst.Name
    local c = inst.Parent
    while c and c ~= game do
        p = c.Name .. "." .. p
        c = c.Parent
    end
    return p
end

local function gIdxPath(inst)
    local r = ""
    local c = inst
    local idx = {}
    
    while c and c ~= game do
        local p = c.Parent
        if p then
            local ch = p:GetChildren()
            for i, child in ipairs(ch) do
                if child == c then
                    table.insert(idx, 1, i)
                    break
                end
            end
        end
        c = p
    end
    
    r = "game"
    for _, i in ipairs(idx) do
        r = r .. ":GetChildren()[" .. i .. "]"
    end
    
    return r
end

local function createSplitTextDisplay(parent, text, maxLength)
    for _, child in pairs(parent:GetChildren()) do
        if child:IsA("TextLabel") and child.Name:match("^SplitText") then
            child:Destroy()
        end
    end
    
    local parts = {}
    local fullText = text
    
    while #fullText > 0 do
        local part = string.sub(fullText, 1, maxLength)
        table.insert(parts, part)
        fullText = string.sub(fullText, maxLength + 1)
    end
    
    local totalHeight = 0
    for i, part in ipairs(parts) do
        local textLabel = cInst("TextLabel", {
            Name = "SplitText" .. i,
            Size = UDim2.new(1, -10, 0, 0),
            Position = UDim2.new(0, 5, 0, totalHeight),
            BackgroundTransparency = 1,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 14,
            Font = Enum.Font.SourceSans,
            Text = part,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextWrapped = true,
            AutomaticSize = Enum.AutomaticSize.Y
        }, parent)
        
        totalHeight = totalHeight + textLabel.AbsoluteSize.Y
    end
    
    return text
end

local SGui = cInst("ScreenGui", {
    Name = "RemoteSpy",
    ResetOnSpawn = false
}, P.PlayerGui)

local MF = cInst("Frame", {
    Name = "MF",
    Size = UDim2.new(0, 700, 0, 500),
    Position = UDim2.new(0.5, -350, 0.5, -250),
    BackgroundColor3 = Color3.fromRGB(40, 40, 40),
    BorderSizePixel = 0,
    Active = true,
    Draggable = true
}, SGui)

local TB = cInst("Frame", {
    Name = "TB",
    Size = UDim2.new(1, 0, 0, 30),
    BackgroundColor3 = Color3.fromRGB(30, 30, 30),
    BorderSizePixel = 0
}, MF)

cInst("TextLabel", {
    Name = "Title",
    Size = UDim2.new(1, -10, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    BackgroundTransparency = 1,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 16,
    Font = Enum.Font.SourceSansBold,
    Text = "Remote Spy",
    TextXAlignment = Enum.TextXAlignment.Left
}, TB)

local CB = cInst("TextButton", {
    Name = "CB",
    Size = UDim2.new(0, 30, 0, 30),
    Position = UDim2.new(1, -30, 0, 0),
    BackgroundTransparency = 1,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 16,
    Font = Enum.Font.SourceSansBold,
    Text = "X"
}, TB)

local CF = cInst("Frame", {
    Name = "CF",
    Size = UDim2.new(1, 0, 1, -30),
    Position = UDim2.new(0, 0, 0, 30),
    BackgroundColor3 = Color3.fromRGB(50, 50, 50),
    BorderSizePixel = 0
}, MF)

local RLF = cInst("ScrollingFrame", {
    Name = "RLF",
    Size = UDim2.new(0.3, 0, 1, 0),
    BackgroundColor3 = Color3.fromRGB(45, 45, 45),
    BorderSizePixel = 0,
    ScrollBarThickness = 6,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y
}, CF)

local RLL = cInst("UIListLayout", {
    SortOrder = Enum.SortOrder.Name,
    Padding = UDim.new(0, 2)
}, RLF)

local DF = cInst("Frame", {
    Name = "DF",
    Size = UDim2.new(0.7, 0, 1, 0),
    Position = UDim2.new(0.3, 0, 0, 0),
    BackgroundColor3 = Color3.fromRGB(55, 55, 55),
    BorderSizePixel = 0
}, CF)

local IF = cInst("Frame", {
    Name = "IF",
    Size = UDim2.new(1, 0, 0.7, 0),
    BackgroundColor3 = Color3.fromRGB(55, 55, 55),
    BorderSizePixel = 0
}, DF)

cInst("TextLabel", {
    Name = "IT",
    Size = UDim2.new(1, 0, 0, 25),
    BackgroundColor3 = Color3.fromRGB(40, 40, 40),
    BorderSizePixel = 0,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 14,
    Font = Enum.Font.SourceSansBold,
    Text = "Remote Information"
}, IF)

local IS = cInst("ScrollingFrame", {
    Name = "IS",
    Size = UDim2.new(1, 0, 1, -25),
    Position = UDim2.new(0, 0, 0, 25),
    BackgroundColor3 = Color3.fromRGB(60, 60, 60),
    BorderSizePixel = 0,
    ScrollBarThickness = 6,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y
}, IF)

local ITxt = cInst("TextLabel", {
    Name = "ITxt",
    Size = UDim2.new(1, -10, 0, 0),
    Position = UDim2.new(0, 5, 0, 0),
    BackgroundTransparency = 1,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 14,
    Font = Enum.Font.SourceSans,
    Text = "Select a remote to view details",
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    TextWrapped = true,
    AutomaticSize = Enum.AutomaticSize.Y
}, IS)

local AF = cInst("ScrollingFrame", {
    Name = "AF",
    Size = UDim2.new(1, 0, 0.3, 0),
    Position = UDim2.new(0, 0, 0.7, 0),
    BackgroundColor3 = Color3.fromRGB(55, 55, 55),
    BorderSizePixel = 0,
    ScrollBarThickness = 6,
    CanvasSize = UDim2.new(0, 0, 0, 210)
}, DF)

cInst("TextLabel", {
    Name = "AT",
    Size = UDim2.new(1, 0, 0, 25),
    BackgroundColor3 = Color3.fromRGB(40, 40, 40),
    BorderSizePixel = 0,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 14,
    Font = Enum.Font.SourceSansBold,
    Text = "Actions"
}, AF)

local AC = cInst("Frame", {
    Name = "AC",
    Size = UDim2.new(1, -10, 0, 180),
    Position = UDim2.new(0, 5, 0, 30),
    BackgroundColor3 = Color3.fromRGB(60, 60, 60),
    BorderSizePixel = 0
}, AF)

local function cBtn(name, posX, posY)
    return cInst("TextButton", {
        Name = name .. "Btn",
        Size = UDim2.new(0.48, 0, 0, 30),
        Position = UDim2.new(posX, 0, 0, posY),
        BackgroundColor3 = Color3.fromRGB(70, 70, 70),
        BorderColor3 = Color3.fromRGB(100, 100, 100),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.SourceSans,
        Text = name
    }, AC)
end

local CPBtn = cBtn("Copy Path", 0, 10)
local CDBtn = cBtn("Copy Data", 0.5, 10)
local GCBtn = cBtn("Generate Code", 0, 50)
local GIBtn = cBtn("Generate Index Code", 0.5, 50)
local BRBtn = cBtn("Block/Unblock", 0, 90)
local CRBtn = cBtn("Clear All", 0.5, 90)
local DLBtn = cBtn("Download Data", 0, 130)
local CABtn = cBtn("Copy All", 0.5, 130)

local function updInfo()
    if not selR or not rData[selR] then
        ITxt.Text = "Select a remote to view details"
        return
    end
    
    local d = rData[selR]
    local info = "Name: " .. d.n .. "\n"
    info = info .. "Type: " .. d.t .. "\n"
    info = info .. "Path: " .. gPath(d.i) .. "\n"
    info = info .. "Status: " .. (blkR[d.n] and "Blocked" or "Active") .. "\n"
    info = info .. "Count: " .. (rCount[d.n] or 1) .. "\n\n"
    info = info .. "Data:\n" .. tStr(d.d or {}, 1)
    
    d.fullInfoText = info
    
    if ITxt then
        ITxt:Destroy()
    end
    
    createSplitTextDisplay(IS, info, 5000)
end

local function saveToFile(filename, data)
    local success, err = pcall(function()
        writefile(filename, data)
    end)
    
    if success then
        local notification = cInst("Frame", {
            Name = "Notification",
            Size = UDim2.new(0, 200, 0, 50),
            Position = UDim2.new(0.5, -100, 0, -50),
            BackgroundColor3 = Color3.fromRGB(50, 150, 50),
            BorderSizePixel = 0,
            Parent = SGui
        })
        
        cInst("TextLabel", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 14,
            Font = Enum.Font.SourceSansBold,
            Text = "File saved successfully!",
            Parent = notification
        })
        
        notification:TweenPosition(
            UDim2.new(0.5, -100, 0, 20),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.5,
            true
        )
        
        task.delay(2, function()
            notification:TweenPosition(
                UDim2.new(0.5, -100, 0, -50),
                Enum.EasingDirection.In,
                Enum.EasingStyle.Quad,
                0.5,
                true,
                function()
                    notification:Destroy()
                end
            )
        end)
    else
        warn("Failed to save file:", err)
    end
end

local function cRBtn(rName, rType, rInst, rData, idx)
    local btnName = rName
    if idx and idx > 1 then
        btnName = rName .. " (" .. idx .. ")"
    end
    
    local Btn = cInst("TextButton", {
        Name = btnName,
        Size = UDim2.new(1, -10, 0, 30),
        BackgroundColor3 = Color3.fromRGB(60, 60, 60),
        BorderColor3 = Color3.fromRGB(100, 100, 100),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.SourceSans,
        Text = btnName,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd
    }, RLF)
    
    cInst("Frame", {
        Name = "TI",
        Size = UDim2.new(0, 5, 1, -4),
        Position = UDim2.new(0, 2, 0, 2),
        BorderSizePixel = 0,
        BackgroundColor3 = rType == "RemoteEvent" 
            and Color3.fromRGB(0, 150, 255) 
            or Color3.fromRGB(255, 150, 0)
    }, Btn)
    
    Btn.MouseButton1Click:Connect(function()
        selR = btnName
        
        for _, c in pairs(RLF:GetChildren()) do
            if c:IsA("TextButton") then
                c.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            end
        end
        Btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        
        updInfo()
    end)
    
    return Btn
end

local function hRData(rName, rInst, rType, args)
    if blkR[rName] then return end
    
    local isNew = true
    local idx = 1
    
    if not rCount[rName] then
        rCount[rName] = 1
    end
    
    for k, v in pairs(rData) do
        if v.n == rName then
            if dCmp(v.d, args) then
                isNew = false
                break
            end
        end
    end
    
    if isNew then
        local btnName = rName
        if rCount[rName] > 1 then
            btnName = rName .. " (" .. rCount[rName] .. ")"
        end
        
        rData[btnName] = {
            n = rName,
            i = rInst,
            t = rType,
            d = args
        }
        
        cRBtn(rName, rType, rInst, args, rCount[rName])
        rCount[rName] = rCount[rName] + 1
    end
end

local function cRObj(cont)
    for _, o in ipairs(cont:GetDescendants()) do
        if o:IsA("RemoteEvent") then
            o.OnClientEvent:Connect(function(...)
                hRData(o.Name, o, "RemoteEvent", {...})
            end)
        elseif o:IsA("RemoteFunction") then
            o.OnClientInvoke = function(...)
                hRData(o.Name, o, "RemoteFunction", {...})
                return nil
            end
        end
    end
end

CPBtn.MouseButton1Click:Connect(function()
    if selR and rData[selR] then
        setclipboard(gPath(rData[selR].i))
    end
end)

CDBtn.MouseButton1Click:Connect(function()
    if selR and rData[selR] then
        setclipboard(tStr(rData[selR].d or {}, 1))
    end
end)

CABtn.MouseButton1Click:Connect(function()
    if selR and rData[selR] then
        setclipboard(rData[selR].fullInfoText or "No data available")
    end
end)

DLBtn.MouseButton1Click:Connect(function()
    if selR and rData[selR] then
        local d = rData[selR]
        local filename = d.n .. "_data.txt"
        saveToFile(filename, d.fullInfoText or "No data available")
    end
end)

GCBtn.MouseButton1Click:Connect(function()
    if selR and rData[selR] then
        local i = rData[selR].i
        local p = gPath(i)
        local c = ""
        
        if i:IsA("RemoteEvent") then
            c = "local r = " .. p .. "\n\nr.OnClientEvent:Connect(function(...)\n    print(\"Remote fired:\", ...)\nend)"
        else
            c = "local r = " .. p .. "\n\nr.OnClientInvoke = function(...)\n    print(\"Remote called:\", ...)\n    return nil\nend"
        end
        
        setclipboard(c)
    end
end)

GIBtn.MouseButton1Click:Connect(function()
    if selR and rData[selR] then
        local i = rData[selR].i
        local p = gIdxPath(i)
        local c = ""
        
        if i:IsA("RemoteEvent") then
            c = "local r = " .. p .. "\n\nr.OnClientEvent:Connect(function(...)\n    print(\"Remote fired:\", ...)\nend)"
        else
            c = "local r = " .. p .. "\n\nr.OnClientInvoke = function(...)\n    print(\"Remote called:\", ...)\n    return nil\nend"
        end
        
        setclipboard(c)
    end
end)

BRBtn.MouseButton1Click:Connect(function()
    if selR and rData[selR] then
        local rName = rData[selR].n
        blkR[rName] = not blkR[rName]
        updInfo()
        
        for _, c in pairs(RLF:GetChildren()) do
            if c:IsA("TextButton") and string.find(c.Name, "^" .. rName .. "( %(%d+%))?$") then
                c.BackgroundColor3 = blkR[rName] 
                    and Color3.fromRGB(100, 50, 50) 
                    or Color3.fromRGB(60, 60, 60)
            end
        end
        
        local btn = RLF:FindFirstChild(selR)
        if btn then
            btn.BackgroundColor3 = blkR[rName] 
                and Color3.fromRGB(100, 50, 50) 
                or Color3.fromRGB(80, 80, 80)
        end
    end
end)

CRBtn.MouseButton1Click:Connect(function()
    for _, c in pairs(RLF:GetChildren()) do
        if c:IsA("TextButton") then
            c:Destroy()
        end
    end
    
    rData = {}
    rCount = {}
    selR = nil
    ITxt.Text = "Select a remote to view details"
end)

CB.MouseButton1Click:Connect(function()
    SGui:Destroy()
end)

cRObj(RS)

RS.DescendantAdded:Connect(function(d)
    if d:IsA("RemoteEvent") or d:IsA("RemoteFunction") then
        cRObj({d})
    end
end)
