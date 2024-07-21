require "test_helper"
require "stimulus_builder/element"
require "stimulus_builder/controller"
require "stimulus_builder/controller_attribute"

class ControllerAttributeTest < ActiveSupport::TestCase
  test "represents a data-controller attribute with minimum one controller present" do
    controller = StimulusBuilder::Controller.new(:display, element)
    controller_attribute = StimulusBuilder::ControllerAttribute.new(controller)

    assert_equal({ "data-controller" => "display" }, controller_attribute.to_hash)
  end

  test "accepts more controllers and also preserves the order" do
    controllers = [
      StimulusBuilder::Controller.new(:display, element),
      StimulusBuilder::Controller.new(:animation, element)
    ]
    controller_attribute = StimulusBuilder::ControllerAttribute.new(*controllers)

    assert_equal({ "data-controller" => "display animation" }, controller_attribute.to_hash)
  end

  private

  def element
    StimulusBuilder::Element.new
  end
end
