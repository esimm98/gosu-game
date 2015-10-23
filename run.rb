require_relative "player"
require_relative "star"
require_relative "zorder"
require_relative "bomb"
require 'gosu'

class GameWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Gosu Tutorial Game"

    @background_image = Gosu::Image.new("media/space.jpg", :tileable => true)

    @player = Player.new
    @player.warp(320, 240)

    @star_anim = Gosu::Image::load_tiles("media/star.png", 25, 25)
    @stars = Array.new

    @bomb_image = Gosu::Image.new("media/bobomb.png")
    @bombs = Array.new

    @font = Gosu::Font.new(20)
  end

  def update
  	if Gosu::button_down? Gosu::KbLeft or Gosu::button_down? Gosu::GpLeft then
  		@player.turn_left
  	end
  	if Gosu::button_down? Gosu::KbRight or Gosu::button_down? Gosu::GpRight then
  		@player.turn_right
  	end
  	if Gosu::button_down? Gosu::KbUp or Gosu::button_down? Gosu::GpButton0 then
  		@player.accelerate
  	end
  	@player.move
  	@player.collect_stars(@stars)
  	@player.explode_bombs(@bombs)

  	if rand(100) < 25 and @stars.size < 150 then
  		@stars.push(Star.new(@star_anim))
  	end

  	if rand(100) < 5 and @bombs.size < 15 then
  		@bombs.push(Bomb.new(@bomb_image))
  	end
  end

  def draw
  	@background_image.draw(0, 0, ZOrder::Background)
  	@player.draw
  	@stars.each { |star| star.draw }
  	@bombs.each { |bomb| bomb.draw }
  	@font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
  end

  def button_down(id)
  	if id == Gosu::KbEscape
  		close
  	end
  end
end

window = GameWindow.new
window.show