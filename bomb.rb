require_relative "zorder"

class Bomb
	attr_reader :x, :y

	def initialize(img)
		@image = img
		@x = rand * 640
		@y = rand * 480
	end

	def draw
		@image.draw(@x, @y, 1)
	end
end