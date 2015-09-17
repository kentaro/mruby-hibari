# mruby-hibari

A Web application framework for Web servers that support mruby and Rack-based API.

mruby-hibari currently supports the Web servers below:

  * [ngx_mruby](http://ngx.mruby.org/) enabled Nginx
  * [mod_mruby](http://mod.mruby.org/) enabled Apache
  * [h2o](https://h2o.examp1e.net/)

## Synopsis

Write once, run the same on any servers above.

### OOP Style

```ruby
class MyApp < Hibari::App
  def build
    res.code = 200
    res.headers["content-type"] = "text/html; charset=utf8"
    res.body.push("Hello, World!")
    req.params.each do |k,v|
      res.body.push("#{k}: #{v}")
    end
  end
end

MyApp.new.run
```

### DSL Style

```ruby
hibari do
  res.code = 200
  res.headers["content-type"] = "text/html; charset=utf8"
  res.body.push("Hello, World!")
  req.params.each do |k,v|
    res.body.push("#{k}: #{v}")
  end
end
```

## How to Setup

### ngx_mruby, mod_mruby

  1. Add dependency on mruby-hibari into the build_config.rb in mruby installation.
  2. Write mruby handler like above.

### h2o

  1. `git clone` at h2o/deps to embed mruby-hibari: `cd h2o/deps && git clone https://github.com/kentaro/mruby-hibari`
  2. Write mruby handler like above.

## API

### Hibari::Request

#### `env()` => `Hash`

Accesor to `ENV` passed from Web server.

#### `uri()` => `URI`

Build URI and returns it as `URI` object.

#### `params()` => `Hash`

Parse query string and returns it as `Hash` object.

(__This method currently does nothing about decoding or other, just split the query string with `&` and `=`__)

#### `request_method()` => `String`
#### `script_name()`    => `String`
#### `path_info()`      => `String`
#### `request_uri()`    => `String`
#### `query_string()`   => `String`
#### `server_name()`    => `String`
#### `server_addr()`    => `String`
#### `remote_addr()`    => `String`
#### `remote_port()`    => `String`
#### `scheme()`         => `String`
#### `engine_name()`    => `String`

Shortcuts to `env[XXX`].

### Hibari::Response

#### `code()`     => `Int`
#### `code=(Int)` => ()

Accessor to HTTP response code.

#### `headers()`      => `Hash`
#### `headers=(Hash)` => ()

Accessor to HTTP response headers.

#### `body()`       => `Array`
#### `body=(Array)` => ()

Accessor to HTTP response body.

#### `to_rack()` => `Array`

Returns an array that follows Rack's spec.

## Author

Kentaro Kuribayashi

## License

MIT
