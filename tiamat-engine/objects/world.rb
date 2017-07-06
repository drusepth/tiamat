module Tiamat
  class World < BaseTiamatObject
    include DimensionsProperty

    attr_accessor :contained_objects

    after_tick :display_world

    def initialize
      self.contained_objects = []

      super
    end

    def spawn(object_class, args = {})
      Tiamat::Engine.log("Spawning #{object_class.name} in world with args #{args}", channel: :spawning)
      self.contained_objects << object_class.new(*args)
    end

    def display_world
      puts "world map"
    end
  end
end