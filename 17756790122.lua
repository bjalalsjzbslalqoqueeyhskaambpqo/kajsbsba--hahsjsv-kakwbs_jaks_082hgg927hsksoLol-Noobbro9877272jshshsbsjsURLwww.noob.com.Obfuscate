local MiniUI = loadstring(game:HttpGet("https://ui.api-x.site"))()

local ui = MiniUI:new("Hub World(Google")
local txt = ui:Sub("Mindful Mountain Mission")

spawn(function()
if game.PlaceId == 17817379634 then
local a = false
txt:TBtn("Farm Points", function()
a = not a
while a do
local args = {
    [1] = {
        [1] = {
            [1] = "\1",
            [2] = "E\254\150XC B\189\189\8a\202#yE\228",
            [3] = {
                [1] = "ShareContent",
                [2] = workspace:WaitForChild("Enemy"):WaitForChild("Enemy"),
                [3] = {
                    [1] = {
                        ["WrongAnswerMessage"] = "Watch out! Not everyone is who they say they are online!",
                        ["Type"] = "DigitalFootprint",
                        ["AppropriateAudience"] = {
                            [1] = "Family",
                            [2] = "Friend",
                            [3] = "Public"
                        },
                        ["Format"] = {
                            [1] = "I feel [POSITIVE-EMOTION-WORD] today!",
                            [2] = "What an awesome game! I feel [POSITIVE-EMOTION-WORD]! ",
                            [3] = "I\226\128\153ve been feeling [POSITIVE-EMOTION-WORD] recently.",
                            [4] = "[NAME] is so [POSITIVE-NAME-CALLING]! They always know how to make me smile."
                        },
                        ["Background"] = "rbxassetid://18217271735",
                        ["CardIcon"] = "rbxassetid://18218248270"
                    },
                    [2] = "What an awesome game! I feel great! "
                }
            }
        },
        [2] = "\7"
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("remnantsofsiren_bridgenet2@1.0.1"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
wait()
end
end)
end
txt:Btn("Claim UGC", function()
    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("UGCEvents"):WaitForChild("ClaimUGC"):FireServer()

end)

txt:Btn("TP game Mission", function()
    local args = {
    [1] = 17817379634
}

game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("TeleportRequest"):FireServer(unpack(args))
end)
end)


wait(0.7)
infoSub = ui:Sub("Info Script")
infoSub:Txt("Version: 0.1")
infoSub:Txt("Create: 03/10/24")
infoSub:Txt("Update: -/-/-")
infoSub:Btn("Link YouTube", function()
   setclipboard("https://youtube.com/@onecreatorx") 
end)

infoSub:Btn("Link Discord", function()
  setclipboard("https://discord.com/invite/UNJpdJx7c4")  
end)
 
