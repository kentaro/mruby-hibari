module Hibari
  class Request
    attr_reader :env

    def initialize(env)
      @env = env
    end

    def params
      unless @params
        @params = {}
        @env['QUERY_STRING'].split('&').each do |p|
          k, v = p.split('=')
          @params[k] = v
        end
      end

      @params
    end
  end
end
