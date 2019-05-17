module Geo
  class Camera
    getter target : LibRay::Vector3

    def initialize
      @position = LibRay::Vector3.new(x: 10, y: 20, z: 20)
      @target = LibRay::Vector3.new(x: 0, y: 0, z: 0)
      @up = LibRay::Vector3.new(x: 0, y: 1, z: 0)
      @fovy = 45
      @camera = LibRay::Camera.new
      @mouse_x = 0
      @mouse_y = 0
    end

    def update
      frame_time = LibRay.get_frame_time

      z_delta = 0
      x_delta = 0

      z_delta = -1 if LibRay.key_down?(LibRay::KEY_UP) || LibRay.key_down?(LibRay::KEY_W)
      z_delta = 1 if LibRay.key_down?(LibRay::KEY_DOWN) || LibRay.key_down?(LibRay::KEY_S)

      x_delta = -1 if LibRay.key_down?(LibRay::KEY_LEFT) || LibRay.key_down?(LibRay::KEY_A)
      x_delta = 1 if LibRay.key_down?(LibRay::KEY_RIGHT) || LibRay.key_down?(LibRay::KEY_D)

      @target.z += 10 * z_delta * frame_time if z_delta != 0
      @target.x += 10 * x_delta * frame_time if x_delta != 0

      @position.z += 10 * z_delta * frame_time if z_delta != 0
      @position.x += 10 * x_delta * frame_time if x_delta != 0

      x_delta = 0
      y_delta = 0

      mouse_x = LibRay.get_mouse_x
      mouse_y = LibRay.get_mouse_y

      x_delta = -1 if mouse_x < @mouse_x
      x_delta = 1 if mouse_x > @mouse_x

      y_delta = -1 if mouse_y < @mouse_y
      y_delta = 1 if mouse_y > @mouse_y

      @target.x += 50 * x_delta * frame_time if x_delta != 0
      @target.y += -10 * y_delta * frame_time if y_delta != 0

      @position.y += 10 * y_delta * frame_time if y_delta != 0

      @mouse_x = mouse_x
      @mouse_y = mouse_y

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
