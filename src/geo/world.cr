module Geo
  class World
    def initialize
      @camera = LibRay::Camera.new(
        position: LibRay::Vector3.new(x: 0, y: 10, z: 10),
        target: LibRay::Vector3.new(x: 0, y: 0, z: 0),
        up: LibRay::Vector3.new(x: 0, y: 1, z: 0),
        fovy: 45
      )
    end

    def update
    end

    def draw
      LibRay.begin_3d_mode(@camera)

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
