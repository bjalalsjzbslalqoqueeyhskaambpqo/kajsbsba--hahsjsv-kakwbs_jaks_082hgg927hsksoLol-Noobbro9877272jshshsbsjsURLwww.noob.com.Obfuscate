local OneX = {}
OneX.__index = OneX

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local TextService = game:GetService("TextService")
local GuiService = game:GetService("GuiService")

local PLAYER = Players.LocalPlayer
local MOUSE = PLAYER:GetMouse()
local SCREEN_GUI_NAME = "OneXLibrary"
local DEFAULT_FONT = Enum.Font.GothamSemibold
local DEFAULT_TEXT_SIZE = 14
local DEFAULT_CORNER_RADIUS = UDim.new(0, 6)
local DEFAULT_PADDING = UDim.new(0, 8)
local DEFAULT_TWEEN_INFO = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

local COLORS = {
    BACKGROUND = Color3.fromRGB(30, 30, 35),
    BACKGROUND_DARK = Color3.fromRGB(25, 25, 30),
    BACKGROUND_LIGHT = Color3.fromRGB(40, 40, 45),
    ACCENT = Color3.fromRGB(0, 180, 130),
    ACCENT_DARK = Color3.fromRGB(0, 150, 100),
    ACCENT_LIGHT = Color3.fromRGB(40, 210, 150),
    TEXT_PRIMARY = Color3.fromRGB(255, 255, 255),
    TEXT_SECONDARY = Color3.fromRGB(180, 180, 180),
    SUCCESS = Color3.fromRGB(50, 200, 100),
    WARNING = Color3.fromRGB(255, 180, 30),
    ERROR = Color3.fromRGB(255, 60, 60),
    TRANSPARENT = Color3.fromRGB(255, 255, 255),
}

local function createInstance(className, properties)
    local instance = Instance.new(className)
    for property, value in pairs(properties or {}) do
        instance[property] = value
    end
    return instance
end

local function createCorner(parent, radius)
    local corner = createInstance("UICorner", {
        CornerRadius = radius or DEFAULT_CORNER_RADIUS,
        Parent = parent
    })
    return corner
end

local function createStroke(parent, color, thickness)
    local stroke = createInstance("UIStroke", {
        Color = color or COLORS.BACKGROUND_LIGHT,
        Thickness = thickness or 1,
        Parent = parent
    })
    return stroke
end

local function createPadding(parent, padding)
    local uiPadding = createInstance("UIPadding", {
        PaddingTop = padding or DEFAULT_PADDING,
        PaddingBottom = padding or DEFAULT_PADDING,
        PaddingLeft = padding or DEFAULT_PADDING,
        PaddingRight = padding or DEFAULT_PADDING,
        Parent = parent
    })
    return uiPadding
end

local function createGradient(parent, colorSequence, rotation)
    local gradient = createInstance("UIGradient", {
        Color = colorSequence or ColorSequence.new({
            ColorSequenceKeypoint.new(0, COLORS.ACCENT),
            ColorSequenceKeypoint.new(1, COLORS.ACCENT_DARK)
        }),
        Rotation = rotation or 90,
        Parent = parent
    })
    return gradient
end

local function tween(instance, properties, duration, easingStyle, easingDirection)
    local tweenInfo = TweenInfo.new(
        duration or DEFAULT_TWEEN_INFO.Time,
        easingStyle or DEFAULT_TWEEN_INFO.EasingStyle,
        easingDirection or DEFAULT_TWEEN_INFO.EasingDirection
    )
    local tween = TweenService:Create(instance, tweenInfo, properties)
    tween:Play()
    return tween
end

local function createImageOrEmoji(parent, imageIdOrEmoji, size, position, imageColor)
    local isEmoji = imageIdOrEmoji and #imageIdOrEmoji <= 8 and not imageIdOrEmoji:match("^rbxassetid://")
    
    if isEmoji then
        local textLabel = createInstance("TextLabel", {
            Name = "Emoji",
            Size = size or UDim2.fromOffset(20, 20),
            Position = position or UDim2.fromOffset(0, 0),
            BackgroundTransparency = 1,
            Text = imageIdOrEmoji,
            TextColor3 = imageColor or COLORS.TEXT_PRIMARY,
            TextSize = (size and size.X.Offset * 0.7) or 16,
            Font = Enum.Font.GothamBold,
            Parent = parent
        })
        return textLabel
    else
        local imageId = imageIdOrEmoji
        if imageIdOrEmoji and not imageIdOrEmoji:match("^rbxassetid://") then
            imageId = "rbxassetid://" .. imageIdOrEmoji
        end
        
        local imageLabel = createInstance("ImageLabel", {
            Name = "Icon",
            Size = size or UDim2.fromOffset(20, 20),
            Position = position or UDim2.fromOffset(0, 0),
            BackgroundTransparency = 1,
            Image = imageId,
            ImageColor3 = imageColor or COLORS.TEXT_PRIMARY,
            ScaleType = Enum.ScaleType.Fit,
            Parent = parent
        })
        return imageLabel
    end
end

function OneX.new(title, theme)
    local self = setmetatable({}, OneX)
    
    self.title = title or "OneX UI"
    self.theme = theme or "Dark"
    self.windows = {}
    self.currentWindow = nil
    self.minimized = false
    self.elements = {}
    self.connections = {}
    self.utilities = {
        antiAFK = false,
        autoReconnect = false,
        speedEnabled = false,
        speedMultiplier = 1,
        fullBrightness = false
    }
    
    self:createMainGUI()
    self:setupUtilities()
    
    return self
end

function OneX:createMainGUI()
    if CoreGui:FindFirstChild(SCREEN_GUI_NAME) then
        CoreGui:FindFirstChild(SCREEN_GUI_NAME):Destroy()
    end
    
    self.gui = createInstance("ScreenGui", {
        Name = SCREEN_GUI_NAME,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        ResetOnSpawn = false,
        DisplayOrder = 999,
        Parent = CoreGui
    })
    
    self.mainFrame = createInstance("Frame", {
        Name = "MainFrame",
        Size = UDim2.new(0, 550, 0, 350),
        Position = UDim2.new(0.5, -275, 0.5, -175),
        BackgroundColor3 = COLORS.BACKGROUND,
        BorderSizePixel = 0,
        Active = true,
        Draggable = true,
        Parent = self.gui
    })
    createCorner(self.mainFrame)
    createStroke(self.mainFrame, COLORS.ACCENT, 1)
    
    self.titleBar = createInstance("Frame", {
        Name = "TitleBar",
        Size = UDim2.new(1, 0, 0, 36),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = COLORS.BACKGROUND_DARK,
        BorderSizePixel = 0,
        Parent = self.mainFrame
    })
    createCorner(self.titleBar)
    
    local titleGradient = createGradient(self.titleBar, ColorSequence.new({
        ColorSequenceKeypoint.new(0, COLORS.BACKGROUND_DARK),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 40))
    }), 45)
    
    self.titleText = createInstance("TextLabel", {
        Name = "TitleText",
        Size = UDim2.new(1, -100, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = self.title,
        TextColor3 = COLORS.TEXT_PRIMARY,
        TextSize = 16,
        Font = DEFAULT_FONT,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = self.titleBar
    })
    
    self.minimizeButton = createInstance("TextButton", {
        Name = "MinimizeButton",
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -70, 0, 3),
        BackgroundColor3 = COLORS.BACKGROUND_LIGHT,
        Text = "-",
        TextColor3 = COLORS.TEXT_PRIMARY,
        TextSize = 20,
        Font = DEFAULT_FONT,
        Parent = self.titleBar
    })
    createCorner(self.minimizeButton, UDim.new(0, 4))
    
    self.closeButton = createInstance("TextButton", {
        Name = "CloseButton",
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -35, 0, 3),
        BackgroundColor3 = COLORS.ERROR,
        Text = "X",
        TextColor3 = COLORS.TEXT_PRIMARY,
        TextSize = 14,
        Font = DEFAULT_FONT,
        Parent = self.titleBar
    })
    createCorner(self.closeButton, UDim.new(0, 4))
    
    self.contentFrame = createInstance("Frame", {
        Name = "ContentFrame",
        Size = UDim2.new(1, 0, 1, -36),
        Position = UDim2.new(0, 0, 0, 36),
        BackgroundColor3 = COLORS.BACKGROUND,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = self.mainFrame
    })
    
    self.tabContainer = createInstance("Frame", {
        Name = "TabContainer",
        Size = UDim2.new(0, 130, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = COLORS.BACKGROUND_DARK,
        BorderSizePixel = 0,
        Parent = self.contentFrame
    })
    
    local tabContainerGradient = createGradient(self.tabContainer, ColorSequence.new({
        ColorSequenceKeypoint.new(0, COLORS.BACKGROUND_DARK),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 35))
    }), 90)
    
    self.tabScrollFrame = createInstance("ScrollingFrame", {
        Name = "TabScrollFrame",
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = COLORS.ACCENT,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        Parent = self.tabContainer
    })
    createPadding(self.tabScrollFrame, UDim.new(0, 5))
    
    self.tabListLayout = createInstance("UIListLayout", {
        Padding = UDim.new(0, 5),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = self.tabScrollFrame
    })
    
    self.windowContainer = createInstance("Frame", {
        Name = "WindowContainer",
        Size = UDim2.new(1, -130, 1, 0),
        Position = UDim2.new(0, 130, 0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Parent = self.contentFrame
    })
    
    self:setupEvents()
end

function OneX:setupEvents()
    self.minimizeButton.MouseButton1Click:Connect(function()
        self:toggleMinimize()
    end)
    
    self.closeButton.MouseButton1Click:Connect(function()
        self:destroy()
    end)
    
    self.tabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        self.tabScrollFrame.CanvasSize = UDim2.new(0, 0, 0, self.tabListLayout.AbsoluteContentSize.Y)
    end)
    
    self:handleResponsiveDesign()
end

function OneX:handleResponsiveDesign()
    local function updateSize()
        local screenSize = workspace.CurrentCamera.ViewportSize
        local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
        
        if isMobile then
            self.mainFrame.Size = UDim2.new(0.9, 0, 0.7, 0)
            self.mainFrame.Position = UDim2.new(0.5, -self.mainFrame.AbsoluteSize.X/2, 0.5, -self.mainFrame.AbsoluteSize.Y/2)
            self.tabContainer.Size = UDim2.new(0, 100, 1, 0)
            self.windowContainer.Size = UDim2.new(1, -100, 1, 0)
            self.windowContainer.Position = UDim2.new(0, 100, 0, 0)
        else
            self.mainFrame.Size = UDim2.new(0, 550, 0, 350)
            self.mainFrame.Position = UDim2.new(0.5, -275, 0.5, -175)
            self.tabContainer.Size = UDim2.new(0, 130, 1, 0)
            self.windowContainer.Size = UDim2.new(1, -130, 1, 0)
            self.windowContainer.Position = UDim2.new(0, 130, 0, 0)
        end
    end
    
    updateSize()
    
    self.connections.screenSizeChanged = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateSize)
end

function OneX:toggleMinimize()
    self.minimized = not self.minimized
    
    if self.minimized then
        tween(self.mainFrame, {Size = UDim2.new(0, 550, 0, 36)}, 0.5, Enum.EasingStyle.Quint)
        task.delay(0.2, function()
            self.contentFrame.Visible = false
        end)
    else
        self.contentFrame.Visible = true
        tween(self.mainFrame, {Size = UDim2.new(0, 550, 0, 350)}, 0.5, Enum.EasingStyle.Quint)
    end
end

function OneX:addTab(name, imageIdOrEmoji)
    local tabButton = createInstance("TextButton", {
        Name = name .. "Tab",
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundColor3 = COLORS.BACKGROUND_LIGHT,
        BackgroundTransparency = 0.8,
        BorderSizePixel = 0,
        Text = imageIdOrEmoji and "   " .. name or name,
        TextColor3 = COLORS.TEXT_SECONDARY,
        TextSize = DEFAULT_TEXT_SIZE,
        Font = DEFAULT_FONT,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = self.tabScrollFrame
    })
    createCorner(tabButton, UDim.new(0, 4))
    
    if imageIdOrEmoji then
        local icon = createImageOrEmoji(
            tabButton, 
            imageIdOrEmoji, 
            UDim2.fromOffset(18, 18), 
            UDim2.new(0, 8, 0.5, -9),
            COLORS.TEXT_SECONDARY
        )
    end
    
    local window = createInstance("ScrollingFrame", {
        Name = name .. "Window",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = COLORS.ACCENT,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        Visible = false,
        Parent = self.windowContainer
    })
    createPadding(window, UDim.new(0, 10))
    
    local listLayout = createInstance("UIListLayout", {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = window
    })
    
    listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        window.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 16)
    end)
    
    self.windows[name] = {
        button = tabButton,
        frame = window,
        elements = {}
    }
    
    tabButton.MouseButton1Click:Connect(function()
        self:selectTab(name)
    end)
    
    if not self.currentWindow then
        self:selectTab(name)
    end
    
    return self.windows[name]
end

function OneX:selectTab(name)
    if not self.windows[name] then return end
    
    for tabName, window in pairs(self.windows) do
        window.frame.Visible = false
        
        tween(window.button, {
            BackgroundColor3 = COLORS.BACKGROUND_LIGHT,
            BackgroundTransparency = 0.8,
            TextColor3 = COLORS.TEXT_SECONDARY
        })
        
        if window.button:FindFirstChild("Icon") then
            tween(window.button.Icon, {ImageColor3 = COLORS.TEXT_SECONDARY})
        elseif window.button:FindFirstChild("Emoji") then
            tween(window.button.Emoji, {TextColor3 = COLORS.TEXT_SECONDARY})
        end
    end
    
    self.windows[name].frame.Visible = true
    
    tween(self.windows[name].button, {
        BackgroundColor3 = COLORS.ACCENT,
        BackgroundTransparency = 0.7,
        TextColor3 = COLORS.TEXT_PRIMARY
    })
    
    if self.windows[name].button:FindFirstChild("Icon") then
        tween(self.windows[name].button.Icon, {ImageColor3 = COLORS.TEXT_PRIMARY})
    elseif self.windows[name].button:FindFirstChild("Emoji") then
        tween(self.windows[name].button.Emoji, {TextColor3 = COLORS.TEXT_PRIMARY})
    end
    
    self.currentWindow = name
end

function OneX:addOneLabel(tabName, text, textColor)
    if not self.windows[tabName] then return end
    
    local label = createInstance("TextLabel", {
        Name = "OneLabel",
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = textColor or COLORS.TEXT_PRIMARY,
        TextSize = DEFAULT_TEXT_SIZE,
        Font = DEFAULT_FONT,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = self.windows[tabName].frame
    })
    
    table.insert(self.windows[tabName].elements, label)
    return label
end

function OneX:addOneButton(tabName, text, callback, buttonColor, imageIdOrEmoji)
    if not self.windows[tabName] then return end
    
    local buttonContainer = createInstance("Frame", {
        Name = "OneButtonContainer",
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundTransparency = 1,
        Parent = self.windows[tabName].frame
    })
    
    local button = createInstance("TextButton", {
        Name = "Button",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = buttonColor or COLORS.BACKGROUND_LIGHT,
        Text = imageIdOrEmoji and "   " .. text or text,
        TextColor3 = COLORS.TEXT_PRIMARY,
        TextSize = DEFAULT_TEXT_SIZE,
        Font = DEFAULT_FONT,
        TextXAlignment = imageIdOrEmoji and Enum.TextXAlignment.Left or Enum.TextXAlignment.Center,
        Parent = buttonContainer
    })
    createCorner(button)
    
    if imageIdOrEmoji then
        local icon = createImageOrEmoji(
            button, 
            imageIdOrEmoji, 
            UDim2.fromOffset(20, 20), 
            UDim2.new(0, 10, 0.5, -10)
        )
    end
    
    local buttonGradient = createGradient(button, ColorSequence.new({
        ColorSequenceKeypoint.new(0, (buttonColor or COLORS.BACKGROUND_LIGHT)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(
            math.clamp((buttonColor or COLORS.BACKGROUND_LIGHT).R * 255 + 15, 0, 255) / 255,
            math.clamp((buttonColor or COLORS.BACKGROUND_LIGHT).G * 255 + 15, 0, 255) / 255,
            math.clamp((buttonColor or COLORS.BACKGROUND_LIGHT).B * 255 + 15, 0, 255) / 255
        ))
    }), 90)
    
    button.MouseEnter:Connect(function()
        tween(button, {BackgroundColor3 = buttonColor == COLORS.ACCENT and COLORS.ACCENT_LIGHT or COLORS.ACCENT})
    end)
    
    button.MouseLeave:Connect(function()
        tween(button, {BackgroundColor3 = buttonColor or COLORS.BACKGROUND_LIGHT})
    end)
    
    button.MouseButton1Down:Connect(function()
        tween(button, {BackgroundColor3 = buttonColor == COLORS.ACCENT and COLORS.ACCENT_DARK or COLORS.ACCENT_DARK})
    end)
    
    button.MouseButton1Up:Connect(function()
        tween(button, {BackgroundColor3 = buttonColor == COLORS.ACCENT and COLORS.ACCENT_LIGHT or COLORS.ACCENT})
    end)
    
    button.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    
    table.insert(self.windows[tabName].elements, buttonContainer)
    return button
end

function OneX:addOneToggle(tabName, text, default, callback, imageIdOrEmoji)
    if not self.windows[tabName] then return end
    
    local toggleContainer = createInstance("Frame", {
        Name = "OneToggleContainer",
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundTransparency = 1,
        Parent = self.windows[tabName].frame
    })
    
    local label = createInstance("TextLabel", {
        Name = "Label",
        Size = UDim2.new(1, -56, 1, 0),
        Position = UDim2.new(0, imageIdOrEmoji and 30 or 0, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = COLORS.TEXT_PRIMARY,
        TextSize = DEFAULT_TEXT_SIZE,
        Font = DEFAULT_FONT,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = toggleContainer
    })
    
    if imageIdOrEmoji then
        local icon = createImageOrEmoji(
            toggleContainer, 
            imageIdOrEmoji, 
            UDim2.fromOffset(20, 20), 
            UDim2.new(0, 0, 0.5, -10)
        )
    end
    
    local toggleBackground = createInstance("Frame", {
        Name = "Background",
        Size = UDim2.new(0, 44, 0, 22),
        Position = UDim2.new(1, -44, 0.5, -11),
        BackgroundColor3 = COLORS.BACKGROUND_LIGHT,
        Parent = toggleContainer
    })
    createCorner(toggleBackground, UDim.new(1, 0))
    
    local toggleButton = createInstance("Frame", {
        Name = "Button",
        Size = UDim2.new(0, 18, 0, 18),
        Position = UDim2.new(0, 2, 0.5, -9),
        BackgroundColor3 = COLORS.TEXT_SECONDARY,
        Parent = toggleBackground
    })
    createCorner(toggleButton, UDim.new(1, 0))
    
    local enabled = default or false
    
    local function updateToggle()
        if enabled then
            tween(toggleBackground, {BackgroundColor3 = COLORS.ACCENT})
            tween(toggleButton, {Position = UDim2.new(0, 24, 0.5, -9), BackgroundColor3 = COLORS.TEXT_PRIMARY})
        else
            tween(toggleBackground, {BackgroundColor3 = COLORS.BACKGROUND_LIGHT})
            tween(toggleButton, {Position = UDim2.new(0, 2, 0.5, -9), BackgroundColor3 = COLORS.TEXT_SECONDARY})
        end
        
        if callback then callback(enabled) end
    end
    
    updateToggle()
    
    toggleBackground.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            enabled = not enabled
            updateToggle()
        end
    end)
    
    toggleButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            enabled = not enabled
            updateToggle()
        end
    end)
    
    table.insert(self.windows[tabName].elements, toggleContainer)
    
    return {
        getValue = function() return enabled end,
        setValue = function(value) 
            enabled = value
            updateToggle()
        end
    }
end

function OneX:addOneSlider(tabName, text, min, max, default, callback, imageIdOrEmoji)
    if not self.windows[tabName] then return end
    
    min = min or 0
    max = max or 100
    default = default or min
    
    local sliderContainer = createInstance("Frame", {
        Name = "OneSliderContainer",
        Size = UDim2.new(1, 0, 0, 50),
        BackgroundTransparency = 1,
        Parent = self.windows[tabName].frame
    })
    
    local labelContainer = createInstance("Frame", {
        Name = "LabelContainer",
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        Parent = sliderContainer
    })
    
    if imageIdOrEmoji then
        local icon = createImageOrEmoji(
            labelContainer, 
            imageIdOrEmoji, 
            UDim2.fromOffset(16, 16), 
            UDim2.new(0, 0, 0.5, -8)
        )
    end
    
    local label = createInstance("TextLabel", {
        Name = "Label",
        Size = UDim2.new(1, -60, 1, 0),
        Position = UDim2.new(0, imageIdOrEmoji and 24 or 0, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = COLORS.TEXT_PRIMARY,
        TextSize = DEFAULT_TEXT_SIZE,
        Font = DEFAULT_FONT,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = labelContainer
    })
    
    local valueLabel = createInstance("TextLabel", {
        Name = "Value",
        Size = UDim2.new(0, 50, 0, 20),
        Position = UDim2.new(1, -50, 0, 0),
        BackgroundTransparency = 1,
        Text = tostring(default),
        TextColor3 = COLORS.ACCENT,
        TextSize = DEFAULT_TEXT_SIZE,
        Font = DEFAULT_FONT,
        TextXAlignment = Enum.TextXAlignment.Right,
        Parent = labelContainer
    })
    
    local sliderBackground = createInstance("Frame", {
        Name = "Background",
        Size = UDim2.new(1, 0, 0, 8),
        Position = UDim2.new(0, 0, 0, 30),
        BackgroundColor3 = COLORS.BACKGROUND_LIGHT,
        Parent = sliderContainer
    })
    createCorner(sliderBackground, UDim.new(1, 0))
    
    local sliderFill = createInstance("Frame", {
        Name = "Fill",
        Size = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = COLORS.ACCENT,
        Parent = sliderBackground
    })
    createCorner(sliderFill, UDim.new(1, 0))
    
    local sliderButton = createInstance("TextButton", {
        Name = "Button",
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(0, 0, 0.5, -8),
        BackgroundColor3 = COLORS.TEXT_PRIMARY,
        Text = "",
        Parent = sliderBackground
    })
    createCorner(sliderButton, UDim.new(1, 0))
    
    local value = default
    local dragging = false
    
    local function updateSlider(newValue)
        value = math.clamp(newValue, min, max)
        
        local percent = (value - min) / (max - min)
        local buttonPosition = math.clamp(percent * sliderBackground.AbsoluteSize.X, 0, sliderBackground.AbsoluteSize.X)
        
        sliderFill.Size = UDim2.new(0, buttonPosition, 1, 0)
        sliderButton.Position = UDim2.new(0, buttonPosition - 8, 0.5, -8)
        valueLabel.Text = tostring(math.floor(value * 100) /  buttonPosition - 8, 0.5, -8)
        valueLabel.Text = tostring(math.floor(value * 100) / 100)
        
        if callback then callback(value) end
    end
    
    updateSlider(default)
    
    sliderBackground.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            
            local percent = math.clamp((input.Position.X - sliderBackground.AbsolutePosition.X) / sliderBackground.AbsoluteSize.X, 0, 1)
            local newValue = min + (max - min) * percent
            
            updateSlider(newValue)
        end
    end)
    
    sliderBackground.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    sliderButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)
    
    sliderButton.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local percent = math.clamp((input.Position.X - sliderBackground.AbsolutePosition.X) / sliderBackground.AbsoluteSize.X, 0, 1)
            local newValue = min + (max - min) * percent
            
            updateSlider(newValue)
        end
    end)
    
    table.insert(self.windows[tabName].elements, sliderContainer)
    
    return {
        getValue = function() return value end,
        setValue = function(newValue) updateSlider(newValue) end
    }
end

function OneX:addOneTextbox(tabName, placeholder, callback, imageIdOrEmoji)
    if not self.windows[tabName] then return end
    
    local textboxContainer = createInstance("Frame", {
        Name = "OneTextboxContainer",
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundTransparency = 1,
        Parent = self.windows[tabName].frame
    })
    
    local textbox = createInstance("TextBox", {
        Name = "Textbox",
        Size = UDim2.new(1, imageIdOrEmoji and -30 or 0, 1, 0),
        Position = UDim2.new(0, imageIdOrEmoji and 30 or 0, 0, 0),
        BackgroundColor3 = COLORS.BACKGROUND_LIGHT,
        PlaceholderText = placeholder or "Enter text...",
        PlaceholderColor3 = COLORS.TEXT_SECONDARY,
        Text = "",
        TextColor3 = COLORS.TEXT_PRIMARY,
        TextSize = DEFAULT_TEXT_SIZE,
        Font = DEFAULT_FONT,
        ClearTextOnFocus = false,
        Parent = textboxContainer
    })
    createCorner(textbox)
    createPadding(textbox, UDim.new(0, 8))
    
    if imageIdOrEmoji then
        local icon = createImageOrEmoji(
            textboxContainer, 
            imageIdOrEmoji, 
            UDim2.fromOffset(20, 20), 
            UDim2.new(0, 0, 0.5, -10)
        )
    end
    
    textbox.FocusLost:Connect(function(enterPressed)
        if callback then callback(textbox.Text, enterPressed) end
    end)
    
    table.insert(self.windows[tabName].elements, textboxContainer)
    
    return {
        getValue = function() return textbox.Text end,
        setValue = function(text) textbox.Text = text end
    }
end

function OneX:addOneDropdown(tabName, text, options, callback, imageIdOrEmoji)
    if not self.windows[tabName] then return end
    
    options = options or {}
    local selected = options[1] or ""
    
    local dropdownContainer = createInstance("Frame", {
        Name = "OneDropdownContainer",
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundTransparency = 1,
        Parent = self.windows[tabName].frame
    })
    
    local label = createInstance("TextLabel", {
        Name = "Label",
        Size = UDim2.new(0.5, -5, 1, 0),
        Position = UDim2.new(0, imageIdOrEmoji and 30 or 0, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = COLORS.TEXT_PRIMARY,
        TextSize = DEFAULT_TEXT_SIZE,
        Font = DEFAULT_FONT,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = dropdownContainer
    })
    
    if imageIdOrEmoji then
        local icon = createImageOrEmoji(
            dropdownContainer, 
            imageIdOrEmoji, 
            UDim2.fromOffset(20, 20), 
            UDim2.new(0, 0, 0.5, -10)
        )
    end
    
    local dropdown = createInstance("TextButton", {
        Name = "Dropdown",
        Size = UDim2.new(0.5, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0, 0),
        BackgroundColor3 = COLORS.BACKGROUND_LIGHT,
        Text = selected,
        TextColor3 = COLORS.TEXT_PRIMARY,
        TextSize = DEFAULT_TEXT_SIZE,
        Font = DEFAULT_FONT,
        Parent = dropdownContainer
    })
    createCorner(dropdown)
    
    local arrow = createInstance("TextLabel", {
        Name = "Arrow",
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(1, -25, 0.5, -10),
        BackgroundTransparency = 1,
        Text = "▼",
        TextColor3 = COLORS.TEXT_SECONDARY,
        TextSize = 14,
        Font = DEFAULT_FONT,
        Parent = dropdown
    })
    
    local optionsFrame = createInstance("Frame", {
        Name = "Options",
        Size = UDim2.new(1, 0, 0, #options * 30),
        Position = UDim2.new(0, 0, 1, 5),
        BackgroundColor3 = COLORS.BACKGROUND_LIGHT,
        Visible = false,
        ZIndex = 10,
        Parent = dropdown
    })
    createCorner(optionsFrame)
    
    local optionsLayout = createInstance("UIListLayout", {
        Padding = UDim.new(0, 0),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = optionsFrame
    })
    
    for i, option in ipairs(options) do
        local optionButton = createInstance("TextButton", {
            Name = "Option_" .. i,
            Size = UDim2.new(1, 0, 0, 30),
            BackgroundTransparency = 1,
            Text = option,
            TextColor3 = COLORS.TEXT_PRIMARY,
            TextSize = DEFAULT_TEXT_SIZE,
            Font = DEFAULT_FONT,
            ZIndex = 10,
            Parent = optionsFrame
        })
        
        optionButton.MouseEnter:Connect(function()
            tween(optionButton, {BackgroundColor3 = COLORS.ACCENT, BackgroundTransparency = 0.7})
        end)
        
        optionButton.MouseLeave:Connect(function()
            tween(optionButton, {BackgroundTransparency = 1})
        end)
        
        optionButton.MouseButton1Click:Connect(function()
            selected = option
            dropdown.Text = selected
            optionsFrame.Visible = false
            arrow.Text = "▼"
            if callback then callback(selected) end
        end)
    end
    
    dropdown.MouseButton1Click:Connect(function()
        optionsFrame.Visible = not optionsFrame.Visible
        arrow.Text = optionsFrame.Visible and "▲" or "▼"
    end)
    
    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local position = input.Position
            local dropdownPosition = dropdown.AbsolutePosition
            local dropdownSize = dropdown.AbsoluteSize
            local optionsPosition = optionsFrame.AbsolutePosition
            local optionsSize = optionsFrame.AbsoluteSize
            
            if optionsFrame.Visible then
                local inDropdown = position.X >= dropdownPosition.X and position.X <= dropdownPosition.X + dropdownSize.X and
                                  position.Y >= dropdownPosition.Y and position.Y <= dropdownPosition.Y + dropdownSize.Y
                
                local inOptions = position.X >= optionsPosition.X and position.X <= optionsPosition.X + optionsSize.X and
                                 position.Y >= optionsPosition.Y and position.Y <= optionsPosition.Y + optionsSize.Y
                
                if not inDropdown and not inOptions then
                    optionsFrame.Visible = false
                    arrow.Text = "▼"
                end
            end
        end
    end)
    
    table.insert(self.windows[tabName].elements, dropdownContainer)
    
    return {
        getValue = function() return selected end,
        setValue = function(option)
            if table.find(options, option) then
                selected = option
                dropdown.Text = selected
                if callback then callback(selected) end
            end
        end
    }
end

function OneX:addOneSeparator(tabName, text)
    if not self.windows[tabName] then return end
    
    local separatorContainer = createInstance("Frame", {
        Name = "OneSeparatorContainer",
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        Parent = self.windows[tabName].frame
    })
    
    local line1 = createInstance("Frame", {
        Name = "Line1",
        Size = UDim2.new(0.5, -10, 0, 1),
        Position = UDim2.new(0, 0, 0.5, 0),
        BackgroundColor3 = COLORS.ACCENT,
        BackgroundTransparency = 0.7,
        BorderSizePixel = 0,
        Parent = separatorContainer
    })
    
    local line2 = createInstance("Frame", {
        Name = "Line2",
        Size = UDim2.new(0.5, -10, 0, 1),
        Position = UDim2.new(0.5, 10, 0.5, 0),
        BackgroundColor3 = COLORS.ACCENT,
        BackgroundTransparency = 0.7,
        BorderSizePixel = 0,
        Parent = separatorContainer
    })
    
    if text then
        local label = createInstance("TextLabel", {
            Name = "Label",
            Size = UDim2.new(0, 0, 1, 0),
            Position = UDim2.new(0.5, 0, 0, 0),
            BackgroundTransparency = 1,
            Text = text,
            TextColor3 = COLORS.ACCENT,
            TextSize = 12,
            Font = DEFAULT_FONT,
            AutomaticSize = Enum.AutomaticSize.X,
            Parent = separatorContainer
        })
    end
    
    table.insert(self.windows[tabName].elements, separatorContainer)
    return separatorContainer
end

function OneX:addOneSection(tabName, text, imageIdOrEmoji)
    if not self.windows[tabName] then return end
    
    local sectionContainer = createInstance("Frame", {
        Name = "OneSectionContainer",
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundTransparency = 1,
        Parent = self.windows[tabName].frame
    })
    
    if imageIdOrEmoji then
        local icon = createImageOrEmoji(
            sectionContainer, 
            imageIdOrEmoji, 
            UDim2.fromOffset(20, 20), 
            UDim2.new(0, 0, 0.5, -10),
            COLORS.ACCENT
        )
    end
    
    local label = createInstance("TextLabel", {
        Name = "Label",
        Size = UDim2.new(1, imageIdOrEmoji and -25 or 0, 1, 0),
        Position = UDim2.new(0, imageIdOrEmoji and 25 or 0, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = COLORS.ACCENT,
        TextSize = 16,
        Font = DEFAULT_FONT,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = sectionContainer
    })
    
    local line = createInstance("Frame", {
        Name = "Line",
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 1, -1),
        BackgroundColor3 = COLORS.ACCENT,
        BackgroundTransparency = 0.7,
        BorderSizePixel = 0,
        Parent = sectionContainer
    })
    
    table.insert(self.windows[tabName].elements, sectionContainer)
    return sectionContainer
end

function OneX:addOneInfo(tabName, text, color, imageIdOrEmoji)
    if not self.windows[tabName] then return end
    
    local infoContainer = createInstance("Frame", {
        Name = "OneInfoContainer",
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = COLORS.BACKGROUND_LIGHT,
        Parent = self.windows[tabName].frame
    })
    createCorner(infoContainer)
    
    if imageIdOrEmoji then
        local icon = createImageOrEmoji(
            infoContainer, 
            imageIdOrEmoji, 
            UDim2.fromOffset(20, 20), 
            UDim2.new(0, 10, 0, 10),
            color or COLORS.TEXT_SECONDARY
        )
    end
    
    local infoText = createInstance("TextLabel", {
        Name = "InfoText",
        Size = UDim2.new(1, imageIdOrEmoji and -40 or 0, 0, 0),
        Position = UDim2.new(0, imageIdOrEmoji and 40 or 0, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = color or COLORS.TEXT_SECONDARY,
        TextSize = 14,
        Font = DEFAULT_FONT,
        TextWrapped = true,
        AutomaticSize = Enum.AutomaticSize.Y,
        Parent = infoContainer
    })
    createPadding(infoText, UDim.new(0, 10))
    
    table.insert(self.windows[tabName].elements, infoContainer)
    return infoContainer
end

function OneX:addOneSocialLink(tabName, platform, url, imageIdOrEmoji)
    if not self.windows[tabName] then return end
    
    local linkContainer = createInstance("Frame", {
        Name = "OneSocialLinkContainer",
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundTransparency = 1,
        Parent = self.windows[tabName].frame
    })
    
    local linkButton = createInstance("TextButton", {
        Name = "LinkButton",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = COLORS.BACKGROUND_LIGHT,
        Text = imageIdOrEmoji and "   " .. platform or platform,
        TextColor3 = COLORS.TEXT_PRIMARY,
        TextSize = DEFAULT_TEXT_SIZE,
        Font = DEFAULT_FONT,
        TextXAlignment = imageIdOrEmoji and Enum.TextXAlignment.Left or Enum.TextXAlignment.Center,
        Parent = linkContainer
    })
    createCorner(linkButton)
    
    if imageIdOrEmoji then
        local icon = createImageOrEmoji(
            linkButton, 
            imageIdOrEmoji, 
            UDim2.fromOffset(20, 20), 
            UDim2.new(0, 10, 0.5, -10)
        )
    end
    
    linkButton.MouseButton1Click:Connect(function()
        pcall(function()
            setclipboard(url)
        end)
        
        self:notify("Link Copied", "The " .. platform .. " link has been copied to your clipboard.", 3)
    end)
    
    table.insert(self.windows[tabName].elements, linkContainer)
    return linkButton
end

function OneX:addOneColorPicker(tabName, text, defaultColor, callback, imageIdOrEmoji)
    if not self.windows[tabName] then return end
    
    defaultColor = defaultColor or Color3.fromRGB(255, 255, 255)
    
    local colorPickerContainer = createInstance("Frame", {
        Name = "OneColorPickerContainer",
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundTransparency = 1,
        Parent = self.windows[tabName].frame
    })
    
    local label = createInstance("TextLabel", {
        Name = "Label",
        Size = UDim2.new(1, -56, 1, 0),
        Position = UDim2.new(0, imageIdOrEmoji and 30 or 0, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = COLORS.TEXT_PRIMARY,
        TextSize = DEFAULT_TEXT_SIZE,
        Font = DEFAULT_FONT,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = colorPickerContainer
    })
    
    if imageIdOrEmoji then
        local icon = createImageOrEmoji(
            colorPickerContainer, 
            imageIdOrEmoji, 
            UDim2.fromOffset(20, 20), 
            UDim2.new(0, 0, 0.5, -10)
        )
    end
    
    local colorDisplay = createInstance("Frame", {
        Name = "ColorDisplay",
        Size = UDim2.new(0, 36, 0, 26),
        Position = UDim2.new(1, -36, 0.5, -13),
        BackgroundColor3 = defaultColor,
        Parent = colorPickerContainer
    })
    createCorner(colorDisplay, UDim.new(0, 4))
    
    local colorPicker = createInstance("Frame", {
        Name = "ColorPicker",
        Size = UDim2.new(0, 200, 0, 200),
        Position = UDim2.new(1, -200, 1, 10),
        BackgroundColor3 = COLORS.BACKGROUND_DARK,
        Visible = false,
        ZIndex = 100,
        Parent = colorPickerContainer
    })
    createCorner(colorPicker)
    createStroke(colorPicker, COLORS.ACCENT, 1)
    
    local hueFrame = createInstance("Frame", {
        Name = "HueFrame",
        Size = UDim2.new(0, 20, 1, -20),
        Position = UDim2.new(1, -30, 0, 10),
        BackgroundColor3 = Color3.fromRGB(255, 0, 0),
        ZIndex = 101,
        Parent = colorPicker
    })
    createCorner(hueFrame)
    
    local hueGradient = createInstance("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(0.167, Color3.fromRGB(255, 255, 0)),
            ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0, 255, 0)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
            ColorSequenceKeypoint.new(0.667, Color3.fromRGB(0, 0, 255)),
            ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 0, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
        }),
        Rotation = 90,
        Parent = hueFrame
    })
    
    local hueSelector = createInstance("Frame", {
        Name = "HueSelector",
        Size = UDim2.new(1, 4, 0, 3),
        Position = UDim2.new(0, -2, 0, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        ZIndex = 102,
        Parent = hueFrame
    })
    createCorner(hueSelector, UDim.new(0, 2))
    
    local satValFrame = createInstance("Frame", {
        Name = "SatValFrame",
        Size = UDim2.new(1, -60, 1, -20),
        Position = UDim2.new(0, 10, 0, 10),
        BackgroundColor3 = Color3.fromRGB(255, 0, 0),
        ZIndex = 101,
        Parent = colorPicker
    })
    createCorner(satValFrame)
    
    local satGradient = createInstance("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
        }),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(1, 0)
        }),
        Rotation = 0,
        Parent = satValFrame
    })
    
    local valGradient = createInstance("Frame", {
        Name = "ValGradient",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0,
        ZIndex = 102,
        Parent = satValFrame
    })
    createCorner(valGradient)
    
    local valGradientTransparency = createInstance("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
        }),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(1, 0)
        }),
        Rotation = 90,
        Parent = valGradient
    })
    
    local satValSelector = createInstance("Frame", {
        Name = "SatValSelector",
        Size = UDim2.new(0, 6, 0, 6),
        Position = UDim2.new(1, 0, 0, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        ZIndex = 103,
        Parent = satValFrame
    })
    createCorner(satValSelector, UDim.new(1, 0))
    createStroke(satValSelector, Color3.fromRGB(0, 0, 0), 1)
    
    local rgbDisplay = createInstance("TextLabel", {
        Name = "RGBDisplay",
        Size = UDim2.new(1, 0, 0, 20),
        Position = UDim2.new(0, 0, 1, -20),
        BackgroundTransparency = 1,
        Text = string.format("RGB: %d, %d, %d", 
            math.floor(defaultColor.R * 255), 
            math.floor(defaultColor.G * 255), 
            math.floor(defaultColor.B * 255)),
        TextColor3 = COLORS.TEXT_PRIMARY,
        TextSize = 12,
        Font = DEFAULT_FONT,
        ZIndex = 101,
        Parent = colorPicker
    })
    
    local currentColor = defaultColor
    local hue, sat, val = 0, 0, 1
    
    local function updateColor()
        local color = Color3.fromHSV(hue, sat, val)
        currentColor = color
        colorDisplay.BackgroundColor3 = color
        satValFrame.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
        rgbDisplay.Text = string.format("RGB: %d, %d, %d", 
            math.floor(color.R * 255), 
            math.floor(color.G * 255), 
            math.floor(color.B * 255))
        
        if callback then callback(color) end
    end
    
    local function updateHue(inputPosition)
        local offset = math.clamp((inputPosition.Y - hueFrame.AbsolutePosition.Y) / hueFrame.AbsoluteSize.Y, 0, 1)
        hue = 1 - offset
        hueSelector.Position = UDim2.new(0, -2, offset, -1.5)
        updateColor()
    end
    
    local function updateSatVal(inputPosition)
        local xOffset = math.clamp((inputPosition.X - satValFrame.AbsolutePosition.X) / satValFrame.AbsoluteSize.X, 0, 1)
        local yOffset = math.clamp((inputPosition.Y - satValFrame.AbsolutePosition.Y) / satValFrame.AbsoluteSize.Y, 0, 1)
        
        sat = xOffset
        val = 1 - yOffset
        
        satValSelector.Position = UDim2.new(xOffset, 0, yOffset, 0)
        updateColor()
    end
    
    local function initializeFromColor(color)
        local h, s, v = Color3.toHSV(color)
        hue, sat, val = h, s, v
        
        hueSelector.Position = UDim2.new(0, -2, 1 - h, -1.5)
        satValSelector.Position = UDim2.new(s, 0, 1 - v, 0)
        satValFrame.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
        
        updateColor()
    end
    
    initializeFromColor(defaultColor)
    
    colorDisplay.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            colorPicker.Visible = not colorPicker.Visible
        end
    end)
    
    hueFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            updateHue(input.Position)
        end
    end)
    
    hueFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if input.UserInputState == Enum.UserInputState.Begin or input.UserInputState == Enum.UserInputState.Change then
                updateHue(input.Position)
            end
        end
    end)
    
    satValFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            updateSatVal(input.Position)
        end
    end)
    
    satValFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if input.UserInputState == Enum.UserInputState.Begin or input.UserInputState == Enum.UserInputState.Change then
                updateSatVal(input.Position)
            end
        end
    end)
    
    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if colorPicker.Visible then
                local position = input.Position
                local pickerPosition = colorPicker.AbsolutePosition
                local pickerSize = colorPicker.AbsoluteSize
                
                local inPicker = position.X >= pickerPosition.X and position.X <= pickerPosition.X + pickerSize.X and
                               position.Y >= pickerPosition.Y and position.Y <= pickerPosition.Y + pickerSize.Y
                
                local inDisplay = position.X >= colorDisplay.AbsolutePosition.X and position.X <= colorDisplay.AbsolutePosition.X + colorDisplay.AbsoluteSize.X and
                                position.Y >= colorDisplay.AbsolutePosition.Y and position.Y <= colorDisplay.AbsolutePosition.Y + colorDisplay.AbsoluteSize.Y
                
                if not inPicker and not inDisplay then
                    colorPicker.Visible = false
                end
            end
        end
    end)
    
    table.insert(self.windows[tabName].elements, colorPickerContainer)
    
    return {
        getValue = function() return currentColor end,
        setValue = function(color) 
            initializeFromColor(color)
        end
    }
end

function OneX:addOneKeybind(tabName, text, defaultKey, callback, imageIdOrEmoji)
    if not self.windows[tabName] then return end
    
    local keybindContainer = createInstance("Frame", {
        Name = "OneKeybindContainer",
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundTransparency = 1,
        Parent = self.windows[tabName].frame
    })
    
    local label = createInstance("TextLabel", {
        Name = "Label",
        Size = UDim2.new(1, -80, 1, 0),
        Position = UDim2.new(0, imageIdOrEmoji and 30 or 0, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = COLORS.TEXT_PRIMARY,
        TextSize = DEFAULT_TEXT_SIZE,
        Font = DEFAULT_FONT,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = keybindContainer
    })
    
    if imageIdOrEmoji then
        local icon = createImageOrEmoji(
            keybindContainer, 
            imageIdOrEmoji, 
            UDim2.fromOffset(20, 20), 
            UDim2.new(0, 0, 0.5, -10)
        )
    end
    
    local keybindButton = createInstance("TextButton", {
        Name = "KeybindButton",
        Size = UDim2.new(0, 70, 0, 30),
        Position = UDim2.new(1, -70, 0.5, -15),
        BackgroundColor3 = COLORS.BACKGROUND_LIGHT,
        Text = defaultKey and defaultKey.Name or "None",
        TextColor3 = COLORS.TEXT_PRIMARY,
        TextSize = DEFAULT_TEXT_SIZE,
        Font = DEFAULT_FONT,
        Parent = keybindContainer
    })
    createCorner(keybindButton, UDim.new(0, 4))
    
    local currentKey = defaultKey
    local listening = false
    
    keybindButton.MouseButton1Click:Connect(function()
        if listening then return end
        
        listening = true
        keybindButton.Text = "..."
        
        local connection
        connection = UserInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                currentKey = input.KeyCode
                keybindButton.Text = currentKey.Name
                listening = false
                connection:Disconnect()
                
                if callback then callback(currentKey) end
            end
        end)
    end)
    
    if defaultKey then
        UserInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == currentKey and not listening then
                if callback then callback(currentKey) end
            end
        end)
    end
    
    table.insert(self.windows[tabName].elements, keybindContainer)
    
    return {
        getKey = function() return currentKey end,
        setKey = function(key) 
            currentKey = key
            keybindButton.Text = key and key.Name or "None"
        end
    }
end

function OneX:notify(title, message, duration)
    duration = duration or 3
    
    local notificationContainer = createInstance("Frame", {
        Name = "Notification",
        Size = UDim2.new(0, 250, 0, 80),
        Position = UDim2.new(1, -260, 1, -90),
        BackgroundColor3 = COLORS.BACKGROUND_DARK,
        BorderSizePixel = 0,
        Parent = self.gui
    })
    createCorner(notificationContainer)
    createStroke(notificationContainer, COLORS.ACCENT, 1)
    
    local notificationGradient = createGradient(notificationContainer, ColorSequence.new({
        ColorSequenceKeypoint.new(0, COLORS.BACKGROUND_DARK),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 40))
    }), 45)
    
    local notificationTitle = createInstance("TextLabel", {
        Name = "Title",
        Size = UDim2.new(1, 0, 0, 30),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = COLORS.ACCENT,
        TextSize = 16,
        Font = DEFAULT_FONT,
        Parent = notificationContainer
    })
    createPadding(notificationTitle, UDim.new(0, 10))
    
    local notificationMessage = createInstance("TextLabel", {
        Name = "Message",
        Size = UDim2.new(1, 0, 1, -30),
        Position = UDim2.new(0, 0, 0, 30),
        BackgroundTransparency = 1,
        Text = message,
        TextColor3 = COLORS.TEXT_PRIMARY,
        TextSize = 14,
        TextWrapped = true,
        Font = DEFAULT_FONT,
        Parent = notificationContainer
    })
    createPadding(notificationMessage, UDim.new(0, 10))
    
    tween(notificationContainer, {Position = UDim2.new(1, -260, 1, -90)}, 0.3, Enum.EasingStyle.Quint)
    
    task.delay(duration, function()
        tween(notificationContainer, {Position = UDim2.new(1, 10, 1, -90)}, 0.3, Enum.EasingStyle.Quint).Completed:Connect(function()
            notificationContainer:Destroy()
        end)
    end)
    
    return notificationContainer
end

function OneX:setupUtilities()
    local antiAFKConnection = nil
    
    local function setupAntiAFK()
        if self.utilities.antiAFK then
            if antiAFKConnection then return end
            
            local virtualUser = game:GetService("VirtualUser")
            antiAFKConnection = game:GetService("Players").LocalPlayer.Idled:Connect(function()
                virtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                task.wait(1)
                virtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            end)
            
            self:notify("Anti AFK", "Anti AFK has been enabled.", 3)
        else
            if antiAFKConnection then
                antiAFKConnection:Disconnect()
                antiAFKConnection = nil
                self:notify("Anti AFK", "Anti AFK has been disabled.", 3)
            end
        end
    end
    
    local autoReconnectConnection = nil
    
    local function setupAutoReconnect()
        if self.utilities.autoReconnect then
            if autoReconnectConnection then return end
            
            autoReconnectConnection = game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
                if child.Name == "ErrorPrompt" and child:FindFirstChild("MessageArea") and child.MessageArea:FindFirstChild("ErrorFrame") then
                    local errorMessage = child.MessageArea.ErrorFrame.ErrorMessage.Text
                    if errorMessage:match("disconnected") or errorMessage:match("game has ended") then
                        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
                    end
                end
            end)
            
            self:notify("Auto Reconnect", "Auto reconnect has been enabled.", 3)
        else
            if autoReconnectConnection then
                autoReconnectConnection:Disconnect()
                autoReconnectConnection = nil
                self:notify("Auto Reconnect", "Auto reconnect has been disabled.", 3)
            end
        end
    end
    
    local speedConnection = nil
    local originalSpeed = 16
    
    local function setupSpeedHack()
        if self.utilities.speedEnabled then
            if speedConnection then return end
            
            originalSpeed = game:GetService("Players").LocalPlayer.Character and 
                           game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid") and 
                           game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed or 16
            
            speedConnection = RunService.Heartbeat:Connect(function()
                if game:GetService("Players").LocalPlayer.Character and 
                   game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid") then
                    game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = originalSpeed * self.utilities.speedMultiplier
                end
            end)
            
            self:notify("Speed Hack", "Speed hack has been enabled (x" .. self.utilities.speedMultiplier .. ").", 3)
        else
            if speedConnection then
                speedConnection:Disconnect()
                speedConnection = nil
                
                if game:GetService("Players").LocalPlayer.Character and 
                   game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid") then
                    game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = originalSpeed
                end
                
                self:notify("Speed Hack", "Speed hack has been disabled.", 3)
            end
        end
    end
    
    local lightingConnection = nil
    local originalBrightness = 0
    local originalAmbient = Color3.new()
    local originalOutdoorAmbient = Color3.new()
    local originalFogEnd = 0
    
    local function setupFullBrightness()
        if self.utilities.fullBrightness then
            if lightingConnection then return end
            
            local lighting = game:GetService("Lighting")
            originalBrightness = lighting.Brightness
            originalAmbient = lighting.Ambient
            originalOutdoorAmbient = lighting.OutdoorAmbient
            originalFogEnd = lighting.FogEnd
            
            lightingConnection = RunService.Heartbeat:Connect(function()
                lighting.Brightness = 2
                lighting.Ambient = Color3.fromRGB(255, 255, 255)
                lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
                lighting.FogEnd = 100000
                
                if lighting:FindFirstChild("Blur") then
                    lighting.Blur.Enabled = false
                end
                
                if lighting:FindFirstChild("ColorCorrection") then
                    lighting.ColorCorrection.Enabled = false
                end
                
                if lighting:FindFirstChild("SunRays") then
                    lighting.SunRays.Enabled = false
                end
            end)
            
            self:notify("Full Brightness", "Full brightness has been enabled.", 3)
        else
            if lightingConnection then
                lightingConnection:Disconnect()
                lightingConnection = nil
                
                local lighting = game:GetService("Lighting")
                lighting.Brightness = originalBrightness
                lighting.Ambient = originalAmbient
                lighting.OutdoorAmbient = originalOutdoorAmbient
                lighting.FogEnd = originalFogEnd
                
                self:notify("Full Brightness", "Full brightness has been disabled.", 3)
            end
        end
    end
    
    self.toggleAntiAFK = function(enabled)
        self.utilities.antiAFK = enabled ~= nil and enabled or not self.utilities.antiAFK
        setupAntiAFK()
        return self.utilities.antiAFK
    end
    
    self.toggleAutoReconnect = function(enabled)
        self.utilities.autoReconnect = enabled ~= nil and enabled or not self.utilities.autoReconnect
        setupAutoReconnect()
        return self.utilities.autoReconnect
    end
    
    self.toggleSpeed = function(enabled, multiplier)
        self.utilities.speedEnabled = enabled ~= nil and enabled or not self.utilities.speedEnabled
        if multiplier then
            self.utilities.speedMultiplier = multiplier
        end
        setupSpeedHack()
        return self.utilities.speedEnabled
    end
    
    self.toggleFullBrightness = function(enabled)
        self.utilities.fullBrightness = enabled ~= nil and enabled or not self.utilities.fullBrightness
        setupFullBrightness()
        return self.utilities.fullBrightness
    end
end

function OneX:destroy()
    for _, connection in pairs(self.connections) do
        if connection then
            connection:Disconnect()
        end
    end
    
    self.toggleAntiAFK(false)
    self.toggleAutoReconnect(false)
    self.toggleSpeed(false)
    self.toggleFullBrightness(false)
    
    if self.gui then
        self.gui:Destroy()
    end
end

function OneX.createDefault()
    local ui = OneX.new("OneX UI")
    
    local mainTab = ui:addTab("Main", "🏠")
    local utilityTab = ui:addTab("Utility", "🛠️")
    local settingsTab = ui:addTab("Settings", "⚙️")
    local creditsTab = ui:addTab("Credits", "ℹ️")
    
    ui:addOneSection("mainTab", "Main Features", "🚀")
    ui:addOneInfo("mainTab", "Welcome to OneX UI Library! This is a default UI template. Customize it to fit your needs.", COLORS.ACCENT, "💡")
    ui:addOneButton("mainTab", "Example Button", function()
        ui:notify("Button Clicked", "You clicked the example button!", 3)
    end, COLORS.ACCENT, "🔘")
    ui:addOneToggle("mainTab", "Example Toggle", false, function(value)
        ui:notify("Toggle Changed", "Toggle is now " .. (value and "enabled" or "disabled"), 3)
    end, "🔄")
    ui:addOneSlider("mainTab", "Example Slider", 0, 100, 50, function(value)
    end, "📊")
    
    ui:addOneSection("utilityTab", "Game Utilities", "🎮")
    ui:addOneToggle("utilityTab", "Anti AFK", false, function(value)
        ui.toggleAntiAFK(value)
    end, "⏰")
    ui:addOneToggle("utilityTab", "Auto Reconnect", false, function(value)
        ui.toggleAutoReconnect(value)
    end, "🔄")
    ui:addOneToggle("utilityTab", "Speed Hack", false, function(value)
        ui.toggleSpeed(value)
    end, "⚡")
    ui:addOneSlider("utilityTab", "Speed Multiplier", 1, 10, 2, function(value)
        ui.utilities.speedMultiplier = value
        if ui.utilities.speedEnabled then
            ui.toggleSpeed(true, value)
        end
    end, "🏃")
    ui:addOneToggle("utilityTab", "Full Brightness", false, function(value)
        ui.toggleFullBrightness(value)
    end, "💡")
    
    ui:addOneSection("settingsTab", "UI Settings", "🎨")
    ui:addOneDropdown("settingsTab", "Theme", {"Dark", "Light"}, function(value)
        ui:notify("Theme Changed", "Theme changed to " .. value, 3)
    end, "🎭")
    ui:addOneButton("settingsTab", "Reset UI", function()
        ui.mainFrame.Position = UDim2.new(0.5, -275, 0.5, -175)
    end, nil, "🔄")
    ui:addOneColorPicker("settingsTab", "Accent Color", COLORS.ACCENT, function(color)
        ui:notify("Color Changed", "Accent color has been updated", 2)
    end, "🎨")
    
    ui:addOneSection("creditsTab", "Credits", "👑")
    ui:addOneInfo("creditsTab", "OneX UI Library\nCreated for Roblox\n\nA comprehensive UI library for creating dynamic interfaces.", nil, "📚")
    ui:addOneSeparator("creditsTab", "Links")
    ui:addOneSocialLink("creditsTab", "GitHub", "https://github.com", "📂")
    ui:addOneSocialLink("creditsTab", "Discord", "https://discord.com", "💬")
    
    return ui
end

return OneX
