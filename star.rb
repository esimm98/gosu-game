require_relative "zorder"

class Star
	attr_reader :x, :y

	def initialize(animation)
		@animation = animation
		@color = Gosu::Color.new(0xff_000000)
		@color.red = random_color_component_not_too_dark
		@color.green = random_color_component_not_too_dark
		@color.blue = random_color_component_not_too_dark
		@x = rand * 640
		@y = rand * 480
	end

	def draw
		img = @animation[Gosu::milliseconds / 100 % @animation.size];
		img.draw(@x - img.width / 2.0, @y - img.height / 2.0,
			ZOrder::Stars, 1, 1, @color, :add)
	end

	private
		def random_color_component_not_too_dark
			rand(256 - 40) + 40
		end
end