--textures from: gamiano.de, gimp, wz2100, chromiumBSU, minetest, minecraft, ...

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
local function orenode(name, drops)
minetest.register_node("extrablocks:"..name.."_ore", {
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

orenode("marble", "marble_clean")
stonelikenode("marble_tiling", "Tiling")
stonelikenode("marble_clean", "Marble")

orenode("lapis_lazuli", "lapis_lazuli_lump")
stonelikenode("lapis_lazuli_block", "Lapis Lazuli Block")

stonelikenode("previous_cobble", "Previous Cobblestone")
stonelikenode("space", "Space")
stonelikenode("special", "special")
stonelikenode("onefootstep", "One Footstep")
stonelikenode("coalblock", "Coalblock")
stonelikenode("dried_dirt", "Dried Dirt")
stonelikenode("wall", "Wall")

monode("goldbrick", "Goldbrick", LIGHT_MAX-1)
monode("goldblock", "Goldblock", LIGHT_MAX-1)
monode("gold", "Gold", LIGHT_MAX-1)
monode("acid", "Acid", LIGHT_MAX-1)


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
			local n1 = minetest.env:get_node(p1)
			if n0.name == "extrablocks:torte" then
				slabpos = p0
				slabnode = n0
			elseif n1.name == "extrablocks:torte" then
				slabpos = p1
				slabnode = n1
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
