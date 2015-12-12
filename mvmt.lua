local function lit_rocket(pos)
	minetest.add_particlespawner(
		3, --amount
		0.1, --time
		{x=pos.x-0.2, y=pos.y-0.2, z=pos.z-0.2}, --minpos
		{x=pos.x+0.2, y=pos.y+0.2, z=pos.z+0.2}, --maxpos
		{x=-0, y=-0, z=-0}, --minvel
		{x=0, y=0, z=0}, --maxvel
		{x=-0.5,y=5,z=-0.5}, --minacc
		{x=0.5,y=5,z=0.5}, --maxacc
		0.1, --minexptime
		1, --maxexptime
		2, --minsize
		8, --maxsize
		false, --collisiondetection
		"smoke_puff.png" --texture
	)
	minetest.sound_play("extrablocks_rbp_lit", {pos = pos,	gain = 0.2,	max_hear_distance = 3})
end
--http://www.freesound.org/people/roubignolle/sounds/36352/

local function off_rocket(pos)
	minetest.sound_play("extrablocks_rbp_off", {pos = pos,	gain = 0.2,	max_hear_distance = 3})
end

local function acc(p)
	local pcontrol = p:get_player_control()
	if pcontrol then --"and" wouldn't work, I think
		if pcontrol["sneak"] then
			return 3
		end
	end
	return 30
end

local jpllist = {}

minetest.register_craftitem("extrablocks:rocket_bag", {
	description = "Experimental Rocket Bag",
	inventory_image = "extrablocks_rbp.png",
	on_use = function(_, player)
		if not player then
			return
		end
		local playername = player:get_player_name()
		if not playername then
			return
		end
		local pos = player:getpos()
		local enabled = jpllist[playername]
		if enabled then
			player:set_physics_override({jump=1})
			jpllist[playername] = false
			off_rocket(pos)
		else
			local accel = acc(player)
			player:set_physics_override({jump=accel})
			jpllist[playername] = true
			lit_rocket(pos)
		end
		return --necessary because of on_use
	end,
})
