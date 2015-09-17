module Hibari
  class Response
    attr_accessor :code, :headers, :body

    DEFAULT_CODE = 500

    def initialize
      flash!
    end

    def dirty?
      @code != DEFAULT_CODE ||
      !@headers.empty?      ||
      !@body.empty?
    end

    def flash!
      @code    = DEFAULT_CODE
      @headers = {}
      @body    = []
    end

    def to_rack
      [@code, @headers, @body]
    end
  end
end

