(function(t, s)
    if not t or not s then return end
    
    local h = gethwid and gethwid() or "unknown"
    if #h < 8 then return end
    
    h = #h > 16 and h:sub(1,16) or h .. string.rep("x",16-#h)
    
    local p = game:GetService("HttpService"):JSONEncode({t = t, s = s, h = h})
    
    print("[DEBUG] Sending request to:", "https://onx-dev.uk/api/v2/script/" .. s)
    print("[DEBUG] Payload:", p)
    
    local r = request({
        Url = "https://onx-dev.uk/api/v2/script/" .. s,
        Method = "POST",
        Body = p,
        Headers = {["Content-Type"] = "application/json"}
    })
    
    print("[DEBUG] Response status:", r and r.StatusCode or "nil")
    print("[DEBUG] Response body:", r and r.Body or "nil")
    
    if r and r.StatusCode == 200 then
        local success, result = pcall(loadstring(r.Body))
        if not success then
            warn("[ONX] Error ejecutando script:", result)
        end
    else
        warn("[ONX] Request failed with status:", r and r.StatusCode or "nil")
    end
end)(...)
