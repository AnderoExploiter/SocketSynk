local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChildOfClass("Humanoid")
local head = character:FindFirstChild("Head")
local rootPart = character:FindFirstChild("HumanoidRootPart")

if head and humanoid and rootPart then
    humanoid.BreakJointsOnDeath = false  -- Отключаем разрыв соединений при смерти

    -- Отсоединяем голову
    head.Parent = workspace
    head.Anchored = false
    head.CanCollide = true

    -- Добавляем физику
    local bodyVelocity = Instance.new("BodyVelocity", head)
    bodyVelocity.Velocity = rootPart.CFrame.LookVector * 50 + Vector3.new(0, 20, 0)
    bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)

    local bodyAngularVelocity = Instance.new("BodyAngularVelocity", head)
    bodyAngularVelocity.AngularVelocity = Vector3.new(10, 10, 10)
    bodyAngularVelocity.MaxTorque = Vector3.new(1e5, 1e5, 1e5)

    -- Анимация игрока
    local tweenService = game:GetService("TweenService")
    local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local armGoal = {CFrame = character["Right Arm"].CFrame * CFrame.Angles(0, 0, math.rad(-90))}
    local armTween = tweenService:Create(character["Right Arm"], tweenInfo, armGoal)
    armTween:Play()

    armTween.Completed:Connect(function()
        print("Анимация завершена!")
    end)

    -- Возвращаем голову через 5 секунд
    task.delay(5, function()
        bodyVelocity:Destroy()
        bodyAngularVelocity:Destroy()
        head.Position = character.HumanoidRootPart.Position + Vector3.new(0, 5, 0)
        head.Parent = character
        head.Anchored = false
        head.CanCollide = false
        head.Transparency = 0
    end)
else
    warn("Не удалось найти необходимые части тела.")
end
