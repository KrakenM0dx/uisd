local Library = {}

-- Create a ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CSGO_UI"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create a main frame for the menu
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 400, 0, 300)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Create a title bar
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "CS:GO Style Menu"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 20
titleLabel.Parent = titleBar

-- Function to create a button
function Library:CreateButton(text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 200, 0, 50)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 18
    button.Parent = mainFrame

    button.MouseButton1Click:Connect(callback)
    return button
end

-- Function to create a slider
function Library:CreateSlider(min, max, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(0, 200, 0, 50)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    sliderFrame.Parent = mainFrame

    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(0, 10, 1, 0)
    slider.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    slider.Position = UDim2.new(0, 0, 0, 0)
    slider.Parent = sliderFrame

    local sliderValue = min

    sliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local moveConnection
            moveConnection = game:GetService("UserInputService").InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    local mousePos = input.Position.X
                    local framePos = sliderFrame.AbsolutePosition.X
                    local frameSize = sliderFrame.AbsoluteSize.X

                    local newSliderPos = math.clamp((mousePos - framePos) / frameSize, 0, 1)
                    slider.Position = UDim2.new(newSliderPos, 0, 0, 0)
                    sliderValue = math.floor(newSliderPos * (max - min) + min)
                    callback(sliderValue)
                end
            end)

            local endConnection
            endConnection = game:GetService("UserInputService").InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    moveConnection:Disconnect()
                    endConnection:Disconnect()
                end
            end)
        end
    end)

    return sliderFrame
end

return Library
