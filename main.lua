push = require "push"

Class = require "class"

require "Bird"
require "Pipe"
require "PipePair"

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288
--init Bird
local bird = Bird()
-- init Pipes Pairs
local pipePairs = {}

local spawnTimer = 0
-- Load Images

--handle background
local background = love.graphics.newImage("assets/background.png")
local backgroundScroll = 0
local BACKGROUND_SPEED = 30
local BACKGROUND_LOOPING_POINT = 413
--handle ground
local ground = love.graphics.newImage("assets/ground.png")
local groundScroll = 0
local GROUND_SPEED = 60
local GROUND_LOOPING_POINT = 514

-- initialize our last recorded Y value for a gap placement to base other gaps off of
local lastY = -PIPE_HEIGHT + math.random(80) + 20

-- scrolling variable to pause the game when we collide with a pipe
local scrolling = false

-- local pipe = love.graphics.newImage("assets/pipe.png")
-- local bird = love.graphics.newImage("assets/bird.png")
-- local fiddy = love.graphics.newImage("assets/3fiddy.png")

function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest")
  math.randomseed(os.time())

  love.window.setTitle("3Fiddy Bird")

  smallFont = love.graphics.newFont("assets/font.ttf", 16)
  titleFont = love.graphics.newFont("assets/flappy.ttf", 24)
  text = 'start'
  --screen setup
  push:setupScreen(
    VIRTUAL_WIDTH,
    VIRTUAL_HEIGHT,
    WINDOW_WIDTH,
    WINDOW_HEIGHT,
    {
      vsync = true,
      fullscreen = false,
      resizable = true
    }
  )

  love.keyboard.keyPressed = {}
end

function love.resize(w, h)
  push:resize(w, h)
end

function love.keypressed(key)
  love.keyboard.keyPressed[key] = true

  if key == "escape" then
    love.event.quit()
  end

  if key == "enter" or key == "return" then
    if scrolling then
      text = 'resume'
      scrolling = false
    else
      scrolling = true
    end
  end
end

function love.keyboard.wasPressed(key)
  if love.keyboard.keyPressed[key] then
    return true
  else
    return false
  end
end

function love.update(dt)
  if scrolling then
    -- scroll background by preset speed * dt, looping back to 0 after the looping point
    backgroundScroll = (backgroundScroll + BACKGROUND_SPEED * dt) % BACKGROUND_LOOPING_POINT

    -- scroll ground by preset speed * dt, looping back to 0 after the screen width passes
    groundScroll = (groundScroll + GROUND_SPEED * dt) % GROUND_LOOPING_POINT

    spawnTimer = spawnTimer + dt

    if spawnTimer > 2.5 then
      -- modify the last Y coordinate we placed so pipe gaps aren't too far apart
      -- no higher than 10 pixels below the top edge of the screen,
      -- and no lower than a gap length (90 pixels) from the bottom
      local y = math.max(-PIPE_HEIGHT + 10, math.min(lastY + math.random(-20, 20), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
      lastY = y

      table.insert(pipePairs, PipePair(y))
      spawnTimer = 0
    end
    bird:update(dt)

    for k, pipes in pairs(pipePairs) do
      pipes:update(dt)

      -- remove any flagged pipes
      -- we need this second loop, rather than deleting in the previous loop, because
      -- modifying the table in-place without explicit keys will result in skipping the
      -- next pipe, since all implicit keys (numerical indices) are automatically shifted
      -- down after a table removal
      for k, pair in pairs(pipePairs) do
        if pair.remove then
          table.remove(pipePairs, k)
        end
      end
    end
  end

  love.keyboard.keyPressed = {}
end

function love.draw()
  push:start()
  love.graphics.draw(background, -backgroundScroll, 0)

  for k, pipes in pairs(pipePairs) do
    pipes:render()
  end

  love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)
  bird:render()
  if not scrolling then
    displayTitle(text)
  end
  push:finish()
end

function displayTitle(text)
  love.graphics.setFont(titleFont)
  love.graphics.printf("3-Fiddy bird", 0, 50, VIRTUAL_WIDTH, "center")
  love.graphics.setFont(smallFont)
  love.graphics.printf("Press ENTER to " .. text, 0, 80, VIRTUAL_WIDTH, "center")
end
