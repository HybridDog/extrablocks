local gun_range = 100
local gun_prec = 7
local gun_a = 200
local gun_v = 100
local shot_delay = vector.straightdelay(gun_range, gun_v, gun_a)

local function paint(pos, pos0)
	if minetest.get_node(pos).name == "air" then
		if minetest.get_node(pos).name ~= "wool:blue" then
			local delay = vector.straightdelay(vector.distance(pos,pos0), gun_v, gun_a)
			minetest.after(delay, function(pos)
					minetest.add_node(pos, {name="wool:blue"})
				end, pos)
		end
		return true
	end
end

local function shoot(player, range, particle_texture, particle_time, sound)
	local t1 = os.clock()

	local playerpos=player:getpos()
	local dir=player:get_look_dir()

	local pos = {x=playerpos.x, y=playerpos.y+1.6, z=playerpos.z}
	local a = vector.multiply(dir, gun_a)
	local v = vector.multiply(dir, gun_v)
	local nodes = vector.fine_line(pos, dir, range, gun_prec)

	minetest.add_particle(pos, v, a, particle_time, 1, false, particle_texture)
	for i,p in ipairs(nodes) do
		if minetest.get_node(p).name ~= "air" then
			if minetest.get_node(p).name ~= "wool:blue"
			and i > 1 then
				posb = nodes[i-1]
				paint(posb, pos)
			end
			break
		end
	end
	minetest.sound_play(sound, {pos = playerpos, gain = 1.0, max_hear_distance = range})

	print("[technic] <gun> my shot was calculated after "..tostring(os.clock()-t1).."s")
end

minetest.register_tool("extrablocks:gun", {
	description = "Test Gun",
	inventory_image = "technic_mining_laser_mk3.png^[transformFY",
	stack_max = 1,
	on_use = function(itemstack, user)
		shoot(user, gun_range, "wool_blue.png", shot_delay, "extrablocks_shot")
	end,
})
