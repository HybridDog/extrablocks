-- Crafting of extrablocks

minetest.register_craft({
	output = "wool:white 9",
	recipe = {
		{"default:leaves", "default:leaves", "default:leaves"},
		{"default:leaves", "default:leaves", "default:leaves"},
		{"default:leaves", "default:leaves", "default:leaves"}
	}
})

minetest.register_craft({
	output = "extrablocks:sugar 6",
	recipe = {
		{"default:papyrus", "default:papyrus"},
		{"default:leaves", "default:leaves"},
	}
})

minetest.register_craft({
	output = "extrablocks:flour 8",
	recipe = {
		{"extrablocks:wheat"},
	}
})

minetest.register_craft({
	output = "extrablocks:muffin_uncooked 7",
	recipe = {
		{"extrablocks:sugar", "extrablocks:sugar", "extrablocks:sugar"},
		{"extrablocks:flour", "extrablocks:flour", "extrablocks:flour"},
		{"default:paper", "bucket:bucket_water", "default:paper"},
	},
	replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}},
})

minetest.register_craft({
	output = "extrablocks:torte 2",
	recipe = {
		{"extrablocks:muffin", "extrablocks:sugar", "extrablocks:muffin"},
		{"extrablocks:flour", "extrablocks:flour", "extrablocks:flour"},
		{"bucket:bucket_water", "extrablocks:muffin", "bucket:bucket_water"},
	},
	replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}, {"bucket:bucket_water", "bucket:bucket_empty"}},
})

minetest.register_craft({
	output = "extrablocks:marble_tiling 4",
	recipe = {
		{"extrablocks:marble_clean", "extrablocks:marble_clean"},
		{"extrablocks:marble_clean", "extrablocks:marble_clean"},
	}
})

minetest.register_craft({
	output = "extrablocks:fokni_gnebbrick",
	recipe = {
		{"extrablocks:fokni_gneb", "extrablocks:fokni_gneb"},
		{"extrablocks:fokni_gneb", "extrablocks:fokni_gneb"},
	}
})

minetest.register_craft({
	output = "extrablocks:goldbrick",
	recipe = {
		{"extrablocks:gold", "extrablocks:gold"},
		{"extrablocks:gold", "extrablocks:gold"},
	}
})

minetest.register_craft({
	output = "extrablocks:previous_cobble 5",
	recipe = {
		{"default:cobble",	"default:cobble",	"default:cobble"},
		{"default:cobble",	"",					"default:cobble"},
		{"",				"default:cobble",	""},
	}
})

minetest.register_craft({
	output = "extrablocks:special 9",
	recipe = {
		{"",					"extrablocks:space",			""},
		{"extrablocks:space",	"extrablocks:iringnite_block",	"extrablocks:space"},
		{"",					"extrablocks:space",			""},
	}
})

minetest.register_craft({
	output = "extrablocks:wall 9",
	recipe = {
		{"extrablocks:marble_clean",	"extrablocks:marble_clean",		"extrablocks:marble_clean"},
		{"extrablocks:stonebrick",		"extrablocks:previous_cobble",	"extrablocks:stonebrick"},
		{"extrablocks:marble_clean",	"extrablocks:marble_clean",		"extrablocks:marble_clean"},
	}
})

minetest.register_craft({
	output = "extrablocks:radi",
	recipe = {
		{"extrablocks:repellent"},
		{"extrablocks:acid"}
	}
})

local function blockcraft(ingot, block)
minetest.register_craft({
	output = block,
	recipe = {
		{ingot, ingot, ingot},
		{ingot, ingot, ingot},
		{ingot, ingot, ingot}
	}
})
minetest.register_craft({
	output = ingot.." 9",
	recipe = {{block}},
})
end

blockcraft("extrablocks:lapis_lazuli_lump", "extrablocks:lapis_lazuli_block")
blockcraft("extrablocks:iringnite_ingot", "extrablocks:iringnite_block")
blockcraft("extrablocks:gold", "extrablocks:goldblock")

local function fencecraft(name)
minetest.register_craft({
	output = "extrablocks:fence_"..name.." 6",
	recipe = {
		{"extrablocks:"..name, "extrablocks:"..name, "extrablocks:"..name},
		{"extrablocks:"..name, "extrablocks:"..name, "extrablocks:"..name},
	}
})
end

fencecraft("special")
fencecraft("stonebrick")
fencecraft("fokni_gneb")

minetest.register_craft({
	type = "cooking",
	output = "extrablocks:muffin",
	recipe = "extrablocks:muffin_uncooked",
})

minetest.register_craft({
	type = "cooking",
	output = "extrablocks:marble_clean",
	recipe = "extrablocks:marble_ore",
})

minetest.register_craft({
	type = "cooking",
	output = "extrablocks:iringnite_ingot",
	recipe = "extrablocks:iringnite_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "extrablocks:fokni_gneb",
	recipe = "extrablocks:fokni_gneb_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "extrablocks:fence_repellent 3",
	recipe = "extrablocks:fence_special",
})

minetest.register_craft({
	type = "cooking",
	output = "extrablocks:repellent 8",
	recipe = "extrablocks:special",
})

minetest.register_craft({
	type = "cooking",
	output = "extrablocks:gold",
	recipe = "extrablocks:goldstone",
})

minetest.register_craft({
	type = "cooking",
	output = "extrablocks:coalblock 9",
	recipe = "default:coalblock",
})

minetest.register_craft({
	type = "cooking",
	output = "extrablocks:space",
	recipe = "extrablocks:coalblock",
})

minetest.register_craft({
	type = "cooking",
	output = "extrablocks:onefootstep 2",
	recipe = "extrablocks:previous_cobble",
})

minetest.register_craft({
	type = "cooking",
	output = "extrablocks:dried_dirt",
	recipe = "default:dirt",
})

minetest.register_craft({
	type = "cooking",
	output = "extrablocks:stonebrick 2",
	recipe = "default:stonebrick",
})

minetest.register_craft({
	type = "cooking",
	output = "extrablocks:acid 9",
	recipe = "extrablocks:iringnite_block",
})
