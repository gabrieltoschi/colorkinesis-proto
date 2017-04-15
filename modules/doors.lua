function drawDoors(struct, tileset, group)
	for i = 1, lvlh do
		for j = 1, lvlw do
			if doorsCode[struct[i][j]] ~= false then
				love.graphics.draw(tileset.ref, group[doorsCode[struct[i][j]]],
					getMapX(j), getMapY(i))
			end
		end
	end
end

function tryDoor(ref)
	local doortype = doorsColors[ref]
	local doorpoints = doorsPoints[ref]

	if doorpoints > (bodysize - 1) then
		return false
	end

	for i = bodysize, (bodysize - doorpoints + 1), -1 do
		if objects[i].group ~= doortype then
			return false
		end
	end

	return doorpoints
end

function removeDoor(x, y)
	doors[y][x] = "X"
end

