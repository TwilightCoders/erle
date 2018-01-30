module ERLE

  class Atom < Term
    @enclosed_pattern = /[A-z0-9_@\-\.]*/
    @unopened_pattern = /[a-z][A-z0-9_@]*/

    @open = @close = /'/

    # enclosure /'/
    pattern /^'#{@enclosed_pattern.source}'/
    pattern /^#{@unopened_pattern.source}/
    # pattern /^[a-z][a-z0-9_@\-\.]*/ # TODO: Handle uppercase

    INNER_PATTERN = /(#{@unopened_pattern}|#{@enclosed_pattern}|)/

    def to_ruby
      @output ||= @input
    end

  protected

    # An atom is a literal, a constant with name.
    # An atom is to be enclosed in single quotes (')
    # if it does not begin with a lower-case letter
    # or if it contains other characters than
    # alphanumeric characters, underscore (_), or @.
    def self.parse(parser)
      if (parser.scan(open))
        parser.scan(@enclosed_pattern)
        result = parser.matched
        parser.scan(close)
      elsif parser.scan(@unopened_pattern)
        result = parser.matched.to_sym
      else
        parser.raise_unexpected_token
      end

      new(result)
    end


  end

end
