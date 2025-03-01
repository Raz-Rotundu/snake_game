# Window class for the snake game

require 'gosu'
require_relative 'better_snake.rb'
require_relative 'sconst.rb'

module Snake_win
  
  class Game_window < Gosu::Window

    def initialize()
      super(Sconst::WINX, Sconst::WINY)
      self.caption = "Ruby Snake Game"

      @score_card = Gosu::Font.new(Sconst::SCORE_SIZE)
      
      @anim = Scollect::Animation.new(Sconst::FOODIMG, Sconst::FOODX, Sconst::FOODY)
      @stars = []

      @snake = Snake::Snake_sprite.new()
      @snake.place((Sconst::WINX / 2), (Sconst::WINY / 2))
    end

    def update()
      if Gosu.button_down?(Gosu::KB_UP) and not @snake.direction == 'd'
        @snake.turn('u')
      elsif Gosu.button_down?(Gosu::KB_DOWN) and not @snake.direction == 'u'
        @snake.turn('d')
      elsif Gosu.button_down?(Gosu::KB_LEFT) and not @snake.direction == 'r'
        @snake.turn('l')
      elsif Gosu.button_down?(Gosu::KB_RIGHT) and not @snake.direction == 'l'
        @snake.turn('r')
      end

      # TODO fix this
      if @snake.self_touch?
        self.close()
        @snake.reset()
      end 

      @snake.eat_star(@stars)
      @score = @snake.score()
      @snake.move()

      if rand(1..100) < 4 and @stars.length() < 20
        @stars.append(Snake::Star.new(@anim))
      end
      
      #TODO remove this
    end

    def draw()
      @snake.draw()

      @stars.each do |s|
        s.draw()
      end

      @score_card.draw_text("Score: #{@snake.score}", 0, 0, 1)
    end

    def button_down(id)
      if id == Gosu::KB_Q
        close()
      else
        super(id)
      end
    end

  end
end 
