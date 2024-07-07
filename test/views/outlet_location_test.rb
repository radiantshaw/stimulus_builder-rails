require "test_helper"
require "stimulus_builder/helper"

class OutletLocationTest < ActionView::TestCase
  include StimulusBuilder::Helper

  test "locates another controller as an outlet" do
    to_render =
      stimulated.div do |element|
        _color_picker = element.connect(:color_picker)

        _color_picker["#dirty"] = element.use(:dirty)
      end

    render(html: to_render)

    assert_select("div[data-color-picker-dirty-outlet=?]", "#dirty")
  end
end
