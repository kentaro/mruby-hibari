module Hibari
  class App
    attr_reader :req, :res

    def initialize
      @res = Response.new
    end

    def call(env)
      @env = env
      @req = Request.new(env)
      @res.flash! if @res.dirty?

      build
      res.to_rack
    end

    def run
      engine = if Object.const_defined?(:Nginx)
                'nginx'
               elsif Object.const_defined?(:Apache)
                'apache'
               else # presume it's h2o
                'h2o'
               end

      case engine
      when 'nginx', 'apache'
        Kernel.run(self)
      when 'h2o'
        self
      end
    end
  end
end

Kernel.define_method(:hibari) do |&block|
  app = Hibari::App.new
  app.class.define_method(:build, &block)
  app.run
end
