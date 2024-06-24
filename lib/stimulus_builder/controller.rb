require "stimulus_builder/handler"

class StimulusBuilder::Controller
  def initialize(controller_name)
    @controller_name = controller_name.to_s
  end

  def method_missing(action_method, *args)
    StimulusBuilder::Handler.new(self, action_method)
  end

  def to_s
    to_str
  end

  def to_str
    controller_identifier
  end

  private

  def controller_identifier
    @controller_name.dasherize
  end
end
