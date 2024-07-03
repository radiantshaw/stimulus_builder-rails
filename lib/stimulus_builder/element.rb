require "stimulus_builder/action_descriptor"
require "stimulus_builder/controller_attribute"

class StimulusBuilder::Element
  attr_reader :handlers
  attr_reader :action_descriptors

  def initialize
    @handlers = []
    @action_descriptors = []
    @attributes = []
  end

  def <<(attribute)
    case attribute
    when StimulusBuilder::ControllerAttribute
      connect_controller(attribute)
    end
  end

  def attributes
    @attributes.inject({}) do |memo, attribute|
      memo.merge(attribute)
    end
  end

  def connect(controller_name)
    self << StimulusBuilder::ControllerAttribute.new([controller_name])

    StimulusBuilder::Controller.new(controller_name)
  end

  def fire(handler, **options)
    @action_descriptors << StimulusBuilder::ActionDescriptor.new(nil, handler, **options)
  end

  def on(event, handler, attach_to: nil, **options)
    @action_descriptors << StimulusBuilder::ActionDescriptor.new(event, handler, attach_to, **options)
  end

  def target_attributes
    @target_attributes ||= []
  end

  # FIXME: This is needed to not render this element in tests.
  def to_s
    ''.freeze
  end

  private

  def connect_controller(controller_attribute)
    index = @attributes.index do |attribute|
      StimulusBuilder::ControllerAttribute === attribute
    end

    if index.present?
      @attributes[index] += controller_attribute
    else
      @attributes << controller_attribute
    end
  end
end
