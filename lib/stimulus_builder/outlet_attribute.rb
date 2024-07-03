require "stimulus_builder/identifier"

class StimulusBuilder::OutletAttribute
  def initialize(selector, identifier, outlet)
    @selector = selector
    @identifier = identifier
    @outlet = outlet
  end

  def name
    "#{@identifier}-#{@outlet}-outlet"
  end

  def value
    @selector
  end

  def to_hash
    { name => value }
  end
end
