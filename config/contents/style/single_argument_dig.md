Sometimes using `dig` method ends up with just a single
argument. In such cases, dig should be replaced with `[]`.

Since replacing `hash&.dig(:key)` with `hash[:key]` could potentially lead to error,
calls to the `dig` method using safe navigation will be ignored.

@safety
    This cop is unsafe because it cannot be guaranteed that the receiver
    is an `Enumerable` or does not have a nonstandard implementation
    of `dig`.

### Example:
    # bad
    { key: 'value' }.dig(:key)
    [1, 2, 3].dig(0)

    # good
    { key: 'value' }[:key]
    [1, 2, 3][0]

    # good
    { key1: { key2: 'value' } }.dig(:key1, :key2)
    [1, [2, [3]]].dig(1, 1)

    # good
    keys = %i[key1 key2]
    { key1: { key2: 'value' } }.dig(*keys)
