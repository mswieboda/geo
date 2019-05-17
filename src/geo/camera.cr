module Geo
  class Camera
    getter target : LibRay::Vector3

    def initialize
      @position = LibRay::Vector3.new(x: 10, y: 20, z: 20)
      @target = LibRay::Vector3.new(x: 0, y: 0, z: 0)
      @up = LibRay::Vector3.new(x: 0, y: 1, z: 0)
      @fovy = 45
      @camera = LibRay::Camera.new
    end

    def update
      frame_time = LibRay.get_frame_time

      vert = 0
      horz = 0

      vert = -1 if LibRay.key_down?(LibRay::KEY_UP)
      vert = 1 if LibRay.key_down?(LibRay::KEY_DOWN)
      horz = -1 if LibRay.key_down?(LibRay::KEY_LEFT)
      horz = 1 if LibRay.key_down?(LibRay::KEY_RIGHT)

      @target.z += 10 * vert * frame_time if vert != 0
      @target.x += 10 * horz * frame_time if horz != 0

      update_camera
    end

    def update_camera
      @camera = LibRay::Camera.new(
        position: @position,
        target: @target,
        up: @up,
        fovy: @fovy
      )
    end

    def begin_3d_mode
      LibRay.begin_3d_mode(@camera)
    end
  end
end
