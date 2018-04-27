module ERLE

  class Atom < Term

    def to_ruby
      @output ||= @input
    end

  end

  class OpenedAtom < Atom
    @pattern = /[a-z][A-z0-9_@]*/
    pattern /^#{@pattern.source}/

    def self.new *args
      superclass.new *args
    end

    def self.parse(parser)
      super do |result|
        new(result.to_sym)
      end
    end
  end

  class ClosedAtom < Atom
    @pattern = /[A-z0-9_@\:\-\. ]*/
    # pattern /^#{@pattern.source}/
    pattern /[^']*/
    enclosure /'/

    def self.new *args
      superclass.new *args
    end

  end

end
