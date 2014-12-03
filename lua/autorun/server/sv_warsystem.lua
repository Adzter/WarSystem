-- Let the server know we're expecting the net messages
util.AddNetworkString( "startRequestWar" )
util.AddNetworkString( "broadcastRequestWar" )
util.AddNetworkString( "acceptWar" )
util.AddNetworkString( "declineWar" )

-- Store the current time
local lastRequest = CurTime()
local cachedRequestingTeam = nil
local watingForResponse = false


hook.Add( "PlayerSay", "detectCommand", function( ply, text, team )
	if ( string.sub( text, 1, 4 ) == "!war" ) then
		startRequestWar( ply )
	end
end )

-- Broadcasts the request to start a war
function startRequestWar( ply )
	-- Make sure they can't spam by adding a cooldown
	if lastRequest < CurTime() then
	
		-- First lets check if they're actually the leader of the gang
		-- Also going to add requestingTeam as a variable to keep code cleaner
		requestingTeam = team.GetName( ply:Team() )
		
		-- Cache this so we can refer back to it later
		cachedRequestingTeam = requestingTeam
		if table.HasValue( warConfig.teamLeaders, requestingTeam ) then
			-- Send a request to all the other team leaders to start a war
			for k,v in pairs( team.GetAllTeams() ) do
			
				-- Check all the teams to see if they exist in the team leaders table.
				-- A further check ensures that they aren't the requesting team
				-- since you don't request a war with yourself.
				if table.HasValue( warConfig.teamLeaders, v["Name"] ) and v["Name"] != requestingTeam then
					-- Send the broadcast request to all players
					for k,v in pairs( team.GetPlayers( k ) ) do
					
						lastRequest = CurTime() + warConfig.requestDelay
						broadcastRequestWar( v, ply )
						waitingForResponse = true
						DarkRP.notify( ply, 0, 3, "War request sent!" )
						
						-- Time out the request after 30 seconds
						timer.Simple( warConfig.timeout, function() warTimeout() end)
						
					end
				end

			end

		end
	else
		DarkRP.notify( ply, 1, 5, "Cannot request for another: " .. math.floor( lastRequest - CurTime() ) .. " seconds" )
	end
end

-- Send the accept/decline message to the leader of the opposing faction
function broadcastRequestWar( leader, requester )
	net.Start( "broadcastRequestWar" )
		net.WriteEntity( requester )
	net.Send( leader )
end

function warTimeout()
	if not isAtWar and waitingForResponse then
	
		-- If we're not at war then let the teams know that the war was declined
		for k,v in pairs( team.GetAllTeams() ) do
			if table.HasValue( warConfig.teamLeaders, v["Name"] ) or table.HasValue( warConfig.teams, v["Name"] ) then
				for k,v in pairs( team.GetPlayers( k ) ) do
					waitingForResponse = false
					DarkRP.notify( v, 0, 3, "War declined!" )
					
					for k,v in pairs( player.GetAll() ) do
						v:SendLua( "if DFrame then DFrame:Remove() end" );
					end
				end
			end
		end
		
	end
end

-- Accepts the war when the net message is received
net.Receive( "acceptWar", function( len, ply )	
	if waitingForResponse then
		local acceptingTeam = team.GetName( ply:Team() )
		
		-- Check to see if the request is from a team leader
		if table.HasValue( warConfig.teamLeaders, acceptingTeam ) then
			
			-- We don't want the person who sent the request to accept it
			if cachedRequestingTeam == nil then return end
			if acceptingTeam == cachedRequestingTeam then return end	
			
			waitingForResponse = false
			-- Add code here to start the war
		end
	end
end)

-- Declines the war when the net message is received
net.Receive( "declineWar", function( len, ply )
	if waitingForResponse then
		local acceptingTeam = team.GetName( ply:Team() )
		
		-- Check to see if the request is from a team leader
		if table.HasValue( warConfig.teamLeaders, acceptingTeam ) then
			
			-- We don't want the person who sent the request to accept it
			if cachedRequestingTeam == nil then return end
			if acceptingTeam == cachedRequestingTeam then return end	
			
			for k,v in pairs( team.GetAllTeams() ) do
				if table.HasValue( warConfig.teamLeaders, v["Name"] ) or table.HasValue( warConfig.teams, v["Name"] ) then
					for k,v in pairs( team.GetPlayers( k ) ) do
						waitingForResponse = false
						DarkRP.notify( v, 0, 3, "War declined!" )
					end
				end
			end		
			-- Add code here to decline the war
		end
	end
end)