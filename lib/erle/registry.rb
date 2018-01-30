module ERLE

  module Registry
    class << self
      attr_accessor :_enclosures
      attr_accessor :_patterns
    end

    @_enclosures = {}
    @_patterns = {}

    def self.enclosure(klass, one, two)
      @_enclosures[one] = klass
    end

    def self.pattern(klass, pat)
      (@_patterns[klass] ||= Set.new).add(pat)
    end

    def self.pattern_find
      return unless block_given?
      @_patterns.each do |klass, patterns|
        pattern = patterns.find do |pattern|
          yield(pattern)
        end
        return [klass, pattern] if pattern
      end
      nil
    end

    def self.open_find(str)
      sorted_encolsures.find do |k, v|
        str =~ k
      end
    end

    def self.sorted_encolsures
      @sorted_encolsures ||= @_enclosures.sort_by { |pattern, klass| pattern.source.length }.reverse.to_h
    end

    def self.openings
      @openings ||= sorted_encolsures.keys
    end

    def self.openings_source
      @openings_source ||= openings.map(&:source)
    end

    def self.openings_regex
      @openings_regex ||= Regexp.new("(#{openings_source.join('|')})")
    end

    # def self.close_find(str)
    #   @_enclosures.values.find do |klass|
    #     str =~ klass.close
    #   end
    # end

    # def self.closings
    #   @closings ||= @_enclosures.values.collect(&:close).sort { |a, b| b.source.length <=> a.source.length }
    # end

    # def self.closings_source
    #   @closings_source ||= closings.map(&:source)
    # end

    # def self.closings_regex
    #   @closings_regex ||= Regexp.new("(#{closings_source.join('|')})")
    # end
  end
end
