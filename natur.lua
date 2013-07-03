local function moss(input, output)
	minetest.register_abm({
		nodenames = {input},
		neighbors = {"group:water"},
		interval = 50,
		chance = 20,
		action = function(pos)
			if not minetest.env:find_node_near(pos, 3, output) then
				minetest.env:add_node(pos, {name=output})
				print("[extrablocks] "..input.." changed to "..output.." at ("..pos.x..", "..pos.y..", "..pos.z..")")
			end
		end,
	})
end

moss("default:cobble",	"default:mossycobble")
moss("default:stonebrick",	"extrablocks:mossystonebrick")
moss("extrablocks:wall",	"extrablocks:mossywall")
moss("nuke:iron_tnt",	"nuke:mossy_tnt")
moss("nuke:mese_tnt",	"nuke:mossy_tnt")
