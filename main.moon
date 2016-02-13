meter = 100

meters = (num) ->
	return num * meter

terminal_vel = meters 53.6
grav_accel_mod = 2



class Player
	new: (@x, @y, @width, @height) =>

		@draw = ->
			love.graphics.rectangle "fill", @x, @y, @width, @height

		@move_speed = meters(5)

		@falling = true
		@y_vel = 0

		@side = (side) ->
			if side == "top"
				return @y
			if side == "bottom"
				return @y + @height
			if side == "left"
				return @x
			if side == "right"
				return @x + @width

		@collides = (x2,y2,w2,h2) ->
			return @x < x2 + w2 and
			x2 < @x + @width and
			@y < y2 + h2 and
			y2 < @y + @height

		@collide_top = false
		@collide_bottom = false
		@collide_left = false
		@collide_right = false



		@fall = (dt) ->
			if @collide_bottom
				@y_vel = 0
			else
				if @y_vel < terminal_vel
	
					@y_vel += ( meters(9.8) * (dt) ) * grav_accel_mod
				else
					@y_vel = terminal_vel
				@y += @y_vel * dt
	


		@control = (dt) ->
	
			if love.keyboard.isDown "space"
				@reset!

			unless @collide_right
				if love.keyboard.isDown "right"
					@x += @move_speed * dt
		
			if love.keyboard.isDown "left"
				@x -= @move_speed * dt



		@reset = ->
			@x = 60
			@y = 10
			@y_vel = 0
			@falling = true



		



class Box
	new: (@type, @x, @y, @width, @height) =>

		@draw = ->
			love.graphics.rectangle "line", @x, @y, @width, @height



		@side = (side) ->
			if side == "top"
				return @y
			if side == "bottom"
				return @y + @height
			if side == "left"
				return @x
			if side == "right"
				return @x + @width



player = Player 200, 10, meters(0.5), meters(1.75)
--player = Player 60, 10, meters(20), meters(20)

floor = "floor", Box 60, 500, 600, 40
wall = "l wall", Box 620, 150, 40, 350
wall2 = "l wall", Box 59, 501, 10, 40


love.load = ->
	player.reset!

love.update = (dt) ->

	player.control dt

	
	--player collide with floor
	if player.collides floor.x, floor.y, floor.width, floor.height
		
		player.y = (floor.side "top") - player.height
		player.collide_bottom = true
		

		--if player.collides floor.x, floor.y, floor.width, floor.height
		--	player.y = (floor.hitbox "top") - player.height + 1

		else
			player.collide_bottom = false
			
			


	--player collide with wall

	if player.collides wall.x, wall.y, wall.width, wall.height
		player.collide_right = true
	else 
		player.collide_right = false


	--if (player.hitbox "right") > (wall.hitbox "left")
	--	player.x = (wall.hitbox "left") - player.width
	--	player.collide_right = true
	--else 
	--	player.collide_right = false

	
		



	player.fall dt



love.draw = ->

	--show player coords
	--love.graphics.print "x: "..player.x, 500, 10
	love.graphics.print ("bottom of player: "..player.side "bottom"), 500, 25

	--speedometer
	love.graphics.print ( "fall speed: "..player.y_vel/meters(1).." m/s" ), 200, 10

	--yardstick
	love.graphics.print "1m", 5, meters(.5)
	love.graphics.rectangle "fill", 30, 10, 3, meters(1)

	--player
	player.draw player.x, player.y

	--floor
	floor.draw!

	--wall 
	wall.draw!
	--wall2.draw!