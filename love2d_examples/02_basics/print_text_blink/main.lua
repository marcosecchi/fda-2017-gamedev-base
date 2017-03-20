function love.load(arg)
  -- assegna alla variabile il font caricato, con dimensione 30
  visitorFont = love.graphics.newFont("assets/fonts/visitor/visitor1.ttf", 50)

  -- definisce i valori dei due colori da utilizzare
  color1 = {
    r = 255, g = 100, b = 0, a = 255
  }
  color2 = {
    r = 0, g = 255, b = 100, a = 255
  }

  blinkColor = color1 -- definisce ed inizializza il colore da visualizzare

  timer = 0 -- definisce il timer
  blinkTime = 0.5  -- definisce ogni quanto  "blinkare"
end

function love.update(dt)
  timer = timer + dt -- aggiunge al timer il tempo intercorso tra un frame e l'altro

  if(timer >= blinkTime) then     -- se il timer ha superato il tempo di "blinking"...
    if(blinkColor == color1) then -- ... effettua il cambio di colore
      blinkColor = color2
    else
      blinkColor = color1
    end
    timer = 0 -- azzera il timer
  end
end

function love.draw()
  love.graphics.setColor(blinkColor.r, blinkColor.g, blinkColor.b, blinkColor.a) -- assegna il colore selezionato
  love.graphics.setFont(visitorFont) -- assegna il font
  love.graphics.printf("Blinking Text ", 0, 100, love.graphics.getWidth(), "center") --scrivi a schermo, centrando il testo
end
