module Klass
  def dot_new(klass_name, methods)
    zelf = {}
    undefined_method = lambda do |message|
      raise "Error: #{message} is not defined"
    end
    register_methods!(zelf, methods)
    dispatch = lambda do |message|
      m = zelf[message]
      if m
        lambda do |*args|
          m[zelf, *args]
        end
      else
        undefined_method[message]
      end
    end

  end

  private # maybe could be public
  def method_names(methods)
    methods.select.with_index { |_, i| i.odd? }
  end

  def method_bodies(methods)
    methods.select.with_index { |_, i| i.even? }
  end

  def alias_method_name(method_name)
    method_name.to_s.gsub(/^def_/, "dot_").to_sym
  end

  def register_methods!(zelf, methods)
    names = method_names(alias_dot_new(methods)).map{ |name| alias_method_name(name) }
    bodies = method_bodies(methods)
    names.zip(bodies).each do |name body|
      zelf[name] = body
    end
  end

  def alias_dot_new(methods)
    initialize_declaration = methods.select.with_index do |name, index|
      name == :def_initialize
    end

    init_index = initialize_declaration[1]
    init_body = methods[init_index + 1]
    methods + [:def_new, init_body]
  end
end


DockingStation = Klass::dot_new[
  :DockingStation,
  [
    :def_initialize, lambda do |zelf, capacity|
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
  ]
]

# DockingStation[:dot_new][:dot_bikes]
# => []
