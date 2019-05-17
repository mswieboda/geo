module Geo
  class Player
    getter position : LibRay::Vector3
    getter rotation : LibC::Float

    target_model : LibRay::Model

    FORWARD_SPEED  =  15
    STRAFE_SPEED   =  10
    ROTATION_SPEED = 100

    def initialize
      # Note: length is spelled wrong in bindings:
      target_mesh = LibRay.gen_mesh_cube(width: 1, height: 1, lenght: 1)
      @target_model = LibRay.load_model_from_mesh(target_mesh)

      @position = LibRay::Vector3.new
      @rotation = 0
    end

    def update
      frame_time = LibRay.get_frame_time

      forward_delta = 0
      strafe_delta = 0
      rotation_delta = 0

      rotation_delta = 1 if LibRay.key_down?(LibRay::KEY_Q)
      rotation_delta = -1 if LibRay.key_down?(LibRay::KEY_E)

      forward_delta = 1 if LibRay.key_down?(LibRay::KEY_UP) || LibRay.key_down?(LibRay::KEY_W)
      forward_delta = -1 if LibRay.key_down?(LibRay::KEY_DOWN) || LibRay.key_down?(LibRay::KEY_S)

      strafe_delta = 1 if LibRay.key_down?(LibRay::KEY_LEFT) || LibRay.key_down?(LibRay::KEY_A)
      strafe_delta = -1 if LibRay.key_down?(LibRay::KEY_RIGHT) || LibRay.key_down?(LibRay::KEY_D)

      @rotation += ROTATION_SPEED * rotation_delta * frame_time if rotation_delta != 0

      if forward_delta != 0
        distance = FORWARD_SPEED * forward_delta * frame_time

        @position.z += distance * Math.cos(@rotation * (Math::PI / 180.0))
        @position.x += distance * Math.sin(@rotation * (Math::PI / 180.0))
      end

      if strafe_delta != 0
        distance = STRAFE_SPEED * strafe_delta.abs * frame_time
        angle_with_strafe = (@rotation + strafe_delta * 90)

        @position.z += distance * Math.cos(angle_with_strafe * (Math::PI / 180.0))
        @position.x += distance * Math.sin(angle_with_strafe * (Math::PI / 180.0))
      end
    end

    def draw
      LibRay.draw_model_ex(
        model: @target_model,
        position: @position,
        rotation_axis: LibRay::Vector3.new(x: 0, y: 1, z: 0),
        rotation_angle: @rotation,
        scale: LibRay::Vector3.new(x: 1, y: 1, z: 3),
        tint: LibRay::GREEN
      )
    end
  end
end
