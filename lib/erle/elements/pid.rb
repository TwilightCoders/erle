module ERLE

  # http://erlang.org/doc/reference_manual/data_types.html#id68255
  class Pid < Term

    class Data < ::String

      def to_erl
        "<#{self}>"
      end
    end

    enclosure /</, />/
    pattern %r{[-0-9](\.[0-9])+}
    # @delimeter = '.'

    def to_ruby
      @output ||= Data.new(@input)
    end
  end

end
