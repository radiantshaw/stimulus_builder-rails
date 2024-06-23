class StimulusBuilder::Handler
  def initialize(controller, action_method)
    @controller = controller
    @action_method = action_method
  end

  def to_s
    "#{@controller}##{@action_method}"
  end
end
