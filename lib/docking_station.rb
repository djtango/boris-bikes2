module DockingStation
  DEFAULT_CAPACITY = 20
  @@self = DockingStation
  @@dot_class = :DockingStation
  @@dot_new = lambda do |capacity=DEFAULT_CAPACITY|
    dot_capacity = DEFAULT_CAPACITY
    dot_bikes = []

    dot_dock = lambda do |bike|
      dot_bikes.push(bike)
    end

    dot_release_bike = lambda do 
      dot_bikes.pop
    end

    dispatch = lambda do |message|

      case message
      when :dot_class?
        @@self::dot_class?
      when :dot_dock
        dot_dock
      when :dot_bikes
        dot_bikes
      when :dot_release_bike
        dot_release_bike
      else
        raise "Undefined method exception"
      end

    end

    dispatch
  end

  def DockingStation::dot_new
    @@dot_new
  end
  def DockingStation::dot_class?
    @@dot_class
  end
end

