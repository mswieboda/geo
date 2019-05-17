module Geo
  class Camera
    property player : Player

    CAMERA_DISTANCE = 20

    def initialize(@player)
      @position = LibRay::Vector3.new(x: 0, y: 20, z: 0)
      @up = LibRay::Vector3.new(x: 0, y: 1, z: 0)
      @fovy = 45
      @camera = LibRay::Camera.new
      @rotation_angle = 0
    end

    def update
      @position.z = @player.position.z - CAMERA_DISTANCE * Math.cos(@player.rotation * (Math::PI / 180.0))
      @position.x = @player.position.x - CAMERA_DISTANCE * Math.sin(@player.rotation * (Math::PI / 180.0))

      @camera = LibRay::Camera.new(
        position: @position,
        target: @player.position,
        up: @up,
        fovy: @fovy
      )
    end

    def begin_3d_mode
      LibRay.begin_3d_mode(@camera)
    end
  end
end
