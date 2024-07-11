require "stimulus_builder/param_attribute"

class StimulusBuilder::Handler
  def initialize(controller, action_method, params)
    @controller = controller
    @action_method = action_method.to_s
    @params = params
  end

  def param_attributes
    @params.map do |param_name, param_value|
      StimulusBuilder::ParamAttribute.new(@controller, param_name, param_value)
    end
  end

  def to_s
    "#{@controller}##{@action_method.camelize(:lower)}"
  end
end
