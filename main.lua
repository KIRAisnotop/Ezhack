local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Ez hack",
    LoadingTitle = "Ez hack Loading",
    LoadingSubtitle = "by @KIRA_opYT on youtube",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "Ezhack",
        FileName = "Config"
    },
    Discord = {
        Enabled = true,
        Invite = "zWdze4NuBB",
        RememberJoins = true
    },
    KeySystem = true,
    KeySettings = {
        Title = "Untitled",
        Subtitle = "Key System",
        Note = "Join the discord for the key!",
        FileName = "Key",
        SaveKey = true,
        GrabKeyFromSite = true,
        Key = {"https://pastebin.com/raw/xjn9UqJz"}
    }
})

local MainTab = Window:CreateTab("Main", 4483362458)

-- Kill self button
MainTab:CreateButton({
    Name = "kill self",
    Callback = function()
        local Players = game:GetService("Players")
        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function(character)
                if character:FindFirstChild("Humanoid") then
                    character.Humanoid.Health = 0
                end
            end)
        end)
    end,
})

-- Testing button
MainTab:CreateButton({
    Name = "Testing(press F9)",
    Callback = function()
        print("testing")
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = 0
        end
    end,
})

-- Speed slider
MainTab:CreateSlider({
    Name = "Speed hacks",
    Range = {16, 300},
    Increment = 1,
    Suffix = "Stud",
    CurrentValue = 16,
    Flag = "Slider1",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.WalkSpeed = Value
    end,
})

-- Jump Power slider
MainTab:CreateSlider({
    Name = "Jump Power",
    Range = {50, 300}, -- Adjust the range as needed
    Increment = 1,
    Suffix = "Stud",
    CurrentValue = 50,
    Flag = "Slider2", -- Ensure this flag is unique
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.JumpPower = Value
    end,
})
