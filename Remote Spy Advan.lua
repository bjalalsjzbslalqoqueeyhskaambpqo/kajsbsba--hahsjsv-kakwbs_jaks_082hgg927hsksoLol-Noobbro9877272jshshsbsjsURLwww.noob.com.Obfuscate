RSUI = {}

local g, f, sF, rF, aTB, hTB, mB, tL, sL, rL, sBtn, lBtn, cBtn, cpBtn
local isMin = false
local sentRemotes = {}
local receivedRemotes = {}
local receivedRemoteArgs = {}
local sentRemoteArgs = {}
local sentRemoteHierarchy = {}
local activeLoops = {}
local cloneref = cloneref or function(x) return x end
local function SafeGetService(service)
    return cloneref(game:GetService(service))
end

function RSUI.createUI()
    g = Instance.new("ScreenGui")
    g.Name = "RemoteSpy"
    g.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    f = Instance.new("Frame", g)
    f.Size = UDim2.new(0, 600, 0, 450)
    f.Position = UDim2.new(0.5, -300, 0.5, -225)
    f.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)

    sL = RSUI.createLabel("Sending", UDim2.new(0, 10, 0, 30), UDim2.new(0.5, -20, 0, 20))
    rL = RSUI.createLabel("Receiving", UDim2.new(0.5, 10, 0, 30), UDim2.new(0.5, -20, 0, 20))
    tL = RSUI.createLabel("Remote Spy v1 - By OneCreatorX", UDim2.new(0, 10, 0, 5), UDim2.new(1, -20, 0, 20))

    sF = Instance.new("ScrollingFrame", f)
    sF.Size = UDim2.new(0.5, -20, 0.6, -60)
    sF.Position = UDim2.new(0, 10, 0, 55)
    sF.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)

    rF = Instance.new("ScrollingFrame", f)
    rF.Size = UDim2.new(0.5, -20, 0.6, -60)
    rF.Position = UDim2.new(0.5, 10, 0, 55)
    rF.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)

    aTB = Instance.new("TextBox", f)
    aTB.Size = UDim2.new(1, -20, 0.2, -20)
    aTB.Position = UDim2.new(0, 10, 0.6, 15)
    aTB.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    aTB.ClearTextOnFocus = false
    aTB.TextColor3 = Color3.new(1, 1, 1)
    aTB.TextWrapped = true
    aTB.TextXAlignment = Enum.TextXAlignment.Left
    aTB.TextYAlignment = Enum.TextYAlignment.Top
    aTB.MultiLine = true

    mB = Instance.new("TextButton", f)
    mB.Size = UDim2.new(0, 25, 0, 25)
    mB.Position = UDim2.new(1, -35, 0, 5)
    mB.Text = "-"
    mB.BackgroundColor3 = Color3.new(0.2, 0.6, 0.8)
    mB.TextColor3 = Color3.new(1, 1, 1)



function RSUI.sendRemote()
    local currentText = aTB.Text
    local success, result = pcall(function()
        return loadstring(currentText)()
    end)
    
end


    sBtn = RSUI.createBtn("Send", 0.05, 0.8, function()
        RSUI.sendRemote()
    end)
    lBtn = RSUI.createBtn("Loop (Start/stop)", 0.35, 0.8, function()
    local currentText = aTB.Text
    local buttonId = tostring(lBtn)
    
    if activeLoops[buttonId] then
        activeLoops[buttonId] = false
    else
        activeLoops[buttonId] = true
        
        spawn(function()
            while activeLoops[buttonId] do
                local success, result = pcall(function()
                    return loadstring(currentText)()
                end)
                if not success then
                    
                end
                wait(0.1)
            end
        end)
    end
end)
    cBtn = RSUI.createBtn("Clear", 0.65, 0.8, function() end)
    cpBtn = RSUI.createBtn("Copy Full", 0.05, 0.85, function()
        local currentText = aTB.Text
        RSUI.setClipboardText(currentText)
    end)

    mB.MouseButton1Click:Connect(function()
        if isMin then
            RSUI.maximize()
        else
            RSUI.minimize()
        end
    end)

    g.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

function RSUI.createLabel(text, position, size)
    local label = Instance.new("TextLabel", f)
    label.Size = size
    label.Position = position
    label.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Text = text
    return label
end

function RSUI.createBtn(text, x, y, callback)
    local b = Instance.new("TextButton", f)
    b.Size = UDim2.new(0.3, -20, 0.05, -10)
    b.Position = UDim2.new(x, 10, y, 15)
    b.Text = text
    b.BackgroundColor3 = Color3.new(0.2, 0.6, 0.8)
    b.TextColor3 = Color3.new(1, 1, 1)
    RSUI.addClickEvent(b, callback)
    return b
end

function RSUI.addClickEvent(button, callback)
    button.MouseButton1Click:Connect(callback)
end

function RSUI.decryptArgs(...)
    local decArgs = {}
    for _, arg in ipairs({...}) do
        if typeof(arg) == "Instance" then
            decArgs[#decArgs + 1] = RSUI.getHierarchy(arg)
        elseif typeof(arg) == "table" then
            decArgs[#decArgs + 1] = RSUI.formatTable(arg)
        else
            decArgs[#decArgs + 1] = tostring(arg)
        end
    end
    return decArgs
end

function RSUI.formatstr(name)
    if not name:match("[%a_]+[%w_]*") then
        return "['" .. name:gsub("'", "\\'") .. "']"
    else
        return name
    end
end

function RSUI.SafeGetService(className)
    local success, service = pcall(game.GetService, game, className)
    return success and service
end

function RSUI.getNil(name, className)
    return 'nil --' .. name .. ' (' .. className .. ')'
end

function RSUI.getHierarchy(instance)
    local parent = instance
    local out = ""

    if parent == nil then
        return "nil"
    elseif parent == game then
        return "game"
    else
        while parent and parent ~= game do
            if parent.Name:match("^[%a_][%w_]*$") then
                out = ':WaitForChild("' .. parent.Name .. '")' .. out
            else
                out = ':WaitForChild("' .. parent.Name:gsub('"', '\\"') .. '")' .. out
            end
            parent = parent.Parent
        end

        if parent == game then
            if RSUI.SafeGetService(instance.ClassName) then
                if string.lower(instance.ClassName) == "workspace" then
                    return 'workspace' .. out
                else
                    return 'game:GetService("' .. instance.ClassName .. '")' .. out
                end
            else
                return 'game' .. out
            end
        else
            return 'RSUI.getNil("' .. instance.Name:gsub('"', '\\"') .. '", "' .. instance.ClassName .. '")' .. out
        end
    end
end

function RSUI.parseTextBox(text)
    local remote, method, argsStr = text:match("(.+):(%w+)%((.*)%)")
    if not remote or not method then return nil end

    local args = loadstring("return " .. argsStr)()
    if not args then return nil end

    local remoteInstance = RSUI.getRemoteFromString(remote)
    if not remoteInstance then return nil end

    return remoteInstance, method, args
end

function RSUI.getRemoteFromString(str)
    local success, result = pcall(function()
        return loadstring("return " .. str)()
    end)
    if success and (typeof(result) == "Instance") and (result:IsA("RemoteEvent") or result:IsA("RemoteFunction")) then
        return result
    end
    return nil
end

function RSUI.updateDetailsSent(method, decArgs, hierarchy)
    local detailsText = "local args = {\n"
    for i, arg in ipairs(decArgs) do
        detailsText = detailsText .. "    [" .. i .. "] = " .. arg .. ",\n"
    end
    detailsText = detailsText .. "}\n\n" .. hierarchy .. ":" .. method .. "(unpack(args))"
    aTB.Text = detailsText
end

function RSUI.getInstanceName(instance)
    local name = instance.Name
    if not name:match("^[%a][%w]*$") or name:match("^%d") then
        return '["' .. name:gsub('"', '\\"') .. '"]'
    else
        return name
    end
end

function RSUI.formatTable(tbl, indent)
    indent = indent or 0
    local str = "{"
    for k, v in pairs(tbl) do
        if type(v) == "table" then
            str = str .. "\n" .. string.rep(" ", indent + 2) .. "[" .. RSUI.formatTableKey(k) .. "] = " .. RSUI.formatTable(v, indent + 2)
        else
            str = str .. "\n" .. string.rep(" ", indent + 2) .. "[" .. RSUI.formatTableKey(k) .. "] = " .. RSUI.formatTableValue(v)
        end
    end
    return str .. "\n" .. string.rep(" ", indent) .. "}"
end

function RSUI.formatTableKey(key)
    if type(key) == "string" and key:match("^[%a][%w]*$") then
        return key
    else
        return "[" .. tostring(key) .. "]"
    end
end

function RSUI.formatTableValue(value)
    if typeof(value) == "Instance" then
        return RSUI.getHierarchy(value)
    elseif typeof(value) == "table" then
        return RSUI.formatTable(value)
    else
        return tostring(value)
    end
end

function RSUI.interceptEvent(instance)
    local isPrinting
    local event
    local hasReceivedData = false
    
    local function handleEvent(...)
        if not hasReceivedData then
            hasReceivedData = true
            local btn, getPrintingStatus = RSUI.createReceivedButton(instance, ...)
            isPrinting = getPrintingStatus
            RSUI.updateScrollFrameSize(rF)
        end
        
        local decArgs = RSUI.decryptArgs(...)
        if isPrinting() then
            RSUI.updateDetailsReceived(decArgs)
        end
    end
    
    if instance:IsA("RemoteEvent") then
        event = instance.OnClientEvent:Connect(handleEvent)
    elseif instance:IsA("BindableEvent") then
        event = instance.Event:Connect(handleEvent)
    end
    
    return event
end

function RSUI.createButton(frame, text, callback)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.new(1, -10, 0, 30)
    b.Position = UDim2.new(0, 5, 0, 0)
    b.Text = text
    b.BackgroundColor3 = Color3.new(0.2, 0.6, 0.8)
    b.TextColor3 = Color3.new(1, 1, 1)
    RSUI.addClickEvent(b, callback)
    
    for _, child in ipairs(frame:GetChildren()) do
        if child:IsA("TextButton") and child ~= b then
            child.Position = UDim2.new(0, 5, 0, child.Position.Y.Offset + 35)
        end
    end
    return b
end

function RSUI.updateButtonCount(button, count)
    for _, child in ipairs(button:GetChildren()) do
        if child:IsA("TextLabel") then
            child.Text = count > 999 and "+999" or tostring(count)
            break
        end
    end
end

function RSUI.updateScrollFrameSize(frame)
    local layout = frame:FindFirstChildOfClass("UIListLayout")
    if layout then
        frame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y)
    end
end

function RSUI.minimize()
    isMin = true
    f.Size = UDim2.new(0, 600, 0, 35)
    f.Position = UDim2.new(0.5, -300, 0, 0)
    for _, child in ipairs(f:GetChildren()) do
        if child ~= mB and child ~= tL then
            child.Visible = false
        end
    end
    mB.Text = "+"
end

function RSUI.maximize()
    isMin = false
    f.Size = UDim2.new(0, 600, 0, 450)
    f.Position = UDim2.new(0.5, -300, 0.5, -225)
    for _, child in ipairs(f:GetChildren()) do
        child.Visible = true
    end
    mB.Text = "-"
end

function RSUI.updateDetailsReceived(decArgs)
    local detailsText = "local response = {\n"
    for i, arg in ipairs(decArgs) do
        detailsText = detailsText .. "    [" .. i .. "] = " .. arg .. "\n"
    end
    detailsText = detailsText .. "}"
    aTB.Text = detailsText
end

function RSUI.createReceivedButton(remote, ...)
    local hierarchy
    if type(remote) == "string" then
        hierarchy = remote
    else
        hierarchy = RSUI.getHierarchy(remote)
    end
    local decArgs = RSUI.decryptArgs(...)
    receivedRemoteArgs[hierarchy] = decArgs

    if not receivedRemotes[hierarchy] then
        local b = RSUI.createButton(rF, type(remote) == "string" and remote or remote.Name, function()
            RSUI.updateDetailsReceived(receivedRemoteArgs[hierarchy])
        end)
        receivedRemotes[hierarchy] = b
        RSUI.updateScrollFrameSize(rF)
        return b, function() return not b.BackgroundColor3:ToHSV() == Color3.fromRGB(0, 120, 0):ToHSV() end
    else
        
        return receivedRemotes[hierarchy], function() return not receivedRemotes[hierarchy].BackgroundColor3:ToHSV() == Color3.fromRGB(0, 120, 0):ToHSV() end
    end
end


function RSUI.updateDetailsSent(method, decArgs, hierarchy)
    local detailsText = "local args = {\n"
    for i, arg in ipairs(decArgs) do
        detailsText = detailsText .. "    [" .. i .. "] = " .. arg .. "\n"
    end
    detailsText = detailsText .. "}\n\n" .. hierarchy .. ":" .. method .. "(unpack(args))"
    aTB.Text = detailsText
end



function RSUI.logRemoteCall(remote, method, args)
    local hierarchy = RSUI.getHierarchy(remote)

    if method == "FireServer" then
        local decArgs = RSUI.decryptArgs(unpack(args))
        if not sentRemotes[hierarchy] then
            local b = RSUI.createButton(sF, remote.Name, function()
                RSUI.updateDetailsSent("FireServer", decArgs, hierarchy)
            end)
            sentRemotes[hierarchy] = b
            sentRemoteArgs[hierarchy] = decArgs
            sentRemoteHierarchy[hierarchy] = hierarchy
            RSUI.updateDetailsSent("FireServer", decArgs, hierarchy)
        else
            
        end
    elseif method == "InvokeServer" then
        local decArgs = RSUI.decryptArgs(unpack(args))
        if not sentRemotes[hierarchy] then
            local b = RSUI.createButton(sF, remote.Name, function()
                RSUI.updateDetailsSent("InvokeServer", decArgs, hierarchy)
            end)
            sentRemotes[hierarchy] = b
            sentRemoteArgs[hierarchy] = decArgs
            sentRemoteHierarchy[hierarchy] = hierarchy
            RSUI.updateDetailsSent("InvokeServer", decArgs, hierarchy)
        else

        end

    end
end


function RSUI.setClipboardText(text)
    local success, result = pcall(function()
        setclipboard(text)
    end)
    if not success then
        print("Error copying to clipboard: " .. result)
    end
end

local oth = oth or syn and syn.oth
local unhook = oth and oth.unhook
local hook = oth and oth.hook

local newcclosure = newcclosure or blankfunction
local cloneref = cloneref or blankfunction

local hookmetamethod = hookmetamethod or (makewriteable and makereadonly and getrawmetatable) and function(obj: object, metamethod: string, func: Function)
    local old = getrawmetatable(obj)

    if hookfunction then
        return hookfunction(old[metamethod],func)
    else
        local oldmetamethod = old[metamethod]
        makewriteable(old)
        old[metamethod] = func
        makereadonly(old)
        return oldmetamethod
    end
end

function ya(self, method, ...)
    local args = {...}
    RSUI.logRemoteCall(self, method, args)
end

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local method = getnamecallmethod()
 local args = {...}

    if method == "FireServer" or method == "InvokeServer" then
        spawn(function()
            ya(self, method, args)
        end)
    end

    return oldNamecall(self, ...)
end))



RSUI.createUI()

for _, obj in ipairs(game:GetDescendants()) do
    if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
        RSUI.interceptEvent(obj)
    end
end
