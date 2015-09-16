module Hibari
  class Request
    attr_reader :env

    def initialize(env)
      @env = env
    end

    def uri
      @uri ||= URI.parse("#{scheme}://#{server_name}:#{server_port}#{request_uri}")
    end

    def params
      @params ||= (Proc.new {
        params = {}

        query_string.split('&').each do |pair|
          k, v = pair.split('=')
          params[k] = v
        end

        params
      }).call
    end

    %w[
      REQUEST_METHOD
      SCRIPT_NAME
      PATH_INFO
      REQUEST_URI
      QUERY_STRING
      SERVER_NAME
      SERVER_ADDR
      SERVER_PORT
      REMOTE_ADDR
      REMOTE_PORT
    ].each do |n|
      define_method(n.downcase.to_sym) do
        @env[n]
      end
    end

    def scheme
      env['rack.url_scheme']
    end

    def engine_name
      env['server.name']
    end
  end
end
