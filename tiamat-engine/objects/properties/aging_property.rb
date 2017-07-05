module AgingProperty
  INITIAL_AGE         = 0
  AGE_INCREMENT_DELTA = 1

  def self.included(base)
    base.send(:include, InstanceMethods)

    base.class_eval do
      create_hook 'age'
      during_tick :age
      during_age  :increment_age
    end
  end

  module InstanceMethods
    attr_accessor :age

    def _age
      @_age || AgingProperty::INITIAL_AGE
    end

    def increment_age
      @_age ||= AgingProperty::INITIAL_AGE
      @_age  += AgingProperty::AGE_INCREMENT_DELTA
    end
  end
end
