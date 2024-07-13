require "stimulus_builder/element_representation"
require "stimulus_builder/handler"
require "stimulus_builder/value_attribute"
require "stimulus_builder/target_attribute"

class StimulusBuilder::Controller
  include StimulusBuilder::ElementRepresentation

  MODULE_SEPARATOR = "/".freeze
  IDENTIFIER_SEPARATOR = "--".freeze

  private_constant :MODULE_SEPARATOR, :IDENTIFIER_SEPARATOR

  def initialize(controller_name, element)
    @controller_name = controller_name.to_s
    @element = element
  end

  def method_missing(action_method, *args)
    if action_method.ends_with?("=".freeze)
      args[0] << StimulusBuilder::TargetAttribute.new(self, action_method[..-2])
    else
      params = args[0] || {}
      StimulusBuilder::Handler.new(self, action_method, params)
    end
  end

  def values!(**values)
    values.each do |name, value|
      @element.pass_values!(self, name, value)
    end

    # FIXME: This is required so that when this method is called from Ruby files,
    # it doesn't output the values hash that gets returned by the each method above.
    ''
  end

  def classes!(**map)
    map.each do |logical_name, klass|
      @element.pass_classes!(self, logical_name, klass)
    end

    # FIXME: This is required so that when this method is called from Ruby files,
    # it doesn't output the map hash that gets returned by the each method above.
    ''
  end

  def [](event_name)
    "#{self}:#{event_name.to_s.dasherize}"
  end

  def []=(selector, outlet)
    @element.open_outlet!(self, outlet, selector)
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
