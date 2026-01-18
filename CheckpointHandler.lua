local Players = game:GetService("Players")
local checkpointsFolder = workspace:WaitForChild("Checkpoints")

for _, checkpoint in ipairs(checkpointsFolder:GetChildren()) do
	checkpoint.Touched:Connect(function(hit)
		local character = hit.Parent
		local humanoid = character:FindFirstChild("Humanoid")
		if not humanoid then return end
   
		local player = Players:GetPlayerFromCharacter(character)
		if not player then return end

		local stage = player.leaderstats.Stage

		local number = tonumber(checkpoint.Name:match("%d+"))
		if not number then return end 

		if stage.Value < number then
			stage.Value = number
		end
	end)
end

