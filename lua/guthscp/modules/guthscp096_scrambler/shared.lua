local guthscp096_scrambler = guthscp.modules.guthscp096_scrambler

function guthscp096_scrambler.has_scrambler_equiped( ply )
	return ply:GetNWBool( "guthscp096:has_scrambler", false )
end

function guthscp096_scrambler.set_scrambler_equiped( ply, is_equiped )
	ply:SetNWBool( "guthscp096:has_scrambler", is_equiped )
end