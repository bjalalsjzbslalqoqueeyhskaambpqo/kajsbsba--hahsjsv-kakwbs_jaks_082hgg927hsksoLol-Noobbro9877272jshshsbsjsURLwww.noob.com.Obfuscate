local Plrs,UIS=game:GetService("Players"),game:GetService("UserInputService")
local HS = game:GetService("HttpService")
local k = "AIzaSyCeb4A_gNAS7clem3u28gOo0PXIzO3o99g"
local url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=" .. k

local icons={Folder="📁",Model="📦",Part="🧊",MeshPart="🔷",Tool="🔧",Script="📜",LocalScript="📝",ModuleScript="📚",Workspace="🌍",Players="👥",Lighting="💡",ReplicatedStorage="🗄️",ServerStorage="🗃️",StarterGui="🖥️",StarterPack="🎒",Teams="👥",SoundService="🔊",Camera="📷",Humanoid="🧍",Terrain="🏞️",Decal="🖼️",Texture="🎨",PointLight="💡",SpotLight="🔦",Fire="🔥",Smoke="💨",Explosion="💥",Sparkles="✨",ParticleEmitter="🎆",TrussPath="🔩",VehicleSeat="💺",ClickDetector="👆",ProximityPrompt="❗",SurfaceGui="📺",BillboardGui="🗳️",ScreenGui="🖥️",UICorner="🔘",UIGradient="🌈",UIStroke="✏️",Motor6D="🦾",Sound="🔈",Attachment="🔗",Beam="↔️",BlurEffect="🌫️",BoolValue="✅",StringValue="🔤",NumberValue="🔢",Vector3Value="➡️",CFrameValue="🔲",Color3Value="🎨",IntValue="🔢",ObjectValue="🎯",RayValue="➖",BasePart="◻️",WeldConstraint="🔗",Highlight="✨",Animator="🎭",AnimationController="🎬",KeyframeSequence="🔑",TweenService="↕️",DataStoreService="💾",MarketplaceService="🛒",Debris="🗑️",PathfindingService="🧭",RemoteEvent="📡",RemoteFunction="📞"}

local function gI(c)return icons[c]or"❓"end

local function cB(p,t,po,s,c)
    local b=Instance.new("TextButton")
    b.Text,b.Position,b.Size,b.Parent,b.BackgroundColor3,b.TextColor3=t,po,s,p,Color3.fromRGB(40,40,40),Color3.new(1,1,1)
    b.MouseButton1Click:Connect(c)
    local corner=Instance.new("UICorner")
    corner.CornerRadius=UDim.new(0,8)
    corner.Parent=b
    return b
end

local function gFN(o)
    local p, c = o.Name, o.Parent
    while c and c ~= game do
        if c:FindFirstChild(p) and #c:GetChildren() > 1 then
            local s = c:GetChildren()
            for j, v in ipairs(s) do
                if v.Name == p then
                    if v == o then
                        p = c.Name .. "." .. p .. ":GetChildren()[" .. j .. "]"
                        break
                    end
                end
            end
        else
            p = c.Name .. "." .. p
        end
        c = c.Parent
    end
    return "game." .. p
end

local function cP(o)setclipboard(gFN(o))end

local function cEI(title,content,callback,parent)
    local f=Instance.new("Frame")
    f.Size,f.Position,f.BackgroundColor3,f.Parent=UDim2.new(0,300,0,150),UDim2.new(0.5,-150,0.5,-75),Color3.fromRGB(30,30,30),parent
    local c=Instance.new("UICorner")
    c.CornerRadius,c.Parent=UDim.new(0,12),f
    local t=Instance.new("TextLabel")
    t.Text,t.Size,t.Position,t.BackgroundTransparency,t.TextColor3,t.Parent=title,UDim2.new(1,0,0,30),UDim2.new(0,0,0,0),1,Color3.new(1,1,1),f
    local i=Instance.new("TextBox")
    i.Text,i.Size,i.Position,i.Parent=content,UDim2.new(1,-20,0,30),UDim2.new(0,10,0,40),f
    local bc=Instance.new("UICorner")
    bc.CornerRadius,bc.Parent=UDim.new(0,8),i
    local b=cB(f,"OK",UDim2.new(0,10,1,-40),UDim2.new(0.5,-15,0,30),function()callback(i.Text)f:Destroy()end)
    local cb=cB(f,"Cancel",UDim2.new(0.5,5,1,-40),UDim2.new(0.5,-15,0,30),function()f:Destroy()end)
    return f,i
end

local function eM(msg)
    local d = {
        contents = {
            {
                parts = {
                    {
                        text = msg
                    }
                }
            }
        }
    }
    local h = {
        ["Content-Type"] = "application/json"
    }
    local rd = HS:JSONEncode(d)
    local req = http_request or request or syn.request or http.request
    local ok, res = pcall(function()
        return req({
            Url = url,
            Method = "POST",
            Headers = h,
            Body = rd
        })
    end)
    if ok and res.StatusCode == 200 then
        return res.Body
    else
        warn("Error al enviar la petición:", res)
        return nil
    end
end

local function pR(r)
    local rd = HS:JSONDecode(r)
    if rd and rd.candidates and rd.candidates[1] and rd.candidates[1].content and rd.candidates[1].content.parts then
        local tG = ""
        for _, p in ipairs(rd.candidates[1].content.parts) do
            if p.text then
                tG = tG .. p.text
            end
        end
        tG = tG:gsub("`", ""):gsub("'", ""):gsub("%*", "")
        return tG
    else
        return ""
    end
end

local function showAIResponse(response, parent)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(0.8, 0, 0.8, 0)
    f.Position = UDim2.new(0.1, 0, 0.1, 0)
    f.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    f.ZIndex = 10000
    f.Parent = parent

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 12)
    c.Parent = f

    local s = Instance.new("ScrollingFrame")
    s.Size = UDim2.new(1, -20, 1, -60)
    s.Position = UDim2.new(0, 10, 0, 10)
    s.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    s.BorderSizePixel = 0
    s.ScrollBarThickness = 8
    s.ZIndex = 10001
    s.Parent = f

    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, -16, 0, 0)
    t.Position = UDim2.new(0, 8, 0, 0)
    t.BackgroundTransparency = 1
    t.TextColor3 = Color3.new(1, 1, 1)
    t.TextSize = 14
    t.Font = Enum.Font.SourceSans
    t.TextWrapped = true
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.TextYAlignment = Enum.TextYAlignment.Top
    t.ZIndex = 10002
    t.Parent = s
    
    -- Asegurarse de que el texto se muestre completo
    t.Text = response
    
    -- Ajustar el tamaño del TextLabel basado en el contenido
    local textSize = game:GetService("TextService"):GetTextSize(
        t.Text,
        t.TextSize,
        t.Font,
        Vector2.new(s.AbsoluteSize.X - 16, 10000)
    )
    t.Size = UDim2.new(1, -16, 0, textSize.Y)
    s.CanvasSize = UDim2.new(0, 0, 0, textSize.Y + 20)

    local cb = cB(f, "Copy", UDim2.new(0.35, 5, 1, -40), UDim2.new(0.3, -15, 0, 30), function()
        setclipboard(response)
    end)
    cb.ZIndex = 10003

    local closeb = cB(f, "Close", UDim2.new(0.7, 5, 1, -40), UDim2.new(0.3, -15, 0, 30), function()
        f:Destroy()
    end)
    closeb.ZIndex = 10003

    local blocker = Instance.new("TextButton")
    blocker.Size = UDim2.new(1, 0, 1, 0)
    blocker.BackgroundTransparency = 1
    blocker.Text = ""
    blocker.ZIndex = 9999
    blocker.Parent = f
    blocker.MouseButton1Click:Connect(function() end)
end

local function getInstanceProperties(o)
    local commonProperties = {"Name", "Parent", "ClassName", "Position", "Size", "Rotation", "CFrame", "Anchored", "CanCollide", "Transparency", "Color", "Material", "Reflectance", "BrickColor", "TopSurface", "BottomSurface", "FrontSurface", "BackSurface", "LeftSurface", "RightSurface", "Shape", "Massless", "Elasticity", "Friction", "FrictionWeight", "ElasticityWeight", "CustomPhysicalProperties", "Velocity", "RotVelocity", "Orientation", "AssemblyAngularVelocity", "AssemblyLinearVelocity", "AssemblyMass", "AssemblyCenter", "CenterOfMass", "PivotOffset", "WorldPivot", "Archivable", "ChildAdded", "ChildRemoved", "DescendantAdded", "DescendantRemoving", "AncestryChanged", "AttributeChanged", "Changed", "childAdded", "childRemoved", "descendantAdded", "descendantRemoving", "Touched", "TouchEnded", "InputBegan", "InputChanged", "InputEnded", "MouseEnter", "MouseLeave", "MouseMoved", "MouseWheelBackward", "MouseWheelForward", "RootPriority", "PrimaryPart", "BasePart", "Attachment", "Constraint", "Joint", "JointInstance", "Weld", "Motor", "Animator", "Animation", "AnimationController", "AnimationTrack", "Humanoid", "HumanoidDescription", "Tool", "Script", "LocalScript", "ModuleScript", "RemoteEvent", "RemoteFunction", "BindableEvent", "BindableFunction", "Sound", "SoundGroup", "Decal", "Texture", "SurfaceLight", "SpotLight", "PointLight", "Fire", "Smoke", "Sparkles", "Trail", "Beam", "ParticleEmitter", "Explosion", "ForceField", "Highlight", "SelectionBox", "SurfaceGui", "BillboardGui", "ScreenGui", "TextLabel", "TextButton", "TextBox", "ImageLabel", "ImageButton", "ViewportFrame", "VideoFrame", "ClickDetector", "ProximityPrompt", "DialogChoice", "Dialog", "UIAspectRatioConstraint", "UICorner", "UIGradient", "UIGridLayout", "UIListLayout", "UIPadding", "UIPageLayout", "UIScale", "UISizeConstraint", "UIStroke", "UITableLayout", "UITextSizeConstraint"}
    local properties = {}
    for _, prop in ipairs(commonProperties) do
        if pcall(function() return o[prop] end) then
            table.insert(properties, prop)
        end
    end
    if #properties == 0 then
        local prefijo = "proporcióname las propiedades que tiene la siguiente instancia de Roblox, separado por coma , sin textos ni explicaciones extras"
        local instanceInfo = "Class: " .. o.ClassName
        local query = prefijo .. "\n" .. instanceInfo
        local response = eM(query)
        if response then
            local parsedResponse = pR(response)
            properties = parsedResponse:split(",")
        end
    end
    if #properties == 0 then
        properties = {"Name", "ClassName", "Parent"}
    end
    return properties
end

local function vMP(o, parent)
    local properties = getInstanceProperties(o)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(0, 300, 0, 400)
    f.Position = UDim2.new(0.5, -150, 0.5, -200)
    f.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    f.ZIndex = 10000
    f.Parent = parent

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 12)
    c.Parent = f

    local t = Instance.new("TextLabel")
    t.Text = "Properties of " .. (pcall(function() return o.Name end) and o.Name or "Unknown")
    t.Size = UDim2.new(1, 0, 0, 30)
    t.Position = UDim2.new(0, 0, 0, 0)
    t.BackgroundTransparency = 1
    t.TextColor3 = Color3.new(1, 1, 1)
    t.ZIndex = 10001
    t.Parent = f

    local s = Instance.new("ScrollingFrame")
    s.Size = UDim2.new(1, -20, 1, -70)
    s.Position = UDim2.new(0, 10, 0, 40)
    s.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    s.BorderSizePixel = 0
    s.ScrollBarThickness = 8
    s.ZIndex = 10001
    s.Parent = f

    for i, prop in ipairs(properties) do
        if type(prop) == "string" and prop:match("^%s*(.-)%s*$") ~= "" then
            local propFrame = Instance.new("Frame")
            propFrame.Size = UDim2.new(1, -10, 0, 30)
            propFrame.Position = UDim2.new(0, 5, 0, (i-1) * 35)
            propFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            propFrame.ZIndex = 10002
            propFrame.Parent = s

            local propName = Instance.new("TextLabel")
            propName.Text = prop
            propName.Size = UDim2.new(0.5, -5, 1, 0)
            propName.Position = UDim2.new(0, 5, 0, 0)
            propName.BackgroundTransparency = 1
            propName.TextColor3 = Color3.new(1, 1, 1)
            propName.TextXAlignment = Enum.TextXAlignment.Left
            propName.ZIndex = 10003
            propName.Parent = propFrame

            local propValue = Instance.new("TextBox")
            propValue.Size = UDim2.new(0.5, -5, 1, 0)
            propValue.Position = UDim2.new(0.5, 0, 0, 0)
            propValue.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            propValue.TextColor3 = Color3.new(1, 1, 1)
            propValue.ZIndex = 10003
            propValue.Parent = propFrame
            propValue.ClearTextOnFocus = false

            local success, result = pcall(function() return tostring(o[prop]) end)
            propValue.Text = success and result or "N/A"

            propValue.FocusLost:Connect(function()
                pcall(function() o[prop] = propValue.Text end)
            end)
        end
    end

    s.CanvasSize = UDim2.new(0, 0, 0, #properties * 35 + 5)

    local closeb = cB(f, "Close", UDim2.new(0.5, -50, 1, -35), UDim2.new(0, 100, 0, 30), function()
        f:Destroy()
    end)
    closeb.ZIndex = 10003

    local blocker = Instance.new("TextButton")
    blocker.Size = UDim2.new(1, 0, 1, 0)
    blocker.BackgroundTransparency = 1
    blocker.Text = ""
    blocker.ZIndex = 9999
    blocker.Parent = f
    blocker.MouseButton1Click:Connect(function() end)
end

local function cOM(o,uF,parent)
    local f=Instance.new("Frame")
    f.Size,f.Position, f.BackgroundColor3,f.Parent=UDim2.new(0,180,0,234),UDim2.new(1,9,0,0),Color3.fromRGB(30,30,30),parent
    local c=Instance.new("UICorner")
    c.CornerRadius,c.Parent=UDim.new(0,12),f
    local function cO(t,y,c)
        local ob=cB(f,t,UDim2.new(0,9,0,y),UDim2.new(1,-18,0,27),function()c()f:Destroy()end)
    end
    cO("Copy Path",9,function()cP(o)end)
    cO("Rename",45,function()
        cEI("Rename",o.Name,function(n)pcall(function()o.Name=n uF()end)end,parent)
    end)
    cO("Delete",81,function()pcall(function()o:Destroy()uF()end)end)
    cO("View Properties",117,function()vMP(o,parent)end)
    cO("AI Query",153,function()
        local prefijo = "Este mensaje es para un contexto de Roblox. Por favor, responde solo con el código necesario sin usar ``, o en caso de que se pida información sobre la instancia brindar una respuesta con la información en vez de un código, además de eso la información que se va a brindar no es necesario usarla de forma tan literal y directa sino puedes utilizarlo como una fuente de información en algunos casos para apuntar directamente a la instancia o para decir formas de trabajar con la distancia según se pida Script o se pida algún tipo de información de la misma Ya que en algunos casos se mejor es trabajar de forma dinámica con la información obtenida trabajar por la jerarquía directa que puede cambiar dependiendo tu analiza la situación"
        local instanceInfo = "Class: " .. o.ClassName .. ", Full Path: " .. gFN(o)
        cEI("AI Query for " .. o.Name, "Enter your question", function(query)
            local fullQuery = prefijo .. "\n" .. instanceInfo .. "\n" .. query
            local response = eM(fullQuery)
            if response then
                local parsedResponse = pR(response)
                showAIResponse(parsedResponse, parent)
            else
                showAIResponse("Error: No se pudo obtener una respuesta de la IA.", parent)
            end
        end, parent)
    end)
    if o:IsA("RemoteEvent")or o:IsA("RemoteFunction")then
        cO("Use Remote",189,function()
            cEI("Use Remote","Enter arguments here",function(a)
                pcall(function()
                    if o:IsA("RemoteEvent")then o:FireServer(a)
                    elseif o:IsA("RemoteFunction")then o:InvokeServer(a)end
                end)
            end,parent)
        end)
    else
        cO("Close",189,function()end)
    end
end

local function fEG()
    for _,c in ipairs(Plrs.LocalPlayer:WaitForChild("PlayerGui"):GetChildren())do
        if c:IsA("ScreenGui")and c.Enabled then return c end
    end
    local ng=Instance.new("ScreenGui")
    ng.Name,ng.Enabled,ng.Parent="DexLiteGui",true,Plrs.LocalPlayer:WaitForChild("PlayerGui")
    return ng
end

local function cGUI()
    local sg,mf,cf,tl=fEG(),Instance.new("Frame"),Instance.new("ScrollingFrame"),Instance.new("TextLabel")
    mf.Name,mf.Size,mf.Position,mf.BackgroundColor3,mf.Parent="Main",UDim2.new(0.72,0,0.72,0),UDim2.new(0.14,0,0.14,0),Color3.fromRGB(20,20,20),sg
    local c=Instance.new("UICorner")
    c.CornerRadius,c.Parent=UDim.new(0,12),mf
    tl.Size,tl.Position,tl.BackgroundColor3,tl.TextColor3,tl.Text,tl.Parent=UDim2.new(1,-9,0,27),UDim2.new(0,4.5,0,4.5),Color3.fromRGB(30,30,30),Color3.new(1,1,1),"DexLite Explorer",mf
    local cl=Instance.new("UICorner")
    cl.CornerRadius,cl.Parent=UDim.new(0,8),tl
    cf.Size,cf.Position,cf.BackgroundColor3,cf.Parent=UDim2.new(1,-9,1,-40.5),UDim2.new(0,4.5,0,36),Color3.fromRGB(25,25,25),mf
    local cc=Instance.new("UICorner")
    cc.CornerRadius,cc.Parent=UDim.new(0,8),cf
    local tb=cB(sg,"D",UDim2.new(1,-54,1,-54),UDim2.new(0,45,0,45),function()mf.Visible=not mf.Visible end)
    tb.AnchorPoint=Vector2.new(1,1)
    return sg,mf,cf,tl
end

local function sC(p,cf)
    cf:ClearAllChildren()
    local ll=Instance.new("UIListLayout")
    ll.Parent=cf
    local function cIB(i,d)
        local b=cB(cf,string.rep("  ",d)..gI(i.ClassName).." "..i.Name,UDim2.new(0,0,0,#cf:GetChildren()*27),UDim2.new(1,0,0,27),function()sC(i,cf)end)
        b.TextXAlignment=Enum.TextXAlignment.Left
        local ps,con
        b.InputBegan:Connect(function(input)
            if input.UserInputType==Enum.UserInputType.Touch or input.UserInputType==Enum.UserInputType.MouseButton1 then
                ps=tick()
                con=UIS.InputEnded:Connect(function(input)
                    if input.UserInputType==Enum.UserInputType.Touch or input.UserInputType==Enum.UserInputType.MouseButton1 then
                        local pd=tick()-ps
                        if pd>=1 then cOM(i,function()sC(p,cf)end,cf.Parent)end
                        ps=nil
                        if con then con:Disconnect()con=nil end
                    end
                end)
            end
        end)
    end
    local bb=cB(cf,"← Back",UDim2.new(0,0,0,0),UDim2.new(1,0,0,27),function()if p.Parent then sC(p.Parent,cf)end end)
    for _,c in ipairs(p:GetChildren())do cIB(c,0)end
    cf.CanvasSize=UDim2.new(0,0,0,#cf:GetChildren()*27)
end

local function cSS()
    local sg,f=fEG(),Instance.new("Frame")
    f.Size,f.BackgroundColor3,f.Parent=UDim2.new(1,0,1,0),Color3.fromRGB(20,20,20),sg
    local tl,cl=Instance.new("TextLabel"),Instance.new("TextLabel")
    tl.Size,tl.Position,tl.BackgroundTransparency,tl.TextColor3,tl.TextSize,tl.Font,tl.Text,tl.Parent=UDim2.new(1,0,0,54),UDim2.new(0,0,0.4,0),1,Color3.new(1,1,1),43,Enum.Font.GothamBold,"DexLite Explorer + IA [Beta 0.1]",f
    cl.Size,cl.Position,cl.BackgroundTransparency,cl.TextColor3,cl.TextSize,cl.Font,cl.Text,cl.Parent=UDim2.new(1,0,0,27),UDim2.new(0,0,0.6,0),1,Color3.new(0.8,0.8,0.8),22,Enum.Font.Gotham,"By: OneCreatorX",f
    return f
end

local ss,sg,mf,cf,tl=cSS(),cGUI()
mf.Visible=false
sC(game,cf)
wait(3)
ss:Destroy()
mf.Visible=true
