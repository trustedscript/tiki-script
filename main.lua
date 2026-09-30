-- MM2 Pro Cheat GUI
 
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
 
-- Wait for PlayerGui
local function waitForGui()
    while not LocalPlayer:FindFirstChild("PlayerGui") do wait() end
    return LocalPlayer.PlayerGui
end
 
local PlayerGui = waitForGui()
 
-- Prevent duplicates
if PlayerGui:FindFirstChild("MM2ProCheatGui") then
    PlayerGui.MM2ProCheatGui:Destroy()
end
 
-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MM2ProCheatGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui
 
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 280, 0, 280)
Frame.Position = UDim2.new(0.5, -140, 0.5, -140)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.Parent = ScreenGui
Frame.Active = true
Frame.Draggable = true
 
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "Tiki Verh Script"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Parent = Frame
 
local function createToggleButton(text, posY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 240, 0, 35)
    btn.Position = UDim2.new(0, 20, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 18
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Text = text..": OFF"
    btn.Parent = Frame
 
    local toggled = false
 
    btn.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            btn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
            btn.Text = text..": ON"
        else
            btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            btn.Text = text..": OFF"
        end
    end)
 
    return function() return toggled end
end
 
local walkSpeedToggle = createToggleButton("Greit begiot", 40)
local espToggle = createToggleButton("Matyt visus per sienas", 80)
local jumpPowerToggle = createToggleButton("Aukstai sokineti", 120)
local noclipToggle = createToggleButton("Vaikscioti per sienas", 160)
local infJumpToggle = createToggleButton("Begalybinis suolis", 200)
local autoKnifeToggle = createToggleButton("Automatinis zudymas is peilio", 240)
 
local defaultWalkSpeed = 16
local boostedWalkSpeed = 30
local defaultJumpPower = 50
local boostedJumpPower = 100
 
-- ESP Setup
local function createHighlight(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = player.Character.HumanoidRootPart
        if not hrp:FindFirstChild("ESPHighlight") then
            local highlight = Instance.new("BoxHandleAdornment")
            highlight.Name = "ESPHighlight"
            highlight.Adornee = hrp
            highlight.AlwaysOnTop = true
            highlight.ZIndex = 10
            highlight.Size = Vector3.new(4, 6, 2)
            highlight.Color3 = Color3.fromRGB(255, 0, 0)
            highlight.Transparency = 0.5
            highlight.Parent = hrp
        end
    end
end
 
local function removeHighlight(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = player.Character.HumanoidRootPart
        local highlight = hrp:FindFirstChild("ESPHighlight")
        if highlight then highlight:Destroy() end
    end
end
 
-- Noclip Functions
local function noclipEnable()
    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide == true then
                part.CanCollide = false
            end
        end
    end
end
 
local function noclipDisable()
    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide == false then
                part.CanCollide = true
            end
        end
    end
end
 
-- Infinite Jump (connect once)
local infJumpConnection
UserInputService.JumpRequest:Connect(function()
    if infJumpToggle() and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)
 
-- Auto Knife Function
local function getNearestPlayer(maxDist)
    local nearestPlayer = nil
    local nearestDist = maxDist or 10
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return nil end
    local lpPos = LocalPlayer.Character.HumanoidRootPart.Position
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (player.Character.HumanoidRootPart.Position - lpPos).Magnitude
            if dist < nearestDist then
                nearestDist = dist
                nearestPlayer = player
            end
        end
    end
    return nearestPlayer, nearestDist
end
 
local function autoKnife()
    local knifeTool = LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool") or LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
    if not knifeTool then return end
    local target, dist = getNearestPlayer(10)
    if target and dist <= 10 then
        if not LocalPlayer.Character:FindFirstChild(knifeTool.Name) then
            LocalPlayer.Character.Humanoid:EquipTool(knifeTool)
        end
        knifeTool:Activate()
    end
end
 
-- Main loop
RunService.Heartbeat:Connect(function()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then return end
    local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
 
    -- WalkSpeed fix: set every frame if toggled ON
    if walkSpeedToggle() then
        if humanoid.WalkSpeed ~= boostedWalkSpeed then
            humanoid.WalkSpeed = boostedWalkSpeed
        end
    else
        if humanoid.WalkSpeed ~= defaultWalkSpeed then
            humanoid.WalkSpeed = defaultWalkSpeed
        end
    end
 
    -- JumpPower toggle
    if jumpPowerToggle() then
        if humanoid.JumpPower ~= boostedJumpPower then
            humanoid.JumpPower = boostedJumpPower
        end
    else
        if humanoid.JumpPower ~= defaultJumpPower then
            humanoid.JumpPower = defaultJumpPower
        end
    end
 
    -- ESP toggle
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if espToggle() then
                createHighlight(player)
            else
                removeHighlight(player)
            end
        end
    end
 
    -- NoClip toggle
    if noclipToggle() then
        noclipEnable()
    else
        noclipDisable()
    end
 
    -- Auto Knife toggle
    if autoKnifeToggle() then
        autoKnife()
    end
end)
 
-- Clean highlights on player leave
Players.PlayerRemoving:Connect(removeHighlight)
 
-- Clean highlights on character added
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        removeHighlight(player)
    end)
end)
 
-- Reset on respawn
LocalPlayer.CharacterAdded:Connect(function(character)
    wait(1)
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.WalkSpeed = defaultWalkSpeed
    humanoid.JumpPower = defaultJumpPower
    noclipDisable()
end)