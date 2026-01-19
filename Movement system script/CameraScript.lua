local camera = workspace.CurrentCamera
local player = game.Players.LocalPlayer
local camerahb = workspace:WaitForChild("HitBox")
local camerahbsm = workspace:WaitForChild("HitBox2")
local defaultcam = true
local Ts = game:GetService("TweenService")
local touching = {}
print(camerahb)
player.Character:WaitForChild("HumanoidRootPart")
local easeback = true

camera.CameraType = Enum.CameraType.Scriptable
camera.CameraSubject = player.Character.HumanoidRootPart
camera.CameraType = Enum.CameraType.Attach
camera.FieldOfView = 40

local speed = 3.5 -- how fast the camera eases toward target

game:GetService("RunService").RenderStepped:Connect(function(dt)
	local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if hrp and defaultcam then
		-- target position with offset
		local targetCFrame = CFrame.new(hrp.Position + Vector3.new(0,5,60), hrp.Position+ Vector3.new(0,5,0))
		-- interpolate smoothly toward the target
		camera.CFrame = camera.CFrame:Lerp(targetCFrame, dt * speed)
	end
end)

--game:GetService("RunService").Stepped:Connect(function()
--	if defaultcam then
--		if easeback then
--			local goal = {
--				CFrame = CFrame.new(player.Character.HumanoidRootPart.Position) * CFrame.new(0, 5, 60)
--			}

--			local tweeninfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
--			local tween = Ts:Create(camera, tweeninfo, goal)
--			tween:Play()
--			easeback = false
--		else
--			camera.CFrame = CFrame.new(player.Character.HumanoidRootPart.Position) * CFrame.new(0, 5, 60)
--		end
--	end
--end)

camerahb.Touched:Connect(function(hit)
	print("badwalh")
	if hit.Parent == player.Character then
		touching[player] = true
		defaultcam = false
		local goal = {}
		goal.CFrame = CFrame.new(
			Vector3.new(camerahb.Position.X, camerahb.Position.Y + 5, camerahb.Position.Z + 70),
			camerahb.Position
		)
		local tweeninfo = TweenInfo.new(
			1,
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.Out
		)
		local tween = Ts:Create(camera, tweeninfo, goal)
		tween:play()
		-- do local stuff here (like camera effects, GUI, sounds)
	end
end)
camerahb.TouchEnded:Connect(function(hit)
	if hit.Parent == player.Character then
		defaultcam = true
		easeback = true
	end
end)

camerahbsm.Touched:Connect(function(hit)
	print("badwalh")
	if hit.Parent == player.Character then
		touching[player] = true
		defaultcam = false
		local goal = {}
		goal.CFrame = CFrame.new(
			Vector3.new(camerahbsm.Position.X, camerahbsm.Position.Y - 7.5, camerahbsm.Position.Z + 15),
			camerahbsm.Position + Vector3.new(0, -7.5, 0)
		)
		local tweeninfo = TweenInfo.new(
			1,
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.Out
		)
		local tween = Ts:Create(camera, tweeninfo, goal)
		tween:play()
		-- do local stuff here (like camera effects, GUI, sounds)
	end
end)
camerahbsm.TouchEnded:Connect(function(hit)
	if hit.Parent == player.Character then
		defaultcam = true
		easeback = true
	end
end)


