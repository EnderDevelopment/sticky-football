-- ScoreboardScript.lua
local ScoreboardModule = require(game:GetService("ServerScriptService"):WaitForChild("ScoreboardModule"))

ScoreboardModule:Initialize()

local function onBallTouched(part)
    local player = game.Players:GetPlayerFromCharacter(part.Parent)
    if player then
        ScoreboardModule:UpdateScore(player, 1)
    end
end

local ball = workspace:WaitForChild("Ball")
ball.Touched:Connect(onBallTouched)