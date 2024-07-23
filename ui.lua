-- Local aliases for common functions
local DrawingNew       = Drawing.new
local GetService        = game.GetService
local Vector2New        = Vector2.new
local Color3FromRGB     = Color3.fromRGB
local TableInsert       = table.insert
local TaskWait          = task.wait
local UserInputService  = GetService(game, 'UserInputService')

-- Main library table
local UI = {
    Active = true,
    Tabs = {},
    AllDrawings = {}
}

-- Helper function to create drawings
local function CreateDrawing(type, properties)
    local drawing = DrawingNew(type)
    if properties then
        for key, value in pairs(properties) do
            drawing[key] = value
        end
    end
    TableInsert(UI.AllDrawings, drawing)
    return drawing
end

-- UI Initialization
local Camera = workspace.CurrentCamera
local CamX = Camera.ViewportSize.X
local MenuWidth = math.max(CamX / 18, 120)

local Watermark = CreateDrawing('Text', {
    Text = 'Custom UI Library',
    Position = Vector2New(CamX / 2, 0),
    Center = true,
    Size = 40,
    Visible = true,
    Color = Color3FromRGB(1, 0, 0),
    ZIndex = 99999999
})

-- Function to toggle UI visibility
function UI:Toggle(state)
    self.Active = state
    Watermark.Visible = state
    for _, tab in ipairs(self.Tabs) do
        for _, drawing in ipairs(tab.Drawings) do
            drawing.Visible = state
        end
    end
end

-- Create and handle tabs
function UI:AddTab(name)
    local tab = {
        Name = name,
        Opened = false,
        Drawings = {},
        Options = {}
    }

    -- Create tab UI elements
    local base = CreateDrawing('Square', {
        Visible = true,
        Color = Color3FromRGB(0, 0, 0),
        Transparency = 0.5,
        Filled = true,
        Position = Vector2New(0, #self.Tabs * 30),
        Size = Vector2New(MenuWidth, 30)
    })

    local text = CreateDrawing('Text', {
        Visible = true,
        Color = Color3FromRGB(255, 255, 255),
        Font = 2,
        Position = base.Position,
        Size = 14,
        Text = name
    })

    TableInsert(tab.Drawings, base)
    TableInsert(tab.Drawings, text)

    -- Add tab to the library
    TableInsert(self.Tabs, tab)
    return tab
end

-- Add button to a tab
function UI:AddButton(tab, buttonName, callback)
    local button = {
        Name = buttonName,
        Callback = callback,
        Drawings = {}
    }

    local base = CreateDrawing('Square', {
        Visible = false,
        Transparency = 0.5,
        Filled = true,
        Position = Vector2New(0, #tab.Options * 30),
        Size = Vector2New(MenuWidth, 30)
    })

    local text = CreateDrawing('Text', {
        Visible = false,
        Color = Color3FromRGB(255, 255, 255),
        Font = 2,
        Position = base.Position,
        Size = 14,
        Text = buttonName
    })

    TableInsert(button.Drawings, base)
    TableInsert(button.Drawings, text)

    -- Update tab options
    TableInsert(tab.Options, button)
    return button
end

-- Add toggle to a tab
function UI:AddToggle(tab, toggleName, defaultState, callback)
    local toggle = {
        Name = toggleName,
        Enabled = defaultState,
        Callback = callback,
        Drawings = {}
    }

    local base = CreateDrawing('Square', {
        Visible = false,
        Transparency = 0.5,
        Filled = true,
        Position = Vector2New(0, #tab.Options * 30),
        Size = Vector2New(MenuWidth, 30)
    })

    local text = CreateDrawing('Text', {
        Visible = false,
        Color = Color3FromRGB(255, 255, 255),
        Font = 2,
        Position = base.Position,
        Size = 14,
        Text = toggleName
    })

    TableInsert(toggle.Drawings, base)
    TableInsert(toggle.Drawings, text)

    -- Update tab options
    TableInsert(tab.Options, toggle)
    return toggle
end

-- Add slider to a tab
function UI:AddSlider(tab, sliderName, minValue, maxValue, defaultValue, callback)
    local slider = {
        Name = sliderName,
        Min = minValue,
        Max = maxValue,
        Value = defaultValue,
        Callback = callback,
        Drawings = {}
    }

    local base = CreateDrawing('Square', {
        Visible = false,
        Transparency = 0.5,
        Filled = true,
        Position = Vector2New(0, #tab.Options * 30),
        Size = Vector2New(MenuWidth, 30)
    })

    local text = CreateDrawing('Text', {
        Visible = false,
        Color = Color3FromRGB(255, 255, 255),
        Font = 2,
        Position = base.Position,
        Size = 14,
        Text = sliderName .. ': ' .. defaultValue
    })

    TableInsert(slider.Drawings, base)
    TableInsert(slider.Drawings, text)

    -- Update tab options
    TableInsert(tab.Options, slider)
    return slider
end

-- Cleanup function
function UI:Cleanup()
    for _, drawing in ipairs(self.AllDrawings) do
        drawing:Remove()
    end
    self.AllDrawings = {}
    self.Tabs = {}
end

return UI
