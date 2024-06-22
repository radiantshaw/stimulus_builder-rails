require "stimulus_builder/controller"
require "stimulus_builder/declarations"
require "stimulus_builder/element"
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

    declarations = StimulusBuilder::Declarations.new(controllers)
    action_attribute = StimulusBuilder::ActionAttribute.new(element.handlers)

    @builder_context.div(
      data: {
        **declarations.to_h,
        **action_attribute.to_h
      }
    )
  end
end
