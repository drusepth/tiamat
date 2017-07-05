module AgingProperty
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
      @_age || 0
    end

    def increment_age
      @_age ||= 0
      @_age  += 1
    end
  end
end
