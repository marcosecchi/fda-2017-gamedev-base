function love.load(arg)

  -- init fonts
  font100 = love.graphics.newFont("fonts/visitor/visitor1.ttf", 100)
  font40 = love.graphics.newFont("fonts/visitor/visitor1.ttf", 40)

  -- init audio
  beep = love.audio.newSource("audio/beep.wav", "static")
  beep2 = love.audio.newSource("audio/beep2.wav", "static")

  -- screen
  screen = {}
  screen["w"] = love.graphics.getWidth()
  screen["h"] = love.graphics.getHeight()

  -- pad
  pad = {}
  pad["w"] = 10
  pad["h"] = 60
  pad["speed"] = 3
  pad["startY"] = (screen.h - pad.h) / 2

  -- players
  player1 = {}
  player1["x"] = 40 - pad.w / 2;
  player1["y"] = pad.startY;
  player1["score"] = 0

  player2 = {}
  player2["x"] = screen.w - 40 - pad.w / 2;
  player2["y"] = pad.startY;
  player2["score"] = 0

  -- board
  board = {}
  board["lineW"] = 14
  board["numVerticalDots"] = 14

  -- ball
  ball = {}
  ball["size"] = 10
  ball["speed"] = 3
  ball["startX"] = screen.w / 2
  ball["startY"] = screen.h / 2
  ball["x"] = ball.startX
  ball["y"] = ball.startY
  ball["dx"] = 1
  ball["dy"] = 1

  -- game
  game = {}
  game["winScore"] = 9
  game["status"] = "start"

  gameOverTimer = 0;
end

function love.update(dt)
  -- player1 movement
  if(love.keyboard.isDown("w")) then
    player1.y = player1.y - pad.speed
  elseif(love.keyboard.isDown("s")) then
    player1.y = player1.y + pad.speed
  end

  if(player1.y < board.lineW + pad.h / 2) then
    player1.y = board.lineW + pad.h / 2
  elseif(player1.y > screen.h - board.lineW - pad.h / 2) then
    player1.y = screen.h - board.lineW - pad.h / 2
  end

  -- player2 movement
  if(love.keyboard.isDown("p")) then
    player2.y = player2.y - pad.speed
  elseif(love.keyboard.isDown("l")) then
    player2.y = player2.y + pad.speed
  end

  if(player2.y < board.lineW + pad.h / 2) then
    player2.y = board.lineW + pad.h / 2
  elseif(player2.y > screen.h - board.lineW - pad.h / 2) then
    player2.y = screen.h - board.lineW - pad.h / 2
  end

  -- check game status
  if(game.status == "start") then
    updateStartStatus()
  elseif(game.status == "play") then
    updatePlayStatus()
  elseif(game.status == "game over") then
    gameOverTimer = gameOverTimer + dt
    updateGameOverStatus()
  end
end

function updateStartStatus()
  if(love.keyboard.isDown("space")) then
    player1.score = 0
    player2.score = 0
    rand = math.random(-1, 1)
    if(rand > 0) then
      ball.dx = 1;
    else
      ball.dx = -1;
    end
    game.status = "play"
  end
end

function updateGameOverStatus()
  -- wait a number of seconds and then show the start screen
  if(gameOverTimer > 5) then
    resetScore()
    game.status = "start"
  end

  if(love.keyboard.isDown("space")) then
    resetScore()
    game.status = "play"
  end
end

function updatePlayStatus()
  -- ball momvement
  ball.x =  (ball.x + ball.dx * ball.speed)
  ball.y = (ball.y + ball.dy * ball.speed)

  if(ball.y > screen.h - board.lineW - ball.size / 2) then
    ball.y = screen.h - board.lineW - ball.size / 2
    ball.dy = -ball.dy
    beep:play()
  elseif (ball.y < board.lineW + ball.size / 2) then
    ball.y = board.lineW + ball.size / 2
    ball.dy = -ball.dy
    beep:play()
  end

  if(
      ball.x > player2.x - ball.size and
      ball.y < player2.y + pad.h / 2 and
      ball.y > player2.y - pad.h / 2
  ) then
    ball.x = player2.x - ball.size
    ball.dx = -ball.dx
    beep:play()
  elseif (
      ball.x < player1.x + ball.size and
      ball.y < player1.y + pad.h / 2 and
      ball.y > player1.y - pad.h / 2
  ) then
    ball.x = player1.x + ball.size
    ball.dx = -ball.dx
    beep:play()
  end

  if(ball.x > player2.x + 10) then
    player1.score = player1.score + 1
    beep2:play()
    resetBall()
    if(player1.score == game.winScore) then
      endGame()
    end
  elseif(ball.x < player1.x - 10) then
    player2.score = player2.score + 1
    beep2:play()
    resetBall()
    if(player2.score == game.winScore) then
      endGame()
    end
  end
end

function love.draw()
  if(game.status ~= "start") then
    drawBoard()
    drawScore()
    drawPads()
    drawBall()
    if(game.status == "game over") then
        drawGameOverScreen()
    end
  else
    drawStartScreen()
  end
end

function drawStartScreen()
  love.graphics.setFont(font100)
  love.graphics.printf("PONG", 0, 120, screen.w, "center")
  love.graphics.setFont(font40)
  love.graphics.printf("Press Spacebar to Start", 0, screen.h / 2, screen.w, "center")
  love.graphics.printf("Left Player: w/s\nRight Player: p/l", 0, screen.h / 2 + 60, screen.w, "center")
end

function drawGameOverScreen()
  love.graphics.setColor(0, 0, 0, 220)
  love.graphics.rectangle("fill", 0, 0, screen.w, screen.h)
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.setFont(font100)
  love.graphics.printf("GAME OVER", 0, 120, screen.w, "center")
  love.graphics.setFont(font40)
  if(player1.score == game.winScore) then
    love.graphics.printf("Player 1 Wins!", 0, screen.h / 2, screen.w, "center")
  else
    love.graphics.printf("Player 2 Wins!", 0, screen.h / 2, screen.w, "center")
  end
  love.graphics.printf("Press Spacebar to play again", 0, screen.h / 2 + 60, screen.w, "center")
end

function drawBoard()
  love.graphics.rectangle("fill", 0, 0, screen.w, board.lineW)
  love.graphics.rectangle("fill", 0, screen.h - board.lineW, screen.w, board.lineW)
  local h = screen.h / board.numVerticalDots
  for i=0,board.numVerticalDots - 1 do
    love.graphics.rectangle("fill", (screen.w / 2) - (board.lineW / 2), h * i, board.lineW, h / 2)
  end
end

function drawScore()
  love.graphics.setFont(font100)
  love.graphics.printf(player1.score, 0, 15, screen.w / 2, "center")
  love.graphics.printf(player2.score, screen.w / 2, 15, screen.w / 2, "center")
end

function drawPads()
  love.graphics.rectangle("fill", player1.x - pad.w / 2, player1.y - pad.h / 2, pad.w, pad.h)
  love.graphics.rectangle("fill", player2.x - pad.w / 2, player2.y - pad.h / 2, pad.w, pad.h)
end

function drawBall()
  love.graphics.rectangle("fill", ball.x - ball.size / 2, ball.y - ball.size / 2, ball.size, ball.size)
end

function resetScore()
  player1.score = 0
  player2.score = 0
end

function resetBall()
  ball.x = ball.startX
  ball.y = ball.startY
  ball.dx = -ball.dx
  ball.dy = -ball.dy
end

function endGame()
  gameOverTimer = 0
  game.status = "game over"
end
