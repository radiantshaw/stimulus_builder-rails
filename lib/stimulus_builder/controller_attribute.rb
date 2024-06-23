class StimulusBuilder::ControllerAttribute
  def initialize(controllers)
    @controllers = controllers
  end

  def name
    :controller
  end

  def value
    @controllers.join(" ")
  end
end
