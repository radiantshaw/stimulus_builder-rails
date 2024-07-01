require "test_helper"
require "stimulus_builder/helper"

class ControllerConnectionTest < ActionView::TestCase
  include StimulusBuilder::Helper

  test "connects to a controller" do
    to_render =
      stimulated.div2 do |container|
        container.connect(:container)
      end

    render(html: to_render)

    assert_select("div[data-controller=?]", "container")
  end

  test "connects to multiple controllers" do
    to_render =
      stimulated.div2 do |container|
        container.connect(:container)
        container.connect(:display)
      end

    render(html: to_render)

    assert_select("div[data-controller=?]", "container display")
  end
end
