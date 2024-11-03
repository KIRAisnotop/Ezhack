local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Ez hack V2",
    LoadingTitle = "Ez hack Loading",
    LoadingSubtitle = "by @KIRA_opYT on YouTube",
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
        Title = "Key",
        Subtitle = "Key System",
        Note = "Join the Discord for the key!",
        FileName = "Key",
        SaveKey = true,
        GrabKeyFromSite = true,
        Key = {"https://pastebin.com/raw/xjn9UqJz"}
    }
})

local MainTab = Window:CreateTab("Main", 4483362458)

-- ESP Tab
local ESPTab = Window:CreateTab("ESP", 4483362458)

-- Variables for ESP functionality
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local ESPEnabled = false
local ESPConnections = {}

-- Function to get a random color if no team
local function getRandomColor()
    return Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
end

-- Function to create ESP for a player
local function createESP(player)
    local character = player.Character
    if not character then return end

    -- Set the color based on team or randomly if no team
    local color = player.Team and player.Team.TeamColor.Color or getRandomColor()

    -- Create selection box for the character
    local espBox = Instance.new("SelectionBox")
    espBox.Name = "ESPBox"
    espBox.Adornee = character
    espBox.LineThickness = 0.05
    espBox.Color3 = color
    espBox.Parent = character

    -- Tracer line from camera to player
    local tracerLine = Drawing.new("Line")
    tracerLine.Color = color
    tracerLine.Thickness = 1.5
    tracerLine.Transparency = 1

    -- Billboard GUI for distance display
    local billboard = Instance.new("BillboardGui", character)
    billboard.Name = "DistanceLabel"
    billboard.Size = UDim2.new(0, 100, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true

    local distanceText = Instance.new("TextLabel", billboard)
    distanceText.Size = UDim2.new(1, 0, 1, 0)
    distanceText.BackgroundTransparency = 1
    distanceText.TextColor3 = color
    distanceText.TextStrokeTransparency = 0.5
    distanceText.TextScaled = true

    -- Update ESP elements
    local connection = RunService.RenderStepped:Connect(function()
        if ESPEnabled and character and character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0 then
            local hrpPosition = character.HumanoidRootPart.Position
            local distance = (hrpPosition - Camera.CFrame.Position).Magnitude
            distanceText.Text = string.format("[%d Studs]", math.floor(distance))

            -- Set tracer line from camera to player
            local viewportPoint = Camera:WorldToViewportPoint(hrpPosition)
            tracerLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
            tracerLine.To = Vector2.new(viewportPoint.X, viewportPoint.Y)
            tracerLine.Visible = true

            -- Update selection box visibility
            espBox.Visible = true
            distanceText.Visible = true
        else
            tracerLine.Visible = false
            espBox.Visible = false
            distanceText.Visible = false
        end
    end)

    -- Store connection to disable later
    ESPConnections[player] = {
        connection = connection,
        espBox = espBox,
        tracerLine = tracerLine,
        billboard = billboard
    }
end

-- Function to clear ESP
local function clearESP()
    for _, data in pairs(ESPConnections) do
        -- Disconnect and remove all ESP elements
        data.connection:Disconnect()
        if data.espBox then data.espBox:Destroy() end
        if data.tracerLine then data.tracerLine:Remove() end
        if data.billboard then data.billboard:Destroy() end
    end
    ESPConnections = {}
end

-- ESP Toggle
ESPTab:CreateToggle({
    Name = "ESP Toggle",
    CurrentValue = false,
    Flag = "ESP",
    Callback = function(Value)
        ESPEnabled = Value
        if ESPEnabled then
            -- Add ESP to existing players
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    createESP(player)
                end
            end

            -- Connect to player added event
            Players.PlayerAdded:Connect(function(player)
                player.CharacterAdded:Connect(function()
                    if ESPEnabled then
                        createESP(player)
                    end
                end)
            end)
        else
            -- Clear ESP when toggled off
            clearESP()
        end
    end,
})
