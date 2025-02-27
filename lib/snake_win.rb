# Window class for the snake game

require 'gosu'
require_relative 'better_snake.rb'
require_relative 'sconst.rb'

module Snake_win
  
  class Game_window < Gosu::Window

    def initialize()
      super(Sconst::WINX, Sconst::WINY)
      self.caption = "Ruby Snake Game"

      @score = 0
      @score_card = Gosu::Font.new(Sconst::SCORE_SIZE)
      
      @icon = Gosu::Image.from_blob(25,25, "\0\xFF\0\xFF" * (25 * 25))

      @anim = Scollect::Animation.new(Sconst::FOODIMG, Sconst::FOODX, Sconst::FOODY)
      @stars = []

      @snake_head = Snake::Snake_head.new(@icon)
      @snake_head.place((Sconst::WINX / 2), (Sconst::WINY / 2))
    end

    def update()
      @snake_head.move()

      if rand(1..100) < 4 and @stars.length() < 20
        @stars.append(Snake::Star.new(@anim))
      end
  
    end

    def draw()
      @snake_head.draw()

      @stars.each do |s|
        s.draw()
      end

      @score_card.draw_text("Score: #{@score}", 0, 0, 1)
    end
  end
end 
