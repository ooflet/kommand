-- Kommand
-- Ooflet

local connections = {}
local settings = {
	["blur"] = "auto",
	["theme"] = "default",
	["startupScripts"] = "",
}

----------------------------------------------------------------------
-- Library Setup --
----------------------------------------------------------------------
local IsLoaded = Instance.new("BoolValue")
IsLoaded.Name = "IsLoaded"
IsLoaded.Value = false
IsLoaded.Parent = game:GetService("CoreGui")
----------------------------------------------------------------------
-- Core Setup --
----------------------------------------------------------------------
if game.CoreGui:FindFirstChild("Kommand") then
	game:GetService("StarterGui"):SetCore("DevConsoleVisible", true)
	error("Kommand is already executed!")
end

if not isfile("/kommand/config/setting.json") then
	game:GetService("StarterGui"):SetCore("DevConsoleVisible", true)
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ooflet/kommand/main/bootstrap.lua"))()
	error("Kommand is not properly installed!")
end

local function SaveSettings()
	writefile("/kommand/config/setting.json", game:GetService("HttpService"):JSONEncode(settings))
end

local function LoadSettings()
	settings = game:GetService("HttpService"):JSONDecode(readfile("/kommand/config/setting.json"))
end

if readfile("/kommand/config/setting.json") == "" then
	SaveSettings()
else
	LoadSettings()
end

----------------------------------------------------------------------
-- GUI Setup --
----------------------------------------------------------------------

local Kommand = Instance.new("ScreenGui")
local BlurEffect = Instance.new("Folder")
local ConsoleWindow = Instance.new("ImageLabel")
local Blur = Instance.new("Frame")
local TopBar = Instance.new("Frame")
local Exit = Instance.new("TextButton")
local UIPadding = Instance.new("UIPadding")
local Title = Instance.new("TextLabel")
local beta = Instance.new("TextLabel")
local betaUIPadding = Instance.new("UIPadding")
local UIPadding_2 = Instance.new("UIPadding")
local Console = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local CommandBar = Instance.new("Frame")
local CmdBarHolder = Instance.new("Frame")
local CmdBar = Instance.new("TextBox")
local EnvIndicator = Instance.new("TextLabel")

local Intro = Instance.new("Frame")
local IntroUICorner = Instance.new("UICorner")
local TextLabel = Instance.new("TextButton")

Kommand.Name = "Kommand"
if game["Run Service"]:IsStudio() then
	Kommand.Parent = game.Players.LocalPlayer.PlayerGui
else
	Kommand.Parent = game.CoreGui
end

Kommand.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Kommand.DisplayOrder = 9999999999999

Intro.Name = "Intro"
Intro.Parent = Kommand
Intro.AnchorPoint = Vector2.new(0.5, 0.5)
Intro.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Intro.BackgroundTransparency = 1.000
Intro.BorderSizePixel = 0
Intro.Position = UDim2.new(0.5, 0, 0.5, 0)
Intro.Size = UDim2.new(1, 0, 1, 0)
Intro.ZIndex = 999999999

IntroUICorner.CornerRadius = UDim.new(0, 0)
IntroUICorner.Parent = Intro

local loaded = false

repeat
	task.wait()
until IsLoaded.Value == true
IsLoaded:Destroy()

game:GetService("TweenService")
	:Create(
		Intro,
		TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
		{ BackgroundTransparency = 0, BackgroundColor3 = Color3.fromRGB(63, 63, 63), Size = UDim2.new(0, 50, 0, 50) }
	)
	:Play()
game:GetService("TweenService")
	:Create(
		IntroUICorner,
		TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
		{ CornerRadius = UDim.new(1, 0) }
	)
	:Play()

ConsoleWindow.Name = "ConsoleWindow"
ConsoleWindow.Parent = Kommand
ConsoleWindow.AnchorPoint = Vector2.new(0.5, 0.5)
ConsoleWindow.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ConsoleWindow.BackgroundTransparency = 0.1
ConsoleWindow.BorderSizePixel = 0
ConsoleWindow.Position = UDim2.new(0.5, 0, 0.5, 0)
ConsoleWindow.Size = UDim2.new(0, 800, 0, 550)
ConsoleWindow.Image = "rbxassetid://9823958365"
ConsoleWindow.ImageTransparency = 1.000
ConsoleWindow.Visible = false

Blur.Name = "Blur"
Blur.Parent = ConsoleWindow
Blur.AnchorPoint = Vector2.new(0.5, 0.5)
Blur.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Blur.BackgroundTransparency = 1.000
Blur.Position = UDim2.new(0.5, 0, 0.5, 0)
Blur.Size = UDim2.new(0, 770, 0, 520)

TopBar.Name = "TopBar"
TopBar.Parent = ConsoleWindow
TopBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TopBar.BackgroundTransparency = 1.000
TopBar.Size = UDim2.new(1, 0, 1, 0)

Exit.Name = "Exit"
Exit.Parent = TopBar
Exit.Active = false
Exit.AnchorPoint = Vector2.new(1, 0)
Exit.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Exit.BackgroundTransparency = 1.000
Exit.Position = UDim2.new(1, -10, 0, 10)
Exit.Selectable = false
Exit.Size = UDim2.new(0, 30, 0, 25)
Exit.Font = Enum.Font.GothamMedium
Exit.Text = "X"
Exit.TextColor3 = Color3.fromRGB(255, 255, 255)
Exit.TextSize = 20.000

UIPadding.Parent = Exit
UIPadding.PaddingTop = UDim.new(0, 5)

Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.Position = UDim2.new(0, 10, 0, 10)
Title.Size = UDim2.new(0, 200, 0, 25)
Title.Font = Enum.Font.GothamMedium
Title.Text = "kommand"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20.000
Title.TextXAlignment = Enum.TextXAlignment.Left

UIPadding_2.Parent = Title
UIPadding_2.PaddingLeft = UDim.new(0, 10)
UIPadding_2.PaddingRight = UDim.new(0, 10)
UIPadding_2.PaddingTop = UDim.new(0, 5)

beta.Name = "beta"
beta.Parent = TopBar
beta.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
beta.BackgroundTransparency = 1.000
beta.Position = UDim2.new(0, 105, 0, 10)
beta.Size = UDim2.new(0, 100, 0, 25)
beta.Font = Enum.Font.RobotoMono
beta.Text = "beta"
beta.TextColor3 = Color3.fromRGB(255, 255, 255)
beta.TextSize = 12.000
beta.TextXAlignment = Enum.TextXAlignment.Left
beta.TextYAlignment = Enum.TextYAlignment.Bottom

betaUIPadding.Parent = beta
betaUIPadding.PaddingLeft = UDim.new(0, 10)
betaUIPadding.PaddingRight = UDim.new(0, 10)
betaUIPadding.PaddingTop = UDim.new(0, 5)

Console.Name = "Console"
Console.Parent = ConsoleWindow
Console.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Console.BackgroundTransparency = 1.000
Console.Size = UDim2.new(1, 0, 1, 0)

CommandBar.Name = "CommandBar"
CommandBar.Parent = Console
CommandBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CommandBar.BackgroundTransparency = 1.000
CommandBar.Size = UDim2.new(1, 0, 1, 0)

CmdBarHolder.Name = "CmdBarHolder"
CmdBarHolder.Name = "CmdBar"
CmdBarHolder.Parent = CommandBar
CmdBarHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CmdBarHolder.BackgroundTransparency = 1.000
CmdBarHolder.Position = UDim2.new(0.0500000007, 0, 0.944999993, -5)
CmdBarHolder.Size = UDim2.new(0, 750, 0, 25)
CmdBarHolder.ClipsDescendants = true

CmdBar.Font = Enum.Font.RobotoMono
CmdBar.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
CmdBar.PlaceholderText = "Input Command (')"
CmdBar.Text = ""
CmdBar.TextColor3 = Color3.fromRGB(255, 255, 255)
CmdBar.TextSize = 16.000
CmdBar.TextWrapped = true
CmdBar.ClearTextOnFocus = false
CmdBar.TextXAlignment = Enum.TextXAlignment.Left

EnvIndicator.Name = "ModeIndicator"
EnvIndicator.Parent = CommandBar
EnvIndicator.Active = true
EnvIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
EnvIndicator.BackgroundTransparency = 1.000
EnvIndicator.Position = UDim2.new(0.0250000004, 0, 0.944999993, -5)
EnvIndicator.Selectable = true
EnvIndicator.Size = UDim2.new(0, 25, 0, 25)
EnvIndicator.Font = Enum.Font.RobotoMono
EnvIndicator.Text = ">"
EnvIndicator.TextColor3 = Color3.fromRGB(255, 255, 255)
EnvIndicator.TextSize = 16.000
EnvIndicator.TextXAlignment = Enum.TextXAlignment.Left

----------------------------------------------------------------------
-- Blur Setup --
----------------------------------------------------------------------

local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local camera = workspace.CurrentCamera

do
	local function IsNotNaN(x)
		return x == x
	end
	local continue = IsNotNaN(camera:ScreenPointToRay(0, 0).Origin.x)
	while not continue do
		RunService.RenderStepped:Wait()
		continue = IsNotNaN(camera:ScreenPointToRay(0, 0).Origin.x)
	end
end

local binds = {}
local root = Instance.new("Folder", camera)
root.Name = "blur"

local GenUid
do -- Generate unique names for RenderStepped bindings
	local id = 0
	function GenUid()
		id = id + 1
		return "neon::" .. tostring(id)
	end
end

local DrawQuad
do
	local acos, max, pi, sqrt = math.acos, math.max, math.pi, math.sqrt
	local sz = 0.2

	function DrawTriangle(v1, v2, v3, p0, p1) -- I think Stravant wrote this function
		local s1 = (v1 - v2).magnitude
		local s2 = (v2 - v3).magnitude
		local s3 = (v3 - v1).magnitude
		local smax = max(s1, s2, s3)
		local A, B, C
		if s1 == smax then
			A, B, C = v1, v2, v3
		elseif s2 == smax then
			A, B, C = v2, v3, v1
		elseif s3 == smax then
			A, B, C = v3, v1, v2
		end

		local para = ((B - A).x * (C - A).x + (B - A).y * (C - A).y + (B - A).z * (C - A).z) / (A - B).magnitude
		local perp = sqrt((C - A).magnitude ^ 2 - para * para)
		local dif_para = (A - B).magnitude - para

		local st = CFrame.new(B, A)
		local za = CFrame.Angles(pi / 2, 0, 0)

		local cf0 = st

		local Top_Look = (cf0 * za).lookVector
		local Mid_Point = A + CFrame.new(A, B).lookVector * para
		local Needed_Look = CFrame.new(Mid_Point, C).lookVector
		local dot = Top_Look.x * Needed_Look.x + Top_Look.y * Needed_Look.y + Top_Look.z * Needed_Look.z

		local ac = CFrame.Angles(0, 0, acos(dot))

		cf0 = cf0 * ac
		if ((cf0 * za).lookVector - Needed_Look).magnitude > 0.01 then
			cf0 = cf0 * CFrame.Angles(0, 0, -2 * acos(dot))
		end
		cf0 = cf0 * CFrame.new(0, perp / 2, -(dif_para + para / 2))

		local cf1 = st * ac * CFrame.Angles(0, pi, 0)
		if ((cf1 * za).lookVector - Needed_Look).magnitude > 0.01 then
			cf1 = cf1 * CFrame.Angles(0, 0, 2 * acos(dot))
		end
		cf1 = cf1 * CFrame.new(0, perp / 2, dif_para / 2)

		if not p0 then
			p0 = Instance.new("Part")
			p0.FormFactor = "Custom"
			p0.TopSurface = 0
			p0.BottomSurface = 0
			p0.Anchored = true
			p0.CanCollide = false
			p0.Material = "Glass"
			p0.Size = Vector3.new(sz, sz, sz)
			local mesh = Instance.new("SpecialMesh", p0)
			mesh.MeshType = 2
			mesh.Name = "WedgeMesh"
		end
		p0.WedgeMesh.Scale = Vector3.new(0, perp / sz, para / sz)
		p0.CFrame = cf0

		if not p1 then
			p1 = p0:clone()
		end
		p1.WedgeMesh.Scale = Vector3.new(0, perp / sz, dif_para / sz)
		p1.CFrame = cf1

		return p0, p1
	end

	function DrawQuad(v1, v2, v3, v4, parts)
		parts[1], parts[2] = DrawTriangle(v1, v2, v3, parts[1], parts[2])
		parts[3], parts[4] = DrawTriangle(v3, v2, v4, parts[3], parts[4])
	end
end

local function BindFrame(frame, properties)
	if binds[frame] then
		return binds[frame].parts
	end

	local uid = GenUid()
	local parts = {}
	local f = Instance.new("Folder", root)
	f.Name = frame.Name

	local parents = {} -- construct hierarchy tree for rotation
	do
		local function add(child)
			if child:IsA("GuiObject") then
				parents[#parents + 1] = child
				add(child.Parent)
			end
		end
		add(frame)
	end

	local function UpdateOrientation(fetchProps)
		local zIndex = 1 - 0.05 * frame.ZIndex
		-- the transparency inversion bug still surfaces when there's z-fighting
		local tl, br = frame.AbsolutePosition, frame.AbsolutePosition + frame.AbsoluteSize
		local tr, bl = Vector2.new(br.x, tl.y), Vector2.new(tl.x, br.y)
		do
			local rot = 0
			for _, v in ipairs(parents) do
				rot = rot + v.Rotation
			end
			if rot ~= 0 and rot % 180 ~= 0 then
				local mid = tl:lerp(br, 0.5)
				local s, c = math.sin(math.rad(rot)), math.cos(math.rad(rot))
				local vec = tl
				tl = Vector2.new(c * (tl.x - mid.x) - s * (tl.y - mid.y), s * (tl.x - mid.x) + c * (tl.y - mid.y)) + mid
				tr = Vector2.new(c * (tr.x - mid.x) - s * (tr.y - mid.y), s * (tr.x - mid.x) + c * (tr.y - mid.y)) + mid
				bl = Vector2.new(c * (bl.x - mid.x) - s * (bl.y - mid.y), s * (bl.x - mid.x) + c * (bl.y - mid.y)) + mid
				br = Vector2.new(c * (br.x - mid.x) - s * (br.y - mid.y), s * (br.x - mid.x) + c * (br.y - mid.y)) + mid
			end
		end
		DrawQuad(
			camera:ScreenPointToRay(tl.x, tl.y, zIndex).Origin,
			camera:ScreenPointToRay(tr.x, tr.y, zIndex).Origin,
			camera:ScreenPointToRay(bl.x, bl.y, zIndex).Origin,
			camera:ScreenPointToRay(br.x, br.y, zIndex).Origin,
			parts
		)
		if fetchProps then
			for _, pt in pairs(parts) do
				pt.Parent = f
			end
			for propName, propValue in pairs(properties) do
				for _, pt in pairs(parts) do
					pt[propName] = propValue
				end
			end
		end
	end

	UpdateOrientation(true)
	RunService:BindToRenderStep(uid, 2000, UpdateOrientation)

	binds[frame] = {
		uid = uid,
		parts = parts,
	}
	return binds[frame].parts
end

-- Applies the `properties` table to bound parts.

-- Removes the part binding from a gui object if one exists.
local function UnbindFrame(frame)
	local cb = binds[frame]
	if cb then
		RunService:UnbindFromRenderStep(cb.uid)
		for _, v in pairs(cb.parts) do
			v:Destroy()
		end
		binds[frame] = nil
	else
	end
end

-- Returns true if a part binding exists for the gui object.
local function HasBinding(frame)
	return binds[frame] ~= nil
end

-- Returns an array using this.
local function GetBoundParts(frame)
	return binds[frame] and binds[frame].parts
end

local function Modify(frame, properties)
	local parts = GetBoundParts(frame)
	if parts then
		for propName, propValue in pairs(properties) do
			for _, pt in pairs(parts) do
				pt[propName] = propValue
			end
		end
	else
		warn(("No part bindings exist for %s"):format(frame:GetFullName()))
	end
end

local IsGraphicsSupportBlur = true

local function UpdateGraphics()
	LoadSettings()
	local userSettings = UserSettings().GameSettings
	local qualityLevel = userSettings.SavedQualityLevel.Value
	if settings.blur == "auto" then
		if qualityLevel >= 8 then
			IsGraphicsSupportBlur = true
			ConsoleWindow.BackgroundTransparency = 0.1
			BindFrame(Blur, {
				Transparency = 0.98,
				BrickColor = BrickColor.new("Institutional white"),
			})
		else
			IsGraphicsSupportBlur = false
			ConsoleWindow.BackgroundTransparency = 0.025
			UnbindFrame(Blur)
		end
	elseif settings.blur == "true" then
		IsGraphicsSupportBlur = true
			ConsoleWindow.BackgroundTransparency = 0.1
			BindFrame(Blur, {
				Transparency = 0.98,
				BrickColor = BrickColor.new("Institutional white"),
			})
	elseif settings.blur == "false" then
		IsGraphicsSupportBlur = false
			ConsoleWindow.BackgroundTransparency = 0.025
			UnbindFrame(Blur)
	else
		LoadSettings()
		settings.blur = "auto"
	end
end

connections[#connections + 1] = UserSettings().GameSettings
	:GetPropertyChangedSignal("SavedQualityLevel")
	:Connect(function()
		UpdateGraphics()
	end)

local UIBlur = Instance.new("DepthOfFieldEffect")
UIBlur.Name = "ConsoleBlur"
UIBlur.FarIntensity = 0
UIBlur.FocusDistance = 51.6
UIBlur.InFocusRadius = 50
UIBlur.NearIntensity = 1
UIBlur.Parent = game.Lighting
game.Lighting:FindFirstChild("ConsoleBlur").Enabled = true

----------------------------------------------------------------------
-- Dragger Setup --
----------------------------------------------------------------------

local UserInputService = game:GetService("UserInputService")
local ts = game:GetService("TweenService")
local CanDrag = false
local gui = ConsoleWindow
connections[#connections + 1] = ConsoleWindow.MouseEnter:Connect(function()
	CanDrag = true
end)
connections[#connections + 1] = ConsoleWindow.MouseLeave:Connect(function()
	CanDrag = false
end)
local dragging
local dragInput
local dragStart
local startPos
local function update(input)
	local delta = input.Position - dragStart
	gui.Position =
		UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

connections[#connections + 1] = gui.InputBegan:Connect(function(input)
	if CanDrag == true then
		if
			input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch
		then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position

			connections[#connections + 1] = input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end
end)

connections[#connections + 1] = gui.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

connections[#connections + 1] = UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

----------------------------------------------------------------------
-- Console Setup --
----------------------------------------------------------------------

connections[#connections + 1] = game:GetService("UserInputService").InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.F9 then
		if Kommand.Enabled then
			game:GetService("StarterGui"):SetCore("DevConsoleVisible", false)
			Kommand.Enabled = false
			UnbindFrame(Blur)
			game.Lighting:FindFirstChild("ConsoleBlur").Enabled = false
		else
			game:GetService("StarterGui"):SetCore("DevConsoleVisible", false)
			Kommand.Enabled = true
			UpdateGraphics()
			game.Lighting:FindFirstChild("ConsoleBlur").Enabled = true
		end
	end
end)

local OutputLibrary = _G.KommandLibrary.Output

local function OutputText(Message, Type, Prefix, Color)
	OutputLibrary:OutputText(Message, Type, Prefix, Color)
end

connections[#connections + 1] = game:GetService("LogService").MessageOut:Connect(function(Message, Type)
	OutputText(Message, Type)
end)

----------------------------------------------------------------------
-- Executor Check --
----------------------------------------------------------------------

local function CheckExecutor()
	local WritefileEnabled = true
	local ReadfileEnabled = true
	local LoadstringEnabled = pcall(function()
		local a = loadstring("print('Hello world')")
	end)
	local CheckExecutor = pcall(function()
		local a = identifyexecutor()
	end)

	if CheckExecutor then
		if LoadstringEnabled then
			if WritefileEnabled then
				if ReadfileEnabled then
					return true
				else
					OutputText(
						"Executor does not support running Kommand. This function cannot run - Check FAIL (readfile)",
						Enum.MessageType.MessageError
					)
					return false
				end
			else
				OutputText(
					"Executor does not support running Kommand. This function cannot run - Check FAIL (writefile)",
					Enum.MessageType.MessageError
				)
				return false
			end
		else
			OutputText(
				"Executor does not support running Kommand. This function cannot run - Check FAIL (loadstring)",
				Enum.MessageType.MessageError
			)
			return false
		end
	else
		OutputText(
			"Executor does not support running Kommand. This function cannot run - Check FAIL (identifyexecutor)",
			Enum.MessageType.MessageError
		)
		return false
	end
end

----------------------------------------------------------------------
-- ClientLog Setup --
----------------------------------------------------------------------

local ClientLog = Instance.new("ScrollingFrame")
ClientLog.Parent = Console
ClientLog.Name = "ClientLog"
ClientLog.Active = true
ClientLog.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ClientLog.BackgroundTransparency = 1.000
ClientLog.BorderSizePixel = 0
ClientLog.Position = UDim2.new(0.025, 0, 0.065, 10)
ClientLog.Size = UDim2.new(0, 765, 0, 460)
ClientLog.CanvasSize = UDim2.new(0, 0, 0, 0)
ClientLog.AutomaticCanvasSize = Enum.AutomaticSize.Y

UIListLayout.Parent = ClientLog
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

local OriginalAbsoluteSize = ClientLog.AbsoluteCanvasSize.Y

connections[#connections + 1] = ClientLog.Changed:Connect(function(property)
	if property ~= "CanvasPosition" then
		game:GetService("TweenService")
			:Create(ClientLog, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
				CanvasPosition = Vector2.new(
					ClientLog.CanvasPosition.X,
					ClientLog.AbsoluteCanvasSize.Y - OriginalAbsoluteSize
				),
			})
			:Play()
	end
end)

----------------------------------------------------------------------
-- Command Bar Setup --
----------------------------------------------------------------------

local TextBoxIsFocused = false

connections[#connections + 1] = CmdBar.Focused:Connect(function()
	TextBoxIsFocused = true
end)

connections[#connections + 1] = CmdBar.FocusLost:Connect(function()
	TextBoxIsFocused = false
end)

local TextService = game:GetService("TextService")

local container = CmdBarHolder
container.ClipsDescendants = true

local box = CmdBar
box.BorderSizePixel = 0
box.TextXAlignment = Enum.TextXAlignment.Left
box.ClearTextOnFocus = false
box.BackgroundTransparency = 1
box.Size = UDim2.new(5, 0, 1, 0)
box.Parent = container

local PADDING = 5

local function Update()
	local reveal = container.AbsoluteSize.X
	if not box:IsFocused() or box.TextBounds.X <= reveal - 2 * PADDING then
		box:TweenPosition(UDim2.new(0, PADDING, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 0.5, true)
	else
		local cursor = box.CursorPosition
		if cursor ~= -1 then
			local subtext = string.sub(box.Text, 1, cursor - 1)
			local width = TextService:GetTextSize(subtext, box.TextSize, box.Font, Vector2.new(math.huge, math.huge)).X
			local currentCursorPos = box.Position.X.Offset + width
			if currentCursorPos < PADDING then
				box:TweenPosition(
					UDim2.fromOffset(PADDING - width, 0),
					Enum.EasingDirection.Out,
					Enum.EasingStyle.Quint,
					0.5,
					true
				)
			elseif currentCursorPos > reveal - PADDING - 1 then
				box:TweenPosition(
					UDim2.fromOffset(reveal - width - PADDING - 1, 0),
					Enum.EasingDirection.Out,
					Enum.EasingStyle.Quint,
					0.5,
					true
				)
			end
		end
	end
end

Update()

connections[#connections + 1] = box:GetPropertyChangedSignal("Text"):Connect(Update)
connections[#connections + 1] = box:GetPropertyChangedSignal("CursorPosition"):Connect(Update)
connections[#connections + 1] = box.Focused:Connect(Update)
connections[#connections + 1] = box.FocusLost:Connect(Update)

local function SearchForCommand(cmd, ignore)
	local TextboxLength = string.len(CmdBar.Text)
	local CommandLength = string.len(cmd)
	pcall(function()
		match = string.find(cmd, CmdBar.Text)
	end)
	if ignore then
		if match then
			return true
		else
			return false
		end
	else
		if CmdBar.Text == cmd then
			return true
		else
			return false
		end
	end
end

local commandHistory = {}
local currentCommandIndex = 0

connections[#connections + 1] = game:GetService("UserInputService").InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.Quote then
		task.wait(0.05)
		CmdBar:CaptureFocus()
	elseif input.KeyCode == Enum.KeyCode.Up and TextBoxIsFocused then
		currentCommandIndex = math.max(currentCommandIndex - 1, 0)
		local command = commandHistory[currentCommandIndex]
		if command then
			CmdBar.Text = command
			CmdBar.CursorPosition = #CmdBar.Text + 1
		end
	elseif input.KeyCode == Enum.KeyCode.Down and TextBoxIsFocused then
		currentCommandIndex = math.min(currentCommandIndex + 1, #commandHistory + 1)
		local command = commandHistory[currentCommandIndex] or ""
		if command then
			CmdBar.Text = command
			CmdBar.CursorPosition = #CmdBar.Text + 1
		end
	end
end)

local CurrentMode = 0
-- 0 = Lua Command Mode
-- 1 = System Command Mode
-- 2 = Help Mode
-- 3 = Special Command Mode
-- 4 = Response Mode

-- ModeCheck
connections[#connections + 1] = CmdBar.Changed:Connect(function(property)
	if CurrentMode ~= 4 then
		if SearchForCommand("*") then
			CurrentMode = 1
			EnvIndicator.Text = "*"
			CmdBar.PlaceholderText = "In system command mode."
			CmdBar.Text = ""
		elseif SearchForCommand(">") then
			CurrentMode = 0
			EnvIndicator.Text = ">"
			CmdBar.PlaceholderText = "Input Command"
			CmdBar.Text = ""
		elseif SearchForCommand("?") then
			CurrentMode = 2
			EnvIndicator.Text = "?"
			CmdBar.PlaceholderText = "In help mode."
			CmdBar.Text = ""
		elseif SearchForCommand("help") then
			CurrentMode = 2
			EnvIndicator.Text = "?"
			CmdBar.PlaceholderText = "In help mode."
		elseif SearchForCommand("!") then
			CurrentMode = 3
			EnvIndicator.Text = "!"
			CmdBar.PlaceholderText = "In special mode."
			CmdBar.Text = ""
		elseif SearchForCommand("clr") or SearchForCommand("clear") then
			CmdBar.Text = ""
			game:GetService("TweenService")
				:Create(
					ClientLog,
					TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
					{ CanvasPosition = Vector2.new(ClientLog.CanvasPosition.X, 0) }
				)
				:Play()
			for _, v in pairs(ClientLog:GetDescendants()) do
				if v:IsA("TextBox") then
					spawn(function()
						game:GetService("TweenService")
							:Create(
								v,
								TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
								{ TextTransparency = 1 }
							)
							:Play()
						task.wait(0.5)
						v:Destroy()
					end)
				end
			end
		end
	end
end)
----------------------------------------------------------------------
-- Command Setup --
----------------------------------------------------------------------
local IsLookingForResponse = false
local PreviousMode, PreviousModePrefix = nil, nil
local ResponseGiven = false
local ResponseResult = nil

local function CreateResponsePrompt(prefix)
	CmdBar.Text = ""
	PreviousMode = CurrentMode
	task.wait(0.05)
	CmdBar:CaptureFocus()
	CurrentMode = 4
	EnvIndicator.Text = "="
	IsLookingForResponse = true
	repeat
		task.wait()
	until ResponseGiven
	ResponseGiven = false
	return ResponseResult
end

local function RecieveResponsePromptResult(result)
	IsLookingForResponse = false
	ResponseGiven = true
	ResponseResult = result
	CurrentMode = PreviousMode
	if CurrentMode == 0 then
		EnvIndicator.Text = ">"
	elseif CurrentMode == 1 then
		EnvIndicator.Text = "*"
	elseif CurrentMode == 2 then
		EnvIndicator.Text = "?"
	elseif CurrentMode == 3 then
		EnvIndicator.Text = "!"
	end
end

local bar = ""
local function OutputLoadingSequence(percent, msg)
	if ClientLog:FindFirstChild("LoadingBar") then
		local TextLabel = ClientLog:FindFirstChild("LoadingBar")
		TextLabel.Text = "<b>[ " .. percent * 10 .. "% ]</b> " .. msg .. "..."
		if percent == 10 then
			TextLabel.Name = "Complete"
		end
	else
		local TextLabel = Instance.new("TextBox")
		TextLabel.Name = "LoadingBar"
		TextLabel.Parent = ClientLog
		TextLabel.AutomaticSize = Enum.AutomaticSize.Y
		TextLabel.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.Size = UDim2.new(1, 0, 0, 0)
		TextLabel.Font = Enum.Font.RobotoMono
		TextLabel.Text = "<b>[ " .. percent * 10 .. "% ]</b> " .. msg .. "..."
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.TextSize = 16.000
		TextLabel.TextWrapped = true
		TextLabel.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel.ClearTextOnFocus = false
		TextLabel.TextEditable = false
		TextLabel.RichText = true
		TextLabel.TextTransparency = 1
		game:GetService("TweenService")
			:Create(
				TextLabel,
				TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
				{ TextTransparency = 0 }
			)
			:Play()
	end
end

local dbug = {}

function dbug.SetCurrentMode(text)
	text = string.gsub(text, "setcurrentmode", "")
	text = string.gsub(text, "debug", "")
	text = string.gsub(text, " ", "")
	if text == "0" or text == "1" or text == "2" or text == "3" or text == "4" then
		OutputText("debug: set CurrentMode to " .. text, Enum.MessageType.MessageInfo)
		CurrentMode = text
	else
		OutputText("debug: " .. text .. " is not valid variable: CurrentMode", Enum.MessageType.MessageError)
	end
end

connections[#connections + 1] = CmdBar.FocusLost:Connect(function(pressed)
	if CmdBar.Text ~= "" then
		local text = CmdBar.Text
		text = string.split(text, " ")
		if pressed then
			table.insert(commandHistory, table.concat(text, " "))
			currentCommandIndex = #commandHistory + 1
			OutputText("> " .. table.concat(text, " "), Enum.MessageType.MessageOutput)
			if CurrentMode == 0 then
				CmdBar.Text = ""
				task.wait(0.05)
				CmdBar:CaptureFocus()
				if CheckExecutor() then
					local Correct, Err = pcall(function()
						local a = loadstring(table.concat(text, " "))()
					end)
					if not Correct then
						OutputText("An error occured while executing: " .. Err, Enum.MessageType.MessageError)
					end
				end
			end
			if CurrentMode == 1 then
				if text[1] == "settings" then
					if text[2] == "blur" then
						if text[3] == "true" then
							CmdBar.Text = ""
							settings.blur = "true"
							SaveSettings()
							UpdateGraphics()
							OutputText("UIBlur set to true.", "Custom", "--", Color3.fromRGB(85, 170, 255))
						elseif text[3] == "false" then
							CmdBar.Text = ""
							settings.blur = "false"
							SaveSettings()
							UpdateGraphics()
							OutputText("UIBlur set to false.", "Custom", "--", Color3.fromRGB(85, 170, 255))
						elseif text[3] == "auto" then
							CmdBar.Text = ""
							settings.blur = "auto"
							SaveSettings()
							UpdateGraphics()
							OutputText("UIBlur set to auto.", "Custom", "--", Color3.fromRGB(85, 170, 255))
						else
							OutputText(
								"Expected SettingsBlurValue, got nil/unknown.",
								Enum.MessageType.MessageWarning
							)
						end
					else
						OutputText(
							"Expected property, got nil/unknown. Type help setting to see all available settings.",
							Enum.MessageType.MessageWarning
						)
					end
				elseif text[1] == "console" then
					Kommand.Enabled = false
					UnbindFrame(Blur)
					game.Lighting:FindFirstChild("ConsoleBlur").Enabled = false
					game:GetService("StarterGui"):SetCore("DevConsoleVisible", true)
				elseif text[1] == "exit" or text[1] == "quit" then
					OutputText(
						"Are you sure you want to quit Kommand? If you would like to hide Kommand, press F9 or click the X button. [y/n]",
						Enum.MessageType.MessageWarning
					)
					if CreateResponsePrompt() then
						for _, connection in pairs(connections) do
							connection:Disconnect()
						end
						UnbindFrame(Blur)
						Kommand:Destroy()
					end
				elseif text[1] == "debug" then
					if text[2] == "setcurrentmode" then
						CurrentMode = text[3]
						OutputText("Set CurrentMode to " .. tostring(text[3]), Enum.MessageType.Info)
					end
				else
					if not IsLookingForResponse then
						OutputText(
							"Expected function, got nil/unknown. Type help to see all commands.",
							Enum.MessageType.MessageWarning
						)
					end
				end
				if text[1] == "safehop" or text[1] == "serverhop" then
					queue_on_teleport(loadstring(game:HttpGet("https://raw.githubusercontent.com/ooflet/kommand/main/bootstrap.lua"))())
					game["Teleport Service"]:Teleport(game.PlaceId)
					game.Players.LocalPlayer:Kick("Please await teleport to " .. game.PlaceId)
				end
			end
			if CurrentMode == 2 then
				if text[1] ~= "help" then
					local response
					local success, err = pcall(function()
						response = game:HttpGet("https://raw.githubusercontent.com/ooflet/docs/gh-pages/kmdhelp/"..text[1]..".txt")
					end)
					if success then
						local tagFormat = string.split(response, " ")
						if tagFormat[1] == "<redirect>" and tagFormat[3] == "</redirect>" then
							response = game:HttpGet("https://raw.githubusercontent.com/ooflet/docs/gh-pages/kmdhelp/"..tagFormat[2])
						end
						OutputText(response,
						"Custom",
						"",
						Color3.fromRGB(85, 170, 255))
					else
						OutputText("Failed to get help. Command most likely not found.", Enum.MessageType.MessageError)
					end
				else
					OutputText(
						'To see all available functions, please visit Kommand documentation at https://ooflet.github.io/docs, or type the command you would like to view help on',
						"Custom",
						"--",
						Color3.fromRGB(85, 170, 255)
					)
				end
			end
			if CurrentMode == 3 then
				if text[1] == "installfromlink" then
					_G.KommandLibrary.PackageManager:InstallFromLink(text[2])
				elseif text[1] == "install" then
					_G.KommandLibrary.PackageManager:InstallFromRepository(text[2])
				end
			end
			if IsLookingForResponse then
				if SearchForCommand("y") then
					RecieveResponsePromptResult(true)
				elseif SearchForCommand("n") then
					RecieveResponsePromptResult(false)
				else
					OutputText("Please provide a valid response ('y' or 'n')", Enum.MessageType.MessageWarning)
				end
			end
			CmdBar.Text = ""
			task.wait(0.05)
			CmdBar:CaptureFocus()
		end
	end
end)

connections[#connections + 1] = Exit.MouseButton1Click:Connect(function()
	Kommand.Enabled = false
	UnbindFrame(Blur)
	game.Lighting:FindFirstChild("ConsoleBlur").Enabled = false
end)

loaded = true
task.wait(0.75)
game:GetService("TweenService")
	:Create(
		Intro,
		TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
		{ BackgroundTransparency = 0, BackgroundColor3 = Color3.fromRGB(20, 20, 20), Size = UDim2.new(0, 550, 0, 550) }
	)
	:Play()
game:GetService("TweenService")
	:Create(
		IntroUICorner,
		TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut),
		{ CornerRadius = UDim.new(0, 0) }
	)
	:Play()
task.wait(0.5)
game:GetService("TweenService")
	:Create(
		Intro,
		TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
		{ BackgroundTransparency = 0, BackgroundColor3 = Color3.fromRGB(20, 20, 20), Size = UDim2.new(0, 800, 0, 550) }
	)
	:Play()
task.wait(0.5)
ConsoleWindow.Visible = true
UpdateGraphics()
game:GetService("TweenService")
	:Create(Intro, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), { BackgroundTransparency = 1 })
	:Play()
task.wait(1)
Intro:Destroy()
OutputText(
	'Welcome to Kommand! Type help for help.',
	"Custom",
	"--",
	Color3.fromRGB(85, 170, 255)
)
