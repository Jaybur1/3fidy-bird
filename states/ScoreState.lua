ScoreState = Class {__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
local DOLLAR = love.graphics.newImage("assets/oneDollar.png")
local FIDDY_CENTS = love.graphics.newImage("assets/fiddyCents.png")
function ScoreState:enter(params)
  self.score = params.score
end

function ScoreState:update(dt)
  -- go back to play if enter is pressed
  if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
    gStateMachine:change("countdown")
  end
end

function ScoreState:render()
  -- simply render the score to the middle of the screen
  love.graphics.setFont(flappyFont)
  love.graphics.printf("Oof! You lost!", 0, 64, VIRTUAL_WIDTH, "center")

  love.graphics.setFont(mediumFont)
  love.graphics.printf("Score: " .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, "center")

  if self.score >= 2 then
    love.graphics.draw(DOLLAR, VIRTUAL_WIDTH / 2 - 72, VIRTUAL_HEIGHT / 2 - 27)
  end
  if self.score >= 4 then
    love.graphics.draw(DOLLAR, VIRTUAL_WIDTH / 2 - 72, VIRTUAL_HEIGHT / 2 - 27)
    love.graphics.draw(DOLLAR, VIRTUAL_WIDTH / 2 - 32, VIRTUAL_HEIGHT / 2 - 27)
  end
  if self.score >= 6 then
    love.graphics.draw(DOLLAR, VIRTUAL_WIDTH / 2 - 72, VIRTUAL_HEIGHT / 2 - 27)
    love.graphics.draw(DOLLAR, VIRTUAL_WIDTH / 2 - 32, VIRTUAL_HEIGHT / 2 - 27)
    love.graphics.draw(DOLLAR, VIRTUAL_WIDTH / 2 + 8, VIRTUAL_HEIGHT / 2 - 27)
  end
  if self.score >= 8 then
    love.graphics.draw(DOLLAR, VIRTUAL_WIDTH / 2 - 72, VIRTUAL_HEIGHT / 2 - 27)
    love.graphics.draw(DOLLAR, VIRTUAL_WIDTH / 2 - 32, VIRTUAL_HEIGHT / 2 - 27)
    love.graphics.draw(DOLLAR, VIRTUAL_WIDTH / 2 + 8, VIRTUAL_HEIGHT / 2 - 27)
    love.graphics.draw(FIDDY_CENTS, VIRTUAL_WIDTH / 2 + 48, VIRTUAL_HEIGHT / 2 - 27)
  end

  love.graphics.printf("Press Enter to Play Again!", 0, 170, VIRTUAL_WIDTH, "center")
end
