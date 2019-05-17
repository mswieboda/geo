require "cray"
require "./geo/*"

module Geo
  def self.run
    Game.new.run
  end
end

Geo.run
