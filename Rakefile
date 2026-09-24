require "fileutils"
require "rbconfig"

task default: :test

VENDOR_DIR = File.join(__dir__, "vendor")
PICORUBY_DIR = File.join(VENDOR_DIR, "picoruby")
PICORUBY_BIN = File.join(PICORUBY_DIR, "build", "host", "bin", "picoruby")

task :clean do
  FileUtils.rm_rf(VENDOR_DIR)
end

task :test do
  unless File.exist?(PICORUBY_BIN)
    unless File.directory?(File.join(PICORUBY_DIR, ".git"))
      FileUtils.mkdir_p(VENDOR_DIR)
      system("git", "clone", "--depth", "1", "https://github.com/picoruby/picoruby.git", PICORUBY_DIR, exception: true)
    end
    Dir.chdir(PICORUBY_DIR) do
      system("git", "submodule", "update", "--init", "--depth", "1", "--recursive", exception: true)
      system({ "CONFIG" => "picoruby-test" }, "rake", exception: true)
    end
  end

  picotest_lib = File.join(PICORUBY_DIR, "mrbgems", "picoruby-picotest", "mrblib")
  load_files = ["mrblib/rackup.rb"].map { |f| File.join(__dir__, f) }
  runner = <<~RUBY
    $LOAD_PATH.unshift #{picotest_lib.inspect}
    require "picotest"
    ENV["RUBY"] = #{PICORUBY_BIN.inspect}
    exit Picotest::Runner.new(#{File.join(__dir__, "test").inspect}, load_files: #{load_files.inspect}).run
  RUBY
  system(RbConfig.ruby, "-e", runner)
  abort "test failed" unless $?.success?
end

task clean_test: [:clean, :test]
