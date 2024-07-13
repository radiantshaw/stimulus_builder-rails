require "stimulus_builder/helper_delegate"

module StimulusBuilder::Helper
  def stimulated
    StimulusBuilder::HelperDelegate.new(self)
  end
end
