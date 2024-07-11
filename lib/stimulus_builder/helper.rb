require "stimulus_builder/helper_delegate"

module StimulusBuilder::Helper
  def stimulated
    StimulusBuilder::HelperDelegate.new(view_context)
  end
end
