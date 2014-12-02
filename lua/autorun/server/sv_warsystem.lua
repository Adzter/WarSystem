-- Let the server know we're expecting the net messages
util.AddNetworkString( "startRequestWar" )
util.AddNetworkString( "broadcastRequestWar" )
util.AddNetworkString( "acceptWar" )
util.AddNetworkString( "declineWar" )

-- Store the current time
local lastRequest = CurTime()
local timeout = CurTime()
local cachedRequestingTeam = nil

-- Broadcasts the request to start a war
net.Receive( "startRequestWar", function( len, ply )
	-- Make sure they can't spam by adding a cooldown
	if lastRequest < CurTime() then
	
		-- First lets check if they're actually the leader of the gang
		-- Also going to add requestingTeam as a variable to keep code cleaner
		local requestingTeam = team.GetName( ply:Team() )
		
		-- Cache this so we can refer back to it later
		cachedRequestingTeam = requestingTeam
		if table.HasValue( warConfig.teamLeaders, requestingTeam ) then
			
			-- Send a request to all the other team leaders to start a war
			for k,v in pairs( team.GetAllTeams() ) do
			
				-- Check all the teams to see if they exist in the team leaders table.
				-- A further check ensures that they aren't the requesting team
				-- since you don't request a war with yourself.
				if table.HasValue( warConfig.teamLeaders, v["Name"] ) and requestingTeam != v["Name"] then
					-- Send the broadcast request to all players
					for k,v in pairs( team.GetPlayers( k ) ) do
						-- Update the last request time and timeout
						lastRequest = CurTime() + WarConfig.requestDelay
						timeout = CurTime() + WarConfig.timeout
						broadcastRequestWar( v )
						
						-- Time out the request after 30 seconds
						timer.Simple( warConfig.timeout, warTimeout() )
					end
				end

			end

		end
	end
end)

-- Send the accept/decline message to the leader of the opposing faction
function broadcastRequestWar( leader )
	net.Start( "broadcastRequestWar" )
	net.Send( leader )
end

-- Accepts the war when the net message is received
net.Receive( "acceptWar", function( len, ply )	
	local acceptingTeam = team.GetName( ply:Team() )
	
	-- Check to see if the request is from a team leader
	if table.HasValue( warConfig.teamLeaders, acceptingTeam ) then
		
		-- We don't want the person who sent the request to accept it
		if cachedRequestingTeam == nil then return end
		if acceptingTeam == cachedRequestingTeam then return end	
			-- Add code here to start the war
	end
end)

-- Declines the war when the net message is received
net.Receive( "declineWar", function( len, ply )
	local acceptingTeam = team.GetName( ply:Team() )
	
	-- Check to see if the request is from a team leader
	if table.HasValue( warConfig.teamLeaders, acceptingTeam ) then
		
		-- We don't want the person who sent the request to accept it
		if cachedRequestingTeam == nil then return end
		if acceptingTeam == cachedRequestingTeam then return end	
			-- Add code here to decline the war
	end
end)