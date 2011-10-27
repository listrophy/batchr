# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "batchr/version"

Gem::Specification.new do |s|
  s.name        = "batchr"
  s.version     = Batchr::VERSION
  s.authors     = ["Bradley Grzesiak"]
  s.email       = ["brad@bendyworks.com"]
  s.homepage    = ""
  s.summary     = %q{Batching library for ruby}
  s.description = %q{Perfect for batching operations over long enumerables}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  s.executables   = [] # `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
end
