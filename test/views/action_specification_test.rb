require "test_helper"

class ActionSpecificationTest < ActionView::TestCase
  test "handling DOM events" do
    render(partial: "actions/handling_dom_events")

    assert_dom("div[data-controller=\"gallery\"]") do
      assert_dom("> button[data-action=?]", "click->gallery#next")
    end
  end

  test "event shorthand" do
    render(partial: "actions/event_shorthand")

    assert_dom("div[data-controller=\"gallery\"]") do
      assert_select("> button[data-action=?]", "gallery#next")
    end
  end

  test "global events" do
    render(partial: "actions/global_events")

    assert_dom("div[data-controller=\"gallery\"]") do
      assert_select("> div[data-action=?]", "resize@window->gallery#layout")
    end
  end

  test "options" do
    render(partial: "actions/options")

    assert_dom("div[data-controller=\"gallery\"]") do
      assert_select("[data-action=?]", "scroll->gallery#layout:!passive")
      assert_select("> img[data-action=?]", "gallery#open:capture")
    end
  end

  test "multiple_actions" do
    render(partial: "actions/multiple_actions")

    assert_dom("div[data-controller=\"field search\"]") do
      assert_select("> input[data-action=?]", "focus->field#highlight search#update")
    end
  end

  test "naming conventions" do
    render(partial: "actions/naming_conventions")

    assert_dom("form[data-controller=\"profile\"]") do
      assert_select("> button[data-action=?]", "profile#showDialog")
    end
  end
end
