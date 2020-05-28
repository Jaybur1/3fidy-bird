push = require "push"

Class = require "class"

require "Bird"
require "Pipe"
require "PipePair"

--game states

require "StateMachine"
require "states/BaseState"
require "states/PlayState"
require "states/TitleScreenState"

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

  smallFont = love.graphics.newFont("assets/font.ttf", 12)
  mediumFont = love.graphics.newFont("assets.flappy.ttf", 14)
  titleFont = love.graphics.newFont("assets/flappy.ttf", 24)
  hugeFont = love.graphics.newFont("assets/flappy.ttf", 58)

  sounds = {
    ["jump"] = love.audio.newSource("assets/jump.wav", "static"),
    ["explosion"] = love.audio.newSource("assets/explosion.wav", "static"),
    ["hurt"] = love.audio.newSource("assets/hurt.wav", "static"),
    ["score"] = love.audio.newSource("assets/score.wav", "static"),
    ["music"] = love.audio.newSource("assets/marios_way.mp3", "static")
  }

  -- kick off music
  sounds["music"]:setLooping(true)
  sounds["music"]:play()

  text = "start"
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

  -- initialize state machine with all state-returning functions
  gStateMachine =
    StateMachine {
    ["title"] = function()
      return TitleScreenState()
    end,
    ["countdown"] = function()
      return CountdownState()
    end,
    ["play"] = function()
      return PlayState()
    end,
    ["score"] = function()
      return ScoreState()
    end
  }
  gStateMachine:change("title")

  love.keyboard.keyPressed = {}
  -- initialize mouse input table
  love.mouse.buttonsPressed = {}
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
      text = "resume"
      scrolling = false
    else
      scrolling = true
    end
  end
end

--[[
    LÖVE2D callback fired each time a mouse button is pressed; gives us the
    X and Y of the mouse, as well as the button in question.
]]
function love.mousepressed(x, y, button)
  love.mouse.buttonsPressed[button] = true
end

function love.keyboard.wasPressed(key)
  return love.keyboard.keysPressed[key]
end

--[[
  Equivalent to our keyboard function from before, but for the mouse buttons.
]]
function love.mouse.wasPressed(button)
  return love.mouse.buttonsPressed[button]
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
  end

  gStateMachine:update(dt)

  love.keyboard.keysPressed = {}
  love.mouse.buttonsPressed = {}
end

function love.draw()
  push:start()
  love.graphics.draw(background, -backgroundScroll, 0)
  gStateMachine:render()
  love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)

  push:finish()
end

function displayTitle(text)
  love.graphics.setFont(titleFont)
  love.graphics.printf("3-Fiddy bird", 0, 50, VIRTUAL_WIDTH, "center")
  love.graphics.setFont(smallFont)
  love.graphics.printf("Press ENTER to " .. text, 0, 80, VIRTUAL_WIDTH, "center")
end
