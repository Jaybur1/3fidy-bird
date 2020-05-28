Bird = Class {}

local GRAVITY = 20 -- can changed

function Bird:init()
  self.image = love.graphics.newImage("assets/3fiddy.png")
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()

  self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
  self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)

  -- y velocity; gravity

  self.dy = 0
end

function Bird:update(dt)
  --apply gravity to velocity
  self.dy = self.dy + GRAVITY * dt

  if love.keyboard.wasPressed('space') then 
    self.dy = -3.5
  end

  --apply current velocity to current position
  self.y = self.y + self.dy
end

function Bird:render()
  love.graphics.draw(self.image, self.x, self.y)
end
