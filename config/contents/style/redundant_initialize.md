Checks for `initialize` methods that are redundant.

An initializer is redundant if it does not do anything, or if it only
calls `super` with the same arguments given to it. If the initializer takes
an argument that accepts multiple values (`restarg`, `kwrestarg`, etc.) it
will not register an offense, because it allows the initializer to take a different
number of arguments as its superclass potentially does.

NOTE: If an initializer argument has a default value, RuboCop assumes it
to *not* be redundant.

NOTE: Empty initializers are registered as offenses, but it is possible
to purposely create an empty `initialize` method to override a superclass's
initializer.

@safety
    This cop is unsafe because if subclass overrides `initialize` method with
    a different arity than superclass.

### Example:
    # bad
    def initialize
    end

    # bad
    def initialize
      super
    end

    # bad
    def initialize(a, b)
      super
    end

    # bad
    def initialize(a, b)
      super(a, b)
    end

    # good
    def initialize
      do_something
    end

    # good
    def initialize
      do_something
      super
    end

    # good (different number of parameters)
    def initialize(a, b)
      super(a)
    end

    # good (default value)
    def initialize(a, b = 5)
      super
    end

    # good (default value)
    def initialize(a, b: 5)
      super
    end

    # good (changes the parameter requirements)
    def initialize(*)
    end

    # good (changes the parameter requirements)
    def initialize(**)
    end

    # good (changes the parameter requirements)
    def initialize(...)
    end

### Example: AllowComments: true (default)

    # good
    def initialize
      # Overriding to negate superclass `initialize` method.
    end

### Example: AllowComments: false

    # bad
    def initialize
      # Overriding to negate superclass `initialize` method.
    end
