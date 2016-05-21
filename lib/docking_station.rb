module DockingStation
  DEFAULT_CAPACITY = 20
  @dot_new = lambda do |capacity=DEFAULT_CAPACITY|
    dot_capacity = DEFAULT_CAPACITY
    dot_bikes = []

    dot_dock = lambda do |bike|
      puts "dot_dock: #{bike}"
      dot_bikes.push(bike)
      p @dot_bikes
    end

    dispatch = lambda do |message|
      puts "dispatch: #{message}"

      if message == :dot_dock
        return dot_dock
      elsif message == :dot_bikes
        return dot_bikes
      else
        raise "Undefined method exception: #{message}"
      end
      # case message
      # when :dot_dock
      #   dot_dock
      # when :dot_bikes
      #   dot_bikes
      # else
      #   raise "Undefined method exception"
      # end

      puts "end of dispatch"
    end
    puts "end of dot_new"

    dispatch
  end

  def dot_new
    @dot_new
  end
end

