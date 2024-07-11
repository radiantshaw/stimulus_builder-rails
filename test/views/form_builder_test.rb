require "test_helper"
require "stimulus_builder/helper_delegate"

class FormBuilderTest < ActionView::TestCase
  test "doesn't add `data-controller` if `connect` isn't called" do
    to_render =
      stimulated.form_for(:animals, url: "/animals") do |form|
        # ...
      end

    render(html: to_render)

    assert_dom("form[data-controller]", count: 0)
  end

  test "adds `data-controller` when `connect` is called at least once" do
    to_render =
      stimulated.form_for(:animals, url: "/animals") do |form|
        form.connect(:reference)
      end

    render(html: to_render)

    assert_dom("form[data-controller=?]", "reference")
  end

  test "adds multi-valued `data-controller` when `connect` is called more than once" do
    to_render =
      stimulated.form_for(:animals, url: "/animals") do |form|
        form.connect(:clipboard)
        form.connect(:list_item)
      end

    render(html: to_render)

    assert_dom("form[data-controller=?]", "clipboard list-item")
  end

  private

  def stimulated
    StimulusBuilder::HelperDelegate.new(view)
  end
end
