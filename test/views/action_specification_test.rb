require "test_helper"
require "stimulus_builder/helper"

class ActionSpecificationTest < ActionView::TestCase
  include StimulusBuilder::Helper

  test "specifies an action with `on` via a method call on the controller" do
    to_render =
      stimulated.div do |component|
        _gallery = component.connect(:gallery)

        stimulated.div do |button|
          button.on("click", _gallery.next)
        end
      end

    render(html: to_render)

    assert_select("div > div[data-action=?]", "click->gallery#next")
  end

  test "specifies a default event with the `fire` method instead of `on`" do
    to_render =
      stimulated.div do |component|
        _gallery = component.connect(:gallery)

        stimulated.div do |button|
          button.fire(_gallery.next)
        end
      end

    render(html: to_render)

    assert_select("div > div[data-action=?]", "gallery#next")
  end

  test "delegates the event when specified with the `on` method" do
    to_render =
      stimulated.div do |component|
        _gallery = component.connect(:gallery)

        stimulated.div do |button|
          button.on("resize", _gallery.layout, at: :window)
        end
      end

    render(html: to_render)

    assert_select("div > div[data-action=?]", "resize@window->gallery#layout")
  end

  test "appends one or more action options when specified with either `fire` or `on`" do
    to_render =
      stimulated.div do |component|
        _gallery = component.connect(:gallery)

        component.on("scroll", _gallery.layout, passive: false)

        stimulated.div do |button|
          button.fire(_gallery.open, capture: true)
        end
      end

    render(html: to_render)

    assert_select("div[data-action=?]", "scroll->gallery#layout:!passive")
    assert_select("div > div[data-action=?]", "gallery#open:capture")
  end

  test "appends multiple handlers when `fire` or `on` is called more than once" do
    to_render =
      stimulated.div do |component|
        _field = component.connect(:field)
        _search = component.connect(:search)

        stimulated.div do |field|
          field.on("focus", _field.highlight)
          field.fire(_search.update)
        end
      end

    render(html: to_render)

    assert_select("div > div[data-action=?]", "focus->field#highlight search#update")
  end
end
