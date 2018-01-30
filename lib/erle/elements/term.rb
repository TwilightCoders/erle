module ERLE

  class Term

    class << self
      attr_accessor :open, :close, :patterns
    end

    attr_accessor :input
    attr_accessor :output


    def self.patterns
      @patterns ||= Set.new
    end

    def self.pattern(p)
      patterns.add(p)
      ERLE::Registry.pattern(self, p)
    end

    def self.enclosure(one, two=one)
      @open = one.freeze
      @close = two.freeze
      ERLE::Registry.enclosure(self, one, two)
    end

    def initialize(input)
      @input = input
    end

    def to_ruby
      @input
    end

    def self.to_ruby(value)
      case value
      when Term
        value.to_ruby
      else
        value
      end
    end

    def self.until_any_closing
      @until_any_closing ||= Regexp.new("[^#{ERLE::Registry.closings_regex.source}]*")
    end

    def self.parse(parser)

      patterns.find do |pattern|
        parser.scan(pattern)
      end

      result = parser.matched

      if close && !parser.scan(close)
        raise parser.raise_unexpected_token("Expected term closure \" #{close.source} \"")
      end

      # # Make sure we kill any trailing close
      # # TODO: Consider raising if no match?
      # # TODO: Consider doing only if we started with an opening...
      # parser.scan(ERLE::Registry.closings_regex)
      # # binding.pry
      new(result)
    end

  end

end
