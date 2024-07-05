require "debug"
require "stimulus_builder/handler"
require "stimulus_builder/target_attribute"
require "stimulus_builder/outlet_attribute"
require "stimulus_builder/value_attribute"
require "stimulus_builder/class_attribute"

class StimulusBuilder::Controller
  MODULE_SEPARATOR = "/".freeze
  IDENTIFIER_SEPARATOR = "--".freeze

  private_constant :MODULE_SEPARATOR, :IDENTIFIER_SEPARATOR

  def initialize(controller_name, element = nil)
    @controller_name = controller_name.to_s
    @element = element
  end

  def method_missing(action_method, *args)
    if action_method.ends_with?("=".freeze)
      target_element = args[0]
      target_element.target_attributes << StimulusBuilder::TargetAttribute.new(action_method[..-2], self)
    else
      params = args[0] || {}
      StimulusBuilder::Handler.new(self, action_method, params)
    end
  end

  def values!(**values)
    values.each do |key, value|
      @element.value_attributes << StimulusBuilder::ValueAttribute.new(self, key, value)
    end

    # FIXME: This is required so that when this method is called from Ruby files,
    # it doesn't output the values hash that gets returned by the each method above.
    ''
  end

  def classes!(**map)
    map.each do |logical_name, klass|
      @element.class_attributes << StimulusBuilder::ClassAttribute.new(self, logical_name, klass)
    end

    # FIXME: This is required so that when this method is called from Ruby files,
    # it doesn't output the map hash that gets returned by the each method above.
    ''
  end

  def []=(selector, outlet)
    @element.outlet_attributes << StimulusBuilder::OutletAttribute.new(selector, self, outlet)
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
