# Module containing a bunch of constants for the snake game

module Sconst
  # Window parameters
  WINX = 750
  WINY = 750


  # Z orderings
  ZBKG = 0
  ZFOOD = ZSPRITE  = ZTEXT = 1

  # Image locations + dimensions
  FOODIMG = 'media/star.png'
  FOODX = FOODY = 25 # Tile size
  BKGIMG = 'media/grass_background.png'

  # Font sizes for sprites and text
  SPRITESIZE = 12
  FONTSIZE = 24

  # Hex for the green color
  GREEN_HEX = "\0\xFF\0\xFF"

  # Velocity of snake motion
  VEL = 4

  # Number of milliseconds before frame refresh
  REFRESH = 100

  #Scorecard dimensions
  SCORE_SIZE = 50

  # Spacing for snake body segments
  SEG_SPACE = 100

  # Number of pixels distance to be considered touching
  TOUCH_DIST = 35

end
