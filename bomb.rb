require_relative "zorder"

class Bomb
	attr_reader :x, :y, :spawn_time

	def initialize
		@image = Gosu::Image.new("media/bobomb.png")
		@x = rand * 640
		@y = rand * 480

		@spawn_time = Gosu::milliseconds
	end

	def fuse_out
		Gosu::milliseconds == (@spawn_time + 3000)
	end

	def draw
		@image.draw(@x, @y, ZOrder::Bombs)
	end
end