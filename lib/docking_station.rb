module DockingStation
  DEFAULT_CAPACITY = 20
  @dot_new = lambda do |capacity=DEFAULT_CAPACITY|
    dot_capacity = DEFAULT_CAPACITY
    dot_bikes = []

    dot_dock = lambda do |bike|
      dot_bikes.push(bike)
    end

    dispatch = lambda do |message|

      case message
      when :dot_dock
        dot_dock
      when :dot_bikes
        dot_bikes
      else
        raise "Undefined method exception"
      end

    end

    dispatch
  end

  def dot_new
    @dot_new
  end
end

