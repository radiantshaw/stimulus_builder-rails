require "stimulus_builder/target_attribute"
require "stimulus_builder/outlet_attribute"
require "stimulus_builder/value_attribute"
require "stimulus_builder/class_attribute"

module StimulusBuilder::ElementRepresentation
  protected

  def open_outlet!(identifier, outlet, selector)
    @attributes << StimulusBuilder::OutletAttribute.new(identifier, outlet, selector)
  end

  def pass_values!(identifier, name, value)
    @attributes << StimulusBuilder::ValueAttribute.new(identifier, name, value)
  end

  def pass_classes!(identifier, name, value)
    @attributes << StimulusBuilder::ClassAttribute.new(identifier, name, value)
  end
end
