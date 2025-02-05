# Module for the snake window, sprite, and food classes

require 'gosu'

#Window parameters
WINX = 750
WINY = 750

# Z orderings
ZBKG = 0
ZFOOD, ZSPRITE = 1

# Image locations
FOODIMG = "media/star.png"
BKGIMG = "media/grass_background.png"


module Snake
  class Window < Gosu::Window
    def initialize()
      super(WINX, WINY, fullscreen: false)
      self.caption = "Snake Game"
      
      @background = Gosu::Image.new(BKGIMG, tileable: true)

    end

    def update()

    end

    def draw()
      @background.draw(0,0,ZBKG, 2.5, 2.5)

    end

    def button_down(id)
      if id == Gosu::KB_ESCAPE
        close
      else
        super()
      end
    end

  end

  class Sprite

  end

  class Food

  end


end
