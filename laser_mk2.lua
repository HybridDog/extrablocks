--license LGPLv2+, for the changes: WTFPL

local range = 10

local function round_pos(pos)
	return {x=math.floor(pos.x+0.5), y=math.floor(pos.y+0.5), z=math.floor(pos.z+0.5)}
end

local function chps(ran, m, n)
	if math.floor(ran*m+0.5) == math.floor(ran*n+0.5) then
		return true
	end
	return false
end

local function round(z, a)
	return math.floor(z*a+0.5)/a
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
	return {x1,x2, y1,y2, z1,z2}
end

local laser_shoot = function(itemstack, player, pointed_thing)
	local playerpos=player:getpos()
	local dir=player:get_look_dir()
	if pointed_thing.type=="node" then
		pos=minetest.get_pointed_thing_position(pointed_thing, above)
		local node = minetest.get_node(pos)
		if node.name~="ignore" then
			minetest.node_dig(pos,node,player)
		end
	end

	local startpos = {x=playerpos.x, y=playerpos.y+1.6, z=playerpos.z}
	local velocity = {x=dir.x*50, y=dir.y*50, z=dir.z*50}
	minetest.add_particle(startpos, dir, velocity, 1, 1, false, "extrablocks_laser_beam_mk2.png")
	minetest.sound_play("extrablocks_laser_mk2", {pos = playerpos, gain = 1.0, max_hear_distance = range})

	dir = {x=round(dir.x, 10), y=round(dir.y, 10), z=round(dir.z, 10)}
	playerpos = round_pos(playerpos)

	local straight = get_straight(dir, range)
	if straight then
		for i = -straight[1],straight[2],1 do
			for j = -straight[3],straight[4],1 do
				for k = -straight[5],straight[6],1 do
					local pos = {x=startpos.x+i, y=startpos.y+j, z=startpos.z+k}
					lazer_it(pos, player)
				end
			end
		end
		return true
	end

	local sizes = get_qdrt(dir, range)

	local xdz = dir.x/dir.z
	local zdx = dir.z/dir.x
	local xdy = dir.x/dir.y
	local ydx = dir.y/dir.x
	local zdy = dir.z/dir.y
	local ydz = dir.y/dir.z

	for i = -sizes[1],sizes[2],1 do
		for j = -sizes[3],sizes[4],1 do
			for k = -sizes[5],sizes[6],1 do
				local pos = {x=startpos.x+i, y=startpos.y+j, z=startpos.z+k}
				local ran = math.hypot(math.hypot(i,j),k)/3
				if (chps(ran, i/k, xdz) or chps(ran, k/i, zdx))
				and (chps(ran, i/j, xdy) or chps(ran, j/i, ydx))
				and (chps(ran, k/j, zdy) or chps(ran, j/k, ydz)) then
					lazer_it(pos, player)
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
		return
	end
	if player then
		minetest.node_dig(pos,node,player)
	end
end
