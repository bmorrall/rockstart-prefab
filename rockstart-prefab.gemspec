# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "rockstart/prefab/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "rockstart-prefab"
  spec.version     = Rockstart::Prefab::VERSION
  spec.authors     = ["Ben Morrall"]
  spec.email       = ["bemo56@hotmail.com"]
  spec.homepage    = "https://github.com/bmorrall/rockstart-prefab"
  spec.summary     = "Prefab content for getting Rails Ready to Rock!"
  spec.description = "A collection of generators for creating pre-built components."
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.2", ">= 6.0.2.2"
  spec.add_dependency "rockstart"

  spec.add_development_dependency "sqlite3"
end
