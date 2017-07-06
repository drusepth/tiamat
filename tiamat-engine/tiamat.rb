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

      log('Injecting user models', channel: :startup)
      Dir[File.dirname(__FILE__) + '/../models/*.rb'].each do |file_path|
        log("Loading #{file_path}", channel: :internal)
        require_relative file_path
      end

      log('Injecting user services', channel: :startup)
      Dir[File.dirname(__FILE__) + '/../services/*.rb'].each do |file_path|
        log("Loading #{file_path}", channel: :internal)
        require_relative file_path
      end

      log('Engine initialized.', channel: :startup)
    end

    def self.log message, channel: :info
      # TODO logfiles
      puts "[#{channel}] #{message}"
    end
  end
end
