class StimulusBuilder::ActionAttribute
  def initialize(handlers)
    @handlers = handlers
  end

  def to_h
    if @handlers.length > 0
      { action: handler_identifiers }
    else
      {}
    end
  end

  private

  def handler_identifiers
    @handlers.join(" ")
  end
end
