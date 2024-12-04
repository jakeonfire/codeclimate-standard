In Ruby 2.5, `String#delete_prefix` has been added.

This cop identifies places where `gsub(/\Aprefix/, '')` and `sub(/\Aprefix/, '')`
can be replaced by `delete_prefix('prefix')`.

This cop has `SafeMultiline` configuration option that `true` by default because
`^prefix` is unsafe as it will behave incompatible with `delete_prefix`
for receiver is multiline string.

The `delete_prefix('prefix')` method is faster than `gsub(/\Aprefix/, '')`.

@safety
    This cop is unsafe because `Pathname` has `sub` but not `delete_prefix`.

### Example:

    # bad
    str.gsub(/\Aprefix/, '')
    str.gsub!(/\Aprefix/, '')

    str.sub(/\Aprefix/, '')
    str.sub!(/\Aprefix/, '')

    # good
    str.delete_prefix('prefix')
    str.delete_prefix!('prefix')

### Example: SafeMultiline: true (default)

    # good
    str.gsub(/^prefix/, '')
    str.gsub!(/^prefix/, '')
    str.sub(/^prefix/, '')
    str.sub!(/^prefix/, '')

### Example: SafeMultiline: false

    # bad
    str.gsub(/^prefix/, '')
    str.gsub!(/^prefix/, '')
    str.sub(/^prefix/, '')
    str.sub!(/^prefix/, '')
