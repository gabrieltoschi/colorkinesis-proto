function createGameMaps(lvlw, lvlh, px, py)
	for i = 1, lvlw do
		levelmap[i] = {}
		for j = 1, lvlh do
			levelmap[i][j] = 0
		end
	end

	levelmap[px][py] = 1
	bodysize = 1
end

function createObject(id, bgroup, newsheet, newsprites)
	objects[id] = {
		sheet = newsheet,
		sprites = newsprites,
		group = bgroup
	}
end

function updateCoord(pos)
	for x = 1, lvlw do
		for y = 1, lvlh do
			if levelmap[x][y] == bodysize then
				levelmap[x][y] = 0
			elseif levelmap[x][y] ~= 0 then
				levelmap[x][y] = levelmap[x][y] + 1
			end
		end
	end

	moveTimerCount = moveTimerMax
end

function updateCoordInv(pos, headX, headY)
	local basex
	local basey
	local backx
	local backy

	for x = 1, lvlw do
		for y = 1, lvlh do
			if levelmap[x][y] == bodysize then
				basex = x
				basey = y
				levelmap[x][y] = levelmap[x][y] - 1
			elseif levelmap[x][y] == bodysize - 1 and bodysize ~= 1 and bodysize ~= 2 then
				backx = x
				backy = y
				levelmap[x][y] = levelmap[x][y] - 1
			elseif levelmap[x][y] ~= 0 then
				levelmap[x][y] = levelmap[x][y] - 1
			end
		end
	end

	if bodysize == 2 then
		backx = headX
		backy = headY
	end

	if bodysize == 1 then
		if pos == 'U' then
			basey = basey + 1
		elseif pos == 'D' then
			basey = basey - 1
		elseif pos == 'L' then
			basex = basex + 1
		elseif pos == 'R' then
			basex = basex - 1
		end
	else
		backx = basex - backx
		backy = basey - backy

		basex = basex + backx
		basey = basey + backy
	end

	levelmap[basex][basey] = bodysize
	moveTimerCount = moveTimerMax
end

function getPlayerPosition(pos, group)
	local basex
	local basey

	for x = 1, lvlw do
		for y = 1, lvlh do
			if levelmap[x][y] == 1 then
				basex = x
				basey = y
			end
		end
	end

	if pos == 'U' then
		basey = basey - 1
	elseif pos == 'D' then
		basey = basey + 1
	elseif pos == 'L' then
		basex = basex - 1
	elseif pos == 'R' then
		basex = basex + 1
	end

	return basex, basey
end

function updatePlayer(x, y)
	levelmap[x][y] = 1
end

function drawGame()
	local part
	local sheet
	local sprite

	for x = 1, lvlw do
		for y = 1, lvlh do
			if levelmap[x][y] ~= 0 then
				part = levelmap[x][y]
				if objects[part].group == "player" then
					sprite = getSpritePosition(objects[part].sprites, movePosition)
				else
					sprite = getSpriteGroup(objects[part].sprites, objects[part].group)
				end
				love.graphics.draw(objects[part].sheet, sprite, getMapX(x), getMapY(y))
			end
		end
	end
end

function addInGameMap(group, pos)
	local basex
	local basey
	local backx
	local backy

	for x = 1, lvlw do
		for y = 1, lvlh do
			if levelmap[x][y] == bodysize then
				basex = x
				basey = y
			elseif levelmap[x][y] == bodysize - 1 and bodysize ~= 1 then
				backx = x
				backy = y
			end
		end
	end

	if bodysize == 1 then
		if pos == 'U' then
			basey = basey + 1
		elseif pos == 'D' then
			basey = basey - 1
		elseif pos == 'L' then
			basex = basex + 1
		elseif pos == 'R' then
			basex = basex - 1
		end
	else
		backx = basex - backx
		backy = basey - backy

		basex = basex + backx
		basey = basey + backy
	end

	bodysize = bodysize + 1
	levelmap[basex][basey] = bodysize
	createObject(bodysize, group, charsets.color.ref, colorChars)		
end

function removeBody(n)
	local limit = bodysize - n + 1

	for i = bodysize, limit, -1 do
		objects[i] = nil
	end

	for x = 1, lvlw do
		for y = 1, lvlh do
			if levelmap[x][y] >= limit then
				levelmap[x][y] = 0
			end
		end
	end

	bodysize = bodysize - n
end