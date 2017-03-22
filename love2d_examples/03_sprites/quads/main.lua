function love.load(arg)
  tileset = love.graphics.newImage("assets/images/fantasy-tileset.png")

  tileSize = 32
  quad1 = love.graphics.newQuad(0, 0, tileSize, tileSize, tileset:getDimensions())
  quad2 = love.graphics.newQuad(64, 64, tileSize, tileSize, tileset:getDimensions())
end

function love.update(dt)
end

function love.draw()
  love.graphics.draw(tileset, quad1, 20, 20)
  love.graphics.draw(tileset, quad2, 120, 120)
end
