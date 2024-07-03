require "test_helper"
require "stimulus_builder/helper"

class ControllerConnectionTest < ActionView::TestCase
  include StimulusBuilder::Helper

  test "assigns the element as a target" do
    to_render =
      stimulated.div2 do |container|
        _container = container.connect(:container)

        stimulated.div2 do |child|
          _container.child = child
        end
      end

    render(html: to_render)

    assert_select("div > div[data-container-target=?]", "child")
  end

  test "camelizes the target property name" do
    to_render =
      stimulated.div2 do |container|
        _container = container.connect(:container)

        stimulated.div2 do |child|
          _container.first_child = child
        end
      end

    render(html: to_render)

    assert_select("div > div[data-container-target=?]", "firstChild")
  end

  test "assigns multiple target on the same element" do
    to_render =
      stimulated.div2 do |container|
        _container = container.connect(:container)
        _display = container.connect(:display)

        stimulated.div2 do |child|
          _container.first_child = child
          _display.toggled = child
        end
      end

    render(html: to_render)

    assert_select("div > div[data-container-target=?]", "firstChild")
    assert_select("div > div[data-display-target=?]", "toggled")
  end

  test "assigns targets on the nested elements" do
    to_render =
      stimulated.div2 do |container|
        _container = container.connect(:container)
        _nested = container.connect(:nested)

        stimulated.div2 do |child|
          _container.child = child

          stimulated.div2 do |nested_child|
            _nested.nested_child = nested_child
          end
        end
      end

    render(html: to_render)

    assert_select("div > div[data-container-target=?]", "child")
    assert_select("div > div > div[data-nested-target=?]", "nestedChild")
  end
end
