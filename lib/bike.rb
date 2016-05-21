module Bike
  dot_new = lambda do ||
    dispatch = lambda do |message|
      case message
      when :dot_working?
        dot_working?
      else
        raise "Undefined method exception"
      end
    end

  dispatch
  end
end
