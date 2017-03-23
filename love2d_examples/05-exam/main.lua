function love.load(arg)
  -- inizializza l'effetto audio
  beep = love.audio.newSource("audio/beep.wav", "static")
  -- inizializza il font
  visitorFont = love.graphics.newFont("fonts/visitor/visitor1.ttf", 40)

  size  = 20    -- dimensioni della palla
  ballX = 100   -- posizione x della palla
  ballY = 100   -- posizione y della palla
  floorY = 100  -- altezza del pavimento

  velX = math.random(-3, 3)  -- velocità della palla in direzione x
  velY = math.random(-3, 3)  -- velocità della palla in direzione y
end

function love.update(dt)
  -- controllo quando la palla colpisce i lati
  if (
    ballX + velX < 0 + size or
    ballX + velX > love.graphics.getWidth() - size
  ) then
    velX = velX * -1 -- se colpisce un lato, cambio il segno della velocità (cambio direzione x)
    beep:play()
  else
    ballX = ballX + velX -- aggiungo alla posizione x la velocità x
  end

  -- controllo quando la palla colpisce soffitto o pavimento
  if (
    ballY + velY < 0 + size or
    ballY + velY > love.graphics.getHeight() - floorY - size
  ) then
    velY = velY * -0.9 -- se colpisce, cambio il segno della velocità (cambio direzione y)
    beep:play()

    -- se la velocità y è molto bassa, forzo la velocità con una spinta casuale
    if(
      velY < 0.7 and
      velY > -0.7
    ) then
      velX = math.random(-3, 3)
      vely = math.random(-10, -4)
      beep:play()
    end
  else
    ballY = ballY + velY -- aggiungo alla posizione y la velocità y
  end

  velY = velY + 0.4 -- aggiungo la gravità alla velocità y della palla
end

function love.draw()
  -- disegno il pavimento
  love.graphics.setColor(150, 150, 150, 255)
  love.graphics.rectangle(
      "fill",
      0, love.graphics.getHeight() - floorY,
      love.graphics.getWidth(), floorY
  )

  -- disegno la palla
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.circle("fill", ballX, ballY, size, 20)

  -- scrivo del testo descrittivo
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.setFont(visitorFont)
  love.graphics.printf(
      "FDA 2017 - Test",
      0, love.graphics.getHeight() - 70,
      love.graphics.getWidth(),
      "center"
  )
end
