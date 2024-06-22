require "stimulus_builder/controller"
require "stimulus_builder/declarations"

class StimulusBuilder::Element
  def initialize(builder_context)
    @builder_context = builder_context
  end

  def div(controlled_by:)
    controllers =
      Array.wrap(controlled_by).map do |controller_identifier|
        StimulusBuilder::Controller.new(controller_identifier)
      end

    declarations = StimulusBuilder::Declarations.new(controllers)

    @builder_context.div(data: declarations.to_h)
  end
end
