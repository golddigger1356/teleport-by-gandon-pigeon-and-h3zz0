
    --LMAOOOO NIGGA SHITS ALL CHAT GPTTT STOP BEING A SKIDDD LEARN HOW TO CODEEE IM DEAD
    -- =========================
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


    -- Game ID Check
    if game.PlaceId ~= 109983668079237 then
        player:Kick("This script only works in the specific game.")
        return
    end

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

    -- Update character references on respawn
    player.CharacterAdded:Connect(function(newChar)
        char = newChar
        humanoid = char:WaitForChild("Humanoid")
        hrp = char:WaitForChild("HumanoidRootPart")
    end)

    -- GUI Setup
    local ScreenGui = Instance.new("ScreenGui", player.PlayerGui)
    ScreenGui.Name = "pigeonhub"
    ScreenGui.ResetOnSpawn = false

    local Frame = Instance.new("Frame", ScreenGui)
    -- increased height to make room for Auto Block + Swap Pos buttons
    Frame.Size = UDim2.new(0, 220, 0, 320)
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
    -- Increase height and enable wrapping so the longer text doesn't overflow the frame
    Title.Size = UDim2.new(1, -20, 0, 50)
    Title.Position = UDim2.new(0, 10, 0, 10)
    Title.Text = "pigeon hub teleport & auto block by gandon pigeon and h3zzo"
    Title.TextColor3 = Color3.new(1,1,1)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.BackgroundTransparency = 1
    Title.TextXAlignment = Enum.TextXAlignment.Center
    Title.TextYAlignment = Enum.TextYAlignment.Center
    Title.TextWrapped = true
 

    -- Teleport Button
    local TeleportButton = Instance.new("TextButton", Frame)
    TeleportButton.Size = UDim2.new(0, 180, 0, 50)
    TeleportButton.Position = UDim2.new(0, 20, 0, 80)
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
    KeybindButton.Position = UDim2.new(0, 20, 0, 140)
    KeybindButton.Text = "Keybind: [F]"
    KeybindButton.TextColor3 = Color3.fromRGB(0,0,0)
    KeybindButton.Font = Enum.Font.GothamBold
    KeybindButton.TextSize = 16
    KeybindButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
    KeybindButton.BorderSizePixel = 0
    Instance.new("UICorner", KeybindButton).CornerRadius = UDim.new(0, 10)

    -- Auto block state (declare here so closures below and teleportAll share the same local)
    local autoBlockEnabled = true

    -- Auto Block Toggle Button
    local AutoBlockButton = Instance.new("TextButton", Frame)
    AutoBlockButton.Size = UDim2.new(0, 180, 0, 40)
    AutoBlockButton.Position = UDim2.new(0, 20, 0, 200)
    AutoBlockButton.Text = "Auto Block: On"
    AutoBlockButton.TextColor3 = Color3.fromRGB(0,0,0)
    AutoBlockButton.Font = Enum.Font.GothamBold
    AutoBlockButton.TextSize = 14
    AutoBlockButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
    AutoBlockButton.BorderSizePixel = 0
    Instance.new("UICorner", AutoBlockButton).CornerRadius = UDim.new(0, 10)

    AutoBlockButton.MouseButton1Click:Connect(function()
        autoBlockEnabled = not autoBlockEnabled
        AutoBlockButton.Text = "Auto Block: " .. (autoBlockEnabled and "On" or "Off")
        if autoBlockEnabled then
            AutoBlockButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        else
            AutoBlockButton.BackgroundColor3 = Color3.fromRGB(200,200,200)
        end
    end)

    -- Swap Pos (Original / Alt) toggle
    local useAlt = false
    local SwapPosButton = Instance.new("TextButton", Frame)
    SwapPosButton.Size = UDim2.new(0, 180, 0, 40)
    SwapPosButton.Position = UDim2.new(0, 20, 0, 250)
    SwapPosButton.Text = "Swap Pos: Original"
    SwapPosButton.TextColor3 = Color3.fromRGB(0,0,0)
    SwapPosButton.Font = Enum.Font.GothamBold
    SwapPosButton.TextSize = 14
    SwapPosButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
    SwapPosButton.BorderSizePixel = 0
    Instance.new("UICorner", SwapPosButton).CornerRadius = UDim.new(0, 10)

    SwapPosButton.MouseButton1Click:Connect(function()
        useAlt = not useAlt
        if useAlt then
            SwapPosButton.Text = "Swap Pos: Alt"
            SwapPosButton.BackgroundColor3 = Color3.fromRGB(230,230,255)
        else
            SwapPosButton.Text = "Swap Pos: Original"
            SwapPosButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        end
    end)

    -- Saved Locations
    local spots = {
        CFrame.new(-402.18, -6.34, 131.83) * CFrame.Angles(0, math.rad(-20.08), 0),
        CFrame.new(-416.66, -6.34, -2.05) * CFrame.Angles(0, math.rad(-62.89), 0),
        CFrame.new(-329.37, -4.68, 18.12) * CFrame.Angles(0, math.rad(-30.53), 0),
    }

    -- Alternate saved locations (edit these to change the Alt positions)
    local altspots = {
        CFrame.new(-405.9963684082031, -6.4924726486206055, -35.37813186645508) * CFrame.Angles(0, math.rad(-45), 0),
        CFrame.new(-406.007568359375, -6.492473125457764, 144.4500274658203) * CFrame.Angles(0, math.rad(90), 0),
        CFrame.new(-320.0, -5.0, 30.0) * CFrame.Angles(0, math.rad(-25), 0),
    }
    local altspots = {
        CFrame.new(-405.9963684082031, -6.4924726486206055, -35.37813186645508) * CFrame.Angles(0, math.rad(-45), 0),
        CFrame.new(-406.007568359375, -6.492473125457764, 144.4500274658203) * CFrame.Angles(0, math.rad(90), 0),
        CFrame.new(-331.2776184082031, -4.843538761138916, 101.36820983886719) * CFrame.Angles(0, math.rad(-15), 0),
    }
    local REQUIRED_TOOL = "Flying Carpet"
    local teleportKey = Enum.KeyCode.F
    local waitingForKey = false
    local lastStealer = nil

    -- Equip Flying Carpet
    local function equipFlyingCarpet()
        local tool
        local startTime = tick()
        repeat
            tool = char:FindFirstChild(REQUIRED_TOOL) or backpack:FindFirstChild(REQUIRED_TOOL)
            if not tool then task.wait(0.1) end
        until tool or (tick() - startTime > 10) -- wait up to 10 seconds for the tool to appear
        if not tool then
            warn("Flying Carpet not found after 10 seconds!")
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
        -- If the player is holding a tool (not the Flying Carpet), move it to the backpack
        -- so it is effectively taken off when teleport is used.
        local currentTool = char:FindFirstChildOfClass("Tool")
        if currentTool and currentTool.Name ~= REQUIRED_TOOL then
            currentTool.Parent = backpack
            task.wait(0.1)
        end

        if not equipFlyingCarpet() then return end

        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= player then
                lastStealer = plr
                break
            end
        end

        -- choose which set of spots to use depending on Swap Pos toggle
        local chosenSpots = useAlt and altspots or spots
        for _, spot in ipairs(chosenSpots) do
            hrp.CFrame = spot
            task.wait(0.12)
        end

        if lastStealer and autoBlockEnabled then
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
