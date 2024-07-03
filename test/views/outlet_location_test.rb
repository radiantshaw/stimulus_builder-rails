require "test_helper"
require "stimulus_builder/helper"

class OutletLocationTest < ActionView::TestCase
  include StimulusBuilder::Helper

  test "locates another controller as an outlet" do
    to_render =
      stimulated.div2 do |container|
        _container = container.connect(:container)

        _container["#dirty"] = container.use(:dirty)
      end

    render(html: to_render)

    assert_select("div[data-container-dirty-outlet=?]", "#dirty")
  end
end
