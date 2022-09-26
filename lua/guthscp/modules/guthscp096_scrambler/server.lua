local guthscp096_scrambler = guthscp.modules.guthscp096_scrambler

hook.Add( "guthscp096:should_trigger", "guthscp096:scrambler", function( target, ply )
	if guthscp096_scrambler.has_scrambler_equiped( target ) then
		return false
	end
end )

hook.Add( "PlayerSpawn", "guthscp096:scrambler", function( ply )
	guthscp096_scrambler.set_scrambler_equiped( ply, false )
end )