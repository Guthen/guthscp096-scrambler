AddCSLuaFile()

ENT.Base = "guthscp_base"

ENT.PrintName = "Scrambler Googles"
ENT.Category = "GuthSCP"
ENT.Spawnable = true

ENT.Model = "models/props/scp/snav/snav.mdl"

local guthscp096_scrambler = guthscp.modules.guthscp096_scrambler
function ENT:Use( ply )
	if guthscp096_scrambler.has_scrambler_equiped( ply ) then return end

	guthscp096_scrambler.set_scrambler_equiped( ply, true )
	self:Pick()
end

if CLIENT and guthscp then
	guthscp.spawnmenu.add_entity( ENT, "General" )
end