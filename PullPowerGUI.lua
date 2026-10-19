-- PullPowerGUI.lua

local AutoStickyModule = require(script.Parent.AutoStickyModule)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create the GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PullPowerGUI"
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "Pull Power"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
frame.Parent = frame

local slider = Instance.new("TextBox")
slider.Size = UDim2.new(0.8, 0, 0, 30)
slider.Position = UDim2.new(0.1, 0, 0.5, -15)
slider.AnchorPoint = Vector2.new(0.5, 0.5)
slider.Text = "100"
slider.TextColor3 = Color3.new(1, 1, 1)
slider.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
slider.BorderSizePixel = 0
slider.Parent = frame

-- Make the GUI draggable
local dragging
local dragStart
local startPos

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Update pull power when slider value changes
slider.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local value = tonumber(slider.Text)
        if value then
            AutoStickyModule.setPullPower(value)
        else
            slider.Text = tostring(AutoStickyModule.getPullPower())
        end
    end
end)