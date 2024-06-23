require "stimulus_builder/action_descriptor"

class StimulusBuilder::Element
  attr_reader :handlers
  attr_reader :action_descriptors

  def initialize
    @handlers = []
    @action_descriptors = []
  end

  def fire(handler)
    @action_descriptors << StimulusBuilder::ActionDescriptor.new(nil, handler)
  end

  def on(event, handler)
    @action_descriptors << StimulusBuilder::ActionDescriptor.new(event, handler)
  end
end
