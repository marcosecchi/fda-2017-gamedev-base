function love.load(arg)
  -- assegna alla variabile l'asset audio
  beep = love.audio.newSource("assets/audio/beep.wav", "static")
end

function love.keypressed(key, scancode, isrepeat)
  if (key == "space") then -- se il tasto premuto è lo spazio...
    beep:play()            -- suona l'audio (notare la notazione a due punti)
  end
end
