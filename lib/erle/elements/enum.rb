module ERLE
  class Enum < Term

    class << self
      attr_accessor :delimeter
    end

    attr_accessor :terms

    @delimeter = ','

    def initialize(elements)
      @terms = elements.flatten(1)
    end

    def to_ruby
      @output ||= terms_to_ruby
    end

    def self.delimeter_regex
      @delimeter_regex ||= Regexp.new(Regexp.escape(delimeter))
    end

    def self.until_delimeter
      @until_delimeter ||= Regexp.new("[^#{Regexp.escape(delimeter)}]*")
    end

    def self.parse(parser)
      result = []
      delim = false # fake it into looking for the first value
      closed = false

      parser.until_done do
        case
        when parser.scan(close)
          closed = true
          parser.raise_unexpected_token("unexpected '#{delimeter}' before '#{close.source}'") if delim
          break
        when parser.scan(delimeter_regex)
          parser.raise_unexpected_token("expected '#{delimeter}' or '#{close.source}'") if parser.match?(close)
          parser.raise_unexpected_token if delim
          delim = true
        when !Parser::UNPARSED.equal?(value = parser.parse_value)
          delim = false
          result << value
        else
          parser.raise_unexpected_token
        end
      end

      parser.raise_unexpected_token("expected '#{close.source}'") unless closed

      new(result)
    end

  protected

    def terms_to_ruby
      @terms_to_ruby ||= @terms.collect do |term|
        term.is_a?(Term) ? term.to_ruby : term
      end
    end

    def one_or_all(array)
      array.length > 1 ? array : array[0]
    end

  end
end
