local load_time_start = os.clock()
--Node------------------------------------------------------------------------------------
local function orenode(name, desc)
minetest.register_node("extrablocks:"..name.."_ore", {
	description = desc,
	tiles = {"default_stone.png^extrablocks_"..name.."_ore.png"},
	groups = {cracky=3},
	drop = "extrablocks:"..name.."_lump",
	sounds = default.node_sound_stone_defaults(),
})
end

local function monode(name, desc, ligh)
minetest.register_node("extrablocks:"..name, {
	description = desc,
	tiles = {"extrablocks_"..name..".png"},
	light_source = ligh,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})
end

local STONELIKENODES = {
	{"marble_ore", "marble ore"},
	{"marble_tiling", "Tiling"},
	{"marble_clean", "marble"},
	{"lapis_lazuli_block", "lapis lazuli Block"},
	{"previous_cobble", "Previous Cobblestone"},
	{"space", "Space"},
	{"special", "Special"},
	{"onefootstep", "One Footstep"},
	{"coalblock", "Coalblock"},
	{"dried_dirt", "Dried Dirt"},
	{"wall", "Wall"},
	{"mossywall", "Mossy Wall"},
	{"stonebrick", "Alternative Stone Brick"},
	{"fokni_gneb", "Fokni Gneb"},
	{"fokni_gnebbrick", "Fokni Gneb Brick"},
}

local moss_mod = rawget(_G, "moss") and true
if moss_mod then
	minetest.register_alias("extrablocks:mossystonebrick", "default:mossystonebrick")
	minetest.register_alias("stairs:stair_extrablocks_mossystonebrick", "stairs:stair_mossystonebrick")
	minetest.register_alias("stairs:slab_extrablocks_mossystonebrick", "stairs:slab_mossystonebrick")
else
	table.insert(STONELIKENODES, {"mossystonebrick", "Mossy Stone Brick"})
end

for _,i in pairs(STONELIKENODES) do
	local name, desc = unpack(i)
	monode(name, desc, 0)
	stairs.register_stair_and_slab("extrablocks_"..name, "extrablocks:"..name,
		{cracky=3},
		{"extrablocks_"..name..".png"},
		desc.." Stair",
		desc.." Slab",
		default.node_sound_stone_defaults()
	)
end

orenode("lapis_lazuli", "lapis lazuli ore")
orenode("iringnite", "Iringnite ore")
orenode("fokni_gneb", "Fokni Gneb ore")

monode("goldbrick", "Goldbrick", 15)
monode("goldblock", "Goldblock", 15)
monode("gold", "Gold", 15)
monode("acid", "Acid", 15)

minetest.register_node("extrablocks:goldstone", {
	description = "Gold in Stone",
	tiles = {"default_stone.png^extrablocks_goldstone.png"},
	light_source = 15,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("extrablocks:iringnite_block", {
	description = "Iringnite Block",
	tiles = {"extrablocks_iringnite_block.png"},
	groups = {cracky=1,level=2},
	sounds = default.node_sound_stone_defaults({
		dig = {name="extrablocks_iringnite", gain=0.4},
	}),
})

minetest.register_node("extrablocks:invisible_path", {
	description = "APAT",
	tiles = {"extrablocks_inv_path.png"},
	groups = {cracky=1,level=2},
	use_texture_alpha = true,
})

minetest.register_abm({
	nodenames = {"extrablocks:invisible_path"},
	neighbors = {},
	interval = 50,
	chance = 1,
	action = function(pos)
		for i = -1,1,2 do
			for _,p in pairs({
				{x=pos.x, y=pos.y, z=pos.z+i},
				{x=pos.x, y=pos.y+i, z=pos.z},
				{x=pos.x+i, y=pos.y, z=pos.z},
			}) do
				local n = minetest.get_node(p).name
				if n ~= "air"
				and n ~= "extrablocks:invisible_path" then
					minetest.remove_node(pos)
					return
				end
			end
		end
	end,
})



----------------------------------------plants----------------------------------------------------------------------------
local function plantnode(name, desc, selbox)
minetest.register_node("extrablocks:"..name, {
	description = desc,
	inventory_image = "extrablocks_"..name..".png",
	tiles = {"extrablocks_"..name..".png"},
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	drawtype = "plantlike",
	paramtype = "light",
	waving = 1,
	walkable = false,
	buildable_to = true,
	selection_box = {type = "fixed",fixed = selbox},
	furnace_burntime = 1,
})
end
plantnode("wheat", "Weizen", {-1/3, -1/2, -1/3, 1/3, 1/4, 1/3})
plantnode("dry_grass", "Dry Grass", {-1/3, -1/2, -1/3, 1/3, 1/4, 1/3})

minetest.register_node("extrablocks:bush", {
	description = "Bush",
	drawtype = "nodebox",
	tiles = {"extrablocks_bush_top.png", "extrablocks_bush_bottom.png", "extrablocks_bush.png"},
	inventory_image = "extrablocks_bush.png",
	paramtype = "light",
	walkable = false,
	node_box = {
		type = "fixed",
		fixed = {
		{-1/16,	-8/16,	-1/16,	1/16,	-6/16,	1/16},
		{-4/16,	-6/16,	-4/16,	4/16,	5/16,	4/16},
		{-5/16,	-5/16,	-5/16,	5/16,	3/16,	5/16},
		{-6/16,	-4/16,	-6/16,	6/16,	2/16,	6/16},
		{-6.5/16,	-3/16,	-6.5/16,	6.5/16,	-2/16,	6.5/16},
		{-3/16,	5/16,	-3/16,	3/16,	6/16,	3/16},
		{-2/16,	5/16,	-2/16,	2/16,	7/16,	2/16},
		}
	},
	groups = {snappy=3,flammable=2,attached_node=1},
	sounds = default.node_sound_defaults(),
})
---------------------------------------------------pl-----------------------------------------------------------------

local function fencelikenode(name, desc)
local img, img2 = "extrablocks_"..name..".png", "extrablocks_fence_"..name..".png"
minetest.register_node("extrablocks:fence_"..name, {
	description = desc,
	drawtype = "fencelike",
	tiles = {img},
	inventory_image = img2,
	wield_image = img2,
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2},
})
end
fencelikenode("special", "Specialfence")
fencelikenode("repellent", "Repellent Fence")
fencelikenode("stonebrick", "Alternative Stone Brick Fence")
fencelikenode("fokni_gneb", "Fokni Gneb Fence")

local function raillikenode(name, desc)
local img = "extrablocks_"..name..".png"
minetest.register_node("extrablocks:"..name, {
	description = desc,
	drawtype = "raillike",
	tiles = {img},
	inventory_image = img,
	selection_box = {type = "fixed",fixed = {-0.5, -1/2, -0.5, 0.5, -0.45, 0.5},},
	paramtype = "light",
	walkable = false,
	groups = {oddly_breakable_by_hand=3},
})
end
raillikenode("repellent", "Repellent Covering")
raillikenode("radi", "!!!")

minetest.register_node("extrablocks:tort", {
	tiles = {"extrablocks_to_t.png", "extrablocks_to_b.png", "extrablocks_to_s2.png"},
	groups = {crumbly=2},
	drop = "extrablocks:torte 2",
	sounds = default.node_sound_dirt_defaults
})

minetest.register_node("extrablocks:torte", {
	description = "Torte",
	drawtype = "nodebox",
	tiles = {"extrablocks_to_t.png", "extrablocks_to_b.png", "extrablocks_to_s.png"},
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
	},
	groups = {crumbly=3},
	sounds = default.node_sound_dirt_defaults,
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return itemstack
		end

		local slabpos = nil
		local slabnode = nil
		local p0 = pointed_thing.under
		local p1 = pointed_thing.above
		local n0 = minetest.get_node(p0)
		if n0.name == "extrablocks:torte" and p0.y+1 == p1.y then
			slabpos = p0
			slabnode = n0
		end
		if slabpos then
			minetest.remove_node(slabpos)
			local fakestack = ItemStack("extrablocks:tort")
			pointed_thing.above = slabpos
			fakestack = minetest.item_place(fakestack, placer, pointed_thing)
			if not fakestack or fakestack:is_empty() then
				itemstack:take_item(1)
			else
				minetest.set_node(slabpos, slabnode)
			end
			return itemstack
		end

		return minetest.item_place(itemstack, placer, pointed_thing)
	end,
	
})

minetest.register_node("extrablocks:eating_chest", {
	description = "Eating Chest",
	tiles = {{name="extrablocks_eating_chest.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1.5}},
			"default_chest_top.png", "default_chest_side.png"},
	groups = {choppy=2,oddly_breakable_by_hand=2},
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", default.chest_formspec)
		meta:set_string("infotext", "Hungry Chest")
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in hungry chest at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to hungry chest at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from hungry chest at "..minetest.pos_to_string(pos))
	end,
})

minetest.register_abm({
	nodenames = {"extrablocks:eating_chest"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		local inv = minetest.get_meta(pos):get_inventory()
		for _, object in pairs(minetest.get_objects_inside_radius({x = pos.x, y = pos.y+0.5, z = pos.z}, .5)) do
			l = object:get_luaentity()
			if not object:is_player() and l and l.name == "__builtin:item" then
				item = l.itemstring
				if item ~= "" then
					if inv:room_for_item("main", item) then
						inv:add_item("main", item)
						object:remove()
						minetest.sound_play("survival_hunger_eat", {pos = pos, gain = 0.5, max_hear_distance = 10})--sounds from hungry games
						print("[extrablocks] a hungry chest "..minetest.pos_to_string(pos).." ate "..item)
					end
				end
			end
		end
	end,
})

local default_tabs = {
	{x=0, y=0, z=-1},
	{x=0, y=0, z=1},
	{x=0, y=-1, z=0},
	{x=0, y=1, z=0},
	{x=-1, y=0, z=0},
	{x=1, y=0, z=0},
}
local function get_tab(pos, func, max, tabs)
	tabs = tabs or default_tabs
	local tab = {pos}
	local tab_avoid = {[pos.x.." "..pos.y.." "..pos.z] = true}
	local tab_done,num = {pos},2
	while tab[1] do
		for n,p in pairs(tab) do
			for _,p2 in pairs(tabs) do
				local p2 = vector.add(p, p2)
				local pstr = p2.x.." "..p2.y.." "..p2.z
				if not tab_avoid[pstr]
				and func(p2) then
					tab_avoid[pstr] = true
					tab_done[num] = p2
					num = num+1
					table.insert(tab, p2)
					if max
					and num > max then
						return false
					end
				end
			end
			tab[n] = nil
		end
	end
	return tab_done, tab_avoid
end

--[[local lq_rm_count --try to avoid stack overflow
local function rm_lqud(pos, node)
	minetest.remove_node(pos)
	if lq_rm_count > 100 then
		return
	end
	lq_rm_count = lq_rm_count+1
	for i = -1,1,2 do
		for _,p in ipairs({
			{x=pos.x, y=pos.y, z=pos.z+i},
			{x=pos.x+i, y=pos.y, z=pos.z},
			{x=pos.x, y=pos.y+i, z=pos.z}
		}) do
			if minetest.get_node(p).name == node then
				rm_lqud(p, node)
			end
		end
	end
end]]

local function is_liquid(pos)
	local nd = minetest.get_node(pos).name
	for _,i in pairs({"default:water_flowing", "default:water_source", "default:lava_source", "default:lava_flowing"}) do
		if nd == i then
			return true
		end
	end
	return false
end

minetest.register_node("extrablocks:seakiller", {
	description = "Sponge",
	tiles = {"default_mese_block.png^default_glass.png"},
	drop = "",
	groups = {snappy=2, flammable=1},
	on_construct = function(pos)
		local t1 = os.clock()
		for _,p in pairs(get_tab(pos, is_liquid)) do
			minetest.remove_node(p)
		end
		--[[lq_rm_count = 0
		for _, nam in ipairs() do
			rm_lqud(pos, nam)
		end]]
		print(string.format("[extrablocks] "..minetest.pos_to_string(pos).." liquids removed after: %.2fs", os.clock() - t1))
	end
})

local nds = {
	roof = "default:stone",
	floor = "default:obsidian",
	corner = "default:tree",
	wall = "default:wood",
	glass = "default:glass",
}
local current_sn
local function is_sn(pos)
	return minetest.get_node(pos).name == current_sn
end

local anti
local function is_solid(p)
	if anti[p.x.." "..p.y.." "..p.z] then
		return true
	end
	if minetest.registered_nodes[minetest.get_node(p).name].walkable then
		return true
	end
	return false
end


-- patterns for floor etc

local pattern = {}
function pattern.roof()
	return nds.roof
end
function pattern.floor()
	return nds.floor
end
function pattern.wall()
	return nds.wall
end
function pattern.glass()
	return nds.glass
end
function pattern.corner()
	return nds.corner
end


-- tests if free space is about it

local function is_roof(pos)
	for y = 1,10 do
		local y = pos.y+y
		if is_solid({x=pos.x, y=y, z=pos.z}) then
			return false
		end
	end
	return true
end


-- searches for near nodes

local function is_floor(pos)
	for i = -1,1,2 do
		local y = pos.y+i
		if not (
			is_solid({x=pos.x+1, y=y, z=pos.z})
			and is_solid({x=pos.x-1, y=y, z=pos.z})
		)
		and not (
			is_solid({x=pos.x, y=y, z=pos.z+1})
			and is_solid({x=pos.x, y=y, z=pos.z-1})
		)
		and not is_solid({x=pos.x, y=y, z=pos.z}) then
			return true
		end
	end
	return false
end


-- corners for deco

local function is_corner(pos)
	local y = pos.y
	for i = 1,2 do
		if (
			is_solid({x=pos.x+i, y=y, z=pos.z})
			and is_solid({x=pos.x-i, y=y, z=pos.z})
		)
		or (
			is_solid({x=pos.x, y=y, z=pos.z+i})
			and is_solid({x=pos.x, y=y, z=pos.z-i})
		) then
			return false
		end
	end
	return true
end


-- wall is vertical

local function is_wall(pos)
	for i = -1,1,2 do
		for _,p in pairs({
			{x=pos.x, y=pos.y, z=pos.z+i},
			{x=pos.x+i, y=pos.y, z=pos.z},
		}) do
			if not is_solid(p) then
				return true
			end
		end
	end
	return false
end


-- glass touching the wall

local function unsolid(p)
	return not is_solid(p)
end
local function get_glass(pos, status)
	for coord,acoord in pairs({x="z", z="x"}) do
		if not is_solid({[coord]=pos[coord]-1, [acoord]=pos[acoord], y=pos.y})
		and not is_solid({[coord]=pos[coord]+1, [acoord]=pos[acoord], y=pos.y}) then
			for j = -1,1,2 do
				local p = {[coord]=pos[coord]-j, [acoord]=pos[acoord], y=pos.y}
				local g_tab = {
					{x=0, y=-1, z=0},
					{x=0, y=1, z=0},
					{[coord]=0, [acoord]=-1, y=0},
					{[coord]=0, [acoord]=1, y=0},
				}
				local free_space,ndx = get_tab(p, unsolid, 300, g_tab)
				g_tab[5] = {[coord]=0, [acoord]=-1, y=-1}
				g_tab[6] = {[coord]=0, [acoord]=1, y=-1}
				g_tab[7] = {[coord]=0, [acoord]=-1, y=1}
				g_tab[8] = {[coord]=0, [acoord]=1, y=1}
				if free_space then
					local glasss,found = {}
					for _,p in pairs(free_space) do
						local block
						for _,a in pairs(g_tab) do
							if not ndx[p.x+a.x .." "..p.y+a.y .." "..p.z+a.z] then
								block = true
								break
							end
							p[coord] = p[coord]+j
							local pstr = p.x+a.x .." "..p.y+a.y .." "..p.z+a.z
							p[coord] = p[coord]-j
							if not status[pstr]	-- avoids removing doors
							or status[pstr].typ ~= "wall" then
								block = true
								break
							end
						end
						if not block then
							p[coord] = p[coord]+j
							glasss[p.x.." "..p.y.." "..p.z] = vector.new(p)
							found = true
						end
					end
					if found then
						return glasss
					end
				end
			end
		end
	end
end


-- the node

minetest.register_node("extrablocks:house_redesignor", {
	description = "Asnh",
	tiles = {"default_mese_block.png^default_jungleleaves.png"},
	drop = "",
	groups = {snappy=2, flammable=1},
	on_place = function(_, puncher, pos)
		local t1 = os.clock()
		if not pos
		or not puncher then
			return
		end
		pos = pos.under
		current_sn = minetest.get_node(pos).name
		local ctrl = puncher:get_player_control()
		if not ctrl then
			return
		end
		if ctrl.sneak then
			if ctrl.aux1 then
				nds.wall = current_sn
			else
				nds.floor = current_sn
			end
			return
		end
		local data
		data,anti = get_tab(pos, is_sn, 3000)
		if data then
			local status = {}
			for _,p in pairs(data) do
				local no
				local pstr = p.x.." "..p.y.." "..p.z
				if is_floor(p) then
					if is_roof(p) then	-- the roof is the place where a lot air is above
						p.typ = "roof"
					else
						p.typ = "floor"
					end
				elseif is_corner(p) then
					p.typ = "corner"
				elseif is_wall(p) then
					p.typ = "wall"
				else
					no = true
				end
				if not no then
					status[pstr] = p
				end
			end
			for _,p in pairs(status) do
				if p.typ == "wall" then
					local glass = get_glass(p, status)	-- a table of positions for glass
					if glass then
						for i,gl in pairs(glass) do
							gl.typ = "glass"
							status[i] = gl
						end
					end
				end
			end
			for _,p in pairs(status) do
				minetest.set_node(p, {name=pattern[p.typ]()})
			end
		end
		print(string.format("[extrablocks] "..minetest.pos_to_string(pos).." blah blahr: %.2fs", os.clock() - t1))
	end
})

local function get_tab2d(pos, func, max)
	local count
	local tab = {pos}
	local tab_avoid = {[pos.x.." "..pos.y.." "..pos.z] = true}
	local tab_done,num = {pos},2
	while tab[1] do
		for n,p in pairs(tab) do
			for i = -1,1,2 do
				for _,p2 in pairs({
					{x=p.x+i, y=p.y, z=p.z},
					{x=p.x, y=p.y, z=p.z+i},
				}) do
					local pstr = p2.x.." "..p2.y.." "..p2.z
					if not tab_avoid[pstr]
					and func(p2) then
						tab_avoid[pstr] = true
						tab_done[num] = p2
						num = num+1
						table.insert(tab, p2)
						if max
						and num > max then
							return false
						end
					end
				end
			end
			tab[n] = nil
		end
	end
	return tab_done
end

local function is_air(pos)
	return minetest.get_node(pos).name == "air" or false
end

minetest.register_node("extrablocks:house_tidy_up", {
	description = "AUFRÄUMEN",
	tiles = {"default_wood.png^default_glass.png"},
	groups = {snappy=2},
	on_construct = function(pos)
		local t1 = os.clock()
		pos.y = pos.y+1
		local data = get_tab2d(pos, is_air, 3000)
		if data then
			for _,p in pairs(data) do
				p.y = p.y-1
				if minetest.get_node(p).name ~= "air" then
					minetest.remove_node(p)
				end
			end
		end
		--[[lq_rm_count = 0
		for _, nam in ipairs() do
			rm_lqud(pos, nam)
		end]]
		print(string.format("[extrablocks] "..minetest.pos_to_string(pos).." nodees removed after: %.2fs", os.clock() - t1))
	end
})

local lnd = "default:cobble"
minetest.register_node("extrablocks:house_floorfill", {
	description = "bodenen",
	tiles = {"default_junglewood.png^default_glass.png"},
	groups = {snappy=2},
	on_place = function(_, puncher, pos)
		local t1 = os.clock()
		if not pos
		or not puncher then
			return
		end
		local ctrl = puncher:get_player_control()
		if ctrl.sneak then
			lnd = minetest.get_node(pos.under).name
			return
		end
		local pos = pos.above
		local data = get_tab2d(pos, is_air, 3000)
		if data then
			for _,p in pairs(data) do
				minetest.set_node(p, {name=lnd})
			end
		end
		print(string.format("[extrablocks] "..minetest.pos_to_string(pos).." hole filled after: %.2fs", os.clock() - t1))
	end
})


local function moitem(name, desc)
minetest.register_craftitem("extrablocks:"..name, {
	description = desc,
	inventory_image = "extrablocks_"..name..".png",
})
end
moitem("lapis_lazuli_lump", "lapis lazuli")
moitem("sugar", "Sugar")
moitem("muffin_uncooked", "Put me into the furnace!")
moitem("iringnite_lump", "Iringnite lump")
moitem("iringnite_ingot", "Iringnite Ingot")
moitem("fokni_gneb_lump", "Fokni Gneb lump")

minetest.register_craftitem("extrablocks:muffin", {
	description = "Muffin",
	inventory_image = "extrablocks_muffin.png",
	on_use = minetest.item_eat(20),
})

local nt = {
	"default_water_source_animated.png^[verticalframe:8:1"..
		"^(default_nc_rb.png^[transformR90)"..
		"^[transformR270"..
		"^[transformFX"..
		"^[combine:16x16:16,0=default_nc_rb.png^[transformR90",
	"default_water_source_animated.png^[verticalframe:8:1"..
		"^default_nc_rb.png"..
		"^[transformFX"..
		"^[combine:16x16:0,16=default_nc_rb.png",
}

for i = 1,2 do
	nt[i] = {
		name = nt[i],
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 0.6,	-- 300ms (from nyan.cat)
		},
	}
end

minetest.override_item("default:nyancat_rainbow", {
	tiles = {nt[1], nt[1], nt[2]},
})

if moss_mod then
	moss.register_moss({
		node = "extrablocks:wall",
		result = "extrablocks:mossywall"
	})
end




local function ore(name, scarcity, num_ores, size, min, max)
	minetest.register_ore({
		ore_type	 	= "scatter",
		ore				= "extrablocks:"..name,
		wherein			= "default:stone",
		clust_scarcity 	= scarcity,
		clust_num_ores	= num_ores,
		clust_size		= size,
		height_min		= min,
		height_max		= max,
	})
end
ore("lapis_lazuli_ore", 10*10*10, 3, 10, -150, -80)
ore("lapis_lazuli_ore", 7*7*7, 3, 10, -300, -150)
ore("goldstone", 11*11*11, 4, 11, -2000, -1000)
ore("goldstone", 8*8*8, 4, 11, -31000, -2000)
ore("iringnite_ore", 40*40*40, 4, 11, -4000, -3000)
ore("iringnite_ore", 20*20*20, 4, 11, -5000, -4000)
ore("iringnite_ore", 11*11*11, 4, 11, -31000, -5000)
if not minetest.get_modpath("extrablocks") then
	minetest.register_ore({
		ore_type	 	= "sheet",
		ore				= "extrablocks:marble_ore",
		wherein			= "default:stone",
		clust_size		= 20,
		height_min		= -100,
		height_max		= -32,
		noise_params	= {offset=0, scale=1, spread={x=10, y=10, z=10}, seed=113, octaves=3, persist=0.70}
	})
	minetest.register_ore({
		ore_type	 	= "sheet",
		ore				= "extrablocks:marble_ore",
		wherein			= "default:stone",
		clust_size		= 20,
		height_min		= -100,
		height_max		= -90,
		noise_params	= {offset=0, scale=1, spread={x=10, y=10, z=10}, seed=112, octaves=3, persist=0.70}
	})
end

minetest.register_ore({
	ore_type	 	= "sheet",
	ore				= "extrablocks:fokni_gneb_ore",
	wherein			= "default:stone",
	clust_size		= 10,
	height_min		= -10000,
	height_max		= -6000,
	noise_params	= {offset=0, scale=1, spread={x=20, y=20, z=20}, seed=114, octaves=3, persist=0.70}
})


local path = minetest.get_modpath("extrablocks")

dofile(path.."/settings.lua")
if extrablocks_allow_crafting then
	dofile(path.."/crafting.lua")
end
if extrablocks_movement_stuff then
	dofile(path.."/mvmt.lua")
end
if extrablocks_tools then
	dofile(path.."/tools.lua")
end
dofile(path.."/weapons.lua")
dofile(path.."/mining_lasers.lua")
minetest.log("info", string.format("[extrablocks] loaded after ca. %.2fs", os.clock() - load_time_start))
