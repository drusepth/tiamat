module TickHook
  TICK_ORDERING = [:before, :during, :after]

  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend(ClassMethods)
  end

  module InstanceMethods
    def tick
      tick_handlers = self.class.instance_variable_get(:@tick_handlers)
      TickHook::TICK_ORDERING.each do |tick_state|
        tick_handlers[tick_state].each { |method_name| send(method_name) }
      end
    end
  end

  module ClassMethods

    def before_tick(method_name)
      add_tick_handler(method_name, :before)
    end

    def during_tick(method_name)
      add_tick_handler(method_name, :during)
    end

    def after_tick(method_name)
      add_tick_handler(method_name, :after)
    end

    # For use when overriding TickHook::TICK_ORDERING
    def custom_tick_order(method_name, priority)
      add_tick_handler(method_name, priority)
    end

    private

    def add_tick_handler(method_name, priority)
      raise "Invalid priority: #{priorty}" unless TickHook::TICK_ORDERING.include?(priority)
      @tick_handlers ||= Hash[TickHook::TICK_ORDERING.collect { |order| [order, []] }]

      @tick_handlers[priority] << method_name
    end
  end
end