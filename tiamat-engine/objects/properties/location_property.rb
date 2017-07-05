module LocationProperty
  DEFAULT_X_COORDINATE = 0
  DEFAULT_Y_COORDINATE = 0

  MINIMUM_X_MOVEMENT_DISTANCE = -1
  MAXIMUM_X_MOVEMENT_DISTANCE = 1

  MINIMUM_Y_MOVEMENT_DISTANCE = -1
  MAXIMUM_Y_MOVEMENT_DISTANCE = 1

  ENERGY_REQUIRED_PER_MOVEMENT = -5

  def self.included(base)
    base.send(:include, InstanceMethods)

    base.class_eval do
      create_hook 'move'
      during_tick :move

      before_move :initialize_location
      during_move :move_randomly
      after_move  :adjust_energy, LocationProperty::ENERGY_REQUIRED_PER_MOVEMENT
    end
  end

  module InstanceMethods
    def initialize_location
      @_x ||= LocationProperty::DEFAULT_X_COORDINATE
      @_y ||= LocationProperty::DEFAULT_Y_COORDINATE
    end

    #TODO: move this to a RandomMovement behavior
    def move_randomly
      x_spread = LocationProperty::MAXIMUM_X_MOVEMENT_DISTANCE - LocationProperty::MINIMUM_X_MOVEMENT_DISTANCE
      y_spread = LocationProperty::MAXIMUM_Y_MOVEMENT_DISTANCE - LocationProperty::MINIMUM_Y_MOVEMENT_DISTANCE

      @_x += LocationProperty::MINIMUM_X_MOVEMENT_DISTANCE + rand(1 + x_spread)
      @_y += LocationProperty::MINIMUM_Y_MOVEMENT_DISTANCE + rand(1 + y_spread)
    end

    def location
      initialize_location
      [@_x, @_y]
    end

    def _x
      @_x || LocationProperty::DEFAULT_X_COORDINATE
    end

    def _y
      @_y || LocationProperty::DEFAULT_Y_COORDINATE
    end
  end
end
