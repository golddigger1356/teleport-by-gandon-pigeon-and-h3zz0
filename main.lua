--LMAOOOO NIGGA SHITS ALL CHAT GPTTT STOP BEING A SKIDDD LEARN HOW TO CODEEE IM DEAD
-- =========================
-- Whitelist Check
-- =========================
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local Whitelist = {
    "",
    "anonyme18022",
}

local function isWhitelisted(name)
    name = name:lower()
    for _, v in pairs(Whitelist) do
        if name == v:lower() then
            return true
        end
    end
    return false
end

if not isWhitelisted(player.Name) and not isWhitelisted(player.DisplayName) then
    player:Kick("Not whitelisted")
    return
end

-- =========================
-- Teleport + Auto Block System
-- =========================
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local backpack = player:WaitForChild("Backpack")
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui", player.PlayerGui)
ScreenGui.Name = "pigeonhub"
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 220, 0, 220)
Frame.Position = UDim2.new(0.5, -110, 0.5, -110)
Frame.BackgroundColor3 = Color3.fromRGB(2,2,2)
Frame.Active = true
Frame.Draggable = true
Frame.BorderSizePixel = 0
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 15)

local Stroke = Instance.new("UIStroke", Frame)
Stroke.Color = Color3.fromRGB(255,255,255)
Stroke.Thickness = 1

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, -20, 0, 35)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.Text = "pigeon hub Teleport & Auto Block made by gandon pigeon and h3zzo"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Center

-- Teleport Button
local TeleportButton = Instance.new("TextButton", Frame)
TeleportButton.Size = UDim2.new(0, 180, 0, 50)
TeleportButton.Position = UDim2.new(0, 20, 0, 60)
TeleportButton.Text = "Teleport"
TeleportButton.TextColor3 = Color3.fromRGB(0,0,0)
TeleportButton.Font = Enum.Font.GothamBold
TeleportButton.TextSize = 16
TeleportButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
TeleportButton.BorderSizePixel = 0
Instance.new("UICorner", TeleportButton).CornerRadius = UDim.new(0, 10)

-- Keybind Button
local KeybindButton = Instance.new("TextButton", Frame)
KeybindButton.Size = UDim2.new(0, 180, 0, 50)
KeybindButton.Position = UDim2.new(0, 20, 0, 120)
KeybindButton.Text = "Keybind: [F]"
KeybindButton.TextColor3 = Color3.fromRGB(0,0,0)
KeybindButton.Font = Enum.Font.GothamBold
KeybindButton.TextSize = 16
KeybindButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
KeybindButton.BorderSizePixel = 0
Instance.new("UICorner", KeybindButton).CornerRadius = UDim.new(0, 10)

-- Saved Locations
local spots = {
    CFrame.new(-402.18, -6.34, 131.83) * CFrame.Angles(0, math.rad(-20.08), 0),
    CFrame.new(-416.66, -6.34, -2.05) * CFrame.Angles(0, math.rad(-62.89), 0),
    CFrame.new(-329.37, -4.68, 18.12) * CFrame.Angles(0, math.rad(-30.53), 0),
}

local REQUIRED_TOOL = "Flying Carpet"
local teleportKey = Enum.KeyCode.F
local waitingForKey = false
local lastStealer = nil

-- Equip Flying Carpet
local function equipFlyingCarpet()
    local tool = char:FindFirstChild(REQUIRED_TOOL) or backpack:FindFirstChild(REQUIRED_TOOL)
    if not tool then
        warn("Flying Carpet not found!")
        return false
    end
    humanoid:EquipTool(tool)
    while char:FindFirstChildOfClass("Tool") ~= tool do task.wait() end
    return true
end

-- Block Function
local function block(plr)
    if not plr or plr == player then return end
    pcall(function()
        StarterGui:SetCore("PromptBlockPlayer", plr)
    end)
end

-- Teleport + Auto Block
local function teleportAll()
    if not equipFlyingCarpet() then return end

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player then
            lastStealer = plr
            break
        end
    end

    for _, spot in ipairs(spots) do
        hrp.CFrame = spot
        task.wait(0.12)
    end

    if lastStealer then
        block(lastStealer)
    end
end

-- GUI Button Connections
TeleportButton.MouseButton1Click:Connect(teleportAll)

-- Keybind Setup
KeybindButton.MouseButton1Click:Connect(function()
    KeybindButton.Text = "Press a key..."
    waitingForKey = true
end)

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end

    if waitingForKey and input.UserInputType == Enum.UserInputType.Keyboard then
        teleportKey = input.KeyCode
        KeybindButton.Text = "Keybind: [" .. teleportKey.Name .. "]"
        waitingForKey = false
    elseif input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == teleportKey then
        teleportAll()
    end
end)
