# Provide support for defining enumerated types.
#
# Example
#
#   class Colour < AnotherEnum
#
#     define :red do
#       # ...
#     end
#
#     define :green do
#       # ...
#     end
#
#     define :blue do
#       # ...
#     end
#
#   end
#
class AnotherEnum

  class << self

    protected :new # prevent arbitrary new instances

    # Public: Declare a enumerated value.
    #
    # code - a unique (String) code that identifies this value
    # block - optional block defines behaviour specific to this value
    #
    # Example
    #
    #   class Colour < AnotherEnum; end
    #
    #   Colour.define :red do
    #
    #     def rgb
    #       "#ff0000"
    #     end
    #
    #   end
    #
    def define(code, &block)
      code = code.to_sym.to_s
      value = generate_value(code, &block)
      register_value(code, value)
    end

    # Public: Succintly declare methods to return hardcoded values.
    #
    # attributes - a Hash; a method will be generated for each key, returning
    #              the corresponding value
    #
    # Example
    #
    #   Colour.define :red do
    #
    #     hardcode :rgb => "#ff0000"
    #
    #   end
    #
    def hardcode(attributes)
      attributes.each do |name, value|
        define_method(name) { value }
      end
    end

    def get(arg)
      return arg if self === arg
      @all_by_code[arg.to_s]
    end

    alias [] get

    def fetch(code)
      get(code) || raise(ArgumentError, "no such #{self}: #{code.inspect}")
    end

    def all
      @all_by_code.values
    end

    def codes
      @all_by_code.keys
    end

    private

    def generate_value(code, &block)
      new.tap do |value|
        value.singleton_class.class_eval do
          define_method(:code) { code }
          define_method("#{code}?") { true }
          class_eval(&block) if block
        end
      end
    end

    def register_value(code, value)
      singleton_class.send(:define_method, code) { value }            # e.g. Brand.hooroo
      class_eval "def #{code}?; false; end"                           # e.g. other_brand.hooroo?
      @all_by_code ||= {}
      @all_by_code[code] = value
    end

  end

  def to_s
    code
  end

  def inspect
    "#{self.class}.#{code}"
  end

end

module Kernel
  def singleton_class
    class << self
      self
    end
  end unless respond_to?(:singleton_class)
end
