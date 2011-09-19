$:.push File.expand_path("../lib", __FILE__)
require "freetts/version"

Gem::Specification.new do |s|
  s.name        = "freetts"
  s.version     = FreeTTS::VERSION
  s.authors     = ["Chris kottom"]
  s.email       = "chris@chriskottom.com"
  s.homepage    = ""
  s.summary     = %q{A voice synthesizer in JRuby}
  s.description = %q{FreeTTS provides a simple wrapper around the Java library of the same name in order to expose a voice synthesis API.}

  s.rubyforge_project = "freetts"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = ["freetts"]
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
