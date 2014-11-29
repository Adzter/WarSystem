--[[
 __          __     _____     _______     _______ _______ ______ __  __ 
 \ \        / /\   |  __ \   / ____\ \   / / ____|__   __|  ____|  \/  |
  \ \  /\  / /  \  | |__) | | (___  \ \_/ / (___    | |  | |__  | \  / |
   \ \/  \/ / /\ \ |  _  /   \___ \  \   / \___ \   | |  |  __| | |\/| |
    \  /\  / ____ \| | \ \   ____) |  | |  ____) |  | |  | |____| |  | |
     \/  \/_/    \_\_|  \_\ |_____/   |_| |_____/   |_|  |______|_|  |_|
                                                                        
	Created by Adzter: http://steamcommunity.com/id/imadzter
	For NPIGamers: http://npigamers.com/
--]]

local warConfig = {}				 -- Don't touch this
warConfig.team1 = { }				 -- First team name
warConfig.team1Leader = {}			 -- Leader for the first team
warConfig.team2 = { }			     -- Second team name
warConfig.team2Leader = {}			 -- Leader for the second team
warConfig.length = 900				 -- Length the war should last for
warConfig.endWhenLeaderKilled = true -- When the leader is killed, should the war be over?