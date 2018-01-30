module ERLE

  class String < Term
    enclosure /\"/
    # pattern %r{((?:[^\x0-\x1f'\\] |
    #              # escaped special characters:
    #             \\["/bfnrt] |
    #             \\u[0-9a-fA-F]{4} |
    #              # match all but escaped special characters:
    #             \\[\x20-\x21\x23-\x2e\x30-\x5b\x5d-\x61\x63-\x65\x67-\x6d\x6f-\x71\x73\x75-\xff])*)
    #         }nx

    PATTERN = %r{[^\"]*}nx

    def to_ruby
      # self.str.gsub(/"/,"")
      @output ||= @input
    end

    def self.parse(parser)
      opener = parser.matched == "\""

      parser.scan(PATTERN)
      result = parser.matched

      parser.scan(close) if opener

      new(result)
    end

  end

end
