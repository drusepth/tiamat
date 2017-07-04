module HookQueue
  HOOK_ORDERING = [:before, :during, :after]

  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      def self.create_hook(hook_name)
        HookQueue::HOOK_ORDERING.each do |hook_order|
          define_singleton_method("#{hook_order}_#{hook_name}") do |method_name|
            add_hook_handler(hook_name, method_name, hook_order)
          end
        end

        define_singleton_method("custom_#{hook_name}_order") do |method_name, priority|
          add_hook_handler(hook_name, method_name, priority)
        end
      end

      private

      def self.add_hook_handler(hook_name, method_name, priority)
        raise "Invalid priority: #{priorty}" unless HookQueue::HOOK_ORDERING.include?(priority)
        Tiamat::Engine.log("Registering #{priority}_#{hook_name} on #{name}: #{method_name}", channel: :internal)

        @hook_handlers ||= {}
        @hook_handlers[hook_name] ||= Hash[HookQueue::HOOK_ORDERING.collect { |order| [order, []] }]
        @hook_handlers[hook_name][priority] << method_name
      end
    end
  end

  module InstanceMethods
    def hook_handlers
      self.class.instance_variable_get(:@hook_handlers)
    end
  end
end