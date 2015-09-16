module Hibari
  class Request
    attr_reader :env

    def initialize(env)
      @env = env
    end

    def uri
      @uri ||= URI.parse("#{scheme}://#{server_name}#{request_uri}")
    end

    def params
      @params ||= Hash[URI::decode_www_form(query_string)] # not implemented yet
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
  end
end
