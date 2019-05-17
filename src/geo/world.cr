module Geo
  class World
    def initialize
      @camera = Camera.new

      # Note: length is spelled wrong in bindings:
      target_mesh = LibRay.gen_mesh_cube(width: 1, height: 1, lenght: 1)
      @target_model = LibRay.load_model_from_mesh(target_mesh)
    end

    def update
      @camera.update
    end

    def draw
      @camera.begin_3d_mode

      LibRay.draw_grid(100, 0.5)

      LibRay.draw_model_ex(
        model: @target_model,
        position: @camera.target,
        rotation_axis: LibRay::Vector3.new(x: 0, y: 1, z: 0),
        rotation_angle: @camera.rotation_angle,
        scale: LibRay::Vector3.new(x: 1, y: 1, z: 3),
        tint: LibRay::GREEN
      )

      LibRay.end_3d_mode
    end
  end
end
