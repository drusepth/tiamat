class World < BaseTiamatObject
  during_tick :method_one
  during_tick :method_two

  def method_one
    puts 1
  end

  def method_two
    puts 2
  end
end
