-- UI_Library.lua

local UI_Library = {}
UI_Library.__index = UI_Library

function UI_Library:CreateMainFrame(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CSGO_UI"
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
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
    TabContainer.Size = UDim2.new(0, 100, 1, -40)
    TabContainer.Position = UDim2.new(0, 0, 0, 40)
    TabContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabContainer.BorderSizePixel = 0

    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = MainFrame
    ContentContainer.Size = UDim2.new(1, -100, 1, -40)
    ContentContainer.Position = UDim2.new(0, 100, 0, 40)
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
        end
        ContentFrame.Visible = true
    end)

    table.insert(self.Tabs, { Tab = Tab, ContentFrame = ContentFrame })

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

return UI_Library
