class StimulusBuilder::Element
  attr_reader :handlers

  def initialize
    @handlers = []
  end

  def fire(handler)
    @handlers << handler
  end
end
