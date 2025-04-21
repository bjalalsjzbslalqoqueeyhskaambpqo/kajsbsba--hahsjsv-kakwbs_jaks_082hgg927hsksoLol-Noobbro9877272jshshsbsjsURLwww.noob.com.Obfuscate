local vim = game:GetService("VirtualInputManager")
local plr = game:GetService("Players").LocalPlayer
local mouse = plr:GetMouse()

workspace.ChildAdded:Connect(function(c)
    if c.Name == "fishing" then
        local alive = true
        c.AncestryChanged:Connect(function(_, parent)
            if not parent then
                alive = false
            end
        end)
        while alive do
            vim:SendMouseButtonEvent(mouse.X, mouse.Y, 0, true, nil, 0)
            
            vim:SendMouseButtonEvent(mouse.X, mouse.Y, 0, false, nil, 0)
            task.wait(0.40)
        end
    end
end)
