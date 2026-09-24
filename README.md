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
for unregistered names (CRuby's `Rackup::Handler.get` retries a failed
lookup with `require "rackup/handler/#{name}"`; this gem only ever
returns what was already registered).

This gem knows nothing about any specific server. See
[picobrick](https://github.com/bash0C7/picobrick) for a development
HTTP server that registers itself here.

## Installation

```ruby
conf.gem github: 'bash0C7/picoruby-rackup', branch: 'main'
```

## Dependencies

None besides PicoRuby itself.

## Usage

A server registers a handler class once, typically at the bottom of its
own file:

```ruby
Rackup::Handler.register("picobrick", Rackup::Handler::Picobrick)
```

An app (or a framework like Sinatra's `run!`) picks one by name, or the
first available from a list, and calls `run`:

```ruby
handler = Rackup::Handler.pick(["picobrick"])   # or a single name
handler.run(app, Host: "127.0.0.1", Port: 8080) { |server| ... }
```

| Method | Behavior |
|---|---|
| `Rackup::Handler.register(name, klass)` | Associates `name` (String or Symbol, stored as a String) with `klass` |
| `Rackup::Handler.get(name)` | Returns the registered class, or `nil` if `name` is `nil` or unregistered |
| `Rackup::Handler.pick(names)` | Takes a name or an Array of names, returns the first registered match; raises `LoadError` if none match (same as CRuby) |

## Where this is tested

This gem doesn't (yet) carry its own test suite. Its behavior is exercised
via [bash0C7/bash0c7-homepage](https://github.com/bash0C7/bash0c7-homepage)'s
`test/picoruby/rackup_handler_test.rb`, where it backs a self-hosted
[Sinatra](https://github.com/udzura/picoruby-sinatra-covers) admin console
together with [picobrick](https://github.com/bash0C7/picobrick).

## License

MIT
