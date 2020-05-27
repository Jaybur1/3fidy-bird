push = require 'push'

class = require 'class'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT= 288

local background = love.graphics.newImage('assets/background.png')
local ground = love.graphics.newImage('assets/ground.png')
local pipe = love.graphics.newImage('assets/pipe.png')
local bird = love.graphics.newImage('assets/bird.png')