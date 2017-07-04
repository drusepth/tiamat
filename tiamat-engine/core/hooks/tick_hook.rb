module TickHook
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      include HookQueue
      create_hook 'tick'
    end
  end

  module InstanceMethods
    def tick
      tick_handlers = self.class.instance_variable_get(:@hook_handlers)['tick']
      return unless tick_handlers

      HookQueue::HOOK_ORDERING.each do |tick_state|
        tick_handlers[tick_state].each { |method_name| send(method_name) }
      end
    end
  end
end