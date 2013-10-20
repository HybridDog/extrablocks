--license LGPLv2+, for the changes: WTFPL

local laser_mk2_range = 10 --range of the laser shot
local r_corr = 0.25 --remove a bit more nodes (if shooting diagonal) to let it look like a hole (sth like antialiasing)
--local laser_mk2_max_charge = 40000
--technic.register_power_tool("technic:laser_mk2", laser_mk2_max_charge)

local f_1 = 0.5-r_corr
local f_2 = 0.5+r_corr

local function get_used_dir(dir)
	local abs_dir = {x=math.abs(dir.x), y=math.abs(dir.y), z=math.abs(dir.z)}
	local dir_max = math.max(abs_dir.x, abs_dir.y, abs_dir.z)
	if dir_max == abs_dir.x then
		local tab = {"x", {x=1, y=dir.y/dir.x, z=dir.z/dir.x}}
		if dir.x >= 0 then
			tab[3] = "+"
		end
		return tab
	end
	if dir_max == abs_dir.y then
		local tab = {"y", {x=dir.x/dir.y, y=1, z=dir.z/dir.y}}
		if dir.y >= 0 then
			tab[3] = "+"
		end
		return tab
	end
	local tab = {"z", {x=dir.x/dir.z, y=dir.y/dir.z, z=1}}
	if dir.z >= 0 then
		tab[3] = "+"
	end
	return tab
end

local function node_tab(z, d)
	local n1 = math.floor(z*d+f_1)
	local n2 = math.floor(z*d+f_2)
	if n1 == n2 then
		return {n1}
	end
	return {n1, n2}
end

local function lazer_nodes(pos, dir, player, range)
	local t_dir = get_used_dir(dir)
	local dir_typ = t_dir[1]
	if t_dir[3] == "+" then
		f_tab = {0, range}
	else
		f_tab = {-range,0}
	end
	local d_ch = t_dir[2]
	if dir_typ == "x" then
		for d = f_tab[1],f_tab[2],1 do
			local x = d
			local ytab = node_tab(d_ch.y, d)
			local ztab = node_tab(d_ch.z, d)
			for _,y in ipairs(ytab) do
				for _,z in ipairs(ztab) do
					lazer_it({x=pos.x+x, y=pos.y+y, z=pos.z+z}, player)
				end
			end
		end
		return
	end
	if dir_typ == "y" then
		for d = f_tab[1],f_tab[2],1 do
			local xtab = node_tab(d_ch.x, d)
			local y = d
			local ztab = node_tab(d_ch.z, d)
			for _,x in ipairs(xtab) do
				for _,z in ipairs(ztab) do
					lazer_it({x=pos.x+x, y=pos.y+y, z=pos.z+z}, player)
				end
			end
		end
		return
	end
	for d = f_tab[1],f_tab[2],1 do
		local xtab = node_tab(d_ch.x, d)
		local ytab = node_tab(d_ch.y, d)
		local z = d
		for _,x in ipairs(xtab) do
			for _,y in ipairs(ytab) do
				lazer_it({x=pos.x+x, y=pos.y+y, z=pos.z+z}, player)
			end
		end
	end
end

local function laser_shoot(player, range, particle_texture, sound)
	local t1 = os.clock()

	local playerpos=player:getpos()
	local dir=player:get_look_dir()

	local startpos = {x=playerpos.x, y=playerpos.y+1.6, z=playerpos.z}
	local a = {x=dir.x*50, y=dir.y*50, z=dir.z*50}
	minetest.add_particle(startpos, dir, a, 1, 1, false, particle_texture)
	lazer_nodes(vector.round(startpos), dir, player, range)
	minetest.sound_play(sound, {pos = playerpos, gain = 1.0, max_hear_distance = range})

	print("[extrablocks] <laser_mk2> my shot was calculated after "..tostring(os.clock()-t1).."s")
	return true --?
end


minetest.register_tool("extrablocks:laser_mk2", {
	description = "Mining Laser MK2",
	inventory_image = "extrablocks_mining_laser_mk2.png",
	stack_max = 1,
	on_use = function(itemstack, user)
		--[[local meta = get_item_meta(itemstack:get_metadata())
		if not meta or not meta.charge then
			return
		end
		if meta.charge - 400 > 0 then]]
			laser_shoot(user, laser_mk2_range, "extrablocks_laser_beam_mk2.png", "extrablocks_laser_mk2")
			--[[meta.charge = meta.charge - 400
			technic.set_RE_wear(itemstack, meta.charge, laser_mk2_max_charge)
			itemstack:set_metadata(set_item_meta(meta))
		end
		return itemstack]]
	end,
})

function lazer_it(pos, player)	
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
		if math.random(300) == 1 then
			minetest.add_particle(pos, {x=0, y=0, z=0}, {x=0, y=0, z=0}, 0.5, 8, false, "smoke_puff.png")
		end
		return
	end
	if player then
		minetest.node_dig(pos,node,player)
	end
end
