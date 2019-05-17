module Geo
  class World
    def initialize
      @camera = Camera.new
    end

    def update
      @camera.update
    end

    def draw
      @camera.begin_3d_mode

      LibRay.draw_grid(100, 0.5)

      LibRay.draw_cube(
        position: @camera.target,
        width: 1,
        height: 1,
        length: 1,
        color: LibRay::GREEN
      )

      LibRay.end_3d_mode
    end
  end
end
