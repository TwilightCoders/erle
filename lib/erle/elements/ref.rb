module ERLE

  class Ref < Term
    enclosure /\#Ref</, />/

    @delimeter = "."

    @pattern = %r{(?:(\d+)\.?)+}

    def initialize(input)
      @input = input
    end

    # TODO: Leverage Enum, and refactor (Enum) to handle conflicting delimiters
    # e.g. a "." delimeter is preempted by the "float" pattern.
    def to_ruby
      @output ||= @input.split(".")
    end

    def self.parse(parser)

      result = parser.scan(@pattern)

      if close && !parser.scan(close)
        raise parser.raise_unexpected_token("Expected term closure \" #{close.source} \"")
      end

      # Make sure we kill any trailing close
      # TODO: Consider raising if no match?
      # TODO: Consider doing only if we started with an opening...
      # parser.scan(ERLE::Registry.closings_regex)
      new(result)
    end

  end

end
