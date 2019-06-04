module Klass
  def self.dot_new(klass_name, methods)
    klass_obj = {}
    undefined_method = lambda do |message|
      raise "Error: #{message} is not defined"
    end
    register_methods!(klass_obj, klass_name, methods)
    dispatch = lambda do |message|
      method = klass_obj[message]
      if method
        lambda { |*args| method[klass_obj, *args] }
      else
        undefined_method[message]
      end
    end

    dispatch
  end

  # private # maybe could be public
  def self.method_names(methods)
    methods.select.with_index { |_, i| i.even? }
  end

  def self.method_bodies(methods)
    methods.select.with_index { |_, i| i.odd? }
  end

  def self.alias_method_name(method_name)
    method_name.to_s.gsub(/^def_/, "dot_").to_sym
  end

  def self.register_methods!(klass_obj, klass_name, methods)
    methods = generate_dot_new(methods)
    methods = add_dot_class(klass_name, methods)
    names = method_names(methods).map{ |name| alias_method_name(name) }
    bodies = method_bodies(methods)
    names.zip(bodies).each do |name, body|
      klass_obj[name] = body
    end
  end

  def self.generate_dot_new(methods)
    initialize_declaration = methods.map.with_index { |name, index|
      [name, index]
    }.select { |name_index|
      name_index[0] == :def_initialize
    }.first

    init_index = initialize_declaration[1]
    init_body = methods[init_index + 1]
    # is this pattern inheritance?
    new_body = lambda do |zelf, *args|
      # dup is technically prototype-based inheritance, but is this WAD for ruby where the class could be modified at run-time?
      # could call register_methods again...
      klass_instance = zelf.dup
      init_body[klass_instance, *args]
      dispatch = lambda do |message|
        method = klass_instance[message]
        if method
          lambda { |*args| method[klass_instance, *args] }
        else
          undefined_method[message]
        end
      end
      dispatch
    end
    methods + [:def_new, new_body]
  end

  def self.add_dot_class(klass_name, methods)
    methods + [:dot_class?, lambda { |zelf| klass_name }]
  end
end
