module Geo
  class Camera
    getter target : LibRay::Vector3
    getter rotation_angle : LibC::Float

    def initialize
      @position = LibRay::Vector3.new(x: 10, y: 20, z: 20)
      @target = LibRay::Vector3.new(x: 0, y: 0, z: 0)
      @up = LibRay::Vector3.new(x: 0, y: 1, z: 0)
      @fovy = 45
      @camera = LibRay::Camera.new
      @rotation_angle = 0
    end

    def update
      frame_time = LibRay.get_frame_time

      z_delta = 0
      x_delta = 0
      r_delta = 0

      r_delta = -1 if LibRay.key_down?(LibRay::KEY_Q)
      r_delta = 1 if LibRay.key_down?(LibRay::KEY_E)

      z_delta = -1 if LibRay.key_down?(LibRay::KEY_UP) || LibRay.key_down?(LibRay::KEY_W)
      z_delta = 1 if LibRay.key_down?(LibRay::KEY_DOWN) || LibRay.key_down?(LibRay::KEY_S)

      x_delta = -1 if LibRay.key_down?(LibRay::KEY_LEFT) || LibRay.key_down?(LibRay::KEY_A)
      x_delta = 1 if LibRay.key_down?(LibRay::KEY_RIGHT) || LibRay.key_down?(LibRay::KEY_D)

      @rotation_angle += -100 * r_delta * frame_time if r_delta != 0

      puts @rotation_angle

      @target.z += 10 * z_delta * frame_time if z_delta != 0
      @target.x += 10 * x_delta * frame_time if x_delta != 0

      @position.z += 10 * z_delta * frame_time if z_delta != 0
      @position.x += 10 * x_delta * frame_time if x_delta != 0

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
