# mruby-hibari

A Web application framework for Web servers that support Rack-based API for mruby.

## Usage

```ruby
# in your mruby handler

class MyApp < Hibari::App
  def build
    res.body = req.params.map {|k,v| "#{k}: #{v}" }
  end
end

run MyApp.new
```

## Author

Kentaro Kuribayashi

## License

MIT
