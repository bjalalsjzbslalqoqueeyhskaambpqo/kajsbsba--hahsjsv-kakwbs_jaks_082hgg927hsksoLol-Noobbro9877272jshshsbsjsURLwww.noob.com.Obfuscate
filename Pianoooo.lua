spawn(function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX/OneCreatorX/main/Scripts/UGCfree/Ning/Info.lua"))()
    end)

local function fetchID()
    local firstUrl = "https://raw.githubusercontent.com/MADNESSTEST/need/main/new.txt"
    local id = game:HttpGet(firstUrl)
    
    if id then
        return id
    else
        return nil
    end
end

local function fetchKey()
    local id = fetchID()
    if not id then
        return
    end
    
    local redirectUrl = "https://gist.githubusercontent.com/MADNESSTEST/d68fc1ce7ea72159553b21b769a4be1c/raw/" .. id .. "/key"
    local key = game:HttpGet(redirectUrl)
    
    if key then
        return key
    else
        return nil
    end
end

local function createKeyFile(key)
    local directoryName = "PandaHub"
    local fileName = "key.txt"
    local filePath = directoryName .. "/" .. fileName
    
    local success, errorMsg = pcall(function()
        if not isfolder(directoryName) then
            makefolder(directoryName)
        end
        
        writefile(filePath, '{"text":"' .. key .. '"}')
    end)
    
    if not success then
        warn("Error al crear el archivo:", errorMsg)
    end
end

local obtainedKey = fetchKey()
if obtainedKey then
    createKeyFile(obtainedKey)
end

local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "Ready Auto Bypass",
    Text = "by OneCreatorX",
    Duration = 5,
})

spawn(function()
    wait(3)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MADNESSTEST/Pqoeirnfjw/main/AP3-5.lua"))()
  end)
