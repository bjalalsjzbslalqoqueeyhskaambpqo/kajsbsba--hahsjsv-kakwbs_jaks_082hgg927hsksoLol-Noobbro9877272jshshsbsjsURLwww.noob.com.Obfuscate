local NexusUI = {}
NexusUI.__index = NexusUI

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local TextService = game:GetService("TextService")
local GuiService = game:GetService("GuiService")

local PLAYER = Players.LocalPlayer
local MOUSE = PLAYER:GetMouse()
local SCREEN_GUI_NAME = "NexusUILibrary"
local DEFAULT_FONT = Enum.Font.GothamSemibold
local DEFAULT_TEXT_SIZE = 14
local DEFAULT_CORNER_RADIUS = UDim.new(0, 6)
local DEFAULT_PADDING = UDim.new(0, 8)
local DEFAULT_TWEEN_INFO = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local COLORS = {
    BACKGROUND = Color3.fromRGB(30, 30, 35),
    BACKGROUND_DARK = Color3.fromRGB(25, 25, 30),
    BACKGROUND_LIGHT = Color3.fromRGB(40, 40, 45),
    ACCENT = Color3.fromRGB(0, 170, 255),
    ACCENT_DARK = Color3.fromRGB(0, 140, 210),
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

function NexusUI.new(title, theme)
    local self = setmetatable({}, NexusUI)
    
    self.title = title or "Nexus UI"
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

function NexusUI:createMainGUI()
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
        Size = UDim2.new(0, 500, 0, 350),
        Position = UDim2.new(0.5, -250, 0.5, -175),
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
        Size = UDim2.new(0, 120, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = COLORS.BACKGROUND_DARK,
        BorderSizePixel = 0,
        Parent = self.contentFrame
    })
    
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
        Size = UDim2.new(1, -120, 1, 0),
        Position = UDim2.new(0, 120, 0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Parent = self.contentFrame
    })
    
    self:setupEvents()
end

function NexusUI:setupEvents()
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

function NexusUI:handleResponsiveDesign()
    local function updateSize()
        local screenSize = workspace.CurrentCamera.ViewportSize
        local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
        
        if isMobile then
            self.mainFrame.Size = UDim2.new(0.9, 0, 0.7, 0)
            self.mainFrame.Position = UDim2.new(0.5, -self.mainFrame.AbsoluteSize.X/2, 0.5, -self.mainFrame.AbsoluteSize.Y/2)
            self.tabContainer.Size = UDim2.new(0, 80, 1, 0)
            self.windowContainer.Size = UDim2.new(1, -80, 1, 0)
            self.windowContainer.Position = UDim2.new(0, 80, 0, 0)
        else
            self.mainFrame.Size = UDim2.new(0, 500, 0, 350)
            self.mainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
            self.tabContainer.Size = UDim2.new(0, 120, 1, 0)
            self.windowContainer.Size = UDim2.new(1, -120, 1, 0)
            self.windowContainer.Position = UDim2.new(0, 120, 0, 0)
        end
    end
    
    updateSize()
    
    self.connections.screenSizeChanged = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateSize)
end

function NexusUI:toggleMinimize()
    self.minimized = not self.minimized
    
    if self.minimized then
        tween(self.mainFrame, {Size = UDim2.new(0, 500, 0, 36)})
        self.contentFrame.Visible = false
    else
        tween(self.mainFrame, {Size = UDim2.new(0, 500, 0, 350)})
        self.contentFrame.Visible = true
    end
end

function NexusUI:addTab(name, icon)
    local tabButton = createInstance("TextButton", {
        Name = name .. "Tab",
        Size = UDim2.new(1, 0, 0, 32),
        BackgroundColor3 = COLORS.BACKGROUND_LIGHT,
        BorderSizePixel = 0,
        Text = name,
        TextColor3 = COLORS.TEXT_SECONDARY,
        TextSize = DEFAULT_TEXT_SIZE,
        Font = DEFAULT_FONT,
        Parent = self.tabScrollFrame
    })
    createCorner(tabButton, UDim.new(0, 4))
    
    if icon then
        local iconImage = createInstance("ImageLabel", {
            Name = "Icon",
            Size = UDim2.new(0, 16, 0, 16),
            Position = UDim2.new(0, 8, 0.5, -8),
            BackgroundTransparency = 1,
            Image = icon,
            Parent = tabButton
        })
        
        tabButton.Text = "    " .. name
        tabButton.TextXAlignment = Enum.TextXAlignment.Left
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
    createPadding(window)
    
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

function NexusUI:selectTab(name)
    if not self.windows[name] then return end
    
    for tabName, window in pairs(self.windows) do
        window.frame.Visible = false
        window.button.BackgroundColor3 = COLORS.BACKGROUND_LIGHT
        window.button.TextColor3 = COLORS.TEXT_SECONDARY
    end
    
    self.windows[name].frame.Visible = true
    self.windows[name].button.BackgroundColor3 = COLORS.ACCENT
    self.windows[name].button.TextColor3 = COLORS.TEXT_PRIMARY
    
    self.currentWindow = name
end

function NexusUI:addLabel(tabName, text)
    if not self.windows[tabName] then return end
    
    local label = createInstance("TextLabel", {
        Name = "Label",
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = COLORS.TEXT_PRIMARY,
        TextSize = DEFAULT_TEXT_SIZE,
        Font = DEFAULT_FONT,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = self.windows[tabName].frame
    })
    
    table.insert(self.windows[tabName].elements, label)
    return label
end

function NexusUI:addButton(tabName, text, callback)
    if not self.windows[tabName] then return end
    
    local buttonContainer = createInstance("Frame", {
        Name = "ButtonContainer",
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundTransparency = 1,
        Parent = self.windows[tabName].frame
    })
    
    local button = createInstance("TextButton", {
        Name = "Button",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = COLORS.BACKGROUND_LIGHT,
        Text = text,
        TextColor3 = COLORS.TEXT_PRIMARY,
        TextSize = DEFAULT_TEXT_SIZE,
        Font = DEFAULT_FONT,
        Parent = buttonContainer
    })
    createCorner(button)
    
    button.MouseEnter:Connect(function()
        tween(button, {BackgroundColor3 = COLORS.ACCENT})
    end)
    
    button.MouseLeave:Connect(function()
        tween(button, {BackgroundColor3 = COLORS.BACKGROUND_LIGHT})
    end)
    
    button.MouseButton1Down:Connect(function()
        tween(button, {BackgroundColor3 = COLORS.ACCENT_DARK})
    end)
    
    button.MouseButton1Up:Connect(function()
        tween(button, {BackgroundColor3 = COLORS.ACCENT})
    end)
    
    button.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    
    table.insert(self.windows[tabName].elements, buttonContainer)
    return button
end

function NexusUI:addToggle(tabName, text, default, callback)
    if not self.windows[tabName] then return end
    
    local toggleContainer = createInstance("Frame", {
        Name = "ToggleContainer",
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundTransparency = 1,
        Parent = self.windows[tabName].frame
    })
    
    local label = createInstance("TextLabel", {
        Name = "Label",
        Size = UDim2.new(1, -56, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = COLORS.TEXT_PRIMARY,
        TextSize = DEFAULT_TEXT_SIZE,
        Font = DEFAULT_FONT,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = toggleContainer
    })
    
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

function NexusUI:addSlider(tabName, text, min, max, default, callback)
    if not self.windows[tabName] then return end
    
    min = min or 0
    max = max or 100
    default = default or min
    
    local sliderContainer = createInstance("Frame", {
        Name = "SliderContainer",
        Size = UDim2.new(1, 0, 0, 50),
        BackgroundTransparency = 1,
        Parent = self.windows[tabName].frame
    })
    
    local label = createInstance("TextLabel", {
        Name = "Label",
        Size = UDim2.new(1, 0, 0, 20),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = COLORS.TEXT_PRIMARY,
        TextSize = DEFAULT_TEXT_SIZE,
        Font = DEFAULT_FONT,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = sliderContainer
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
        Parent = sliderContainer
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

function NexusUI:addTextbox(tabName, placeholder, callback)
    if not self.windows[tabName] then return end
    
    local textboxContainer = createInstance("Frame", {
        Name = "TextboxContainer",
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundTransparency = 1,
        Parent = self.windows[tabName].frame
    })
    
    local textbox = createInstance("TextBox", {
        Name = "Textbox",
        Size = UDim2.new(1, 0, 1, 0),
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
    
    textbox.FocusLost:Connect(function(enterPressed)
        if callback then callback(textbox.Text, enterPressed) end
    end)
    
    table.insert(self.windows[tabName].elements, textboxContainer)
    
    return {
        getValue = function() return textbox.Text end,
        setValue = function(text) textbox.Text = text end
    }
end

function NexusUI:addDropdown(tabName, text, options, callback)
    if not self.windows[tabName] then return end
    
    options = options or {}
    local selected = options[1] or ""
    
    local dropdownContainer = createInstance("Frame", {
        Name = "DropdownContainer",
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundTransparency = 1,
        Parent = self.windows[tabName].frame
    })
    
    local label = createInstance("TextLabel", {
        Name = "Label",
        Size = UDim2.new(0.5, -5, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = COLORS.TEXT_PRIMARY,
        TextSize = DEFAULT_TEXT_SIZE,
        Font = DEFAULT_FONT,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = dropdownContainer
    })
    
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

function NexusUI:addSeparator(tabName, text)
    if not self.windows[tabName] then return end
    
    local separatorContainer = createInstance("Frame", {
        Name = "SeparatorContainer",
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        Parent = self.windows[tabName].frame
    })
    
    local line1 = createInstance("Frame", {
        Name = "Line1",
        Size = UDim2.new(0.5, -10, 0, 1),
        Position = UDim2.new(0, 0, 0.5, 0),
        BackgroundColor3 = COLORS.BACKGROUND_LIGHT,
        BorderSizePixel = 0,
        Parent = separatorContainer
    })
    
    local line2 = createInstance("Frame", {
        Name = "Line2",
        Size = UDim2.new(0.5, -10, 0, 1),
        Position = UDim2.new(0.5, 10, 0.5, 0),
        BackgroundColor3 = COLORS.BACKGROUND_LIGHT,
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
            TextColor3 = COLORS.TEXT_SECONDARY,
            TextSize = 12,
            Font = DEFAULT_FONT,
            AutomaticSize = Enum.AutomaticSize.X,
            Parent = separatorContainer
        })
    end
    
    table.insert(self.windows[tabName].elements, separatorContainer)
    return separatorContainer
end

function NexusUI:addSection(tabName, text)
    if not self.windows[tabName] then return end
    
    local sectionContainer = createInstance("Frame", {
        Name = "SectionContainer",
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundTransparency = 1,
        Parent = self.windows[tabName].frame
    })
    
    local label = createInstance("TextLabel", {
        Name = "Label",
        Size = UDim2.new(1, 0, 1, 0),
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
        BorderSizePixel = 0,
        Parent = sectionContainer
    })
    
    table.insert(self.windows[tabName].elements, sectionContainer)
    return sectionContainer
end

function NexusUI:addInfo(tabName, text, color)
    if not self.windows[tabName] then return end
    
    local infoContainer = createInstance("Frame", {
        Name = "InfoContainer",
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = COLORS.BACKGROUND_LIGHT,
        Parent = self.windows[tabName].frame
    })
    createCorner(infoContainer)
    
    local infoText = createInstance("TextLabel", {
        Name = "InfoText",
        Size = UDim2.new(1, 0, 0, 0),
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

function NexusUI:addSocialLink(tabName, platform, url, icon)
    if not self.windows[tabName] then return end
    
    local linkContainer = createInstance("Frame", {
        Name = "SocialLinkContainer",
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundTransparency = 1,
        Parent = self.windows[tabName].frame
    })
    
    local linkButton = createInstance("TextButton", {
        Name = "LinkButton",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = COLORS.BACKGROUND_LIGHT,
        Text = platform,
        TextColor3 = COLORS.TEXT_PRIMARY,
        TextSize = DEFAULT_TEXT_SIZE,
        Font = DEFAULT_FONT,
        Parent = linkContainer
    })
    createCorner(linkButton)
    
    if icon then
        local iconImage = createInstance("ImageLabel", {
            Name = "Icon",
            Size = UDim2.new(0, 20, 0, 20),
            Position = UDim2.new(0, 8, 0.5, -10),
            BackgroundTransparency = 1,
            Image = icon,
            Parent = linkButton
        })
        
        linkButton.Text = "    " .. platform
        linkButton.TextXAlignment = Enum.TextXAlignment.Left
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

function NexusUI:notify(title, message, duration)
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

function NexusUI:setupUtilities()
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

function NexusUI:destroy()
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

function NexusUI.createDefault()
    local ui = NexusUI.new("Nexus UI")
    
    local mainTab = ui:addTab("Main")
    local utilityTab = ui:addTab("Utility")
    local settingsTab = ui:addTab("Settings")
    local creditsTab = ui:addTab("Credits")
    
    ui:addSection("mainTab", "Main Features")
    ui:addInfo("mainTab", "Welcome to Nexus UI Library! This is a default UI template. Customize it to fit your needs.")
    ui:addButton("mainTab", "Example Button", function()
        ui:notify("Button Clicked", "You clicked the example button!", 3)
    end)
    ui:addToggle("mainTab", "Example Toggle", false, function(value)
        ui:notify("Toggle Changed", "Toggle is now " .. (value and "enabled" or "disabled"), 3)
    end)
    ui:addSlider("mainTab", "Example Slider", 0, 100, 50, function(value)
    end)
    
    ui:addSection("utilityTab", "Game Utilities")
    ui:addToggle("utilityTab", "Anti AFK", false, function(value)
        ui.toggleAntiAFK(value)
    end)
    ui:addToggle("utilityTab", "Auto Reconnect", false, function(value)
        ui.toggleAutoReconnect(value)
    end)
    ui:addToggle("utilityTab", "Speed Hack", false, function(value)
        ui.toggleSpeed(value)
    end)
    ui:addSlider("utilityTab", "Speed Multiplier", 1, 10, 2, function(value)
        ui.utilities.speedMultiplier = value
        if ui.utilities.speedEnabled then
            ui.toggleSpeed(true, value)
        end
    end)
    ui:addToggle("utilityTab", "Full Brightness", false, function(value)
        ui.toggleFullBrightness(value)
    end)
    
    ui:addSection("settingsTab", "UI Settings")
    ui:addDropdown("settingsTab", "Theme", {"Dark", "Light"}, function(value)
        ui:notify("Theme Changed", "Theme changed to " .. value, 3)
    end)
    ui:addButton("settingsTab", "Reset UI", function()
        ui.mainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    end)
    
    ui:addSection("creditsTab", "Credits")
    ui:addInfo("creditsTab", "Nexus UI Library\nCreated for Roblox\n\nA comprehensive UI library for creating dynamic interfaces.")
    ui:addSeparator("creditsTab", "Links")
    ui:addSocialLink("creditsTab", "GitHub", "https://github.com")
    ui:addSocialLink("creditsTab", "Discord", "https://discord.com")
    
    return ui
end

return NexusUI
