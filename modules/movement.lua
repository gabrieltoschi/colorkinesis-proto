function getSpritePosition (sprites, pos)
	if pos == 'U' then
		return sprites.up
	elseif pos == 'D' then
		return sprites.down
	elseif pos == 'L' then
		return sprites.left
	elseif pos == 'R' then
		return sprites.right
	end
end

function getSpriteGroup (sprites, group)
	return sprites[group]
end

function getMapX(x)
	return inX + ((x-1) * spriteWidth)  
end

function getMapY(y)
	return inY + ((y-1) * spriteHeight)  
end

function moveTimer(dt)
	moveTimerCount = moveTimerCount - (speed * dt)

	if moveTimerCount < 0 then
		return true
	else
		return false
	end
end

function checkMapCollision(x, y)
	if collisionCode[lvlstruct[y][x]] then
		return true
	else
		return false
	end
end

function checkSelfCollision(x, y)
	if levelmap[x][y] ~= 0 then
		return true
	else
		return false
	end
end

function checkSpawnCollision(x, y)
	local collision = false
	local spawnx
	local spawny

	for i, spawnref in ipairs(lvlrefs) do
		if spawnCode[spawnref] then
			spawnx = spawn[spawnCode[spawnref]].x
			spawny = spawn[spawnCode[spawnref]].y

			if x == spawnx and y == spawny then
				collision = spawnref
			end 
		end
	end

	return collision
end

function checkExitCollision(x, y)
	if lvlstruct[y][x] == "Z" then
		levelEnd = true
		return true
	else
		return false
	end
end

function checkDoorCollision(x, y)
	if doorsCode[doors[y][x]] then
		return doors[y][x]
	else
		return false
	end
end

function drawObject(object)
	local sheet = object.sheet
	local sprite = nil
	local x = getMapX(object.x)
	local y = getMapY(object.y)

	if object.pos ~= nil then -- player
		sprite = getSpritePosition(object.sprites, object.pos)
	else -- bodypart
		sprite = object.sprites[object.group]
	end

	love.graphics.draw(sheet, sprite, x, y)
end

function updateSpeed()
	speed = speedMin + (speedIncrement * bodysize)
end
