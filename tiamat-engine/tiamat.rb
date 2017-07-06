module Tiamat
  class Engine
    def self.initialize!
      log('Initializing Tiamat engine', channel: :startup)

      require_relative 'core/hooks/hook_queue'
      require_relative 'core/hooks/tick_hook'

      require_relative 'objects/properties/aging_property'
      require_relative 'objects/properties/energy_property'
      require_relative 'objects/properties/location_property'

      require_relative 'core/base_tiamat_object'

      require_relative 'objects/world'
      require_relative 'objects/lifeform'

      log('Engine initialized.', channel: :startup)
    end

    def self.log message, channel: :info
      # TODO logfiles
      puts "[#{channel}] #{message}"
    end
  end
end
