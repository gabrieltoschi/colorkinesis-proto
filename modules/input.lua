function checkExit(key)
	-- fecha o jogo se a tecla for pressionada

	if love.keyboard.isDown(key) then
		love.event.push('quit')
	end
end

function checkReset(key)
	-- fecha o jogo se a tecla for pressionada

	if love.keyboard.isDown(key) then
		startLevel(currentLevel)
	end
end

function checkInputMovement(pos)
	local newpos = nil

	if love.keyboard.isDown('left') and pos ~= "R" then
		newpos = 'L'
	elseif love.keyboard.isDown('right') and pos ~= "L" then
		newpos = 'R'
	elseif love.keyboard.isDown('up') and pos ~= "D" then
		newpos = 'U'
	elseif love.keyboard.isDown('down') and pos ~= "U" then
		newpos = 'D'
	end

	return newpos
end

