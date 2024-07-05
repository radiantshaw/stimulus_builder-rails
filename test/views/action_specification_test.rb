require "test_helper"
require "stimulus_builder/helper"

class ActionSpecificationTest < ActionView::TestCase
  include StimulusBuilder::Helper

  test "specifies an action" do
    to_render =
      stimulated.div2 do |container|
        _display = container.connect(:display)

        stimulated.div2 do |button|
          button.on('click', _display.fetch_records(path: "/users", first_name: "John"))
        end
      end

    render(html: to_render)

    assert_select("div > div[data-action=?]", "click->display#fetchRecords")
    assert_select("div > div[data-display-path-param=?]", "/users")
    assert_select("div > div[data-display-first-name-param=?]", "John")
  end
end
