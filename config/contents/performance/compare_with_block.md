Identifies places where `sort { |a, b| a.foo <=> b.foo }`
can be replaced by `sort_by(&:foo)`.
This cop also checks `sort!`, `min`, `max` and `minmax` methods.

### Example:
    # bad
    array.sort   { |a, b| a.foo <=> b.foo }
    array.sort!  { |a, b| a.foo <=> b.foo }
    array.max    { |a, b| a.foo <=> b.foo }
    array.min    { |a, b| a.foo <=> b.foo }
    array.minmax { |a, b| a.foo <=> b.foo }
    array.sort   { |a, b| a[:foo] <=> b[:foo] }

    # good
    array.sort_by(&:foo)
    array.sort_by!(&:foo)
    array.sort_by { |v| v.foo }
    array.sort_by do |var|
      var.foo
    end
    array.max_by(&:foo)
    array.min_by(&:foo)
    array.minmax_by(&:foo)
    array.sort_by { |a| a[:foo] }