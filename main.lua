require "modules/config"
require "modules/sprite"
require "modules/level"
require "modules/map"
require "modules/movement"
require "modules/input"
require "modules/spawn"
require "modules/doors"


function love.load(arg)
	createConstants()

	-- preparação de tilesets
	loadTileset(tilesets.map)
	mapTiles = createTiles(tilesets.map, tilesets.map.group)

	-- preparação de charsets
	loadCharset(charsets.player)
	playerChars = createChars(charsets.player, charsets.player.group)

	loadCharset(charsets.color)
	colorChars = createChars(charsets.color, charsets.color.group)

	loadCharset(charsets.doors)
	doorsChars = createChars(charsets.doors, charsets.doors.group)

	loadCharset(charsets.spawn)
	spawnChars = createChars(charsets.spawn, charsets.spawn.group)

	startLevel(currentLevel)

end

function love.update(dt)
	checkExit('escape')
	love.math.setRandomSeed(os.time())
	updateSpeed()

	checkReset('r')

	if gameRunning then
		moveInput = checkInputMovement(movePosition)
		if moveInput ~= nil then
			nextMove = moveInput
		end

			if moveTimer(speed, dt) then
				if nextMove == nil then
					nextMove = movePosition
				end
				movePosition = nextMove
				nextMove = nil

				headX, headY = getPlayerPosition(movePosition)

				spawnCollision = checkSpawnCollision(headX, headY)
				if spawnCollision then
					addInGameMap(spawnCode[spawnCollision], movePosition)
					putSpawnInMap(spawnCollision)
				end

				doorCollision = checkDoorCollision(headX, headY)
				if doorCollision then
					toRemove = tryDoor(doorCollision)
					if toRemove then
						removeDoor(headX, headY)
						removeBody(toRemove)
						doorFailed = false
					else
						doorFailed = true
					end
				end

				updateCoord(movePosition)

				if checkMapCollision(headX, headY) 
					or checkSelfCollision(headX, headY) 
					or checkExitCollision(headX, headY) 
					or doorFailed then
					gameRunning = false
					if bodysize ~= 1 then
						updateCoordInv(movePosition, headX, headY)
					end
				else
					updatePlayer(headX, headY)
				end
			end
	end
end

function love.draw(dt)
	drawLevel(tilesets.map, lvlstruct, lvlw, lvlh, mapTiles, inX, inY)
	drawDoors(doors, charsets.doors, doorsChars)

	for i, spawnref in ipairs(lvlrefs) do
		drawSpawn(spawnref)
	end

	--for x = 1, lvlw do
	--	for y = 1, lvlh do
	--		love.graphics.print(tostring(doors[y][x]), 600 + (10 * x), 300 + (10 * y))
	--	end
	--end

	--love.graphics.print(charsets.doors.group[6], 400, 300)
	--love.graphics.draw(charsets.doors.ref, doorsChars.blue1, 600, 300)


	drawGame()

	if not gameRunning then
		if levelEnd then
			if currentLevel == 2 then
				love.graphics.print("ALPHA VERSION END", ((lvlw-1)*spriteWidth)/2, ((lvlh-1)*spriteHeight)/2)
				love.graphics.print("CONGRATULATIONS", ((lvlw-1)*spriteWidth)/2, ((lvlh-1)*spriteHeight)/2+20)
			else
				currentLevel = currentLevel + 1
				startLevel(currentLevel)
			end
		else
			love.graphics.print("GAME OVER", ((lvlw-1)*spriteWidth)/2, ((lvlh-1)*spriteHeight)/2)
		end
	end
end