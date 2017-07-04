module AgingProperty
  def self.included(base)
    base.send(:include, InstanceMethods)

    base.class_eval do
      include TickHook
      after_tick :increment_age
    end
  end

  module InstanceMethods
    attr_accessor :age

    def age
      @age || 0
    end

    def increment_age
      @age ||= 0
      @age  += 1
    end
  end
end