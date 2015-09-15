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

  assert_equal res.class, Array
  assert_equal res[0], 200
  assert_equal res[1], {'x-test' => '1'}
  assert_equal res[2], ['test']
end

assert 'Hibari::Request#params' do
  req = Hibari::Request.new(env)
  assert_equal req.params, {'foo' => 'bar', 'baz' => 'qux'}
end

assert 'Hibari::Request#to_rack' do
  res = Hibari::Response.new
  res.code = 200

  assert_equal [200, {}, []], res.to_rack
end
