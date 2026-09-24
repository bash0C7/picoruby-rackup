# picoruby-rackup: CRubyのrackup gemのうち、`Rackup::Handler`(サーバーの登録と検索)の
# PicoRuby版。特定のサーバーは知らず、サーバーの側が自分のhandlerを登録する。
#
# CRubyのrackupはrack gemに依存するが、これはmruby-rack(rack gemのうちapp側の道具の
# 移植)に依存しない。handlerの登録と検索は`Rack::`のクラスを使わない(CRubyのrackupが
# rackを要るのはconfig.ruと既定のmiddlewareのためで、picoruby-rackupはどちらも持たない)。
MRuby::Gem::Specification.new("picoruby-rackup") do |spec|
  spec.license = "MIT"
  spec.author = "bash0C7"
  spec.summary = "Rackup::Handler for PicoRuby"
end
