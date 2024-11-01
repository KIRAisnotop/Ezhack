local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Ez hack",
    LoadingTitle = "Ez hack Loading",
    LoadingSubtitle = "by @KIRA_opYT on youtube",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "Ezhack", -- Create a custom folder for your hub/game
        FileName = "Config"
    },
    Discord = {
        Enabled = true,
        Invite = "zWdze4NuBB", -- The Discord invite code
        RememberJoins = true
    },
    KeySystem = true, -- Set this to true to use our key system
    KeySettings = {
        Title = "Untitled",
        Subtitle = "Key System",
        Note = "Join the discord for the key!",
        FileName = "Key",
        SaveKey = true,
        GrabKeyFromSite = true,
        Key = {"https://pastebin.com/raw/xjn9UqJz"} -- List of keys
    }
})

local MainTab = Window:CreateTab("Main", 4483362458)

-- Kill self button
MainTab:CreateButton({
    Name = "Kill Self",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = 0
        end
    end,
})

-- Testing button
MainTab:CreateButton({
    Name = "Testing (press F9)",
    Callback = function()
        print("Testing")
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = 0
        end
    end,
})

-- Fly toggle
local flying = false
local bodyVelocity

local function startFly()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
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
    Callback = funct
