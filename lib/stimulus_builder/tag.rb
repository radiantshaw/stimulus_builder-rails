require "stimulus_builder/controller"
require "stimulus_builder/element"
require "stimulus_builder/stimulus_attributes"
require "stimulus_builder/controller_attribute"
require "stimulus_builder/action_attribute"

class StimulusBuilder::Tag
  def initialize(builder_context)
    @builder_context = builder_context
  end

  def div(&block)
    element = StimulusBuilder::Element.new
    inner_html = yield(element)
    @builder_context.div(inner_html, **element.attributes)
  end

  def div2(&block)
    element = StimulusBuilder::Element.new

    captured_html = block.call(element)

    param_attributes =
      element.param_attributes.inject({}) do |memo, param_attribute|
        memo.merge(param_attribute)
      end

    target_attributes =
      element.target_attributes.inject({}) do |memo, target_attribute|
        memo.merge(target_attribute)
      end

    outlet_attributes =
      element.outlet_attributes.inject({}) do |memo, outlet_attribute|
        memo.merge(outlet_attribute)
      end

    value_attributes =
      element.value_attributes.inject({}) do |memo, value_attribute|
        memo.merge(value_attribute)
      end

    class_attributes =
      element.class_attributes.inject({}) do |memo, class_attribute|
        memo.merge(class_attribute)
      end

    attributes = {
      **element.attributes,
      **element.action_attribute,
      **param_attributes,
      **target_attributes,
      **outlet_attributes,
      **value_attributes,
      **class_attributes,
    }

    @builder_context.div(captured_html, data: attributes)
  end
end
