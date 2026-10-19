-- AutoStickyModule.lua

local AutoStickyModule = {}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local pullPower = 100
local stickiness = 50

function AutoStickyModule.setPullPower(value)
    pullPower = value
end

function AutoStickyModule.setStickiness(value)
    stickiness = value
end

local function findNearestPerson(character)
    local nearestPerson = nil
    local shortestDistance = math.huge

    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character and player.Character ~= character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - character.HumanoidRootPart.Position).magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestPerson = player.Character
            end
        end
    end

    return nearestPerson
end

local function applyPullForce(character, target)
    if character:FindFirstChild("HumanoidRootPart") and target:FindFirstChild("HumanoidRootPart") then
        local direction = (target.HumanoidRootPart.Position - character.HumanoidRootPart.Position).unit
        local force = direction * pullPower
        character.HumanoidRootPart.Velocity = force
    end
end

local function handleAutoSticky(character)
    local nearestPerson = findNearestPerson(character)
    if nearestPerson then
        applyPullForce(character, nearestPerson)
    end
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        local rootPart = character:WaitForChild("HumanoidRootPart")

        local connection
        connection = RunService.Heartbeat:Connect(function()
            if humanoid:GetState() == Enum.HumanoidStateType.Running or humanoid:GetState() == Enum.HumanoidStateType.Walking then
                handleAutoSticky(character)
            end
        end)

        character.AncestryChanged:Connect(function(_, parent)
            if not parent then
                connection:Disconnect()
            end
        end)
    end)
end)

return AutoStickyModule