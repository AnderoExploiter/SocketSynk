local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

if character then
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Size = part.Size * 1.5
            part.BrickColor = BrickColor.Random()
        end
    end
  
    print("Ваш персонаж изменен! 🎉")
else
    warn("Не удалось найти персонажа.")
end
