local P, RS, HS = game:GetService("Players"), game:GetService("RunService"), game:GetService("HttpService")
local p, c, h = P.LocalPlayer, nil, nil
local r, isR, isP = {}, false, false
local FPS, pS, rD, hO = 60, 1, 0, 0
local cC, sT, eT = nil, 0, 0
local isL, isM, isPaused = false, false, false
local cT, tL, rB, lB = 0, nil, nil, nil
local WU = "https://create.api-x.site"
local pausedIndex, pausedTime, i
local startPercentage = 0
local isGeneratingURL = false
local isLoadingURL = false

local function fT(s) return string.format("%02d:%02d:%02d", s/3600, (s%3600)/60, s%60) end

local function ntf(m, d)
    local sg = Instance.new("ScreenGui", p.PlayerGui)
    local f = Instance.new("Frame", sg)
    f.Size, f.Position = UDim2.new(0, 200, 0, 40), UDim2.new(0.5, -100, 0.9, -20)
    f.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
    local t = Instance.new("TextLabel", f)
    t.Size, t.Position = UDim2.new(1, -10, 1, -10), UDim2.new(0, 5, 0, 5)
    t.BackgroundTransparency, t.Text, t.TextColor3 = 1, m, Color3.new(1, 1, 1)
    t.TextWrapped, t.Font, t.TextSize = true, Enum.Font.GothamSemibold, 12
    game:GetService("Debris"):AddItem(sg, d or 2)
end

local function cE(t, p, props)
    local e = Instance.new(t)
    for k, v in pairs(props) do e[k] = v end
    e.Parent = p
    return e
end

local function cB(p, txt, pos, func, col)
    local b = cE("TextButton", p, {
        Size = UDim2.new(0.23, 0, 0.15, 0),
        Position = pos,
        Text = txt,
        BackgroundColor3 = col or Color3.fromRGB(60, 60, 60),
        TextColor3 = Color3.new(1, 1, 1),
        Font = Enum.Font.GothamSemibold,
        TextSize = 12,
        BorderSizePixel = 0
    })
    cE("UICorner", b, {CornerRadius = UDim.new(0, 6)})
    b.MouseButton1Click:Connect(func)
    return b
end

local function sC()
    c, h = p.Character or p.CharacterAdded:Wait(), nil
    h = c:WaitForChild("HumanoidRootPart")
end

local function uP()
    if isR and h and not isPaused then
        table.insert(r, {pos = {h.CFrame:GetComponents()}})
    end
end

local function sR()
    r, isR, sT, isPaused = {}, true, tick(), false
    rB.Text = "Pause"
    rB.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
    ntf("Grabación iniciada", 2)
end

local function pR()
    if #r > 0 then
        isP, isPaused = true, false
        i = math.max(1, math.floor(#r * startPercentage / 100))
        pST = tick() - (i - 1) / (FPS * pS)
        pausedIndex, pausedTime = nil, nil
        rB.Text = "Pause"
        rB.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
        cC = RS.Heartbeat:Connect(function()
            if not isP or isPaused then return end
            if not h then sC() return end
            local dt = tick() - pST
            i = 1 + dt * FPS * pS
            if i > #r then 
                if isL then 
                    i = math.max(1, math.floor(#r * startPercentage / 100))
                    pST = tick() - (i - 1) / (FPS * pS)
                else 
                    isP, cC, isPaused = false, cC and cC:Disconnect(), false 
                    rB.Text = "Rec" 
                    rB.BackgroundColor3 = Color3.fromRGB(220, 50, 50) 
                    ntf("Reproducción terminada", 2) 
                    return 
                end
            end
            local cr, nx = r[math.floor(i)], r[math.min(math.floor(i) + 1, #r)]
            local f = i - math.floor(i)
            h.CFrame = CFrame.new(unpack(cr.pos)):Lerp(CFrame.new(unpack(nx.pos)), f) + Vector3.new(0, hO, 0)
            tL.Text = fT(dt)
        end)
        ntf("Reproducción iniciada desde " .. startPercentage .. "%", 2)
    else 
        ntf("No hay ruta grabada para reproducir", 2) 
    end
end

local function tRP()
    if isR then
        isPaused = not isPaused
        if isPaused then
            rB.Text = "Continue"
            rB.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            eT = tick() - sT
            ntf("Grabación pausada", 2)
        else
            rB.Text = "Pause"
            rB.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
            sT = tick() - eT
            ntf("Grabación continuada", 2)
        end
    elseif isP then
        isPaused = not isPaused
        if isPaused then
            rB.Text = "Continue"
            rB.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            pausedIndex = i
            pausedTime = tick() - pST
            ntf("Reproducción pausada", 2)
        else
            rB.Text = "Pause"
            rB.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
            i = pausedIndex
            pST = tick() - pausedTime
            ntf("Reproducción continuada", 2)
        end
    else
        sR()
    end
end

local function cGUI()
    local sg = cE("ScreenGui", p.PlayerGui, {ResetOnSpawn = false, Name = "RecorderGUI"})
    local fr = cE("Frame", sg, {
        Size = UDim2.new(0, 250, 0, 20),
        Position = UDim2.new(0.5, -125, 0.9, -20),
        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
        BorderSizePixel = 0,
        Active = true,
        Draggable = true
    })
    cE("UICorner", fr, {CornerRadius = UDim.new(0, 8)})
    
    local mB = cE("TextButton", fr, {
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(1.05, -35, 0, 0),
        Text = "+",
        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
        TextColor3 = Color3.new(1, 1, 1),
        Font = Enum.Font.GothamBold,
        TextSize = 16,
        BorderSizePixel = 0
    })
    cE("UICorner", mB, {CornerRadius = UDim.new(0, 6)})
    
    local ct = cE("Frame", fr, {
        Size = UDim2.new(1, 0, 0, 130),
        Position = UDim2.new(0, 0, 1, 5),
        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
        Visible = false
    })
    cE("UICorner", ct, {CornerRadius = UDim.new(0, 8)})
    
    mB.MouseButton1Click:Connect(function()
        isM = not isM
        ct.Visible = isM
        mB.Text = isM and "-" or "+"
    end)
    
    tL = cE("TextLabel", fr, {
        Size = UDim2.new(1, -80, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = "00:00:00",
        TextColor3 = Color3.new(1, 1, 1),
        Font = Enum.Font.GothamSemibold,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local function cTB(txt, pos, ph)
        local tb = cE("TextBox", ct, {
            Size = UDim2.new(0.3, 0, 0.15, 0),
            Position = pos,
            Text = txt,
            PlaceholderText = ph,
            BackgroundColor3 = Color3.fromRGB(50, 50, 50),
            TextColor3 = Color3.new(1, 1, 1),
            Font = Enum.Font.Gotham,
            TextSize = 12,
            BorderSizePixel = 0,
            ClearTextOnFocus = false
        })
        cE("UICorner", tb, {CornerRadius = UDim.new(0, 6)})
        return tb
    end
    
    rB = cB(fr, "Rec", UDim2.new(0.55, 0, 0.1, 0), tRP, Color3.fromRGB(220, 50, 50))
    rB.Size = UDim2.new(0.3, 0, 0.8, 0)
    
    cB(ct, "Play", UDim2.new(0.02, 0, 0.02, 0), pR)
    
    cB(ct, "Stop", UDim2.new(0.40, 0, 0.02, 0), function()
        if isR then rD = tick() - sT end
        isR, isP, isPaused = false, false, false
        if cC then cC:Disconnect() cC = nil end
        eT = isR and (tick() - sT) or eT
        rB.Text = "Rec"
        rB.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
        ntf("Grabación/Reproducción detenida", 2)
    end)
    
    local url = cTB("", UDim2.new(0.02, 0, 0.35, 0), "Ingrese URL de grabación")
    url.Size = UDim2.new(0.96, 0, 0.15, 0)
    url.TextScaled = true
    
    local loadButton = cB(ct, "Load", UDim2.new(0.75, 0, 0.85, 0), function()
        if isLoadingURL then
            ntf("Ya se está cargando una URL. Por favor, espere.", 2)
            return
        end
        local input = url.Text
        if input and input ~= "" then
            isLoadingURL = true
            ntf("Cargando desde URL... Esto puede tomar unos segundos.", 5)
            task.spawn(function()
                if pcall(function() 
                    local content = game:HttpGet(input)
                    local data = HS:JSONDecode(content)
                    rD, r = data.duration, data.data
                end) then
                    ntf("Ruta cargada con éxito", 2)
                else
                    ntf("Error al cargar ruta desde URL", 2)
                end
                isLoadingURL = false
            end)
        else 
            ntf("Por favor, ingrese una URL de grabación", 2) 
        end
    end)
    
    local sS = cTB("1", UDim2.new(0.20, 0, 0.19, 0), "Velocidad")
    sS:GetPropertyChangedSignal("Text"):Connect(function()
        local nS = tonumber(sS.Text)
        if nS and nS > 0 then pS = nS end
    end)
    
    lB = cB(ct, "Loop: Off", UDim2.new(0.75, 0, 0.02, 0), function()
        isL = not isL
        lB.Text = isL and "Loop: On" or "Loop: Off"
        lB.BackgroundColor3 = isL and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(60, 60, 60)
    end)
    
    cB(ct, "YouTube", UDim2.new(0.02, 0, 0.85, 0), function()
        setclipboard("https://youtube.com/@onecreatorx")
        ntf("Enlace de YouTube copiado al portapapeles", 2)
    end, Color3.fromRGB(200, 50, 50))
    
    cB(ct, "Discord", UDim2.new(0.27, 0, 0.85, 0), function()
        setclipboard("https://discord.com/invite/AvgprcyK4w")
        ntf("Invitación de Discord copiada al portapapeles", 2)
    end, Color3.fromRGB(114, 137, 218))
    
    local shareButton = cB(ct, "Share", UDim2.new(0.52, 0, 0.85, 0), function()
        if isGeneratingURL then
            ntf("Ya se está generando una URL. Por favor, espere.", 2)
            return
        end
        isGeneratingURL = true
        ntf("Generando enlace para compartir... Esto puede tomar unos segundos.", 5)
        task.spawn(function()
            local success, result = pcall(function()
                local dataToSend = {duration = rD, data = r}
                local jsonData = HS:JSONEncode(dataToSend)
                
                local req = http_request or request or syn.request or http.request
                local resp = req({
                    Url = WU,
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json",
                        ["User-Agent"] = "Roblox/1.0"
                    },
                    Body = jsonData
                })
                
                local respData = HS:JSONDecode(resp.Body)
                return resp.StatusCode == 200 and respData and respData.url and tostring(respData.url) or false
            end)
            if success and result then
                setclipboard(result)
                ntf("URL de grabación copiada al portapapeles", 2)
            else
                ntf("Error al generar enlace para compartir: " .. tostring(result), 5)
            end
            isGeneratingURL = false
        end)
    end)
    
    local hOI = cTB("0", UDim2.new(0.53, 0, 0.19, 0), "Altura")
    hOI:GetPropertyChangedSignal("Text"):Connect(function()
        local nO = tonumber(hOI.Text)
        if nO then hO = nO end
    end)
    
    local sPB = cTB("0", UDim2.new(0.02, 0, 0.52, 0), "% Inicio")
    sPB.Size = UDim2.new(0.3, 0, 0.15, 0)
    sPB:GetPropertyChangedSignal("Text"):Connect(function()
        local nP = tonumber(sPB.Text)
        if nP and nP >= 0 and nP <= 100 then
            startPercentage = nP
        end
    end)
    
    RS.Heartbeat:Connect(function()
        uP()
        if isR and not isPaused then
            eT = tick() - sT
            tL.Text = fT(eT)
        elseif isP and not isPaused then
            tL.Text = fT(rD)
        elseif isPaused then
            tL.Text = fT(isR and eT or rD)
        else
            tL.Text = fT(rD)
        end
    end)
end

sC()
p.CharacterAdded:Connect(sC)
cGUI()
