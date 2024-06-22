require "test_helper"
require "stimulus_builder/helper"

class StimulusBuilder::HelperTest < ActionView::TestCase
  include StimulusBuilder::Helper

  def test_single_controller_declaration
    assert_equal(
      stimulated.div(controlled_by: "slider"),
      '<div data-controller="slider"></div>'
    )
  end

  def test_multiple_controller_declaration
    assert_equal(
      '<div data-controller="slider display"></div>',
      stimulated.div(controlled_by: ["slider", "display"])
    )
  end

  def test_default_action_declaration
    actual =
      stimulated.div(controlled_by: "slider") do |slider, _element|
        _element.fire(slider.step)
      end

    expected = <<~HTML.chomp
      <div data-controller="slider" data-action="slider#step"></div>
    HTML

    assert_equal(expected, actual)
  end
end
