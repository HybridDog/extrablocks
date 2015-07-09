--license LGPLv2+, for the changes: WTFPL

local range = 10
local dirs = 10
local side_ran = 3
local say_laser_info = false

local function info(info)
	if say_laser_info then
		print("[extrablocks] <laser_mk2> "..info)
	end
end

local function chps(ran, m, n)
	if math.floor(ran*m+0.5) == math.floor(ran*n+0.5) then
		return true
	end
	return false
end

local function round_pos(pos, a)
	local output = {x=math.floor(pos.x*a+0.5)/a, y=math.floor(pos.y*a+0.5)/a, z=math.floor(pos.z*a+0.5)/a}
	info(dump(output).." round "..dump(a))
	return output
end

local function get_straight(dir, range)
	if dir.x == 0
	and dir.z == 0 then
		if dir.y >= 0 then
			return {0,0, 0,range, 0,0}
		end
		return {0,0, range,0, 0,0}
	end
	if dir.x == 0
	and dir.y == 0 then
		if dir.z >= 0 then
			return {0,0, 0,0, 0,range}
		end
		return {0,0, 0,0, range,0}
	end
	if dir.y == 0
	and dir.z == 0 then
		if dir.x >= 0 then
			return {0,range, 0,0, 0,0}
		end
		return {range,0, 0,0, 0,0}
	end
	return false
end

local function get_qdrt(dir)
	if dir.x >= 0 then
		x1,x2 = 0,range
	else
		x1,x2 = range,0
	end
	if dir.y >= 0 then
		y1,y2 = 0,range
	else
		y1,y2 = range,0
	end
	if dir.z >= 0 then
		z1,z2 = 0,range
	else
		z1,z2 = range,0
	end
	local output = {x1,x2, y1,y2, z1,z2}
	info(dump(output).." got_qdrt")
	return output
end

local function make_d_table(dir)
	return {
		xdz = dir.x/dir.z,
		zdx = dir.z/dir.x,
		xdy = dir.x/dir.y,
		ydx = dir.y/dir.x,
		zdy = dir.z/dir.y,
		ydz = dir.y/dir.z,
	}
end

local function allowed_pos(i, j, k, d)
	local ran = math.hypot(math.hypot(i,j),k)/side_ran
	if (chps(ran, i/k, d.xdz) or chps(ran, k/i, d.zdx))
	and (chps(ran, i/j, d.xdy) or chps(ran, j/i, d.ydx))
	and (chps(ran, k/j, d.zdy) or chps(ran, j/k, d.ydz)) then
		return true
	end
	return false
end

local function def_pos(startpos, i, j, k)
	return {x=startpos.x+i, y=startpos.y+j, z=startpos.z+k}
end

local laser_shoot = function(itemstack, player, pointed_thing)
	local playerpos=player:getpos()
	local dir=player:get_look_dir()
	if pointed_thing.type=="node" then
		pos=minetest.get_pointed_thing_position(pointed_thing, above)
		local node = minetest.get_node(pos)
		if node.name~="ignore" then
			minetest.node_dig(pos,node,player)
			info(dump(pos).." dug (pointed)")
		end
	end

	local startpos = {x=playerpos.x, y=playerpos.y+1.6, z=playerpos.z}
	local velocity = {x=dir.x*50, y=dir.y*50, z=dir.z*50}
	minetest.add_particle(startpos, dir, velocity, 1, 1, false, "extrablocks_laser_beam_mk2.png")
	minetest.sound_play("extrablocks_laser_mk2", {pos = playerpos, gain = 1.0, max_hear_distance = range})

	dir = round_pos(dir, dirs)
	playerpos = vector.round(playerpos)

	local straight = get_straight(dir, range)
	if straight then
		info("straight")
		for i = -straight[1],straight[2],1 do
			for j = -straight[3],straight[4],1 do
				for k = -straight[5],straight[6],1 do
					lazer_it(def_pos(startpos, i, j, k), player)
				end
			end
		end
		return true
	end
	info("not straight")

	local sizes = get_qdrt(dir, range)

	local d = make_d_table(dir)

	for i = -sizes[1],sizes[2],1 do
		for j = -sizes[3],sizes[4],1 do
			for k = -sizes[5],sizes[6],1 do
				if allowed_pos(i, j, k, d) then
					lazer_it(def_pos(startpos, i, j, k), player)
				end
			end
		end
	end
	return true
end


minetest.register_tool("extrablocks:laser_mk2", {
	description = "Mining Laser MK2",
	inventory_image = "extrablocks_mining_laser_mk2.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		item=itemstack:to_table()
		laser_shoot(item, user, pointed_thing)
	end,
})

function lazer_it (pos, player)
	local pos1={}
--	pos1.x=math.floor(pos.x)
--	pos1.y=math.floor(pos.y)
--	pos1.z=math.floor(pos.z)
	local node = minetest.get_node(pos)
	if node.name == "air"
	or node.name == "ignore"
	or node.name == "default:lava_source"
	or node.name == "default:lava_flowing" then
		return
	end
	if node.name == "default:water_source"
	or node.name == "default:water_flowing" then
		minetest.remove_node(pos)
		info(dump(pos).." removed")
		return
	end
	if player then
		minetest.node_dig(pos,node,player)
	end
end
