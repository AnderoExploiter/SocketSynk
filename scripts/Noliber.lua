local NotificationLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/AnderoExploiter/SocketSynk/refs/heads/main/scripts/NotiLib.lua"))()

-- Создаем уведомления
NotificationLib:CreateNotification("Добро пожаловать в игру!", 5)
task.wait(1)
NotificationLib:CreateNotification("У вас новое сообщение.", 3)
task.wait(2)
NotificationLib:CreateNotification("Завершена настройка библиотеки.", 4)
