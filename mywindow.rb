# Module for the snake window, sprite, and food classes

require 'gosu'
require_relative 'sconst'
require_relative 'bettersnake'

module Snake_window
  class Main_window < Gosu::Window
    def initialize()
      super(Sconst::WINX, Sconst::WINY, fullscreen: false)
      self.caption = "Snake Game"
      
      # Score caption
      @score = Gosu::Font.new(50)

      #Snake sprite
      # TODO use snake class, not just head
      @icon = Gosu::Image.from_blob(25, 25, "\0\xFF\0\xFF" * (25 * 25))
      @snake = Snake::Snake_head.new(@icon)
      @snake.place(Sconst::WINX/2, Sconst::WINY/2)

      #Food pellets
      @pellets = []
      @animation = Scollect::Animation.new(Sconst::FOODIMG)

    end

    def update()
      if rand(100) < 4 and @pellets.length < 25
        @pellets.push(Snake::Star.new(@animation))
      end
    end

    def draw()
      @pellets.each do |pellet|
        pellet.draw()
      end

      @snake.draw()
    end

  #TODO implement turning controls here
    def button_down(id)
    end

  end
end
