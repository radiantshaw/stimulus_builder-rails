require_relative "lib/stimulus_builder/version"

Gem::Specification.new do |spec|
  spec.name        = "stimulus_builder"
  spec.version     = StimulusBuilder::VERSION
  spec.authors     = ["Nipun Paradkar"]
  spec.email       = ["nipun@lawlytics.com"]
  spec.homepage    = "http://example.com"
  spec.summary     = "Summary of StimulusBuilder."
  spec.description = "Description of StimulusBuilder."
    spec.license     = "MIT"
  
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://example.com"
  spec.metadata["changelog_uri"] = "http://example.com"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.3.1"
end
