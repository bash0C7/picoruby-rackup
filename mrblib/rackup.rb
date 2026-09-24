# CRubyのrackup 2.xの`Rackup::Handler`のうち、Sinatraの`run!`
# (`Rackup::Handler.pick(settings.server)`)が使う範囲。
#
# 特定のサーバーは知らない。サーバーの側が自分のhandlerを
# `Rackup::Handler.register`で登録する(CRubyのPumaが自分のgemで
# `Rackup::Handler::Puma`を登録するのと同じ形)。CRubyの`get`は未登録の名前を
# `rackup/handler/<name>`の遅延requireで探すが、PicoRubyのmrbgemには
# 遅延requireが無いので、登録済みのものだけを引く。
module Rackup
  module Handler
    @handlers = {}

    def self.register(name, klass)
      @handlers[name.to_s] = klass
    end

    def self.get(name)
      return nil if name.nil?

      @handlers[name.to_s]
    end

    # CRubyと同じく、どれも無ければLoadErrorを投げる
    def self.pick(names)
      list = names.is_a?(Array) ? names : [names]
      list.each do |name|
        handler = get(name)
        return handler if handler
      end
      raise LoadError, "Couldn't find handler for: #{list.join(', ')}."
    end
  end
end
