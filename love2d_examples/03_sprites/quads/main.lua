function love.load(arg)
  tileset = love.graphics.newImage("assets/images/fantasy-tileset.png") -- carica un intero spritesheet
  tileSize = 32 -- definisce le dimensioni di una singola tile

  -- definisce un quad
  quad1 = love.graphics.newQuad(0, 32, tileSize, tileSize, tileset:getDimensions())

   -- definisce un quad di dimensioni doppie
  quad2 = love.graphics.newQuad(64, 64, tileSize * 2, tileSize * 2, tileset:getDimensions())

   -- definisce un quad di dimensioni dimezzate
  quad3 = love.graphics.newQuad(0, 736, tileSize / 2, tileSize / 2, tileset:getDimensions())
end

function love.update(dt)
end

function love.draw()
  love.graphics.draw(tileset, quad1, 20, 20)    -- posiziona il primo quad
  love.graphics.draw(tileset, quad2, 120, 120)  -- posiziona il secondo quad
  love.graphics.draw(tileset, quad3, 200, 200)  -- posiziona il terzo quad
end
