Identifies usages of `map { ... }.flatten` and
change them to use `flat_map { ... }` instead.

### Example:
    # bad
    [1, 2, 3, 4].map { |e| [e, e] }.flatten(1)
    [1, 2, 3, 4].collect { |e| [e, e] }.flatten(1)

    # good
    [1, 2, 3, 4].flat_map { |e| [e, e] }
    [1, 2, 3, 4].map { |e| [e, e] }.flatten
    [1, 2, 3, 4].collect { |e| [e, e] }.flatten