class StimulusBuilder::ActionDescriptor
  def initialize(event, handler, target = nil)
    @event, @handler = event, handler
    @target = target
  end

  def to_s
    descriptor = ""

    if @event.present?
      descriptor += @event

      if @target.present?
        descriptor += "@#{@target}"
      end

      descriptor += "->"
    end

    descriptor + "#{@handler}" 
  end
end
