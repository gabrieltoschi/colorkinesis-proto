function loadLevel(lvlnumber)
	local level = levels[lvlnumber]
	local lvlfile = levelFolder .. level .. levelExtension
	local lvldata = love.filesystem.read(lvlfile);

	local lvlw
	local lvlh
	local map = {}
	local spawn = {}
	local spawnrefs = {"N"}
	local doors = {}
	local px
	local py
	local cursor = 1
	local c = '\0'

	-- lvlw
	lvlw = string.sub(lvldata, cursor, cursor)
	cursor = cursor + 1
	c = string.sub(lvldata, cursor, cursor)

	while c ~= '\n' do
		lvlw = lvlw .. c
		cursor = cursor + 1
		c = string.sub(lvldata, cursor, cursor) 
	end
	lvlw = tonumber(lvlw)
	cursor = cursor + 1

	--lvlh
	lvlh = string.sub(lvldata, cursor, cursor)
	cursor = cursor + 1
	c = string.sub(lvldata, cursor, cursor)

	while c ~= '\n' do
		lvlh = lvlh .. c
		cursor = cursor + 1
		c = string.sub(lvldata, cursor, cursor) 
	end
	lvlh = tonumber(lvlh)
	cursor = cursor + 1

	--map
	for i = 1, lvlh do
		map[i] = {}
		for j = 1, lvlw do
			map[i][j] = string.sub(lvldata, cursor, cursor)
			if map[i][j] == 'P' then -- posicao inicial do player
				px = j
				py = i
				map[i][j] = 'E'
			end
			cursor = cursor + 1
		end
		cursor = cursor + 2
	end

	--spawn
	for i = 1, lvlh do
		spawn[i] = {}
		for j = 1, lvlw do
			spawn[i][j] = string.sub(lvldata, cursor, cursor)

			local spawnFound = false

			for s, spawntype in ipairs(spawnrefs) do
				if spawn[i][j] == spawnrefs[s] then
					spawnFound = true
				end
			end
						
			if not spawnFound then
				table.insert(spawnrefs, spawn[i][j])
			end
			cursor = cursor + 1
		end
		cursor = cursor + 2
	end

	-- doors
	for i = 1, lvlh do
		doors[i] = {}
		for j = 1, lvlw do
			doors[i][j] = string.sub(lvldata, cursor, cursor)
			cursor = cursor + 1
		end
		cursor = cursor + 2
	end

	return lvlw, lvlh, map, spawn, spawnrefs, doors, px, py
end

function drawLevel(tileset, lvlstruct, w, h, group, x, y)
	local dx = x
	local dy = y

	for i = 1, h do
		for j = 1, w do
		love.graphics.draw(tileset.ref, group[levelCode[lvlstruct[i][j]]], dx, dy)
		dx = dx + spriteWidth
		end
		dx = x
		dy = dy + spriteHeight
	end
end