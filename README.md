# EnumType

`EnumType` provides support for defining Enumerated Types in Ruby.  An Enumerated Type is a class with a finite (and usually small) set of predefined, named values.

## Usage

Define a enumerated type by subclassing EnumType.  Use `.define` to define allowed values.

    class Colour < EnumType

      define :red do
        # ...
      end

      define :green do
        # ...
      end

      define :blue do
        # ...
      end

    end

Specific values are

## Contributing

It's on GitHub. You know what to do.
