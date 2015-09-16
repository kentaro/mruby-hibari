module Hibari
  class App
    attr_reader :req, :res

    def initialize
      @res = Response.new
    end

    def call(env)
      @env = env
      @req = Request.new(env)

      build
      res.to_rack
    end

    def run
      engine = if Kernel.const_defined?(:Nginx)
                'nginx'
               elsif Kernel.const_defined?(:Apache)
                'apache'
               else
                'h2o'
               end

      case engine
      when 'nginx' || 'apache'
        Kernel.run(self)
      when 'h2o' # presume it's h2o
        self
      end
    end
  end
end
