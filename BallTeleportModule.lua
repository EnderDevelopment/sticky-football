-- BallTeleportModule.lua

local BallTeleportModule = {}

local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")

local ballTag = "Ball"

function BallTeleportModule.teleportNearestBall(player)
    local character = player.Character
    if not character then return end

    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end

    local nearestBall = nil
    local shortestDistance = math.huge

    for _, ball in ipairs(CollectionService:GetTagged(ballTag)) do
        if ball:IsA("BasePart") then
            local distance = (ball.Position - rootPart.Position).magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestBall = ball
            end
        end
    end

    if nearestBall then
        nearestBall.CFrame = rootPart.CFrame + rootPart.CFrame.LookVector * 5
    end
end

return BallTeleportModule