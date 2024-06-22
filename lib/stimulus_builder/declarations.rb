class StimulusBuilder::Declarations
  def initialize(controllers)
    @controllers = controllers
  end

  def to_h
    { controller: controller_attribute }
  end

  private

  def controller_attribute
    @controllers.join(' ')
  end
end
