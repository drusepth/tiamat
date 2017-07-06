module RandomMovementBehavior
  MINIMUM_X_MOVEMENT_DISTANCE = -1
  MAXIMUM_X_MOVEMENT_DISTANCE = 1

  MINIMUM_Y_MOVEMENT_DISTANCE = -1
  MAXIMUM_Y_MOVEMENT_DISTANCE = 1

  ENERGY_REQUIRED_PER_MOVEMENT = -3

  def self.included(base)
    base.send(:include, InstanceMethods)

    base.class_eval do
      create_hook 'move'
      during_tick :move

      during_move :move_randomly
      after_move  :adjust_energy, RandomMovementBehavior::ENERGY_REQUIRED_PER_MOVEMENT
    end
  end

  module InstanceMethods
    def move_randomly
      x_spread = RandomMovementBehavior::MAXIMUM_X_MOVEMENT_DISTANCE - RandomMovementBehavior::MINIMUM_X_MOVEMENT_DISTANCE
      y_spread = RandomMovementBehavior::MAXIMUM_Y_MOVEMENT_DISTANCE - RandomMovementBehavior::MINIMUM_Y_MOVEMENT_DISTANCE

      @_x += RandomMovementBehavior::MINIMUM_X_MOVEMENT_DISTANCE + rand(x_spread)
      @_y += RandomMovementBehavior::MINIMUM_Y_MOVEMENT_DISTANCE + rand(y_spread)
    end
  end
end
