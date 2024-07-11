require "test_helper"
require "stimulus_builder/helper"

class ControllerConnectionTest < ActionView::TestCase
  include StimulusBuilder::Helper

  test "doesn't add `data-controller` if `#connect` isn't called at all" do
    to_render =
      stimulated.div do |element|
        # ...
      end

    render(html: to_render)

    assert_select("div[data-controller]", count: 0)
  end

  test "adds `data-controller` when `#connect` is called at least once" do
    to_render =
      stimulated.div do |element|
        element.connect(:carousel)
      end

    render(html: to_render)

    assert_select("div[data-controller]", count: 1)
  end

  test "understands symbols as controller names" do
    to_render =
      stimulated.div do |element|
        element.connect(:clipboard)
      end

    render(html: to_render)

    assert_select("div[data-controller=?]", "clipboard")
  end

  test "converts multi-word symbols into appropriate controller names" do
    to_render =
      stimulated.div do |element|
        element.connect(:auto_submit)
      end

    render(html: to_render)

    assert_select("div[data-controller=?]", "auto-submit")
  end

  test "understands strings as controller names" do
    to_render =
      stimulated.div do |element|
        element.connect("dialog")
      end

    render(html: to_render)

    assert_select("div[data-controller=?]", "dialog")
  end

  test "converts multi-word strings into appropriate controller names" do
    to_render =
      stimulated.div do |element|
        element.connect("content_loader")
      end

    render(html: to_render)

    assert_select("div[data-controller=?]", "content-loader")
  end

  test "understands nested controller names" do
    to_render =
      stimulated.div do |element|
        element.connect("ordering/sortable")
      end

    render(html: to_render)

    assert_select("div[data-controller=?]", "ordering--sortable")
  end

  test "understands multi-word controller names within nesting" do
    to_render =
      stimulated.div do |element|
        element.connect("user_auth/password_visibility")
      end

    render(html: to_render)

    assert_select("div[data-controller=?]", "user-auth--password-visibility")
  end

  test "appends multiple controllers when called more than once" do
    to_render =
      stimulated.div do |element|
        element.connect(:clipboard)
        element.connect("user_auth/password_visibility")
      end

    render(html: to_render)

    assert_select("div[data-controller=?]", "clipboard user-auth--password-visibility")
  end
end
