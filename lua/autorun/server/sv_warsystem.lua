-- Let the server know we're expecting the net message
util.AddNetworkString( "startRequestWar" )

net.Receive( "startRequestWar", function( len, ply )
	-- First lets check if they're actually the leader of the gang
	if table.HasValue( warConfig.teamLeaders, team.GetName( ply:Team() ) ) then
		
		-- Send a request to all the other team leaders to start a war
		for k,v in pairs( warConfig.teamLeaders ) do
			if not v == team.Getname( ply:Team() ) then
				for k,v in pairs( team.getPlayers( v ) ) do
					broadcastRequestWar( v )
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