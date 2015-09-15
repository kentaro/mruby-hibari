module Hibari
  class App
    attr_reader :req, :res

    def call(env)
      @env = env
      @req = Request.new(env)
      @res = Response.new

      build
      res.to_rack
    end
  end
end
