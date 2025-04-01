local players = game:GetService("Players")

for index, player in players:GetPlayers() do
	local char = player.Character or player.CharacterAdded:Wait()
	local highlight = Instance.new("Highlight")
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.Parent = char
	print("Success")
end
	
players.PlayerAdded:Connect(function(player)
  player.CharacterAdded:Connect(function(char)
	  local highlight = Instance.new("Highlight")
	  highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	  highlight.Parent = char
	  print("Success")
  end)
end)
