require "test_helper"
require "stimulus_builder/helper"

class ControllerConnectionTest < ActionView::TestCase
  include StimulusBuilder::Helper

  test "assigns the element as a target" do
    to_render =
      stimulated.div do |element|
        _clipboard = element.connect(:clipboard)

        stimulated.div do |input_element|
          _clipboard.source = input_element
        end
      end

    render(html: to_render)

    assert_select("div > div[data-clipboard-target=?]", "source")
  end

  test "camelizes the target property name" do
    to_render =
      stimulated.div do |element|
        _clipboard = element.connect(:clipboard)

        stimulated.div do |input_element|
          _clipboard.source_input = input_element
        end
      end

    render(html: to_render)

    assert_select("div > div[data-clipboard-target=?]", "sourceInput")
  end

  test "assigns multiple target on the same element for same controller" do
    to_render =
      stimulated.div do |element|
        _clipboard = element.connect(:clipboard)

        stimulated.div do |input_element|
          _clipboard.source_input = input_element
          _clipboard.highlighted = input_element
        end
      end

    render(html: to_render)

    assert_select("div > div[data-clipboard-target=?]", "sourceInput highlighted")
  end

  test "doesn't get confused when multiple targets are assigned for 2 different controllers" do
    to_render =
      stimulated.div do |element|
        _clipboard = element.connect(:clipboard)
        _display = element.connect(:display)

        stimulated.div do |input_element|
          _clipboard.source_input = input_element
          _clipboard.highlighted = input_element

          _display.toggled = input_element
        end
      end

    render(html: to_render)

    assert_select("div > div[data-clipboard-target=?]", "sourceInput highlighted")
    assert_select("div > div[data-display-target=?]", "toggled")
  end

  test "assigns targets for nested elements" do
    to_render =
      stimulated.div do |element|
        _clipboard = element.connect(:clipboard)
        _display = element.connect(:display)

        stimulated.div do |wrapper_element|
          _display.toggled = wrapper_element

          stimulated.div do |input_element|
            _clipboard.source_input = input_element
          end
        end
      end

    render(html: to_render)

    assert_select("div > div[data-display-target=?]", "toggled")
    assert_select("div > div > div[data-clipboard-target=?]", "sourceInput")
  end
end
