
require 'erle/registry'

module ERLE

  class Parser < StringScanner

    UNPARSED              = Object.new.freeze
    IGNORE                = %r(
                              (?:
                               //[^\n\r]*[\n\r]| # line comments
                               /\*               # c-style comments
                               (?:
                                [^*/]|        # normal chars
                                /[^*]|        # slashes that do not start a nested comment
                                \*[^/]|       # asterisks that do not end this comment
                                /(?=\*/)      # single slash before this comment's end
                               )*
                                 \*/               # the End of this comment
                                 |[ \t\r\n]+       # whitespaces: space, horicontal tab, lf, cr
                              )+
                            )mx

    INTEGER               = /(-?0|-?[1-9]\d*)/
    FLOAT                 = /(-?
                            (?:0|[1-9]\d*)
                            (?:
                              \.\d+(?i:e[+-]?\d+) |
                              \.\d+ |
                              (?i:e[+-]?\d+)
                            )
                            )/x
    TRUE                  = /true/
    FALSE                 = /false/

    def initialize(source, opts = {})
      opts ||= {}
      # source = convert_encoding source
      super source
    end

    alias source string

    def parse
      reset
      obj = nil

      until_done do
        if eos?
          raise_parsing_error
        else
          obj = parse_value
          UNPARSED.equal?(obj) and raise_parsing_error
        end
      end

      eos? or raise_parsing_error
      obj
    end

    def skip_ignore
      skip(IGNORE)
    end

    def until_done
      result = nil
      while !eos?
        skip_ignore
        result = yield if block_given?
        skip_ignore
      end
      result
    end

    def peekaboo(peek = 30, back = 30)
      string[pos-back, peek+back]
    end

    def raise_parsing_error(message = "source is not valid Erlang!")
      # warn "Parsing =>\n#{string}"
      raise ParserError, "Parsing =>\n#{string}\n#{message}"
    end

    def whereami?(peek = 30, back = 30)
      back = [back, string.length - pos].sort[0]
      "#{peekaboo(peek, back)}'\n#{"─" * (back)}┘"
    end

    def raise_unexpected_token(followup=nil)
      message = "Unexpected token at:\n#{whereami?}"
      message += "\n#{followup}" if followup
      raise ParserError, message
    end

    def parse_value
      # TODO: handle symbols
      skip_ignore

      case
      when scan(TRUE)
        true
      when scan(FALSE)
        false
      when !eos? && scan(ERLE::Registry.openings_regex) # TODO: Take out !eos?
        regex, term_class = ERLE::Registry.open_find(matched)
        term_str = term_class.parse(self)
      else
        term_class, regex = ERLE::Registry.pattern_find do |p|
          match?(p)
        end

        if term_class
          term_class.parse(self)
        else
          UNPARSED
        end
      end
    end

  end

end
