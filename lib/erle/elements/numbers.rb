module ERLE

  class Number < Term

  end

  class Float < Number
    pattern %r{[-0-9]\.[0-9]+}

    def to_ruby
      @output ||= @input.to_f
    end

  end

  class Integer < Number

    pattern %r{(-?0|-?[1-9]\d*)}

    def to_ruby
      @output ||= @input.to_i
    end

  end

end
