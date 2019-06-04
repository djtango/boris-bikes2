require 'klass.rb'
module DockingStation
  @@self = DockingStation
  @@klass = Klass::dot_new(:DockingStation, [
    :def_initialize, lambda do |zelf, capacity=20|
      zelf[:at_capacity] = capacity
      zelf[:at_bikes] = []
    end,
    :def_bikes, lambda do |zelf|
      zelf[:at_bikes]
    end,
    :def_dock, lambda do |zelf, bike|
      zelf[:at_bikes].push(bike)
    end,
    :def_release_bike, lambda do |zelf|
      zelf[:at_bikes].pop
    end
  ])

  def DockingStation::dot_new
    @@klass[:dot_new]
  end

  def DockingStation::dot_class?
    @@klass[:dot_class?]
  end
end
