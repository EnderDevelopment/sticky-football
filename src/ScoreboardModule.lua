-- ScoreboardModule.lua
local ScoreboardModule = {}
local Players = game:GetService("Players")

local scoreboard = Instance.new("Frame")
scoreboard.Name = "Scoreboard"
scoreboard.Size = UDim2.new(0, 200, 0, 300)
scoreboard.Position = UDim2.new(0.5, -100, 0.5, -150)
scoreboard.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
scoreboard.BackgroundTransparency = 0.5
scoreboard.Visible = false

local scores = {}

function ScoreboardModule:Initialize()
    -- Initialize scores for each player
    local function onPlayerAdded(player)
        scores[player] = 0
    end
    
    local function onPlayerRemoving(player)
        scores[player] = nil
    end
    
    Players.PlayerAdded:Connect(onPlayerAdded)
    Players.PlayerRemoving:Connect(onPlayerRemoving)
    
    -- Create scoreboard UI for each player
    local function updateScoreboard()
        for _, player in ipairs(Players:GetPlayers()) do
            local scoreText = scoreboard:FindFirstChild(player.Name)
            if not scoreText then
                scoreText = Instance.new("TextLabel")
                scoreText.Name = player.Name
                scoreText.Size = UDim2.new(1, 0, 0, 30)
                scoreText.Position = UDim2.new(0, 0, 0, (#Players:GetPlayers() - 1) * 30)
                scoreText.BackgroundTransparency = 1
                scoreText.TextColor3 = Color3.fromRGB(255, 255, 255)
                scoreText.Text = player.Name .. ": " .. scores[player]
                scoreText.Parent = scoreboard
            end
        end
    end
    
    Players.PlayerAdded:Connect(updateScoreboard)
    Players.PlayerRemoving:Connect(updateScoreboard)
end

function ScoreboardModule:Show()
    scoreboard.Visible = true
end

function ScoreboardModule:Hide()
    scoreboard.Visible = false
end

function ScoreboardModule:UpdateScore(player, points)
    if scores[player] then
        scores[player] = scores[player] + points
        local scoreText = scoreboard:FindFirstChild(player.Name)
        if scoreText then
            scoreText.Text = player.Name .. ": " .. scores[player]
        end
    end
end

return ScoreboardModule