module TickHook
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      include HookQueue
      create_hook 'tick'
    end
  end

  module InstanceMethods
  end
end