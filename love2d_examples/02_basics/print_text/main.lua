function love.load(arg)
  -- assegna alla variabile il font caricato, con dimensione 30
  visitorFont = love.graphics.newFont("assets/fonts/visitor/visitor1.ttf", 30)
  deltaTime = 0
end

function love.update(dt)
  deltaTime = dt  -- recupera il delta time intercorso tra un frame e l'altro
end

function love.draw()
  love.graphics.setFont(visitorFont) -- assegna il font al motore di rendering
  love.graphics.print("Delta time " .. deltaTime, 30, 30) -- stampa il delta time a schermo
  local fps = love.timer.getFPS() -- recupera il numero di frame al secondo
  love.graphics.printf("FPS " .. fps, 30, 70, love.graphics.getWidth(), "left") -- stampa il numero di frame al secondo a schermo
end
