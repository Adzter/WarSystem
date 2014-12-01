--Setup the bfont
surface.CreateFont( "warName", {
	font = "Bebas Neue", 
	size = 55, 
	weight = 500, 
	blursize = 0, 
	scanlines = 0, 
	antialias = true, 
} )
surface.CreateFont( "warDesc", {
	font = "Bebas Neue", 
	size = 25, 
	weight = 500, 
	blursize = 0, 
	scanlines = 0, 
	antialias = true, 
} )

-- Add a chat command to request a war
hook.Add( "OnPlayerChat", "war", function( ply, text, team )
	if ( string.sub( text, 1, 4 ) == "!war" ) then
		net.Start( "startRequestWar" )
		net.SendToServer()
	end
end )

-- Opens the accept/decline message once requested by the server
net.Receive( "broadcastRequestWar", function()
	showMenu()
end)

function showMenu() 
	DFrame = vgui.Create( "DFrame" )
	DFrame:SetSize( 500, 300 )
	DFrame:Center()
	DFrame:SetTitle("")
	DFrame:MakePopup()
	
	function DFrame:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 240, 240, 240 ) )
		draw.RoundedBox( 0, 0, 0, w, 25, Color( 39, 174, 96) )
		draw.SimpleText( "War System", "Trebuchet18", w/2, 3, Color(255,255,255), TEXT_ALIGN_CENTER, 0 )
		draw.SimpleText( "TECHNOBABBLEADZ", "warName", w/2, 75, Color(50,50,50), TEXT_ALIGN_CENTER, 0 )
		draw.SimpleText( "has challenged you to a war", "warDesc", w/2, 150, Color(50,50,50), TEXT_ALIGN_CENTER, 0 )
	end
	
	local acceptButton = vgui.Create( "DButton", DFrame )
	acceptButton:SetPos( 60, 220 )
	acceptButton:SetText( "" )
	acceptButton:SetSize( 180, 60 )
	acceptButton.DoClick = function()
		DFrame:Remove()
	end
	
	function acceptButton:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 39, 174, 96) )
		draw.SimpleText( "Accept", "warDesc", w/2, 20, Color(50,50,50), TEXT_ALIGN_CENTER, 0 )
	end
	
	local declineButton = vgui.Create( "DButton", DFrame )
	declineButton:SetPos( 260, 220 )
	declineButton:SetText( "" )
	declineButton:SetSize( 180, 60 )
	declineButton.DoClick = function()
		DFrame:Remove()
	end
	
	function declineButton:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 39, 174, 96) )
		draw.SimpleText( "Decline", "warDesc", w/2, 20, Color(50,50,50), TEXT_ALIGN_CENTER, 0 )
	end
end