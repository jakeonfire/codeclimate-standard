Identifies places where `gsub(/a+/, 'a')` and `gsub!(/a+/, 'a')`
can be replaced by `squeeze('a')` and `squeeze!('a')`.

The `squeeze('a')` method is faster than `gsub(/a+/, 'a')`.

### Example:

    # bad
    str.gsub(/a+/, 'a')
    str.gsub!(/a+/, 'a')

    # good
    str.squeeze('a')
    str.squeeze!('a')
