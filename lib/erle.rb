require 'strscan'
require 'erle/version'
require 'erle/errors'

require 'erle/parser'

require 'erle/elements/term'
require 'erle/elements/enum'
require 'erle/elements/numbers'
require 'erle/elements/atom'
require 'erle/elements/binary'
require 'erle/elements/list'
require 'erle/elements/pid'
require 'erle/elements/ref'
require 'erle/elements/string'
require 'erle/elements/tuple'

module ERLE

    def self.parse(str)
      Parser.new(str).parse
    end

    def self.to_ruby(str)
      parse(str).to_ruby
    end

end
