Checks for inheritance from Struct.new.

@safety
    Autocorrection is unsafe because it will change the inheritance
    tree (e.g. return value of `Module#ancestors`) of the constant.

### Example:
    # bad
    class Person < Struct.new(:first_name, :last_name)
      def age
        42
      end
    end

    # good
    Person = Struct.new(:first_name, :last_name) do
      def age
        42
      end
    end