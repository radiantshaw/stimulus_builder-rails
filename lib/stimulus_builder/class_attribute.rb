require "stimulus_builder/identifier"

class StimulusBuilder::ClassAttribute
  def initialize(identifier, logical_name, klass)
    @identifier = identifier
    @logical_name, @klass = logical_name.to_s, klass
  end

  def name
    "#{@identifier}-#{@logical_name.dasherize}-class"
  end

  def value
    @klass
  end

  def to_hash
    { name => value }
  end
end
