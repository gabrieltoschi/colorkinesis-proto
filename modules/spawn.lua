function createSpawn(group)
	spawn = {}

	for i, spawntype in ipairs(group) do

	newSpawn = {
		sheet = charsets.spawn.ref,
		sprites = spawnChars,
		x = nil,
		y = nil,
		group = spawntype
	}

	spawn[spawntype] = newSpawn
	end

end

function putSpawnInMap(spawnref)
	if spawnCode[spawnref] then
		local spawnx
		local spawny
		local spawnDone = false

		while not spawnDone do
			spawnx = love.math.random(1, lvlw)
			spawny = love.math.random(1, lvlh)
			if lvlspawn[spawny][spawnx] == spawnref 
				and spawnx ~= spawn[spawnCode[spawnref]].x 
				and spawny ~= spawn[spawnCode[spawnref]].y then
				spawn[spawnCode[spawnref]].x = spawnx
				spawn[spawnCode[spawnref]].y = spawny
				spawnDone = true
			end
		end
	end
end

function drawSpawn(spawnref)
	if spawnCode[spawnref] then
		drawObject(spawn[spawnCode[spawnref]])
	end
end