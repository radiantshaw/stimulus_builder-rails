require "test_helper"
require "stimulus_builder/helper"

class ValuePassingTest < ActionView::TestCase
  include StimulusBuilder::Helper

  test "passes values to the controller" do
    to_render =
      stimulated.div2 do |display|
        _display = display.connect(:display)

        _display.values!(initially_visible: false, timeout: 3)
      end

    render(html: to_render)

    assert_select("div[data-display-initially-visible-value=?]", "false")
    assert_select("div[data-display-timeout-value=?]", "3")
  end
end
