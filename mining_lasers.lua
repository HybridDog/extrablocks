--license LGPLv2+

local mk1_charge = 40000

local mining_lasers_list = {
--	{<num>, <range of the laser shots>, <max_charge>, (math.sqrt(1+100*(range+0.4))-1)/50},
	{"1", 7, mk1_charge, 0.52},
	{"2", 11, mk1_charge*4, 0.66},
	{"3", 30, mk1_charge*16, 1.08},
}

-- Taken from the Flowers mod by erlehmann.
local function table_contains(t, v)
	for _,i in ipairs(t) do
		if i == v then
			return true
		end
	end
	return false
end

local function laser_node(pos, player)	
	local node = minetest.get_node(pos)
	if table_contains({"air", "ignore", "default:lava_source", "default:lava_flowing"}, node.name) then
		return
	end
	if table_contains({"default:water_source", "default:water_flowing"}, node.name) then
		minetest.remove_node(pos)
		if math.random(300) == 1 then
			minetest.add_particle(pos, {x=0, y=0, z=0}, {x=0, y=0, z=0}, 0.5, 8, false, "smoke_puff.png")
		end
		return
	end
	if player then
		minetest.node_dig(pos, node, player)
	end
end

local function laser_shoot(player, range, particle_texture, particle_time, sound)
	local t1 = os.clock()

	local playerpos=player:getpos()
	local dir=player:get_look_dir()

	local startpos = {x=playerpos.x, y=playerpos.y+1.6, z=playerpos.z}
	local a = vector.multiply(dir, 50)
	local nodes = vector.line(vector.round(startpos), dir, range)

	minetest.add_particle(startpos, dir, a, particle_time, 1, false, particle_texture)
	for _,p in ipairs(nodes) do --minetest.after isn't necessary for a laser
		laser_node(p, player)
	end
	minetest.sound_play(sound, {pos = playerpos, gain = 1.0, max_hear_distance = range})

	print("[technic] <mining_laser> my shot was calculated after "..tostring(os.clock()-t1).."s")
end


for _,m in ipairs(mining_lasers_list) do
	minetest.register_tool("extrablocks:laser_mk"..m[1], {
		description = "Mining Laser MK"..m[1],
		inventory_image = "technic_mining_laser_mk"..m[1]..".png",
		stack_max = 1,
		on_use = function(itemstack, user)
			laser_shoot(user, m[2], "technic_laser_beam_mk"..m[1]..".png", m[4], "technic_laser_mk"..m[1])
		end,
	})
end
