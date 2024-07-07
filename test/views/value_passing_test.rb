require "test_helper"
require "stimulus_builder/helper"

class ValuePassingTest < ActionView::TestCase
  include StimulusBuilder::Helper

  test "passes values to the controller" do
    to_render =
      stimulated.div do |element|
        _animated_number = element.connect(:animated_number)

        _animated_number.values!(start_point: 42, end_point: 50, increment: 2)
      end

    render(html: to_render)

    assert_select("div[data-animated-number-start-point-value=?]", "42")
    assert_select("div[data-animated-number-end-point-value=?]", "50")
    assert_select("div[data-animated-number-increment-value=?]", "2")
  end
end
