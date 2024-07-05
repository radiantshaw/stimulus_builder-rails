class StimulusBuilder::ActionAttribute
  def initialize(action_descriptors)
    @action_descriptors = action_descriptors
  end

  def name
    :action
  end

  def value
    @action_descriptors.join(" ").html_safe
  end

  def to_hash
    { name => value }
  end
end
