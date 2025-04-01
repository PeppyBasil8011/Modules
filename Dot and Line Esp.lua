local players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local camera = Workspace.CurrentCamera

local LineGui = Instance.new("ScreenGui")
LineGui.Parent = players.LocalPlayer.PlayerGui
LineGui.IgnoreGuiInset = false
local DotGui = Instance.new("ScreenGui")
DotGui.Parent = players.LocalPlayer.PlayerGui
DotGui.IgnoreGuiInset = false

local function DrawLine(PointA, PointB, Parent)
	local Distance = math.sqrt(math.pow(PointA.X-PointB.X, 2) + math.pow(PointA.Y-PointB.Y, 2))
	local Center = Vector2.new((PointA.X + PointB.X)/2, (PointA.Y + PointB.Y)/2)
	local Rotation = math.atan2(PointA.Y - PointB.Y, PointA.X - PointB.X)
	local LineThickness = 1

	local Line = Instance.new("Frame")
	Line.Size = UDim2.new(0, Distance, 0, LineThickness)
	Line.AnchorPoint = Vector2.new(0.5,0.5)
	Line.Position = UDim2.new(0, Center.X, 0, Center.Y)
	Line.Rotation = math.deg(Rotation)
	Line.Parent = Parent
end

function addEsp(char)
	local worldPoint = char.PrimaryPart.CFrame.Position
	local vector, onScreen = camera:WorldToScreenPoint(worldPoint)

	local screenPoint = UDim2.new(0, vector.X, 0, vector.Y)
	local screenPointVector = Vector2.new(vector.X, vector.Y)
	local depth = vector.Z

	if onScreen then
		DrawLine(workspace.CurrentCamera.ViewportSize/2, screenPointVector, LineGui)

		local frame = Instance.new("Frame")
		frame.AnchorPoint = Vector2.new(0.5, 0.5)
		frame.Size = UDim2.new(0, 500/depth, 0, 500/depth)
		frame.Parent = DotGui
		frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		frame.Position = screenPoint
		local uicorner = Instance.new("UICorner")
		uicorner.CornerRadius = UDim.new(2, 300)
		uicorner.Parent = frame
		local stroke = Instance.new("UIStroke")
		stroke.Color = Color3.fromRGB(0, 0, 0)
		stroke.Enabled = true
		stroke.Parent = frame
		stroke.Thickness = 3
		stroke.Transparency = 0
	end
end

while task.wait() do
	for i, v in LineGui:GetChildren() do
		v:Destroy()
	end
	for i, v in DotGui:GetChildren() do
		v:Destroy()
	end
	for i, v in players:GetPlayers() do
		if v.Character then
			addEsp(v.Character)
		end
	end
end
