TS = game:GetService("TweenService")
p = game:GetService("Players").LocalPlayer
pg = p:WaitForChild("PlayerGui")

function cUI()
    sg = nil
    for _, c in ipairs(pg:GetChildren()) do
        if c:IsA("ScreenGui") and c.Enabled then
            sg = c
            break
        end
    end
    if not sg then error("No ScreenGui habilitado") end

    f = sg:FindFirstChild("LF") or Instance.new("Frame")
    f.Name, f.Size, f.Position = "LF", UDim2.new(0, 300, 0, 100), UDim2.new(0.5, -150, 0.5, -50)
    f.BackgroundColor3, f.BorderSizePixel, f.Parent = Color3.fromRGB(30, 30, 30), 0, sg

    for _, c in ipairs(f:GetChildren()) do c:Destroy() end

    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 10)

    t = Instance.new("TextLabel", f)
    t.Size, t.Position = UDim2.new(1, -20, 0.5, 0), UDim2.new(0, 10, 0, 10)
    t.BackgroundTransparency, t.Text = 1, "Iniciando..."
    t.TextColor3, t.TextSize, t.Font = Color3.new(1, 1, 1), 16, Enum.Font.Code

    s = Instance.new("TextLabel", f)
    s.Size, s.Position = UDim2.new(1, -20, 0.3, 0), UDim2.new(0, 10, 0.5, 0)
    s.BackgroundTransparency, s.Text = 1, "Descifrando..."
    s.TextColor3, s.TextSize, s.Font = Color3.fromRGB(0, 255, 0), 14, Enum.Font.Code

    b = Instance.new("Frame", f)
    b.Size, b.Position = UDim2.new(1, -20, 0, 4), UDim2.new(0, 10, 0.9, -4)
    b.BackgroundColor3, b.BorderSizePixel = Color3.fromRGB(60, 60, 60), 0

    bf = Instance.new("Frame", b)
    bf.Size, bf.BackgroundColor3 = UDim2.new(0, 0, 1, 0), Color3.fromRGB(0, 255, 0)

    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 2)
    Instance.new("UICorner", bf).CornerRadius = UDim.new(0, 2)

    return sg, t, s, bf
end

function aL(bf, t, s)
    for _, v in ipairs({
        {0.2, "Descifrando...", "Accediendo..."},
        {0.4, "Verificando...", "Decodificando..."},
        {0.6, "Aplicando...", "Procesando..."},
        {0.8, "Finalizando...", "Preparando..."},
        {1, "Completado", "Iniciando..."}
    }) do
        TS:Create(bf, TweenInfo.new(0.5), {Size = UDim2.new(v[1], 0, 1, 0)}):Play()
        s.Text, t.Text = v[2], v[3]
        task.wait(0.6)
    end
end

function fS(u, mR)
    for i = 1, mR do
        local s, r = pcall(function() return game:HttpGet(u) end)
        if s then return s, r end
        wait(1)
    end
    return false, "Max reintentos"
end

function SL(s)
    local p = s:split("-")
    local sl = table.concat(table.pack(table.unpack(p, 2)), "-")
    
    local sg, t, s, bf = cUI()
    
    task.spawn(function() aL(bf, t, s) end)

    local sT = os.clock()
    local u = string.format("https://loader.brunotoledo526.workers.dev/?t=%d&sl=%s", os.time(), sl)
    
    local sc, r = fS(u, 3)
    
    task.wait(math.max(3 - (os.clock() - sT), 0))

    if sc then
        spawn(function()
            s.Text = "Carga completada."
            task.wait(2)
            sg:FindFirstChild("LF"):Destroy()
        end)
        
        local sf, le = loadstring(r)
        if sf then 
            sf() 
        else 
            warn("Error: " .. tostring(le))
            s.Text = "Error. Reintentando..."
            task.wait(2)
            SL(table.concat(p, "-"))
        end
    else
        s.Text = "Error. Reintentando..."
        task.wait(2)
        sg:FindFirstChild("LF"):Destroy()
        warn("Error: " .. tostring(r))
        SL(table.concat(p, "-"))
    end
end

return SL
