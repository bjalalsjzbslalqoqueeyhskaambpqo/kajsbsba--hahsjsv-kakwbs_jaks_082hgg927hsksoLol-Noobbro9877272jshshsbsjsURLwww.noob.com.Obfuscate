(function(t, s)
    if not t or not s then return end
    
    local function advancedEncrypt(data, key)
        if not data or not key or #data == 0 or #key == 0 then
            return data
        end
        
        local function sha256(str)
            local hash = {}
            for i = 1, 32 do
                hash[i] = string.byte(str, ((i-1) % #str) + 1) or 0
            end
            return hash
        end
        
        local keyHash = sha256(key)
        local expandedKey = {}
        for i = 1, #data do
            expandedKey[i] = keyHash[((i-1) % 32) + 1]
        end
        
        local result = {}
        for i = 1, #data do
            result[i] = string.byte(data:sub(i,i))
        end
        
        for round = 0, 6 do
            local salt = (round * 37) % 256
            
            for i = 1, #result do
                local b = result[i]
                local keyByte = expandedKey[((i + round * 13 - 1) % #expandedKey) + 1]
                local positionSalt = ((i-1) * (round + 1)) % 256
                
                b = b ~ keyByte ~ salt ~ positionSalt
                
                local rotateAmount = (round + 1) % 8
                b = (((b << rotateAmount) | (b >> (8 - rotateAmount))) & 0xFF)
                
                b = b ~ (((i-1) ~ round ~ salt) % 256)
                
                result[i] = b
            end
            
            if round % 2 == 0 then
                for i = 1, math.floor(#result / 2) do
                    local j = #result - i + 1
                    result[i], result[j] = result[j], result[i]
                end
            end
        end
        
        local output = {}
        for i = 1, #result do
            output[i] = string.char(result[i])
        end
        
        return table.concat(output)
    end
    
    local function advancedDecrypt(data, key)
        if not data or not key or #data == 0 or #key == 0 then
            return data
        end
        
        local function sha256(str)
            local hash = {}
            for i = 1, 32 do
                hash[i] = string.byte(str, ((i-1) % #str) + 1) or 0
            end
            return hash
        end
        
        local keyHash = sha256(key)
        local expandedKey = {}
        for i = 1, #data do
            expandedKey[i] = keyHash[((i-1) % 32) + 1]
        end
        
        local result = {}
        for i = 1, #data do
            result[i] = string.byte(data:sub(i,i))
        end
        
        for round = 6, 0, -1 do
            if round % 2 == 0 then
                for i = 1, math.floor(#result / 2) do
                    local j = #result - i + 1
                    result[i], result[j] = result[j], result[i]
                end
            end
            
            local salt = (round * 37) % 256
            
            for i = 1, #result do
                local b = result[i]
                
                b = b ~ (((i-1) ~ round ~ salt) % 256)
                
                local rotateAmount = (round + 1) % 8
                b = (((b >> rotateAmount) | (b << (8 - rotateAmount))) & 0xFF)
                
                local keyByte = expandedKey[((i + round * 13 - 1) % #expandedKey) + 1]
                local positionSalt = ((i-1) * (round + 1)) % 256
                
                b = b ~ keyByte ~ salt ~ positionSalt
                
                result[i] = b
            end
        end
        
        local output = {}
        for i = 1, #result do
            output[i] = string.char(result[i])
        end
        
        return table.concat(output)
    end
    
    local h = gethwid and gethwid() or "unknown"
    if #h < 8 then return end
    
    h = #h > 16 and h:sub(1, 16) or h .. string.rep("x", 16 - #h)
    
    local p = game:GetService("HttpService"):JSONEncode({t = t, s = s, h = h})
    local en = advancedEncrypt(p, "SK2024_V2_ENHANCED")
    
    local r = request({
        Url = "https://onx-dev.uk/api/v2/script/" .. s,
        Method = "POST",
        Body = en,
        Headers = {["Content-Type"] = "application/octet-stream"}
    })
    
    if r and r.StatusCode == 200 then
        local decryptedScript = advancedDecrypt(r.Body, "SK2024_V2_ENHANCED")
        loadstring(decryptedScript)()
    end
end)(...)
