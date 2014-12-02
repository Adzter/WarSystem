-- Let the server know we're expecting the net message
util.AddNetworkString( "startRequestWar" )
util.AddNetworkString( "broadcastRequestWar" )

-- Store the current time
local lastRequest = CurTime()

net.Receive( "startRequestWar", function( len, ply )
	-- Make sure they can't spam by adding a cooldown
	if lastRequest < CurTime() then
	
		-- First lets check if they're actually the leader of the gang
		-- Also going to add requestingTeam as a variable to keep code cleaner
		local requestingTeam = team.GetName( ply:Team() )
		if table.HasValue( warConfig.teamLeaders, requestingTeam ) then
			
			-- Send a request to all the other team leaders to start a war
			for k,v in pairs( team.GetAllTeams() ) do
			
				-- Check all the teams to see if they exist in the team leaders table.
				-- A further check ensures that they aren't the requesting team
				-- since you don't request a war with yourself.
				if table.HasValue( warConfig.teamLeaders, v["Name"] ) and requestingTeam != v["Name"] then
					-- Send the broadcast request to all players
					for k,v in pairs( team.GetPlayers( k ) ) do
						-- Update the last request time
						lastRequest = CurTime() + WarConfig.requestDelay
						broadcastRequestWar( v )
					end
				end

			end

		end
	end
end)

function broadcastRequestWar( leader )
	-- Send the accept/decline message to the leader of the opposing faction
	net.Start( "broadcastRequestWar" )
	net.Send( leader )
end