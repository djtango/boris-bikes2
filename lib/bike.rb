require 'klass.rb'
Bike = Klass::dot_new(:Bike, [
  :def_initialize, lambda do |zelf|
    zelf[:at_working?] = true
  end,
  :def_working?, lambda do |zelf|
    zelf[:at_working?]
  end
])
