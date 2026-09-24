# picoruby-rackupの`Rackup::Handler`(mrblib/rackup.rb)。
# Sinatraの`run!`が`Rackup::Handler.pick(settings.server)`で引く登録の仕組み。
class RackupHandlerTest < Picotest::Test
  class FakeHandler; end

  def test_register_then_get
    Rackup::Handler.register("fake", FakeHandler)
    assert_equal(FakeHandler, Rackup::Handler.get("fake"))
  end

  def test_get_accepts_a_symbol
    Rackup::Handler.register("fake", FakeHandler)
    assert_equal(FakeHandler, Rackup::Handler.get(:fake))
  end

  def test_get_unknown_is_nil
    assert_nil(Rackup::Handler.get("nothing-here"))
  end

  def test_pick_returns_first_available
    Rackup::Handler.register("fake", FakeHandler)
    assert_equal(FakeHandler, Rackup::Handler.pick(["puma", "fake"]))
  end

  def test_pick_accepts_a_single_name
    Rackup::Handler.register("fake", FakeHandler)
    assert_equal(FakeHandler, Rackup::Handler.pick("fake"))
  end

  def test_pick_raises_load_error_when_none
    assert_raise(LoadError) { Rackup::Handler.pick(["puma", "thin"]) }
  end
end
