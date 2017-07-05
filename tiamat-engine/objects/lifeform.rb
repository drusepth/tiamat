module Tiamat
  class Lifeform < BaseTiamatObject
    include AgingProperty
    include EnergyProperty

    # after_age :method_three
    # def method_three
    #   puts 3
    # end
  end
end
