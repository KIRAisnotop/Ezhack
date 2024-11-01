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

-- Kill Self Button
MainTab:CreateButton({
    Name = "Kill Self",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = 0
        else
            warn("Character or Humanoid not found")
        end
    end,
})

-- Fly Toggle
local flying = false
local bodyVelocity

local function startFly()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    character:WaitForChild("HumanoidRootPart") -- Wait for HumanoidRootPart

    local userInputService = game:GetService("UserInputService")

    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
    bodyVelocity.Parent = character.HumanoidRootPart

    while flying do
        local direction = Vector3.new()
        if userInputService:IsKeyDown(Enum.KeyCode.W) then
            direction = direction + workspace.CurrentCamera.CFrame.LookVector
        end
        if userInputService:IsKeyDown(Enum.KeyCode.S) then
            direction = direction - workspace.CurrentCamera.CFrame.LookVector
        end
        if userInputService:IsKeyDown(Enum.KeyCode.A) then
            direction = direction - workspace.CurrentCamera.CFrame.RightVector
        end
        if userInputService:IsKeyDown(Enum.KeyCode.D) then
            direction = direction + workspace.CurrentCamera.CFrame.RightVector
        end
        if userInputService:IsKeyDown(Enum.KeyCode.Space) then
            bodyVelocity.Velocity = Vector3.new(direction.X, 50, direction.Z) -- Ascend
        elseif userInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            bodyVelocity.Velocity = Vector3.new(direction.X, -50, direction.Z) -- Descend
        else
            bodyVelocity.Velocity = Vector3.new(direction.X, 0, direction.Z) -- Maintain level
        end
        
        wait(0.1)
    end
    
    bodyVelocity:Destroy()
end

MainTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        flying = Value
        if flying then
            startFly()
        elseif bodyVelocity then
            bodyVelocity:Destroy()
        end
    end,
})

-- Speed Slider
MainTab:CreateSlider({
    Name = "Speed Hacks",
    Range = {16, 300},
    Increment = 1,
    Suffix = "Bananas",
    CurrentValue = 16,
    Flag = "SliderSpeed",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")

        humanoid.WalkSpeed = Value -- Set your desired speed value here
        print("Speed set to " .. Value) -- Debugging output
    end,
})

-- Jump Power Slider
MainTab:CreateSlider({
    Name = "Jump Power",
    Range = {50, 200},
    Increment = 1,
    Suffix = "Bananas",
    CurrentValue = 50,
    Flag = "SliderJumpPower",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")

        humanoid.JumpPower = Value -- Set your desired jump power value here
        print("Jump power set to " .. Value) -- Debugging output
    end,
})
