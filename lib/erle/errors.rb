module ERLE

  class Error < StandardError
  end

  class ParserError < ERLE::Error
  end

  class NestingError < ParserError
  end

end
