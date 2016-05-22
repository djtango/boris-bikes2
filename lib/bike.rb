module Bike
  @@dot_class = :Bike
  @@self = Bike
  @@dot_new = lambda do ||
    dot_working = true

    dispatch = lambda do |message|
      case message
      when :dot_class?
        @@self::dot_class?
      when :dot_working?
        dot_working
      else
        raise "Undefined method exception"
      end
    end

  dispatch
  end

  def Bike::dot_new
    @@dot_new
   end

  def Bike::dot_class?
    @@dot_class
  end
end
