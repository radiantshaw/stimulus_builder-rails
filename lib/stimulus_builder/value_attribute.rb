require "stimulus_builder/identifier"

class StimulusBuilder::ValueAttribute
  def initialize(identifier, key, value)
    @identifier = identifier
    @key, @value = key.to_s, value
  end

  def name
    "#{@identifier}-#{@key.dasherize}-value"
  end

  def value
    @value
  end

  def to_hash
    { name => value }
  end
end
