module ERLE
  class Binary < Enum
    enclosure /<</, />>/
    @delimeter = ','

    # TODO: handle specification.
    # http://erlang.org/doc/reference_manual/expressions.html#bit_syntax
    # Ei = Value |
    #      Value:Size |
    #      Value/TypeSpecifierList |
    #      Value:Size/TypeSpecifierList

    def to_ruby
      # using a string literal as in <<"abc">> is syntactic sugar for <<$a,$b,$c>>.
      @output ||= one_or_all(terms_to_ruby)
    end
  end

  # class BitString < Atom
  #   enclosure /<<\"/, /\">>/
  #   @delimeter = ','

  #   @enclosed_pattern = /[A-z0-9_@\-\.]*/
  #   @unopened_pattern = /[a-z][A-z0-9_@]*/

  #   @open = /<<\"/
  #   @close = /\">>/

  # end

end
