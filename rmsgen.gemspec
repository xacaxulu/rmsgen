# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rmsgen/version"

Gem::Specification.new do |s|
  s.name        = "rmsgen"
  s.version     = Rmsgen::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Lake Denman"]
  s.email       = ["lake@lakedenman.com"]
  s.homepage    = ""
  s.summary     = %q{A library to help generate html markup from RMS emails}
  s.description = %q{A library to help generate html markup from RMS emails}

  s.rubyforge_project = "rmsgen"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
