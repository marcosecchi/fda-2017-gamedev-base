function love.load(arg)
  character = love.graphics.newImage("assets/images/character.png")
  bg = love.graphics.newImage("assets/images/bg.png")
end

function love.draw()
  love.graphics.draw(bg, -200, -300)
  love.graphics.draw(character, 100, 100)
end
