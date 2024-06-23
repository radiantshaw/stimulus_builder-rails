require "stimulus_builder/controller"
require "stimulus_builder/element"
require "stimulus_builder/stimulus_attributes"
require "stimulus_builder/controller_attribute"
require "stimulus_builder/action_attribute"

class StimulusBuilder::Tag
  def initialize(builder_context)
    @builder_context = builder_context
  end

  def div(controlled_by:, &block)
    controllers =
      Array.wrap(controlled_by).map do |controller_identifier|
        StimulusBuilder::Controller.new(controller_identifier)
      end

    element = StimulusBuilder::Element.new

    yield(*controllers, element) if block_given?

    stimulus_attributes =
      StimulusBuilder::StimulusAttributes.new([
        StimulusBuilder::ControllerAttribute.new(controllers),
        StimulusBuilder::ActionAttribute.new(element.action_descriptors)
      ])

    @builder_context.div(data: stimulus_attributes.to_h)
  end
end
