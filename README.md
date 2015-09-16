# mruby-hibari

A Web application framework for Web servers that support Rack-based API for mruby.

## Usage

### ngx_mruby, mod_mruby

  1. Add dependency on `mruby-hibari` into `build_config.rb`.
  2. Write mruby handler like below:

```ruby
class MyApp < Hibari::App
  def build
    res.code = 200
    res.headers["content-type"] = "text/html; charset=utf8"
    res.body.push("Hello, World!")
  end
end

run MyApp.new
```

### h2o

  1. `git clone` at h2o/deps: `cd h2o/deps && git clone https://github.com/kentaro/mruby-hibari`
  2. Write mruby handler like below:

```ruby
class MyApp < Hibari::App
  def build
    res.code = 200
    res.headers["content-type"] = "text/html; charset=utf8"
    res.body.push("Hello, World!")
  end
end

MyApp.new
```

h2o doesn't requre to execute `run` method unlike Rack's spec.

## API

### Hibari::Request

#### `env()` => Hash

Accesor to `ENV` passed from Web server.

#### `uri()` => URI

Build URI and returns it as `URI` object.

#### `request_method()` => String
#### `script_name()`    => String
#### `path_info()`      => String
#### `request_uri()`    => String
#### `query_string()`   => String
#### `server_name()`    => String
#### `server_addr()`    => String
#### `remote_addr()`    => String
#### `remote_port()`    => String
#### `scheme()`         => String

Shortcuts to `env[XXX`].

### Hibari::Response

#### `code()`     => Int
#### `code=(Int)` => ()

Accessor to HTTP response code.

#### `headers()`      => Hash
#### `headers=(Hash)` => ()

Accessor to HTTP response headers.

#### `body()`       => Array
#### `body=(Array)` => ()

Accessor to HTTP response body.

#### `to_rack()` => Array

Returns an array that follows Rack's spec.

## Author

Kentaro Kuribayashi

## License

MIT
