local UI_Library = {} UI_Library.__index = UI_Library

function UI_Library:CreateMainFrame(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CSGO_UI"
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.Size = UDim2.new(0, 600, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = MainFrame
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Title.BorderSizePixel = 0
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 20

    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.Size = UDim2.new(0, 150, 1, -40)
    TabContainer.Position = UDim2.new(0, 0, 0, 40)
    TabContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabContainer.BorderSizePixel = 0

    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = MainFrame
    ContentContainer.Size = UDim2.new(1, -150, 1, -40)
    ContentContainer.Position = UDim2.new(0, 150, 0, 40)
    ContentContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    ContentContainer.BorderSizePixel = 0

    self.ScreenGui = ScreenGui
    self.MainFrame = MainFrame
    self.TabContainer = TabContainer
    self.ContentContainer = ContentContainer
    self.Tabs = {}

    return self
end

function UI_Library:CreateTab(name)
    local Tab = Instance.new("TextButton")
    Tab.Name = name .. "_Tab"
    Tab.Parent = self.TabContainer
    Tab.Size = UDim2.new(1, 0, 0, 40)
    Tab.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Tab.BorderSizePixel = 0
    Tab.Text = name
    Tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    Tab.Font = Enum.Font.SourceSansBold
    Tab.TextSize = 18

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = name .. "_Content"
    ContentFrame.Parent = self.ContentContainer
    ContentFrame.Size = UDim2.new(1, 0, 1, 0)
    ContentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    ContentFrame.BorderSizePixel = 0
    ContentFrame.Visible = false

    Tab.MouseButton1Click:Connect(function()
        for _, tab in pairs(self.Tabs) do
            tab.ContentFrame.Visible = false
            tab.Tab.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        end
        ContentFrame.Visible = true
        Tab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)

    table.insert(self.Tabs, { Tab = Tab, ContentFrame = ContentFrame })

    if #self.Tabs == 1 then
        Tab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        ContentFrame.Visible = true
    end

    return ContentFrame
end

function UI_Library:CreateCheckbox(parent, text)
    local Checkbox = Instance.new("Frame")
    Checkbox.Parent = parent
    Checkbox.Size = UDim2.new(1, 0, 0, 40)
    Checkbox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Checkbox.BorderSizePixel = 0

    local CheckboxButton = Instance.new("TextButton")
    CheckboxButton.Parent = Checkbox
    CheckboxButton.Size = UDim2.new(0, 30, 0, 30)
    CheckboxButton.Position = UDim2.new(0, 5, 0.5, -15)
    CheckboxButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    CheckboxButton.BorderSizePixel = 0
    CheckboxButton.Text = ""

    local CheckboxLabel = Instance.new("TextLabel")
    CheckboxLabel.Parent = Checkbox
    CheckboxLabel.Size = UDim2.new(1, -40, 1, 0)
    CheckboxLabel.Position = UDim2.new(0, 40, 0, 0)
    CheckboxLabel.BackgroundTransparency = 1
    CheckboxLabel.Text = text
    CheckboxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    CheckboxLabel.Font = Enum.Font.SourceSans
    CheckboxLabel.TextSize = 18
    CheckboxLabel.TextXAlignment = Enum.TextXAlignment.Left

    local Checked = false
    CheckboxButton.MouseButton1Click:Connect(function()
        Checked = not Checked
        if Checked then
            CheckboxButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        else
            CheckboxButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end
    end)
end

function UI_Library:CreateSlider(parent, text, min, max, default, callback)
    local Slider = Instance.new("Frame")
    Slider.Parent = parent
    Slider.Size = UDim2.new(1, 0, 0, 60)
    Slider.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Slider.BorderSizePixel = 0

    local SliderLabel = Instance.new("TextLabel")
    SliderLabel.Parent = Slider
    SliderLabel.Size = UDim2.new(1, -40, 0, 30)
    SliderLabel.Position = UDim2.new(0, 40, 0, 0)
    SliderLabel.BackgroundTransparency = 1
    SliderLabel.Text = text
    SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    SliderLabel.Font = Enum.Font.SourceSans
    SliderLabel.TextSize = 18
    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left

    local SliderBar = Instance.new("Frame")
    SliderBar.Parent = Slider
    SliderBar.Size = UDim2.new(0.8, 0, 0, 10)
    SliderBar.Position = UDim2.new(0.1, 0, 0.6, 0)
    SliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    SliderBar.BorderSizePixel = 0

    local SliderButton = Instance.new("TextButton")
    SliderButton.Parent = SliderBar
    SliderButton.Size = UDim2.new(0, 20, 0, 20)
    SliderButton.Position = UDim2.new(0, 0, -0.5, 0)
    SliderButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    SliderButton.BorderSizePixel = 0
    SliderButton.Text = ""

    local value = default or min
    local dragging = false
    SliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)
    SliderButton.MouseButton1Up:Connect(function()
        dragging = false
    end)
    SliderBar.InputChanged:Connect(function(input)
        if dragging then
            local pos = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
            SliderButton.Position = UDim2.new(pos, 0, -0.5, 0)
            value = math.floor(min + (max - min) * pos)
            callback(value)
        end
    end)
end

function UI_Library:CreateDropdown(parent, text, options, callback)
    local Dropdown = Instance.new("Frame")
    Dropdown.Parent = parent
    Dropdown.Size = UDim2.new(1, 0, 0, 40)
    Dropdown.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Dropdown.BorderSizePixel = 0

    local DropdownLabel = Instance.new("TextLabel")
    DropdownLabel.Parent = Dropdown
    DropdownLabel.Size = UDim2.new(1, -40, 1, 0)
    DropdownLabel.Position = UDim2.new(0, 40, 0, 0)
    DropdownLabel.BackgroundTransparency = 1
    DropdownLabel.Text = text
    DropdownLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropdownLabel.Font = Enum.Font.SourceSans
    DropdownLabel.TextSize = 18
    DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left

    local DropdownButton = Instance.new("TextButton")
    DropdownButton.Parent = Dropdown
    DropdownButton.Size = UDim2.new(0, 30, 0, 30)
    DropdownButton.Position = UDim2.new(0, 5, 0.5, -15)
    DropdownButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    DropdownButton.BorderSizePixel = 0
    DropdownButton.Text = "V"

    local OptionsFrame = Instance.new("Frame")
    OptionsFrame.Parent = Dropdown
    OptionsFrame.Size = UDim2.new(1, 0, 0, #options * 30)
    OptionsFrame.Position = UDim2.new(0, 0, 1, 0)
    OptionsFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    OptionsFrame.BorderSizePixel = 0
    OptionsFrame.Visible = false

    for i, option in ipairs(options) do
        local OptionButton = Instance.new("TextButton")
        OptionButton.Parent = OptionsFrame
        OptionButton.Size = UDim2.new(1, 0, 0, 30)
        OptionButton.Position = UDim2.new(0, 0, 0, (i - 1) * 30)
        OptionButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        OptionButton.BorderSizePixel = 0
        OptionButton.Text = option
        OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        OptionButton.Font = Enum.Font.SourceSans
        OptionButton.TextSize = 18

        OptionButton.MouseButton1Click:Connect(function()
            DropdownLabel.Text = text .. ": " .. option
            OptionsFrame.Visible = false
            callback(option)
        end)
    end

    DropdownButton.MouseButton1Click:Connect(function()
        OptionsFrame.Visible = not OptionsFrame.Visible
    end)
end

function UI_Library:CreateTextInput(parent, text, callback)
    local TextInput = Instance.new("Frame")
    TextInput.Parent = parent
    TextInput.Size = UDim2.new(1, 0, 0, 40)
    TextInput.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TextInput.BorderSizePixel = 0

    local TextInputLabel = Instance.new("TextLabel")
    TextInputLabel.Parent = TextInput
    TextInputLabel.Size = UDim2.new(1, -40, 1, 0)
    TextInputLabel.Position = UDim2.new(0, 40, 0, 0)
    TextInputLabel.BackgroundTransparency = 1
    TextInputLabel.Text = text
    TextInputLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextInputLabel.Font = Enum.Font.SourceSans
    TextInputLabel.TextSize = 18
    TextInputLabel.TextXAlignment = Enum.TextXAlignment.Left

    local TextBox = Instance.new("TextBox")
    TextBox.Parent = TextInput
    TextBox.Size = UDim2.new(0, 200, 0, 30)
    TextBox.Position = UDim2.new(0, 5, 0.5, -15)
    TextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TextBox.BorderSizePixel = 0
    TextBox.Text = ""
    TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextBox.Font = Enum.Font.SourceSans
    TextBox.TextSize = 18

    TextBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            callback(TextBox.Text)
        end
    end)
end

function UI_Library:CreateButton(parent, text, callback)
    local Button = Instance.new("TextButton")
    Button.Parent = parent
    Button.Size = UDim2.new(1, 0, 0, 40)
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Button.BorderSizePixel = 0
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.SourceSansBold
    Button.TextSize = 18

    Button.MouseButton1Click:Connect(function()
        callback()
    end)
end

return UI_Library
