require "stimulus_builder/identifier"

class StimulusBuilder::ControllerAttribute
  def initialize(controller_names)
    @controller_names = controller_names
  end

  def name
    :controller
  end

  def value
    controller_identifiers.join(" ")
  end

  def to_hash
    { name => value }
  end

  def +(controller_attribute)
    self.class.new(controller_names + controller_attribute.controller_names)
  end

  protected

  attr_reader :controller_names

  private

  def controller_identifiers
    @controller_names.map do |controller_name|
      StimulusBuilder::Identifier.new(controller_name)
    end
  end
end
