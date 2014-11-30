-- Add a chat command to request a war
hook.Add( "PlayerSay", "war", function( ply, text, _ )
	if ( string.sub( string.lower( text ), 1, 4 ) == "!war" ) then
		requestWar()
	end
end

-- Sends the request to the server to start the war
local function requestWar()
	net.Start( "startRequestWar" )
	net.SendToServer()
end

-- Opens the accept/decline message once requested by the server
net.Receive( "broadcastRequestWar", function()
	-- TODO: Add in code here to show the menu
end)