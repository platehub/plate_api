
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "plate_api/version"

Gem::Specification.new do |spec|
  spec.name        = 'plate_api'
  spec.version     = PlateApi::VERSION
  spec.date        = '2019-01-05'
  spec.summary     = "Connector for the Plate API"
  spec.description = "This gem can be used to connect to the Plate API. It takes care
  of the authentication procedure. "
  spec.authors     = ["David Kortleven"]
  spec.email       = 'david@getplate.com'
  spec.files       = ["lib/plate_api.rb"]
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 0.15.4"
  spec.add_dependency "faraday_middleware", "~> 0.13.1"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "factory_bot", "~> 5.0.1"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "byebug"

end
