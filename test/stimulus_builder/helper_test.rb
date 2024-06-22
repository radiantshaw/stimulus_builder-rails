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
      stimulated.div(controlled_by: ["slider", "display"]),
      '<div data-controller="slider display"></div>'
    )
  end
end
