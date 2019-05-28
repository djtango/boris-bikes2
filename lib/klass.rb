module Klass
  def Klass::dot_new(klass_name, methods)
    zelf = {}
    undefined_method = lambda do |message|
      raise "Error: #{message} is not defined"
    end
    Klass::register_methods!(zelf, klass_name, methods)
    dispatch = lambda do |message|
      puts "######### dispatch ###########"
      puts message
      m = zelf[message]
      if m
        lambda { |*args| m[zelf, *args] }
      else
        undefined_method[message]
      end
    end

    dispatch
  end

  # private # maybe could be public
  def Klass::method_names(methods)
    methods.select.with_index { |_, i| i.even? }
  end

  def Klass::method_bodies(methods)
    methods.select.with_index { |_, i| i.odd? }
  end

  def Klass::alias_method_name(method_name)
    method_name.to_s.gsub(/^def_/, "dot_").to_sym
  end

  def Klass::register_methods!(zelf, klass_name, methods)
    methods = Klass::alias_dot_new(methods)
    methods = Klass::add_dot_class(klass_name, methods)
    names = Klass::method_names(methods).map{ |name| alias_method_name(name) }
    bodies = Klass::method_bodies(methods)
    names.zip(bodies).each do |name, body|
      zelf[name] = body
    end
  end

  def Klass::alias_dot_new(methods)
    initialize_declaration = methods.map.with_index { |name, index|
      [name, index]
    }.select { |name_index|
      name_index[0] == :def_initialize
    }.first

    init_index = initialize_declaration[1]
    init_body = methods[init_index + 1]
    methods + [:def_new, init_body]
  end

  def Klass::add_dot_class(klass_name, methods)
    methods + [:dot_class?, lambda { || klass_name }]
  end
end


# DockingStation = Klass::dot_new[
#   :DockingStation,
#   [
#     :def_initialize, lambda do |zelf, capacity|
#       zelf[:at_capacity] = capacity
#       zelf[:at_bikes] = []
#     end,
#     :def_bikes, lambda do |zelf|
#       zelf[:at_bikes]
#     end,
#     :def_dock, lambda do |zelf, bike|
#       zelf[:at_bikes].push(bike)
#     end,
#     :def_release_bike, lambda do |zelf|
#       zelf[:at_bikes].pop
#     end
#   ]
# ]
#
# # DockingStation[:dot_new][:dot_bikes]
# # => []
