local p=game.Players.LocalPlayer
local RS=game:GetService("RunService")
local Rep=game:GetService("ReplicatedStorage")
local EV=Rep:WaitForChild("GameEvents"):WaitForChild("SummerHarvestRemoteEvent")
local eb=Instance.new("TextButton",sec1)
eb.Size=UDim2.new(0.48,0,0,20)
eb.Position=UDim2.new(0,5,0,80)
eb.BackgroundColor3=Color3.fromRGB(50,50,60)
eb.Text="🍓 Auto Event: OFF"
eb.TextColor3=Color3.fromRGB(255,255,255)
eb.TextSize=10
eb.Font=Enum.Font.GothamSemibold
Instance.new("UICorner",eb).CornerRadius=UDim.new(0,6)
local ebs=Instance.new("UIStroke",eb)
ebs.Color=Color3.fromRGB(80,80,90)
ebs.Thickness=1

local ae=false
local eventActive=false

local function checkEvent()
	for _,obj in pairs(p.PlayerGui:GetDescendants()) do
		if obj:IsA("TextLabel") and obj.Text:find("Summer Harvest Ends:") then return true end
	end
	return false
end

local function constantRemote()
	while ae do
		if eventActive then
			EV:FireServer("SubmitHeldPlant")
		end
		RS.Heartbeat:Wait()
	end
end

local function moveTools()
	for _,v in pairs(p.Backpack:GetChildren())do
		if v:IsA("Tool") and v.Name:find("%[.+kg%]") then
			v.Parent=p.Character
		end
	end
	p.Backpack.ChildAdded:Connect(function(tool)
		if ae and tool:IsA("Tool") and tool.Name:find("%[.+kg%]") then
			tool.Parent=p.Character
		end
	end)
end

task.spawn(function()
	while true do
		local active=checkEvent()
		if active ~= eventActive then eventActive=active end
		task.wait(3)
	end
end)

eb.MouseButton1Click:Connect(function()
	ae=not ae
	eb.Text="🍓 Auto Event: "..(ae and "ON" or "OFF")
	eb.BackgroundColor3=ae and Color3.fromRGB(0,120,50) or Color3.fromRGB(50,50,60)
	ebs.Color=ae and Color3.fromRGB(0,150,70) or Color3.fromRGB(80,80,90)
	if ae then
		task.spawn(constantRemote)
		moveTools()
	end
	saveConfig()
end)
