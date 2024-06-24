require "stimulus_builder/handler"

class StimulusBuilder::Controller
  MODULE_SEPARATOR = "/".freeze
  IDENTIFIER_SEPARATOR = "--".freeze

  private_constant :MODULE_SEPARATOR, :IDENTIFIER_SEPARATOR

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
    @controller_name
      .split(MODULE_SEPARATOR)
      .map(&:dasherize)
      .join(IDENTIFIER_SEPARATOR)
  end
end
