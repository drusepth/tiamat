module LocationProperty
  DEFAULT_X_COORDINATE = 0
  DEFAULT_Y_COORDINATE = 0

  def self.included(base)
    base.send(:include, InstanceMethods)

    base.class_eval do
      create_hook 'move'

      add_instance_initializer :initialize_location
    end
  end

  module InstanceMethods
    def initialize_location
      @_x ||= LocationProperty::DEFAULT_X_COORDINATE
      @_y ||= LocationProperty::DEFAULT_Y_COORDINATE
    end

    def location
      [@_x, @_y]
    end

    def _x
      @_x
    end

    def _y
      @_y
    end
  end
end
