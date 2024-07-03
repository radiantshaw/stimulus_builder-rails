require "test_helper"
require "stimulus_builder/helper"

class ClassPassingTest < ActionView::TestCase
  include StimulusBuilder::Helper

  test "passes classes to the controller" do
    to_render =
      stimulated.div2 do |display|
        _display = display.connect(:display)

        _display.classes!(active: 'active--greyed', loading_spinner: 'loader--primary')
      end

    render(html: to_render)

    puts rendered
    assert_select("div[data-display-active-class=?]", "active--greyed")
    assert_select("div[data-display-loading-spinner-class=?]", "loader--primary")
  end
end
