require_relative "lib/stimulus_builder/version"

Gem::Specification.new do |spec|
  spec.name        = "stimulus_builder-rails"
  spec.version     = StimulusBuilder::VERSION
  spec.authors     = ["Nipun Paradkar"]
  spec.email       = ["nipunparadkar123@gmail.com"]
  spec.homepage    = "https://github.com/radiantshaw/stimulus_builder-rails"
  spec.summary     = "Add Stimulus attributes using a nicer Ruby syntax."
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.3.1"
end
