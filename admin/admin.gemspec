$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "admin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "admin"
  s.version     = Admin::VERSION
  s.authors     = ["nonpro"]
  s.email       = ["nonprofessional0111@gmail.com"]
  s.homepage    = ""
  s.summary     = "gravure tube admin"
  s.description = "gravure tube admin"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.5.2"
  s.add_dependency "devise", "4.2.0"
  s.add_dependency "materialize-sass"
  s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
