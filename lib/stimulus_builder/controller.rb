class StimulusBuilder::Controller
  def initialize(controller_identifier)
    @controller_identifier = controller_identifier
  end

  def to_s
    @controller_identifier
  end
end
