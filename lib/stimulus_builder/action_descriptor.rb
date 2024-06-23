class StimulusBuilder::ActionDescriptor
  def initialize(event, handler)
    @event, @handler = event, handler
  end

  def to_s
    descriptor = "#{@handler}" 

    if @event.present?
      descriptor.prepend("#{@event}->")
    end

    descriptor
  end
end
