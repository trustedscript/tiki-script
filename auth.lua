local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")


local CORRECT_KEY = "lol"

local DISCORD_INVITE = "https://discord.gg/UPxPuNAkq"

local TARGET_URL =
    "https://raw.githubusercontent.com/trustedscript/tiki-script/main/main.lua"

local SCRIPT_NAME = "Tiki Hub"

local function trim(text)
	return tostring(text or "")
		:gsub("^%s+", "")
		:gsub("%s+$", "")
end

local function getGuiParent()
	if type(gethui) == "function" then
		local ok, result = pcall(gethui)

		if ok and result then
			return result
		end
	end

	return CoreGui
end


pcall(function()
	local old = getGuiParent():FindFirstChild("TikiHub_Auth")

	if old then
		old:Destroy()
	end
end)

local gui = Instance.new("ScreenGui")
gui.Name = "TikiHub_Auth"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = getGuiParent()

local shadow = Instance.new("Frame")
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.Position = UDim2.new(0.5, 7, 0.5, 7)
shadow.Size = UDim2.fromOffset(394, 294)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.45
shadow.BorderSizePixel = 0
shadow.Parent = gui

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 10)
shadowCorner.Parent = shadow

local main = Instance.new("Frame")
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.fromScale(0.5, 0.5)
main.Size = UDim2.fromOffset(380, 280)
main.BackgroundColor3 = Color3.fromRGB(17, 19, 24)
main.BorderSizePixel = 0
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 9)
mainCorner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(43, 49, 64)
stroke.Thickness = 1
stroke.Transparency = 0.15
stroke.Parent = main

local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 52)
topBar.BackgroundColor3 = Color3.fromRGB(20, 23, 29)
topBar.BorderSizePixel = 0
topBar.Parent = main

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 9)
topCorner.Parent = topBar

local accent = Instance.new("Frame")
accent.Position = UDim2.fromOffset(0, 51)
accent.Size = UDim2.new(1, 0, 0, 1)
accent.BackgroundColor3 = Color3.fromRGB(84, 108, 255)
accent.BorderSizePixel = 0
accent.Parent = main

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(18, 8)
title.Size = UDim2.new(1, -36, 0, 20)
title.Font = Enum.Font.GothamBold
title.Text = SCRIPT_NAME
title.TextColor3 = Color3.fromRGB(235, 238, 245)
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

local subtitle = Instance.new("TextLabel")
subtitle.BackgroundTransparency = 1
subtitle.Position = UDim2.fromOffset(18, 29)
subtitle.Size = UDim2.new(1, -36, 0, 15)
subtitle.Font = Enum.Font.Gotham
subtitle.Text = "Key System"
subtitle.TextColor3 = Color3.fromRGB(132, 139, 154)
subtitle.TextSize = 11
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = topBar

local info = Instance.new("TextLabel")
info.BackgroundTransparency = 1
info.Position = UDim2.fromOffset(20, 72)
info.Size = UDim2.new(1, -40, 0, 40)
info.Font = Enum.Font.Gotham
info.Text = "Join our Discord, get the key and paste it below."
info.TextWrapped = true
info.TextColor3 = Color3.fromRGB(178, 184, 197)
info.TextSize = 12
info.TextXAlignment = Enum.TextXAlignment.Left
info.Parent = main

local keyBox = Instance.new("TextBox")
keyBox.Position = UDim2.fromOffset(20, 123)
keyBox.Size = UDim2.new(1, -40, 0, 40)
keyBox.BackgroundColor3 = Color3.fromRGB(23, 26, 33)
keyBox.BorderSizePixel = 0
keyBox.ClearTextOnFocus = false
keyBox.Font = Enum.Font.Code
keyBox.PlaceholderText = "Enter key..."
keyBox.PlaceholderColor3 = Color3.fromRGB(100, 107, 122)
keyBox.Text = ""
keyBox.TextColor3 = Color3.fromRGB(225, 229, 238)
keyBox.TextSize = 13
keyBox.TextXAlignment = Enum.TextXAlignment.Left
keyBox.Parent = main

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 6)
keyCorner.Parent = keyBox

local padding = Instance.new("UIPadding")
padding.PaddingLeft = UDim.new(0, 12)
padding.PaddingRight = UDim.new(0, 12)
padding.Parent = keyBox

local keyStroke = Instance.new("UIStroke")
keyStroke.Color = Color3.fromRGB(39, 44, 56)
keyStroke.Thickness = 1
keyStroke.Parent = keyBox

local getKeyButton = Instance.new("TextButton")
getKeyButton.Position = UDim2.fromOffset(20, 178)
getKeyButton.Size = UDim2.new(0.5, -25, 0, 38)
getKeyButton.BackgroundColor3 = Color3.fromRGB(35, 39, 49)
getKeyButton.AutoButtonColor = false
getKeyButton.BorderSizePixel = 0
getKeyButton.Font = Enum.Font.GothamBold
getKeyButton.Text = "GET KEY"
getKeyButton.TextColor3 = Color3.fromRGB(220, 224, 234)
getKeyButton.TextSize = 12
getKeyButton.Parent = main

local getKeyCorner = Instance.new("UICorner")
getKeyCorner.CornerRadius = UDim.new(0, 6)
getKeyCorner.Parent = getKeyButton

local checkButton = Instance.new("TextButton")
checkButton.AnchorPoint = Vector2.new(1, 0)
checkButton.Position = UDim2.new(1, -20, 0, 178)
checkButton.Size = UDim2.new(0.5, -25, 0, 38)
checkButton.BackgroundColor3 = Color3.fromRGB(70, 91, 224)
checkButton.AutoButtonColor = false
checkButton.BorderSizePixel = 0
checkButton.Font = Enum.Font.GothamBold
checkButton.Text = "CHECK KEY"
checkButton.TextColor3 = Color3.fromRGB(255, 255, 255)
checkButton.TextSize = 12
checkButton.Parent = main

local checkCorner = Instance.new("UICorner")
checkCorner.CornerRadius = UDim.new(0, 6)
checkCorner.Parent = checkButton

local status = Instance.new("TextLabel")
status.BackgroundTransparency = 1
status.Position = UDim2.fromOffset(20, 230)
status.Size = UDim2.new(1, -40, 0, 35)
status.Font = Enum.Font.Gotham
status.Text = "Click GET KEY to copy the Discord invite."
status.TextWrapped = true
status.TextColor3 = Color3.fromRGB(132, 139, 154)
status.TextSize = 11
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = main

-- Dragging
do
	local dragging = false
	local dragStart
	local startPosition

	topBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPosition = main.Position
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart

			main.Position = UDim2.new(
				startPosition.X.Scale,
				startPosition.X.Offset + delta.X,
				startPosition.Y.Scale,
				startPosition.Y.Offset + delta.Y
			)

			shadow.Position = UDim2.new(
				main.Position.X.Scale,
				main.Position.X.Offset + 7,
				main.Position.Y.Scale,
				main.Position.Y.Offset + 7
			)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)
end

getKeyButton.MouseEnter:Connect(function()
	TweenService:Create(
		getKeyButton,
		TweenInfo.new(0.12),
		{
			BackgroundColor3 = Color3.fromRGB(46, 51, 64)
		}
	):Play()
end)

getKeyButton.MouseLeave:Connect(function()
	TweenService:Create(
		getKeyButton,
		TweenInfo.new(0.12),
		{
			BackgroundColor3 = Color3.fromRGB(35, 39, 49)
		}
	):Play()
end)

checkButton.MouseEnter:Connect(function()
	TweenService:Create(
		checkButton,
		TweenInfo.new(0.12),
		{
			BackgroundColor3 = Color3.fromRGB(82, 104, 245)
		}
	):Play()
end)

checkButton.MouseLeave:Connect(function()
	TweenService:Create(
		checkButton,
		TweenInfo.new(0.12),
		{
			BackgroundColor3 = Color3.fromRGB(70, 91, 224)
		}
	):Play()
end)

getKeyButton.MouseButton1Click:Connect(function()
	local copied = pcall(function()
		if type(setclipboard) == "function" then
			setclipboard(DISCORD_INVITE)

		elseif type(toclipboard) == "function" then
			toclipboard(DISCORD_INVITE)

		else
			error("Clipboard API unavailable")
		end
	end)

	if copied then
		getKeyButton.Text = "COPIED!"
		status.Text = "Discord invite copied. Join the server and get the key."
	else
		getKeyButton.Text = "FAILED"
		status.Text = "Clipboard API is not available."
	end

	task.delay(1.5, function()
		if getKeyButton and getKeyButton.Parent then
			getKeyButton.Text = "GET KEY"
		end
	end)
end)

local busy = false

local function loadTarget(url)
    url = trim(url)

if url == "" then
        return false, "Target URL is empty."
    end

   if type(game.HttpGet) ~= "function" then
    return false, "This environment does not support game:HttpGet()."
end

    if type(loadstring) ~= "function" then
        return false, "loadstring is unavailable in this environment."
    end

    local okSource, source = pcall(function()
        return game:HttpGet(url)
    end)

    if not okSource then
        return false, "Failed to download target: " .. tostring(source)
    end

    if type(source) ~= "string" or source == "" then
        return false, "Downloaded target is empty."
    end

	if #source < 20 then
    return false, "Downloaded target is unexpectedly short."
end

    local chunk, compileError = loadstring(source)

    if type(chunk) ~= "function" then
        return false, "Target compile error: " .. tostring(compileError)
    end

    local okRun, runtimeError = pcall(chunk)

    if not okRun then
        return false, "Target runtime error: " .. tostring(runtimeError)
    end

    return true
end

local function submitKey()
	if busy then
		return
	end

	busy = true
	checkButton.Text = "CHECKING..."
	status.Text = "Checking key..."

	local enteredKey = trim(keyBox.Text)

	if enteredKey == "" then
		status.Text = "Enter your key first."
		checkButton.Text = "CHECK KEY"
		busy = false
		return
	end

	if enteredKey ~= CORRECT_KEY then
		checkButton.Text = "INVALID KEY"
		status.Text = "Invalid key. Get the correct key from Discord."

		TweenService:Create(
			keyStroke,
			TweenInfo.new(0.15),
			{
				Color = Color3.fromRGB(220, 70, 80)
			}
		):Play()

		task.wait(1.2)

		checkButton.Text = "CHECK KEY"

		TweenService:Create(
			keyStroke,
			TweenInfo.new(0.15),
			{
				Color = Color3.fromRGB(39, 44, 56)
			}
		):Play()

		busy = false
		return
	end

checkButton.Text = "LOADING..."
status.Text = "Key accepted. Loading..."

TweenService:Create(
    keyStroke,
    TweenInfo.new(0.15),
    {
        Color = Color3.fromRGB(70, 200, 120)
    }
):Play()

task.wait(0.5)

local ok, err = loadTarget(TARGET_URL)

if not ok then
    checkButton.Text = "ERROR"
    status.Text = tostring(err)
	warn("[TikiAuth] " .. tostring(err))
	print("[TikiAuth] " .. tostring(err))
    busy = false

    TweenService:Create(
        keyStroke,
        TweenInfo.new(0.15),
        {
            Color = Color3.fromRGB(220, 70, 80)
        }
    ):Play()

    return
end

gui:Destroy()
end

checkButton.MouseButton1Click:Connect(submitKey)

keyBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		submitKey()
	end
end)
