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
  'server.name'       => 'test server',
  'server.version'    => '1.0',
}

assert 'hibari' do
  app = hibari do
    res.body = ['test']
  end

  assert_equal Hibari::App, app.class
  assert_equal ['test'], app.call(env)[2]
end

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

assert 'Hibari::App#run' do
  app = TestApp.new

  # When the Web server is Nginx or Apache
  (Proc.new {
    Object.const_set(:Nginx, true)
    Object.define_method(:run) {|obj| obj.res.to_rack }

    res = app.run
    assert_equal Array, res.class

    Object.send(:remove_const, :Nginx)
    Object.send(:remove_method, :run)
  }).call

  # Or it is h2o
  res = app.run
  assert_equal TestApp, res.class
end

assert 'Hibari::Request#uri' do
  req = Hibari::Request.new(env)
  assert_equal(URI::HTTP, req.uri.class)
end

assert 'Hibari::Request#params' do
  req = Hibari::Request.new(env)
  assert_equal(req.params, {'foo' => 'bar', 'baz' => 'qux'})
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
  assert_equal req.engine_name,    env['server.name']
end

assert 'Hibari::Response#to_rack' do
  res = Hibari::Response.new

  assert_equal [500, {}, []], res.to_rack
end

assert 'Hibari::Response#flash!' do
  res = Hibari::Response.new
  res.code = 200
  res.headers['x-test'] = 1
  res.body = ['test']

  assert_equal res.code, 200
  assert_equal(res.headers, {'x-test' => 1})
  assert_equal res.body, ['test']

  res.flash!

  assert_equal res.code, 500
  assert_equal(res.headers, {})
  assert_equal res.body, []
end
