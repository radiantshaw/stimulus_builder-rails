require "stimulus_builder/element"

module StimulusBuilder::Helper
  def stimulated
    StimulusBuilder::Element.new(tag)
  end
end
