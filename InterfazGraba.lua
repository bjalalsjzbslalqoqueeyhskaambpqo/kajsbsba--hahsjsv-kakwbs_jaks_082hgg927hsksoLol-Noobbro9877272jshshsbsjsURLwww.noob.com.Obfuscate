local P = game:GetService("Players")
local RS = game:GetService("RunService")
local HS = game:GetService("HttpService")
local p = P.LocalPlayer

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
        _G.isM = not _G.isM
        ct.Visible = _G.isM
        mB.Text = _G.isM and "-" or "+"
    end)
    
    _G.tL = cE("TextLabel", fr, {
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
    
    _G.rB = cB(fr, "Rec", UDim2.new(0.55, 0, 0.1, 0), _G.tRP, Color3.fromRGB(220, 50, 50))
    _G.rB.Size = UDim2.new(0.3, 0, 0.8, 0)
    
    cB(ct, "Play", UDim2.new(0.02, 0, 0.02, 0), _G.pR)
    
    cB(ct, "Stop", UDim2.new(0.40, 0, 0.02, 0), _G.sTP)
    
    local url = cTB("", UDim2.new(0.26, 0, 0.35, 0), "Ingrese URL de grabación")
    url.Size = UDim2.new(0.70, 0, 0.15, 0)
    url.TextScaled = true
    
    local loadButton = cB(ct, "Load", UDim2.new(0.75, 0, 0.85, 0), function()
        if _G.isLoadingURL then
            ntf("Ya se está cargando una URL. Por favor, espere.", 2)
            return
        end
        local input = url.Text
        if input and input ~= "" then
            _G.isLoadingURL = true
            ntf("Cargando desde URL... Esto puede tomar unos segundos.", 5)
            task.spawn(function()
                if pcall(function() 
                    local content = game:HttpGet(input)
                    local data = HS:JSONDecode(content)
                    _G.rD, _G.r = data.duration, data.data
                end) then
                    ntf("Ruta cargada con éxito", 2)
                else
                    ntf("Error al cargar ruta desde URL", 2)
                end
                _G.isLoadingURL = false
            end)
        else 
            ntf("Por favor, ingrese una URL de grabación", 2) 
        end
    end)
    
    local sS = cTB("1", UDim2.new(0.20, 0, 0.19, 0), "Velocidad")
    sS:GetPropertyChangedSignal("Text"):Connect(function()
        local nS = tonumber(sS.Text)
        if nS and nS > 0 then 
            _G.setPlaybackSpeed(nS)
        end
    end)
    
    _G.lB = cB(ct, "Loop: Off", UDim2.new(0.75, 0, 0.02, 0), function()
        _G.isL = not _G.isL
        _G.setLooping(_G.isL)
        _G.lB.Text = _G.isL and "Loop: On" or "Loop: Off"
        _G.lB.BackgroundColor3 = _G.isL and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(60, 60, 60)
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
        if _G.isGeneratingURL then
            ntf("Ya se está generando una URL. Por favor, espere.", 2)
            return
        end
        _G.isGeneratingURL = true
        ntf("Generando enlace para compartir... Esto puede tomar unos segundos.", 5)
        task.spawn(function()
            local success, result = pcall(function()
                local dataToSend = {duration = _G.rD, data = _G.r}
                local jsonData = HS:JSONEncode(dataToSend)
                
                local req = http_request or request or syn.request or http.request
                local resp = req({
                    Url = _G.WU,
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
            _G.isGeneratingURL = false
        end)
    end)
    
    local hOI = cTB("0", UDim2.new(0.53, 0, 0.19, 0), "Altura")
    hOI:GetPropertyChangedSignal("Text"):Connect(function()
        local nO = tonumber(hOI.Text)
        if nO then 
            _G.setHeightOffset(nO)
        end
    end)
    
    local sPB = cTB("0", UDim2.new(0.02, 0, 0.52, 0), "% Inicio")
    sPB.Size = UDim2.new(0.3, 0, 0.15, 0)
    sPB:GetPropertyChangedSignal("Text"):Connect(function()
        local nP = tonumber(sPB.Text)
        if nP and nP >= 0 and nP <= 100 then
            _G.setStartPercentage(nP)
        end
    end)
    
    local codeTextBox = cTB("", UDim2.new(0.02, 0, 0.68, 0), "Script Execute here)
    codeTextBox.Size = UDim2.new(0.7, 0, 0.15, 0)
    codeTextBox.TextXAlignment = Enum.TextXAlignment.Left
    codeTextBox.ClearTextOnFocus = true
    codeTextBox.TextScaled = true
    
    local executeButton = cB(ct, "Exec", UDim2.new(0.75, 0, 0.68, 0), function()
        local code = codeTextBox.Text
        if code and code ~= "" then
            _G.handleCodeExecution(code)
            codeTextBox.Text = ""
        else
            ntf("Por favor, ingrese código para ejecutar", 2)
        end
    end)
    executeButton.Size = UDim2.new(0.23, 0, 0.15, 0)
    
    local addTextButton = cB(ct, "Add Text", UDim2.new(0.02, 0, 0.35, 0), function()
            spawn(function()
                    if _G.isR and not _G.isPaused then
        _G.isPaused = true
        _G.isInteractionRecording = false
        _G.rB.Text = "Continue"
        _G.rB.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
end
                    end)
        local textInputFrame = cE("Frame", sg, {
            Size = UDim2.new(0.5, 0, 0.5, 0),
            Position = UDim2.new(0.25, 0, 0.25, 0),
            BackgroundColor3 = Color3.fromRGB(40, 40, 40),
            BorderSizePixel = 0
        })
        cE("UICorner", textInputFrame, {CornerRadius = UDim.new(0, 10)})
        
        local textInput = cE("TextBox", textInputFrame, {
            Size = UDim2.new(1, -20, 1, -60),
            Position = UDim2.new(0, 10, 0, 10),
            BackgroundColor3 = Color3.fromRGB(60, 60, 60),
            TextColor3 = Color3.new(1, 1, 1),
            Font = Enum.Font.GothamSemibold,
            TextSize = 14,
            TextWrapped = true,
            Text = "Ingrese su mensaje aquí...",
            ClearTextOnFocus = true
        })
        cE("UICorner", textInput, {CornerRadius = UDim.new(0, 5)})
        
        local submitButton = cB(textInputFrame, "Add", UDim2.new(0.3, -55, 1, -40), function()
            local message = textInput.Text
            if message and message ~= "" then
                _G.addTextMessage(message)
                textInputFrame:Destroy()
else
                ntf("Por favor, ingrese un mensaje", 2)
            end
        end)
        submitButton.Size = UDim2.new(0, 100, 0, 30)
        
        local cancelButton = cB(textInputFrame, "Cancel", UDim2.new(0.6, 5, 1, -40), function()
            textInputFrame:Destroy()
        end)
        cancelButton.Size = UDim2.new(0, 100, 0, 30)
    end)
    addTextButton.Size = UDim2.new(0.23, 0, 0.15, 0)
    
    RS.Heartbeat:Connect(function()
        if _G.isR and not _G.isPaused then
            _G.eT = tick() - _G.sT
            _G.tL.Text = fT(_G.eT)
        elseif _G.isP and not _G.isPaused then
            _G.tL.Text = fT(_G.rD)
        elseif _G.isPaused then
            _G.tL.Text = fT(_G.isR and _G.eT or _G.rD)
        else
            _G.tL.Text = fT(_G.rD)
        end
    end)
end

cGUI()
