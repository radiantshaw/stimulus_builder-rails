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

  def div2(&block)
    element = StimulusBuilder::Element.new

    captured_html = block.call(element)

    target_attributes =
      element.target_attributes.inject({}) do |memo, target_attribute|
        memo.merge(target_attribute)
      end

    outlet_attributes =
      element.outlet_attributes.inject({}) do |memo, outlet_attribute|
        memo.merge(outlet_attribute)
      end

    value_attributes =
      element.value_attributes.inject({}) do |memo, value_attribute|
        memo.merge(value_attribute)
      end

    attributes = {
      **element.attributes,
      **target_attributes,
      **outlet_attributes,
      **value_attributes,
    }

    @builder_context.div(captured_html, data: attributes)
  end
end
