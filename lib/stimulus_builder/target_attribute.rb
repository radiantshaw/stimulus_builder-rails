require "stimulus_builder/identifier"

class StimulusBuilder::TargetAttribute
  def initialize(property_name, controller)
    @property_name = property_name
    @controller = controller
  end

  def name
    "#{@controller}-target"
  end

  def value
    @property_name.camelize(:lower)
  end

  def to_hash
    { name => value }
  end
end
