AddCSLuaFile()

--[[
 __          __     _____     _______     _______ _______ ______ __  __ 
 \ \        / /\   |  __ \   / ____\ \   / / ____|__   __|  ____|  \/  |
  \ \  /\  / /  \  | |__) | | (___  \ \_/ / (___    | |  | |__  | \  / |
   \ \/  \/ / /\ \ |  _  /   \___ \  \   / \___ \   | |  |  __| | |\/| |
    \  /\  / ____ \| | \ \   ____) |  | |  ____) |  | |  | |____| |  | |
     \/  \/_/    \_\_|  \_\ |_____/   |_| |_____/   |_|  |______|_|  |_|
                                                                        
	Created by Adzter: http://steamcommunity.com/id/imadzter
	For NPIGamers: http://npigamers.com/
	
	NOTE: I haven't tested this with more than 2 teams as
	it was only ever intended for 2 teams. In theory it 
	might work but there's probably	some hideous bugs
--]]

warConfig = {}                                     -- Don't touch this
warConfig.teams = { "Gangster", "Mafia" }          -- First and second team name
warConfig.teamLeaders = { "Mob boss", "The Don" }  -- Leader for the first and second team
warConfig.length = 2                             -- Length the war should last for
warConfig.endWhenLeaderKilled = true               -- When the leader is killed, should the war be over?
warConfig.requestDelay = 300                       -- Delay between requesting wars
warConfig.timeout = 30                             -- How long you have to accept/decline the war
warConfig.cooldownBetweenWars = 900				   -- How long after there's a war, should there be another