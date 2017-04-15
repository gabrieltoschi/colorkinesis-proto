function centerWindow()
	-- centraliza a janela do jogo no centro da tela

	local winw, winh, flags = love.window.getMode();
	local deskw, deskh = love.window.getDesktopDimensions(flags.display)
	local correction = 18

	deskw = (deskw - winw)/2
	deskh = (deskh - winh)/2-correction
	love.window.setPosition(deskw, deskh, flags.display)
end

function configureWindowSize(lvlw, lvlh)
	love.window.setMode(lvlw*spriteWidth, lvlh*spriteHeight, {borderless = true})
end

function createConstants()
	-- cria as constantes do motor do jogo
	-- TILESETS
	tilesetFolder = 'assets/tilesets/'
	tilesets = {}

	tilesets.map = {
			image = 'test.png',
			htiles = 4,
			vtiles = 1,
			ref = nil,
			group = {"grass", "jar", "trunk", "bucket"}
		}
	mapTiles = {}

	-- LEVELS
	levelFolder = 'levels/'
	levelExtension = '.level'
	levels = {"1", "2"}
	currentLevel = 1
	inX = 0
	inY = 0

	levelCode = {
		W = "bucket",
		E = "grass",
		Z = "jar"
	}

	collisionCode = {
		W = true,
		E = false,
		Z = false
	}

	-- CHARSETS
	charsetFolder = 'assets/charsets/'
	charsets = {}

	charsets.player = {
		image = 'player.png',
		htiles = 4,
		vtiles = 1,
		ref = nil,
		group = {"down", "left", "right", "up"}
	}
	playerChars = {}

	charsets.color = {
		image = 'color.png',
		htiles = 4,
		vtiles = 1,
		ref = nil,
		group = {"red", "blue", "green", "purple"}
	}
	colorChars = {}

	charsets.doors = {
		image = 'doors.png',
		htiles = 5,
		vtiles = 4,
		ref = nil,
		group = {"red1", "red2", "red3", "red4", "red5",
				 "blue1", "blue2", "blue3", "blue4", "blue5",
				 "green1", "green2", "green3", "green4", "green5",
				 "purple1", "purple2", "purple3", "purple4", "purple5"}
	}
	doorsChars = {}

	charsets.spawn = {
		image = 'spawn.png',
		htiles = 4,
		vtiles = 1,
		ref = nil,
		group = {"red", "blue", "green", "purple"}
	}
	spawnChars = {}

	spawnCode = {
		N = false,
		R = "red",
		B = "blue",
		G = "green",
		P = "purple"
	}

	doorsCode = {
		X = false,
		A = "red1", S = "red2", D = "red3",
		F = "blue1", G = "blue2", H = "blue3"
	}

	doorsColors = {
		A = "red", S = "red", D = "red",
		F = "blue", G = "blue", H = "blue"
	}

	doorsPoints = {
		A = 1, S = 2, D = 3,
		F = 1, G = 2, H = 3
	}

	-- GAME CORE
	speedIncrement = 0.009
	speedMin = 0.18
	speed = speedMin - speedIncrement
	spriteWidth = 32
	spriteHeight = 32
	gameRunning = true
	levelEnd = false
	moveInput = nil
	nextMove = nil

	levelmap = {}
	objects = {}
	doors = {}
	bodysize = 1
	movePosition = "U"
	headX = nil
	headY = nil

	-- TIMERS
	moveTimerMax = 0.8
	moveTimerCount = moveTimerMax

end

function startLevel(lvlnum)
	speed = speedMin - speedIncrement
	gameRunning = true
	levelEnd = false
	moveInput = nil
	nextMove = nil
	levelmap = {}
	objects = {}
	doors = {}
	bodysize = 1
	movePosition = "U"
	headX = nil
	headY = nil

	-- TIMERS
	moveTimerMax = 0.8
	moveTimerCount = moveTimerMax

	-- leitura do primeiro nivel
	lvlstruct = {}
	lvlw, lvlh, lvlstruct, lvlspawn, lvlrefs, doors, px, py = loadLevel(lvlnum)
	
	-- preparação do mapa de jogo
	createGameMaps(lvlw, lvlh, px, py)
	createObject(1, "player", charsets.player.ref, playerChars)

	-- preparação do spawn
	createSpawn(charsets.color.group)
	for i, spawnref in ipairs(lvlrefs) do
		putSpawnInMap(spawnref)
	end

	configureWindowSize(lvlw, lvlh)
	centerWindow()
end






