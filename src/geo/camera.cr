module Geo
  class Camera
    getter target : LibRay::Vector3
    getter rotation_angle : LibC::Float

    def initialize
      @position = LibRay::Vector3.new(x: -10, y: 20, z: -20)
      @target = LibRay::Vector3.new(x: 0, y: 0, z: 10)
      @up = LibRay::Vector3.new(x: 0, y: 1, z: 0)
      @fovy = 45
      @camera = LibRay::Camera.new
      @rotation_angle = 0
    end

    def update
      frame_time = LibRay.get_frame_time

      forward_delta = 0
      strafe_delta = 0
      rotation_delta = 0

      rotation_delta = -1 if LibRay.key_down?(LibRay::KEY_Q)
      rotation_delta = 1 if LibRay.key_down?(LibRay::KEY_E)

      forward_delta = 1 if LibRay.key_down?(LibRay::KEY_UP) || LibRay.key_down?(LibRay::KEY_W)
      forward_delta = -1 if LibRay.key_down?(LibRay::KEY_DOWN) || LibRay.key_down?(LibRay::KEY_S)

      strafe_delta = 1 if LibRay.key_down?(LibRay::KEY_LEFT) || LibRay.key_down?(LibRay::KEY_A)
      strafe_delta = -1 if LibRay.key_down?(LibRay::KEY_RIGHT) || LibRay.key_down?(LibRay::KEY_D)

      @rotation_angle += -100 * rotation_delta * frame_time if rotation_delta != 0

      if forward_delta != 0
        distance = 10 * forward_delta * frame_time

        @target.z += distance * Math.cos(@rotation_angle * (Math::PI / 180.0))
        @target.x += distance * Math.sin(@rotation_angle * (Math::PI / 180.0))
      end

      if strafe_delta != 0
        distance = 10 * strafe_delta.abs * frame_time
        angle_with_strafe = (@rotation_angle + strafe_delta * 90)

        @target.z += distance * Math.cos(angle_with_strafe * (Math::PI / 180.0))
        @target.x += distance * Math.sin(angle_with_strafe * (Math::PI / 180.0))
      end

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
