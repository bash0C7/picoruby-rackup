# picoruby-rackup

`Rackup::Handler` for [PicoRuby](https://github.com/picoruby/picoruby) -
the server-registration-and-lookup slice of CRuby's `rackup` gem, and
nothing else.

A server registers itself with `Rackup::Handler.register(name, klass)`;
an app picks one with `Rackup::Handler.pick(names)`. Unlike CRuby's
`rackup`, this gem does not depend on `rack` (or PicoRuby's
`mruby-rack`) - registration and lookup never touch `Rack::` classes,
because `picoruby-rackup` doesn't need `config.ru` or default
middleware, and PicoRuby mrbgems have no lazy `require` to fall back on
for unregistered names.

This gem knows nothing about any specific server. See
[picobrick](https://github.com/bash0C7/picobrick) for a development
HTTP server that registers itself here.

Extracted from [bash0C7-homepage](https://github.com/bash0C7/bash0c7-homepage),
where it backs a self-hosted [Sinatra](https://github.com/udzura/picoruby-sinatra-covers)
admin console.

## Usage

```ruby
MRuby::Gem::Specification.new("your-gem") do |spec|
  spec.add_dependency "picoruby-rackup", github: "bash0C7/picoruby-rackup"
end
```

## License

MIT
