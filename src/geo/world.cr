module Geo
  class World
    def initialize
      @camera = LibRay::Camera.new(
        position: LibRay::Vector3.new(x: 10, y: 20, z: 20),
        target: LibRay::Vector3.new(x: 0, y: 0, z: 0),
        up: LibRay::Vector3.new(x: 0, y: 1, z: 0),
        fovy: 45.0
      )

      LibRay.set_camera_mode(@camera, 2)
    end

    def update
      LibRay.update_camera(pointerof(@camera))
    end

    def draw
      LibRay.begin_3d_mode(@camera)

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
