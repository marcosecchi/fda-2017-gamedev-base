function love.load(arg)
  visitorFont = love.graphics.newFont("assets/fonts/visitor/visitor1.ttf", 50)

  mainColor = {
    r = 255, g = 100, b = 0, a = 255
  }

  secondaryColor = {
    r = 0, g = 255, b = 100, a = 255
  }

  blinkColor = mainColor
  timer = 0
  blinkTime = 0.5
end

function love.update(dt)
  timer = timer + dt

  if(timer >= blinkTime) then
    if(blinkColor == mainColor) then
      blinkColor = secondaryColor
    else
      blinkColor = mainColor
    end
    timer = 0
  end
end

function love.draw()
  love.graphics.setColor(blinkColor.r, blinkColor.g, blinkColor.b, blinkColor.a)
  love.graphics.setFont(visitorFont)
  love.graphics.printf("Blinking Text ", 0, 100, love.graphics.getWidth(), "center")
end
