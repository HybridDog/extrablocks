--Crafting--------------------
dofile(minetest.get_modpath("extrablocks").."/crafting.lua")

--Node------------------------------------------------------------------------------------
local function orenode(name, desc)
minetest.register_node("extrablocks:"..name.."_ore", {
	description = desc,
	tile_images = {"default_stone.png^extrablocks_"..name.."_ore.png"},
	groups = {cracky=3},
	drop = "extrablocks:"..name.."_lump",
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

local STONELIKENODES = {
	{"marble_ore", "Marble Ore"},
	{"marble_tiling", "Tiling"},
	{"marble_clean", "Marble"},
	{"lapis_lazuli_block", "Lapis Lazuli Block"},
	{"previous_cobble", "Previous Cobblestone"},
	{"space", "Space"},
	{"special", "Special"},
	{"onefootstep", "One Footstep"},
	{"coalblock", "Coalblock"},
	{"dried_dirt", "Dried Dirt"},
	{"wall", "Wall"},
	{"mossywall", "Mossy Wall"},
	{"mossystonebrick", "Mossy Stone Brick"},
	{"stonebrick", "Alternative Stone Brick"},
	{"fokni_gneb", "Fokni Gneb"},
	{"fokni_gnebbrick", "Fokni Gneb Brick"},
}

for i in ipairs(STONELIKENODES) do
	monode(STONELIKENODES[i][1], STONELIKENODES[i][2], 0)
end

orenode("lapis_lazuli", "Lapis Lazuli Ore")
orenode("iringnite", "Iringnite Ore")
orenode("fokni_gneb", "Fokni Gneb Ore")

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

minetest.register_node("extrablocks:iringnite_block", {
	description = "Iringnite Block",
	tiles = {"extrablocks_iringnite_block.png"},
	groups = {cracky=1,level=2},
	sounds = default.node_sound_stone_defaults({
		dig = {name="extrablocks_iringnite", gain=0.4},
	}),
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
	walkable = false,
	buildable_to = true,
	selection_box = {type = "fixed",fixed = selbox},
	furnace_burntime = 1,
})
end
plantnode("wheat", "Weizen", {-1/3, -1/2, -1/3, 1/3, 1/4, 1/3})
plantnode("dry_grass", "Dry Grass", {-1/3, -1/2, -1/3, 1/3, 1/4, 1/3})
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
moitem("iringnite_lump", "Iringnite Lump")
moitem("iringnite_ingot", "Iringnite Ingot")
moitem("fokni_gneb_lump", "Fokni Gneb Lump")

minetest.register_craftitem("extrablocks:muffin", {
	description = "Muffin",
	inventory_image = "extrablocks_muffin.png",
	on_use = minetest.item_eat(20),
})




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
ore("goldstone", 11*11*11, 4, 11, -1000, -450)
ore("goldstone", 8*8*8, 4, 11, -31000, -1000)
ore("iringnite_ore", 40*40*40, 4, 11, -2000, -1000)
ore("iringnite_ore", 20*20*20, 4, 11, -3000, -2000)
ore("iringnite_ore", 11*11*11, 4, 11, -31000, -3000)
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

minetest.register_ore({
	ore_type	 	= "sheet",
	ore				= "extrablocks:fokni_gneb_ore",
	wherein			= "default:stone",
	clust_size		= 20,
	height_min		= -100,
	height_max		= -32,
	noise_params	= {offset=0, scale=1, spread={x=10, y=10, z=10}, seed=114, octaves=3, persist=0.70}
})

--[[generate_ore("extrablocks:goldstone",		"default:stone", minp, maxp, seed+112, 1/11/11/11,	4,	-31000, -450)
generate_ore("extrablocks:goldstone",		"default:stone", minp, maxp, seed+113, 1/11/11/11,	4,	-31000, -1000)
generate_ore("extrablocks:lapis_lazuli_ore","default:stone", minp, maxp, seed+114, 1/10/10/10,	3,	-300,	 -80)
generate_ore("extrablocks:lapis_lazuli_ore","default:stone", minp, maxp, seed+115, 1/10/10/10,	3,	-300,	 -150)
generate_ore("extrablocks:marble_ore",		"default:stone", minp, maxp, seed+116, 1/128,		20, -100,	 -32)
generate_ore("extrablocks:marble_ore",		"default:stone", minp, maxp, seed+117, 1/10/10/10,	3,	-100,	 -90)
]]
dofile(minetest.get_modpath("extrablocks").."/natur.lua")
