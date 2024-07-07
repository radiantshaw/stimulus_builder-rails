require "stimulus_builder/target_attribute"
require "stimulus_builder/outlet_attribute"
require "stimulus_builder/value_attribute"
require "stimulus_builder/class_attribute"

module StimulusBuilder::ElementRepresentation
  protected

  def mark_as_target!(identifier, name)
    if @target_indexes[identifier].nil?
      @attributes << StimulusBuilder::TargetAttribute.new(identifier, name)
      @target_indexes[identifier] = @attributes.length - 1
    else
      @attributes[@target_indexes[identifier]] << name
    end
  end

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
