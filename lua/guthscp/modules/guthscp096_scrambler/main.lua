local MODULE = {
	name = "SCP-096 Scrambler",
	author = "Guthen",
	version = "1.0.0",
	description = [[Scramble the head of SCP-096 from your view for special operations]],
	icon = "guthscp/icons/scrambler.png",
	--version_url = "https://raw.githubusercontent.com/Guthen/guthscp096/update-to-guthscpbase-remaster/lua/guthscp/modules/guthscp096/main.lua",
	dependencies = {
		base = "2.0.0",
		guthscp096 = "2.0.0",
	},
	requires = {
		["shared.lua"] = guthscp.REALMS.SHARED,
		["server.lua"] = guthscp.REALMS.SERVER,
		["client.lua"] = guthscp.REALMS.CLIENT,
	},
}

guthscp.module.hot_reload( "guthscp096_scrambler" )
return MODULE