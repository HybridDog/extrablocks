--license LGPLv2+

local r_corr = 0.25 --remove a bit more nodes (if shooting diagonal) to let it look like a hole (sth like antialiasing)

-- this doesn't need to be calculated every time
local f_1 = 0.5-r_corr
local f_2 = 0.5+r_corr

--returns information about the direction
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

local function return_line(pos, dir, range) --range ~= length
	local tab = {}
	local num = 1
	local t_dir = get_used_dir(dir)
	local dir_typ = t_dir[1]
	if t_dir[3] == "+" then
		f_tab = {0, range, 1}
	else
		f_tab = {0, -range, -1}
	end
	local d_ch = t_dir[2]
	if dir_typ == "x" then
		for d = f_tab[1],f_tab[2],f_tab[3] do
			local x = d
			local ytab = node_tab(d_ch.y, d)
			local ztab = node_tab(d_ch.z, d)
			for _,y in ipairs(ytab) do
				for _,z in ipairs(ztab) do
					tab[num] = {x=pos.x+x, y=pos.y+y, z=pos.z+z}
					num = num+1
				end
			end
		end
	elseif dir_typ == "y" then
		for d = f_tab[1],f_tab[2],f_tab[3] do
			local xtab = node_tab(d_ch.x, d)
			local y = d
			local ztab = node_tab(d_ch.z, d)
			for _,x in ipairs(xtab) do
				for _,z in ipairs(ztab) do
					tab[num] = {x=pos.x+x, y=pos.y+y, z=pos.z+z}
					num = num+1
				end
			end
		end
	else
		for d = f_tab[1],f_tab[2],f_tab[3] do
			local xtab = node_tab(d_ch.x, d)
			local ytab = node_tab(d_ch.y, d)
			local z = d
			for _,x in ipairs(xtab) do
				for _,y in ipairs(ytab) do
					tab[num] = {x=pos.x+x, y=pos.y+y, z=pos.z+z}
					num = num+1
				end
			end
		end
	end
	return tab
end

function vector.line(pos, dir, range)
	--assert_vector(pos)
	if not range then --dir = pos2
		return return_line(pos, vector.direction(pos, dir), vector.distance(pos, dir))
	end
	return return_line(pos, dir, range)
end

function vector.straightdelay(s, v, a)
	if not a then
		return s/v
	end
	return (math.sqrt(v*v+2*a*s)-v)/a
end
