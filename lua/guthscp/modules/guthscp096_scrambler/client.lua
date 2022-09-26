local guthscp096_scrambler = guthscp.modules.guthscp096_scrambler
local guthscp096 = guthscp.modules.guthscp096

local scramble_size = 30
local current_update_time, update_time = 0, .05
local rectangle_count, rects = 40, {}
function generate_scramble_rectangles() 
	--  clear rectangles
	rects = {}

	--  generate new ones
	for i = 1, rectangle_count do
		--  generate gray color 
		local rand = math.random( 32, 64 )

		--  generate position
		local x, y = math.random(), math.random()
		local w, h = math.Rand( .2, .8 ), math.Rand( .2, .8 )
		
		--  center exceeding bounds
		if x + w > 1 then
			x = x - .5
			--x = x - w / 2
		end
		if y + h > 1 then
			y = y - .5
			--y = y - h / 2
		end

		--  register rectangle
		rects[i] = {
			x = x, y = y,
			w = w, h = h,
			color = Color( rand, rand, rand ),
		}
	end
end

local time = 0
hook.Add( "PostPlayerDraw", "guthscp096:scrambler", function( scp )
	local ply = LocalPlayer()

	if not guthscp096_scrambler.has_scrambler_equiped( ply ) or not table.HasValue( guthscp096.get_scps_096(), scp ) then  --  TODO: not efficient, create a set of 096s
		time = 0 
		return 
	end
	
	--  get scp head
	local scp_head_id = scp:LookupBone( guthscp.configs.guthscp096.detection_head_bone )
	local scp_head_pos = scp_head_id and scp:GetBonePosition( scp_head_id ) or scp:EyePos()
	local scp_upper_head_pos = scp_head_pos + Vector( 0, 0, scramble_size )

	--  check for direct eye-contact
	if not ( ply:IsLineOfSightClear( scp_head_pos ) or ply:IsLineOfSightClear( scp_upper_head_pos ) ) then 
		time = 0
		return
	end

	--  convert pos to screen
	local screen_head_pos = scp_head_pos:ToScreen()
	local screen_upper_head_pos = scp_upper_head_pos:ToScreen()

	--debugoverlay.Cross( scp_head_pos, 1, FrameTime(), color_white, true )
	--debugoverlay.Cross( scp_upper_head_pos, 1, FrameTime(), Color( 255, 0, 0 ), true )

	--  get distance relative scale
	local size = Vector( screen_head_pos.x - screen_upper_head_pos.x, screen_head_pos.y - screen_upper_head_pos.y ):Length2D()

	--debugoverlay.Text( scp_head_pos, "scale: " .. scale, FrameTime(), false )

	--  generate scramble
	current_update_time = current_update_time - FrameTime()
	if current_update_time <= 0 then
		generate_scramble_rectangles()
		current_update_time = update_time
	end

	time = time + FrameTime()

	--  scrambles the head
	cam.Start2D()
		--  blink effect
		local t = math.abs( math.cos( time * 7 ) )
		local alpha
		if t > .75 then
			alpha = 255
		else
			alpha = 0
		end

		--  draw rectangle outline
		local outline_size = size * 1.6
		surface.SetDrawColor( Color( 255, 255, 255, alpha ) )
		surface.DrawOutlinedRect( screen_head_pos.x - outline_size / 2, screen_head_pos.y - outline_size / 2, outline_size, outline_size )

		--  draw rectangles
		for i, v in ipairs( rects ) do
			surface.SetDrawColor( v.color )
			surface.DrawRect( screen_head_pos.x - size / 2 + v.x * size, screen_head_pos.y - size / 2 + v.y * size, v.w * size, v.h * size )
		end

		--  draw text
		local offset = Vector( screen_head_pos.x, screen_head_pos.y )
		local matrix = Matrix()
		matrix:Translate( offset )
		matrix:Scale( Vector( 1, 1, 1 ) * ( size * .01 ) )
		cam.PushModelMatrix( matrix, true )
			draw.SimpleText( "SCP-096", "guthscpsnav:scp", 0, 0, Color( 255, 0, 0, alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		cam.PopModelMatrix()
	cam.End2D()
end )