local SOUND = default.node_sound_stone_defaults()
local A = 190,
--Crafting--------------------
minetest.register_craft({
	output = "extrablocks:coalblock",
	recipe = {
		{"default:coal_lump","default:coal_lump","default:coal_lump"},
		{"default:coal_lump","default:coal_lump","default:coal_lump"},
		{"default:coal_lump","default:coal_lump","default:coal_lump"},
	}
})

minetest.register_craft({
	output = "extrablocks:rinde 4",
	recipe = {
		{"default:tree","default:tree"},
		{"default:tree","default:tree"},
	}
})

minetest.register_craft({
	output = "extrablocks:zucker",
	recipe = {
		{"default:papyrus", "default:papyrus"},
	}
})

--Node------------------------------------------------------------------------------------
local function orenode(name, drops, desc)
minetest.register_node("extrablocks:"..name.."_ore", {
	description = desc,
	tile_images = {"default_stone.png^extrablocks_"..name.."_ore.png"},
	groups = {cracky=3},
	drop = drops,
	sounds = default.node_sound_stone_defaults(),
})
end

local function monode(name, desc, ligh)
minetest.register_node("extrablocks:"..name, {
	description = desc,
	tile_images = {"extrablocks_"..name..".png"},
	light_source = ligh,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})
end

local function stonelikenode(name, desc)
monode(name, desc, default.node_sound_stone_defaults(), 0)
end

stonelikenode("marble_ore", "Marble Ore")
stonelikenode("marble_tiling", "Tiling")
stonelikenode("marble_clean", "Marble")

orenode("lapis_lazuli", "extrablocks:lapis_lazuli_lump", "Lapis Lazuli Ore")
stonelikenode("lapis_lazuli_block", "Lapis Lazuli Block")

stonelikenode("previous_cobble", "Previous Cobblestone")
stonelikenode("space", "Space")
stonelikenode("special", "special")
stonelikenode("onefootstep", "One Footstep")
stonelikenode("coalblock", "Coalblock")
stonelikenode("dried_dirt", "Dried Dirt")
stonelikenode("wall", "Wall")
stonelikenode("mossywall", "Mossy Wall")
stonelikenode("mossystonebrick", "Mossy Stone Brick")
stonelikenode("stonebrick", "Alternative Stone Brick")

monode("goldbrick", "Goldbrick", 15)
monode("goldblock", "Goldblock", 15)
monode("gold", "Gold", 15)
monode("acid", "Acid", 15)

minetest.register_node("extrablocks:goldstone", {
	description = "Gold in Stone",
	tile_images = {"default_stone.png^extrablocks_goldstone.png"},
	light_source = 15,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})


----------------------------------------plants----------------------------------------------------------------------------
local function plantnode(name, desc, selbox)
minetest.register_node("extrablocks:"..name, {
	description = desc,
	tile_images = {"extrablocks_"..name..".png"},
	groups = {fleshy=3,flammable=2},
	sounds = default.node_sound_leaves_defaults(),
	drawtype = "plantlike",
	paramtype = "light",
	walkable = false,
	selection_box = {type = "fixed",fixed = selbox},
})
end
plantnode("wheat", "Weizen", {-1/3, -1/2, -1/3, 1/3, 1/4, 1/3})
plantnode("dry_grass", "Dry Grass", {-1/3, -1/2, -1/3, 1/3, 1/4, 1/3})
---------------------------------------------------pl-----------------------------------------------------------------

local KORB = {
	type = "fixed",
	fixed = {
			{-0.5,	-0.5,	-0.5,		0.5,	-0.49,	0.5},
			{-0.5,	-0.5,	-0.5,		-0.49,	0.5,	0.5},
			{-0.5,	-0.5,	-0.5,		0.5,	0.5,	-0.49},
			{-0.5,	-0.5,	0.49,		0.5,	0.5,	0.5},
			{0.49,	-0.5,	-0.5,		0.5,	0.5,	0.5},
		},
	}

minetest.register_node("extrablocks:pot", {
	description = "Pot",
	drawtype = "nodebox",
	tile_images = {"extrablocks_repellent.png"},
	groups = {cracky=1},
	sounds = SOUND,
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = KORB,
	selection_box = KORB,
	sounds = SOUND,
})

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

local function raillikenode(name, desc)
local img = "extrablocks_"..name..".png"
minetest.register_node("extrablocks:"..name, {
	description = desc,
	drawtype = "raillike",
	tile_images = {img},
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
	tile_images = {"extrablocks_to_t.png", "extrablocks_to_b.png", "extrablocks_to_s2.png"},
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
		local n0 = minetest.env:get_node(p0)
		if n0.name == "extrablocks:torte" and p0.y+1 == p1.y then
			slabpos = p0
			slabnode = n0
		end
		if slabpos then
			minetest.env:remove_node(slabpos)
			local fakestack = ItemStack("extrablocks:tort")
			pointed_thing.above = slabpos
			fakestack = minetest.item_place(fakestack, placer, pointed_thing)
			if not fakestack or fakestack:is_empty() then
				itemstack:take_item(1)
			else
				minetest.env:set_node(slabpos, slabnode)
			end
			return itemstack
		end

		return minetest.item_place(itemstack, placer, pointed_thing)
	end,
	
})

local function moitem(name, desc)
minetest.register_craftitem("extrablocks:"..name, {
	description = desc,
	inventory_image = "extrablocks_"..name..".png",
})
end
moitem("lapis_lazuli_lump", "Lapis Lazuli")
moitem("flour", "Flour")
moitem("sugar", "Sugar")
moitem("muffin_uncooked", "Put me into the furnace!")

minetest.register_craftitem("extrablocks:muffin", {
	description = "Muffin",
	inventory_image = "extrablocks_muffin.png",
	on_use = minetest.item_eat(20),
})


local function generate_ore(name, wherein, minp, maxp, seed, chunks_per_volume, ore_per_chunk, height_min, height_max)
	if maxp.y < height_min or minp.y > height_max then
		return
	end
	local y_min = math.max(minp.y, height_min)
	local y_max = math.min(maxp.y, height_max)
	local volume = (maxp.x-minp.x+1)*(y_max-y_min+1)*(maxp.z-minp.z+1)
	local pr = PseudoRandom(seed)
	local num_chunks = math.floor(chunks_per_volume * volume)
	local chunk_size = 3
	if ore_per_chunk <= 4 then
		chunk_size = 2
	end
	local inverse_chance = math.floor(chunk_size*chunk_size*chunk_size / ore_per_chunk)
	--print("generate_ore num_chunks: "..dump(num_chunks))
	for i=1,num_chunks do
	if (y_max-chunk_size+1 <= y_min) then return end
		local y0 = pr:next(y_min, y_max-chunk_size+1)
		if y0 >= height_min and y0 <= height_max then
			local x0 = pr:next(minp.x, maxp.x-chunk_size+1)
			local z0 = pr:next(minp.z, maxp.z-chunk_size+1)
			local p0 = {x=x0, y=y0, z=z0}
			for x1=0,chunk_size-1 do
			for y1=0,chunk_size-1 do
			for z1=0,chunk_size-1 do
				if pr:next(1,inverse_chance) == 1 then
					local x2 = x0+x1
					local y2 = y0+y1
					local z2 = z0+z1
					local p2 = {x=x2, y=y2, z=z2}
					if minetest.env:get_node(p2).name == wherein then
						minetest.env:set_node(p2, {name=name})
					end
				end
			end
			end
			end
		end
	end
	--print("generate_ore done")
end

minetest.register_on_generated(function(minp, maxp, seed)
generate_ore("extrablocks:goldstone",		"default:stone", minp, maxp, seed+112, 1/11/11/11,	4,	-31000, -450)
generate_ore("extrablocks:goldstone",		"default:stone", minp, maxp, seed+113, 1/11/11/11,	4,	-31000, -1000)
generate_ore("extrablocks:lapis_lazuli_ore","default:stone", minp, maxp, seed+114, 1/10/10/10,	3,	-300,	 -80)
generate_ore("extrablocks:lapis_lazuli_ore","default:stone", minp, maxp, seed+115, 1/10/10/10,	3,	-300,	 -150)
generate_ore("extrablocks:marble_ore",		"default:stone", minp, maxp, seed+116, 1/128,		20, -100,	 -32)
generate_ore("extrablocks:marble_ore",		"default:stone", minp, maxp, seed+117, 1/10/10/10,	3,	-100,	 -90)
end)

dofile(minetest.get_modpath("extrablocks").."/natur.lua")
