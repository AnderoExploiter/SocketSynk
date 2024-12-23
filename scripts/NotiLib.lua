local NotificationLib = {}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Создаем ScreenGui для уведомлений
local notificationGui = Instance.new("ScreenGui")
notificationGui.Name = "NotificationGui"
notificationGui.Parent = PlayerGui
notificationGui.ResetOnSpawn = false

local notificationContainer = Instance.new("Frame")
notificationContainer.AnchorPoint = Vector2.new(1, 1)
notificationContainer.Position = UDim2.new(1, -10, 1, -10)
notificationContainer.Size = UDim2.new(0.3, 0, 0.8, 0)
notificationContainer.BackgroundTransparency = 1
notificationContainer.Parent = notificationGui

-- Функция для создания уведомления
function NotificationLib:CreateNotification(text, duration)
    duration = duration or 5 -- Длительность по умолчанию 5 секунд

    -- Создаем уведомление
    local notification = Instance.new("Frame")
    notification.Size = UDim2.new(1, 0, 0, 50)
    notification.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    notification.BorderSizePixel = 0
    notification.ClipsDescendants = true
    notification.Parent = notificationContainer

    -- Добавляем градиентную обводку
    local uiGradient = Instance.new("UIGradient")
    uiGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 255))
    }
    uiGradient.Rotation = 45
    uiGradient.Parent = notification

    -- Текст уведомления
    local textLabel = Instance.new("TextLabel")
    textLabel.Text = text
    textLabel.Size = UDim2.new(1, -10, 1, -10)
    textLabel.Position = UDim2.new(0, 5, 0, 5)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.Font = Enum.Font.SourceSans
    textLabel.TextSize = 18
    textLabel.TextWrapped = true
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Parent = notification

    -- Добавляем анимацию появления
    notification.BackgroundTransparency = 1
    textLabel.TextTransparency = 1
    notification:TweenSizeAndPosition(
        UDim2.new(1, 0, 0, 50),
        UDim2.new(0, 0, 1, -#notificationContainer:GetChildren() * 55),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quad,
        0.5,
        true
    )
    game:GetService("TweenService"):Create(notification, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
    game:GetService("TweenService"):Create(textLabel, TweenInfo.new(0.5), {TextTransparency = 0}):Play()

    -- Удаляем уведомление через заданное время
    task.delay(duration, function()
        notification:TweenSizeAndPosition(
            UDim2.new(1, 0, 0, 0),
            notification.Position,
            Enum.EasingDirection.In,
            Enum.EasingStyle.Quad,
            0.5,
            true
        )
        game:GetService("TweenService"):Create(notification, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
        game:GetService("TweenService"):Create(textLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
        task.wait(0.5)
        notification:Destroy()
    end)
end

return NotificationLib
