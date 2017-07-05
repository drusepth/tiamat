module EnergyProperty
  MINIMUM_ENERGY = 0
  DEFAULT_ENERGY = 100
  MAXIMUM_ENERGY = 300

  ENERGY_DELTA_PER_TICK    = -1
  ENERGY_REGAINED_PER_REST = 10

  def self.included(base)
    base.send(:include, InstanceMethods)

    base.class_eval do
      create_hook 'rest'

      before_tick :initialize_energy
      after_tick  :adjust_energy, EnergyProperty::ENERGY_DELTA_PER_TICK
      after_tick  :bound_energy

      before_rest :initialize_energy
      during_rest :regain_energy_from_resting, EnergyProperty::ENERGY_REGAINED_PER_REST
      after_rest  :bound_energy
    end
  end

  module InstanceMethods
    attr_accessor :age

    def initialize_energy
      @_energy ||= EnergyProperty::DEFAULT_ENERGY
    end

    def _energy
      @_energy || EnergyProperty::DEFAULT_ENERGY
    end

    def adjust_energy(amount)
      @_energy  += amount
    end

    def bound_energy
      @_energy = [EnergyProperty::MINIMUM_ENERGY, @_energy].max
      @_energy = [@_energy, EnergyProperty::MAXIMUM_ENERGY].min
    end

    def regain_energy_from_resting(amount)
      @_energy += EnergyProperty::ENERGY_REGAINED_PER_REST
    end
  end
end
