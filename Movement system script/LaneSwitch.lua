local uis = game:GetService("UserInputService")
local replicated = game:GetService("ReplicatedStorage")
local Switch = replicated:WaitForChild("LaneSwitch")
local Ts = game:GetService("TweenService")
local player = game.Players.LocalPlayer or game.Players.PlayerAdded:Wait()
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")
local CantSwitch = replicated:WaitForChild("CantSwitch")
local canSwitch = {
	[1] = true,
	[2] = true
}

local lanes = workspace:WaitForChild("Lanes")
local laneparts = lanes:GetChildren()
table.sort(laneparts, function(a, b)
	return a.Position.Z < b.Position.Z
end)

-- function to get the closest lane index to a position
local function getClosestLaneIndex(pos)
	local closest, index = math.huge, 1
	for i, part in ipairs(laneparts) do
		local dist = (pos - part.Position).Magnitude
		if dist < closest then
			closest = dist
			index = i
		end
	end
	return index
end

-- set lane to whichever the HRP is closest to at start
lane = getClosestLaneIndex(hrp.Position)

-- function to tween using PivotTo
local function TweenPivotTo(character, targetCFrame, tweenInfo)
	-- create a dummy CFrameValue
	local cframeValue = Instance.new("CFrameValue")
	cframeValue.Value = character:GetPivot() -- starting position

	-- set up tween
	local tween = Ts:Create(cframeValue, tweenInfo, {Value = targetCFrame})

	-- when value changes, update character position
	cframeValue.Changed:Connect(function(newCFrame)
		character:PivotTo(newCFrame)
	end)

	tween:Play()
	tween.Completed:Connect(function()
		cframeValue:Destroy()
	end)
end

uis.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end

	if input.KeyCode == Enum.KeyCode.W and lane > 1 and canSwitch[2] == true then
		lane -= 1
		Switch:FireServer("back")
	elseif input.KeyCode == Enum.KeyCode.S and lane < 3 and canSwitch[1] == true then
		lane += 1
		Switch:FireServer("front")
	else
		return
	end
	print(lane)
	-- calculate new lane CFrame
	local current = character:GetPivot()
	local targetPos = Vector3.new(current.X, current.Y, laneparts[lane].Position.Z)
	local targetCFrame = CFrame.new(targetPos)

	-- smooth tween
	local tweenInfo = TweenInfo.new(0.01, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	TweenPivotTo(character, targetCFrame, tweenInfo)
end)

while wait(0.5) do
	print(canSwitch[1] , canSwitch[2])
end

CantSwitch.OnClientEvent:Connect(function(output)
	print("Found")
	if output == "True1" then
		canSwitch[1] = false
	elseif output == "False1" then
		canSwitch[1] = true
	end
	if output == "True2" then
		canSwitch[2] = false
	elseif output == "False2" then
		canSwitch[2] = true
	end
end)