local BackDetectionTemplate = workspace:WaitForChild("LaneSwitchDetect")-- insert the BackDetection you want to follow the player here
local BackDetection = BackDetectionTemplate:Clone()
local FrontDetection = BackDetectionTemplate:Clone()
BackDetection.Parent = workspace
FrontDetection.Parent = workspace
local player = game.Players.LocalPlayer
local speed = 40 -- set the speed at which the BackDetection will follow the player
local char = player.Character or player.CharacterAdded:wait()
local replicated = game:GetService("ReplicatedStorage")
local CantSwitch = replicated:WaitForChild("CantSwitch")
local Humanoid = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")
local DistanceBehind = 3.81


--game["Run Service"].Heartbeat:Connect(function()
--	local pos = char.HumanoidRootPart.CFrame
--	task.spawn(function()
--		task.wait(0.5)
--		BackDetection.CFrame = BackDetection.CFrame * CFrame.new(pos.X, 0, pos.Z)
--	end)
--end)
local followSpeed = 5

game:GetService("RunService").Heartbeat:Connect(function(dt)
	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end

	local targetPos = root.Position
	BackDetection.Position = BackDetection.Position:Lerp(Vector3.new(targetPos.X, targetPos.Y, targetPos.Z-3.81), followSpeed * dt)
	FrontDetection.Position = FrontDetection.Position:Lerp(Vector3.new(targetPos.X, targetPos.Y, targetPos.Z+4), followSpeed * dt)
end)

BackDetection.Touched:Connect(function(otherPart)
	if not otherPart:IsDescendantOf(char) then
		print("Back touching:", otherPart.Name)
		CantSwitch:FireServer("True1")
	end
end)

BackDetection.TouchEnded:Connect(function(otherPart)
	if not otherPart:IsDescendantOf(char) then
		print("Back stopped touching:", otherPart.Name)
		CantSwitch:FireServer("False1")
	end
end)

FrontDetection.Touched:Connect(function(otherPart)
	if not otherPart:IsDescendantOf(char) then
		print("Front touching:", otherPart.Name)
		CantSwitch:FireServer("True2")
	end
end)

FrontDetection.TouchEnded:Connect(function(otherPart)
	if not otherPart:IsDescendantOf(char) then
		print("Front stopped touching:", otherPart.Name)
		CantSwitch:FireServer("False2")
	end
end)

wait(2)
print("BackDetection class:", BackDetection.ClassName, " FrontDetection class:", FrontDetection.ClassName)
print("BackDetection parent:", BackDetection.Parent)
print("Anchored:", BackDetection.Anchored, " CanTouch:", BackDetection.CanTouch)
