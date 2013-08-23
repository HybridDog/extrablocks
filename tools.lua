extrablocks_hammer_list = {
	{"default:stone", "default:cobble"},
	{"default:cobble", "default:gravel"},
	{"default:gravel", "default:dirt", 3},
	{"default:gravel", "default:sand"},
	{"default:desert_stone", "default:desert_sand"},
	{"default:ice", "default:water_source"},
}

minetest.register_tool("extrablocks:hammer", {
	description = "Steel Hammer",
	inventory_image = "extrablocks_hammer.png",
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})

minetest.register_on_dignode(function(pos, oldnode, digger)
	if digger:get_wielded_item():get_name() == "extrablocks:hammer"
	and oldnode.name ~= "air" then
		local nd = oldnode.name
		for _,i in ipairs(extrablocks_hammer_list) do
			local chance = i[3]
			if chance == nil
			or chance <= 0 then
				chance = 1
			end
			if math.random(chance) == 1
			and nd == i[1] then
				local inv = digger:get_inventory()
				local items = minetest.get_node_drops(nd)
				if inv then
					for _,item in ipairs(items) do
						--if inv:contains_item("main", item) then
						inv:remove_item("main", item)
						--else
						--	return
						--end
					end
					minetest.set_node(pos, {name=i[2]})
					nodeupdate(pos)
					return
				end
			end
		end
	end
end)


if minetest.get_modpath("tnt") then
minetest.register_tool("extrablocks:pick_tnt", {
	inventory_image = "default_tool_woodpick.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			cracky = {times={[3]=1.60}, uses=10, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	},
})

minetest.register_on_dignode(function(pos, oldnode, digger)
	if digger:get_wielded_item():get_name() == "extrablocks:pick_tnt"
	and oldnode.name ~= "air"
	and minetest.get_item_group(oldnode.name, "cracky") >= 1 then
		local time = math.random(10)/10
		minetest.after(time, function(pos)
			minetest.set_node(pos, {name="tnt:tnt_burning"})
			boom(pos, 0)
		end, pos)
	end
end)

minetest.register_craft({
	output = "extrablocks:pick_tnt",
	recipe = {
		{'group:wood', 'group:tree', 'group:wood'},
		{'group:wood', 'group:tree', 'group:wood'},
		{'', 'default:stick', ''},
	}
})
end
