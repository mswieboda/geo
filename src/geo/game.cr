module Geo
  class Game
    SCREEN_WIDTH  = 1024
    SCREEN_HEIGHT =  768

    DEBUG = false

    TARGET_FPS = 60
    DRAW_FPS   = DEBUG

    def initialize
      LibRay.init_window(SCREEN_WIDTH, SCREEN_HEIGHT, "Geo")
      LibRay.set_target_fps(TARGET_FPS)
      @world = World.new
    end

    def run
      while !LibRay.window_should_close?
        update
        draw_init
      end

      close
    end

    def update
      @world.update
    end

    def draw
      @world.draw

      LibRay.draw_fps(0, 0) if DRAW_FPS
    end

    def draw_init
      LibRay.begin_drawing
      LibRay.clear_background LibRay::BLACK

      draw

      LibRay.end_drawing
    end

    def close
      LibRay.close_window
    end
  end
end
