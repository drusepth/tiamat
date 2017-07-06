module AgingProperty
  INITIAL_AGE         = 0
  AGE_INCREMENT_DELTA = 1

  def self.included(base)
    base.send(:include, InstanceMethods)

    base.class_eval do
      create_hook 'age'
      during_tick :age
      during_age  :increment_age

      add_instance_initializer :initialize_age
    end
  end

  module InstanceMethods
    attr_accessor :age

    def initialize_age
      @_age ||= AgingProperty::INITIAL_AGE
    end

    def _age
      @_age
    end

    def increment_age
      @_age += AgingProperty::AGE_INCREMENT_DELTA
    end
  end
end
