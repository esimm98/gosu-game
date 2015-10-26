require_relative "zorder"

class Laser
	attr_reader :x, :y

	def initialize
		@image = Gosu::Image.new("media/laser.png")
		@x = rand * 640
		@y = rand * 480
	end

	def draw
		@image.draw(@x, @y, ZOrder::Laser)
	end
end