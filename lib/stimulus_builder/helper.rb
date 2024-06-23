require "stimulus_builder/tag"

module StimulusBuilder::Helper
  def stimulated
    StimulusBuilder::Tag.new(tag)
  end
end
