module ERLE

  class Map < Enum
    enclosure /\#\{/, /\}/
    @delimeter = ','

  end

end
