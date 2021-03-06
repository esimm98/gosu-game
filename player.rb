require_relative "star"
require_relative "bomb"
require_relative "laser"
require_relative "zorder"

class Player
	attr_reader :score

	def initialize
		@image = Gosu::Image.new("media/starfighter.bmp")
		@beep = Gosu::Sample.new("media/censor.wav")
		@explosion = Gosu::Sample.new("media/explosion.wav")
		@x = @y = @vel_x = @vel_y = @angle = 0.0
		@score = 0
	end

	def warp(x, y)
		@x, @y = x, y
	end

	def turn_left
		@angle -= 4.5
	end

	def turn_right
		@angle += 4.5
	end

	def accelerate
		@vel_x += Gosu::offset_x(@angle, 0.5)
		@vel_y += Gosu::offset_y(@angle, 0.5)
	end

	def move
		@x += @vel_x
		@y += @vel_y
		@x %= 640
		@y %= 480

		@vel_x *= 0.95
		@vel_y *= 0.95
	end

	def score
		@score
	end

	def collect_stars(stars)
		stars.reject! do |star|
			if collided?(star, 35) then
				@score += 10
				@beep.play
				true
			else
				false
			end
		end
	end

	def explode_bombs(bombs)
		bombs.reject! do |bomb|
			if collided?(bomb, 50) && bomb.fuse_out then
				@score -= 500
				@explosion.play
				true
			else
				false
			end
		end
	end

	def draw
		@image.draw_rot(@x, @y, 1, @angle)
	end

	private

		def collided?(object, distance)
			Gosu::distance(@x, @y, object.x, object.y) < distance
		end
end