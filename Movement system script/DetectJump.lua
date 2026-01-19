local uis = game:GetService("UserInputService")
local replicated = game:GetService("ReplicatedStorage")
local Jump = replicated:WaitForChild("Jump")

local player = game.Players.LocalPlayer or game.Players.PlayerAdded:Wait()
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

uis.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.Space and humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
		Jump:FireServer("Start")
	end
end)

uis.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.Space then
		Jump:FireServer("End")
	end
end)

--while true do
--	print(humanoid:GetState())
--	wait(0.1)
--end