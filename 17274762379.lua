local vim = game:GetService("VirtualInputManager")
local plr = game:GetService("Players").LocalPlayer
local mouse = plr:GetMouse()

workspace.ChildAdded:Connect(function(c)
    if c.Name == "fishing" then
        while c and c.Parent do
            vim:SendMouseButtonEvent(mouse.X, mouse.Y, 0, true, nil, 0)
            task.wait(0.05)
            vim:SendMouseButtonEvent(mouse.X, mouse.Y, 0, false, nil, 0)
            task.wait(0.55)
        end
    end
end)
