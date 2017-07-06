module DimensionsProperty
  DEFAULT_HEIGHT = 20
  DEFAULT_WIDTH  = 20

  def self.included(base)
    base.send(:include, InstanceMethods)

    base.class_eval do
      add_instance_initializer :initialize_dimensions
    end
  end

  module InstanceMethods
    def initialize_dimensions
      @_width  ||= DimensionsProperty::DEFAULT_WIDTH
      @_height ||= DimensionsProperty::DEFAULT_HEIGHT
    end

    def dimensions
      [@_width, @_height]
    end

    def _width
      @_width
    end

    def _height
      @_height
    end
  end
end
