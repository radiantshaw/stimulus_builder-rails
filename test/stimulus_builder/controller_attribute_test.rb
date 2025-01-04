require "test_helper"
require "stimulus_builder/element"
require "stimulus_builder/controller"
require "stimulus_builder/controller_attribute"

class ControllerAttributeTest < ActiveSupport::TestCase
  test "is named `data-controller`" do
    controller = StimulusBuilder::Controller.new(:display, element)
    controller_attribute = StimulusBuilder::ControllerAttribute.new(controller)

    assert_equal("data-controller", controller_attribute.name)
  end

  test "returns the given controller name as value" do
    controller = StimulusBuilder::Controller.new(:display, element)
    controller_attribute = StimulusBuilder::ControllerAttribute.new(controller)

    assert_equal("display", controller_attribute.value)
  end

  test "separates multiple controllers with a space, preserving order" do
    controllers = [
      StimulusBuilder::Controller.new(:display, element),
      StimulusBuilder::Controller.new(:animation, element)
    ]
    controller_attribute = StimulusBuilder::ControllerAttribute.new(*controllers)

    assert_equal("display animation", controller_attribute.value)
  end

  private

  def element
    StimulusBuilder::Element.new
  end
end
