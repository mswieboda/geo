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
        position: LibRay::Vector3.new(x: 0, y: 0, z: 0),
        width: 3,
        height: 3,
        length: 3,
        color: LibRay::GREEN
      )

      LibRay.end_3d_mode
    end
  end
end
