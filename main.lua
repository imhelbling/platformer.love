local meter = 100
local meters
meters = function(num)
  return num * meter
end
local terminal_vel = meters(53.6)
local grav_accel_mod = 2
local Player
do
  local _class_0
  local _base_0 = { }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, x, y, width, height)
      self.x, self.y, self.width, self.height = x, y, width, height
      self.draw = function()
        love.graphics.setColor(0, 255, 0)
        love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
        return love.graphics.setColor(255, 255, 255)
      end
      self.move_speed = meters(5)
      self.falling = true
      self.y_vel = 0
      self.side = function(side)
        if side == "top" then
          return self.y
        end
        if side == "bottom" then
          return self.y + self.height
        end
        if side == "left" then
          return self.x
        end
        if side == "right" then
          return self.x + self.width
        end
      end
      self.fall = function(dt)
        if self.collide_bottom then
          self.y_vel = 0
        else
          if self.y_vel < terminal_vel then
            self.y_vel = self.y_vel + ((meters(9.8) * (dt)) * grav_accel_mod)
          else
            self.y_vel = terminal_vel
          end
          self.y = self.y + (self.y_vel * dt)
        end
      end
      self.control = function(dt)
        if love.keyboard.isDown("space") then
          self:reset()
        end
        if not (self.collide_right) then
          if love.keyboard.isDown("d") then
            self.x = self.x + (self.move_speed * dt)
          end
        end
        if love.keyboard.isDown("a") then
          self.x = self.x - (self.move_speed * dt)
        end
      end
      self.reset = function()
        self.x = 60
        self.y = 10
        self.y_vel = 0
        self.falling = true
      end
    end,
    __base = _base_0,
    __name = "Player"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Player = _class_0
end
local Box
do
  local _class_0
  local _base_0 = { }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, x, y, width, height)
      self.x, self.y, self.width, self.height = x, y, width, height
      self.draw = function()
        return love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
      end
    end,
    __base = _base_0,
    __name = "Box"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Box = _class_0
end
local player = Player(200, 10, meters(0.5), meters(1.75))
local floor = Box(60, 500, 600, 40)
local wall = Box(620, 150, 40, 350)
local wall2 = Box(59, 501, 10, 40)
love.load = function()
  return player.reset()
end
love.update = function(dt)
  player.control(dt)
  return player.fall(dt)
end
love.draw = function()
  love.graphics.print(("bottom of player: " .. player.side("bottom")), 500, 25)
  love.graphics.print(("fall speed: " .. player.y_vel / meters(1) .. " m/s"), 200, 10)
  love.graphics.print("1m", 5, meters(.5))
  love.graphics.rectangle("fill", 30, 10, 3, meters(1))
  player.draw(player.x, player.y)
  floor.draw()
  return wall.draw()
end
