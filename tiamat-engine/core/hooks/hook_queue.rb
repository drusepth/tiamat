module HookQueue
  HOOK_ORDERING     = [:before, :during, :after]
  PROPAGATION_STATE = :during

  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      def self.create_hook(hook_name)
        HookQueue::HOOK_ORDERING.each do |hook_order|
          define_singleton_method("#{hook_order}_#{hook_name}") do |method_name, *args|
            add_hook_handler(hook_name, method_name, hook_order, args)
          end
        end

        define_singleton_method("custom_#{hook_name}_order") do |method_name, priority, *args|
          add_hook_handler(hook_name, method_name, priority, args)
        end

        define_method hook_name do
          handlers = self.class.instance_variable_get(:@hook_handlers)

          if handlers && handlers[hook_name]
            Tiamat::Engine.log("Triggering #{hook_name} hooks for #{self.class}", channel: :internal)
          else
            Tiamat::Engine.log("No hook handlers registered on #{self.class}", channel: :internal)
            return
          end

          HookQueue::HOOK_ORDERING.each do |hook_state|
            handlers_for_this_hook_state = handlers[hook_name][hook_state] || []

            Tiamat::Engine.log([
              "- Activating methods " + handlers_for_this_hook_state.map { |hook, args| "#{hook}(#{args})" }.join(', '),
              "for #{self.class}::#{hook_name}_#{hook_state}"
            ].join(' '), channel: :internal)

            handlers_for_this_hook_state.each { |method_name, args| send(method_name, *args) }

            if hook_state == HookQueue::PROPAGATION_STATE
              # If this object contains other objects, we should propagate this hook downward during the during_* state
              if respond_to?(:contained_objects)
                Tiamat::Engine.log("Propagating #{hook_name} to this #{self.class}'s #{contained_objects.count} contained objects.", channel: :internal)
                contained_objects.each { |object| object.send(hook_name) }
              end
            end
          end

          self
        end
      end

      private

      def self.add_hook_handler(hook_name, method_name, priority, *args)
        raise "Invalid priority: #{priorty}" unless HookQueue::HOOK_ORDERING.include?(priority)
        Tiamat::Engine.log("Registering #{name}::#{priority}_#{hook_name} hook: #{method_name}", channel: :internal)

        @hook_handlers ||= {}
        @hook_handlers[hook_name] ||= Hash[HookQueue::HOOK_ORDERING.collect { |order| [order, []] }]
        @hook_handlers[hook_name][priority] << [method_name, *args]
      end
    end
  end

  module InstanceMethods
    def hook_handlers
      self.class.instance_variable_get(:@hook_handlers)
    end

    def possible_actions
      hook_handlers.keys
    end
  end
end
