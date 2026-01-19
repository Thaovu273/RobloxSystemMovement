local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

local touchingOrb = false

local humanoid
local root


local function onCharacter(char)
	humanoid = char:WaitForChild("Humanoid")
	root = char:WaitForChild("HumanoidRootPart")

	local jumpFolder = workspace:WaitForChild("JumpBlocks")

	for _, block in ipairs(jumpFolder:GetChildren()) do
		local hitbox = block:FindFirstChild("Outer")
		if hitbox then

			hitbox.Touched:Connect(function(hit)
				if hit:IsDescendantOf(char) then
					touchingOrb = true
				end
			end)

			hitbox.TouchEnded:Connect(function(hit)
				if hit:IsDescendantOf(char) then
					touchingOrb = false
				end
			end)

		end
	end
end

player.CharacterAdded:Connect(onCharacter) -- when player spawns it runs the function
if player.Character then
	onCharacter(player.Character)
end

UIS.InputBegan:Connect(function(input, gpe) -- checks for when the player presses space
	if gpe then return end
	if input.KeyCode ~= Enum.KeyCode.Space then return end

	if touchingOrb and humanoid and root then
		humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		root.AssemblyLinearVelocity += Vector3.new(0, 1500,0)-- change middle value for stronger orb idk
		
	end
end)
