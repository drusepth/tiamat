module TickHook
  def self.included(base)
    base.class_eval do
      include HookQueue
      create_hook 'tick'
    end
  end
end