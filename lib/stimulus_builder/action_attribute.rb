class StimulusBuilder::ActionAttribute
  def initialize(handlers)
    @handlers = handlers
  end

  def name
    :action
  end

  def value
    @handlers.join(" ")
  end
end
