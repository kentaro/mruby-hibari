env = {
  'REQUEST_METHOD'    => 'GET',
  'SCRIPT_NAME'       => "",
  'PATH_INFO'         => '/test',
  'REQUEST_URI'       => '/test?foo=bar&baz=qux',
  'QUERY_STRING'      => 'foo=bar&baz=qux',
  'SERVER_NAME'       => 'hibari.example.com',
  'SERVER_ADDR'       => '127.0.0.1',
  'SERVER_PORT'       => '40808',
  'REMOTE_ADDR'       => '127.0.0.1',
  'REMOTE_PORT'       => '40809',
  'rack.url_scheme'   => 'http',
  'rack.multithread'  => false,
  'rack.multiprocess' => true,
  'rack.run_once'     => false,
  'rack.hijack?'      => false,
  'server.name'       => 'Hibari',
  'server.version'    => '1.0',
}

class TestApp < Hibari::App
  def build
    res.code    = 200
    res.headers = {'x-test' => '1'}
    res.body    = ['test']
  end
end

assert 'Hibari::App#call' do
  app = TestApp.new
  res = app.call(env)

  assert_equal Array,             res.class
  assert_equal 200,               res[0]
  assert_equal({'x-test' => '1'}, res[1])
  assert_equal ['test'],          res[2]
end

assert 'Hibari::Request#params' do
  req = Hibari::Request.new(env)
  assert_equal(URI::HTTP, req.uri.class)
end

assert 'Hibari::Request#env_accessors' do
  req = Hibari::Request.new(env)

  assert_equal req.request_method, env['REQUEST_METHOD']
  assert_equal req.script_name,    env['SCRIPT_NAME']
  assert_equal req.path_info,      env['PATH_INFO']
  assert_equal req.request_uri,    env['REQUEST_URI']
  assert_equal req.query_string,   env['QUERY_STRING']
  assert_equal req.server_name,    env['SERVER_NAME']
  assert_equal req.server_addr,    env['SERVER_ADDR']
  assert_equal req.server_port,    env['SERVER_PORT']
  assert_equal req.remote_addr,    env['REMOTE_ADDR']
  assert_equal req.remote_port,    env['REMOTE_PORT']
  assert_equal req.scheme,         env['rack.url_scheme']
end

assert 'Hibari::Request#to_rack' do
  res = Hibari::Response.new
  res.code = 200

  assert_equal [200, {}, []], res.to_rack
end
