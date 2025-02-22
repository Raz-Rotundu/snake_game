# Module containing a bunch of constants for the snake game

module Sconst
  # Window parameters
  WINX = 750
  WINY = 750


  # Z orderings
  ZBKG = 0
  ZFOOD = ZSPRITE  = ZTEXT = 1

  # Image locations + dimensions
  FOODIMG = "media/star.png"
  FOODX = FOODY = 25 # Tile size
  BKGIMG = "media/grass_background.png"

  # Font sizes for sprites and text
  SPRITESIZE = 12
  FONTSIZE = 24

  # Velocity of snake motion
  VEL = 2

  # Number of milliseconds before frame refresh
  REFRESH = 100

end
