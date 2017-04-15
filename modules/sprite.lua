function loadTileset(tileset)
	-- carrega a imagem de um tileset
		tileset.ref = love.graphics.newImage(tilesetFolder .. tileset.image)
end

function createTiles(tileset, group)
	-- cria os quads referentes aos tiles de um grupo

	local hct = 0
	local vct = 0
	local tiles = {}

	for i = 1, tileset.htiles * tileset.vtiles do
		newTile = love.graphics.newQuad(spriteWidth*hct, spriteHeight*vct,
			spriteWidth, spriteHeight,
			spriteWidth*tileset.htiles, spriteHeight*tileset.vtiles)
		tiles[group[i]] = newTile
		hct = hct + 1

		if (hct == tileset.htiles) then
			hct = 0
			vct = vct + 1
		end
	end

	return tiles
end

function loadCharset(charset)
	-- carrega a imagem de um charset
		charset.ref = love.graphics.newImage(charsetFolder .. charset.image)
end

function createChars(charset, group)
	-- cria os quads referentes aos chars de um grupo

	local hct = 0
	local vct = 0
	local chars = {}

	for i = 1, charset.htiles * charset.vtiles do
		newChar = love.graphics.newQuad(spriteWidth*hct, spriteHeight*vct,
			spriteWidth, spriteHeight,
			spriteWidth*charset.htiles, spriteHeight*charset.vtiles)
		chars[group[i]] = newChar
		hct = hct + 1

		if (hct == charset.htiles) then
			hct = 0
			vct = vct + 1
		end
	end

	return chars
end

function sheetToObject(sheet, object)
	object.sheet = sheet
end

function spritesToObject(sprites, object)
	object.sprites = sprites
end



