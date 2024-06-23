require "stimulus_builder/action_descriptor"

class StimulusBuilder::Element
  attr_reader :handlers
  attr_reader :action_descriptors

  def initialize
    @handlers = []
    @action_descriptors = []
  end

  def fire(handler, **options)
    @action_descriptors << StimulusBuilder::ActionDescriptor.new(nil, handler, **options)
  end

  def on(event, handler, attach_to: nil, **options)
    @action_descriptors << StimulusBuilder::ActionDescriptor.new(event, handler, attach_to, **options)
  end
end
