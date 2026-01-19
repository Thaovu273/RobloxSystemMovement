local Players = game:GetService("Players")
local checkpointsFolder = workspace:WaitForChild("Checkpoints")

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		local root = character:WaitForChild("HumanoidRootPart")
		local stage = player:WaitForChild("leaderstats"):WaitForChild("Stage")

		local checkpoint = checkpointsFolder:FindFirstChild("Checkpoint" .. stage.Value)
		if checkpoint then
			root.CFrame = checkpoint.CFrame + Vector3.new(0, 5, 0)
		end
	end)
end)

