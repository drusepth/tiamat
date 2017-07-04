class Tiamat
  def self.initialize!
    log('Initializing Tiamat engine', channel: :startup)

    require_relative 'core/hooks/tick_hook'
    require_relative 'core/base_tiamat_object'
    require_relative 'objects/world'

    log('Engine initialized.', channel: :startup)
  end

  def self.log message, channel: :info
    # TODO logfiles
    puts "[#{channel}] #{message}"
  end
end
