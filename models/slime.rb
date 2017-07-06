# Slimes exist only to show off random movement
class Slime < Tiamat::Lifeform
  include AgingProperty
  include EnergyProperty
  include LocationProperty

  include RandomMovementBehavior
end
