module Tiamat
  class World < BaseTiamatObject
    after_tick :display_world

    def display_world
      puts "world map"
    end
  end
end