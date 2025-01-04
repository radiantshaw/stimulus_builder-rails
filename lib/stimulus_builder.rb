require "zeitwerk"

require "stimulus_builder/version"
require "stimulus_builder/railtie"

loader = Zeitwerk::Loader.for_gem
loader.setup

module StimulusBuilder
  # Your code goes here...
end
