module Tiamat
  class Engine
    def self.initialize!
      log('Initializing Tiamat engine', channel: :startup)

      require_relative 'core/hooks/hook_queue'
      require_relative 'core/hooks/tick_hook'

      require_relative 'objects/properties/aging_property'
      require_relative 'objects/properties/energy_property'
      require_relative 'objects/properties/location_property'

      require_relative 'objects/behaviors/random_movement_behavior'

      require_relative 'core/base_tiamat_object'

      require_relative 'objects/world'
      require_relative 'objects/lifeform'

      log('Injecting user models', channel: :startup)
      load_user_models!

      log('Injecting user services', channel: :startup)
      load_user_services!

      log('Engine initialized.', channel: :startup)
    end

    def self.log message, channel: :info
      # TODO logfiles
      puts "[#{channel}] #{message}"
    end

    private

    def self.load_user_models!
      Dir[File.dirname(__FILE__) + '/../models/*.rb'].each do |file_path|
        log("Loading #{file_path}", channel: :internal)
        require_relative file_path
      end
    end

    def self.load_user_services!
      Dir[File.dirname(__FILE__) + '/../services/*.rb'].each do |file_path|
        log("Loading #{file_path}", channel: :internal)
        require_relative file_path
      end
    end
  end
end
