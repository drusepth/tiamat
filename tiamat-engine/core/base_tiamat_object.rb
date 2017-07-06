module Tiamat
  class BaseTiamatObject
    include TickHook

    def initialize
      hook_initializers = self.class.instance_variable_get(:@hook_initializers) || []
      hook_initializers.each do |method_name|
        Tiamat::Engine.log("Running hook initializer #{method_name}", channel: :internal)
        send(method_name)
      end
    end
  end
end
