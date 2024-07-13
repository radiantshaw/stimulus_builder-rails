require "test_helper"
require "stimulus_builder/helper_delegate"

class ControllerConnectionTest < ActionView::TestCase
  test "identifiers" do
    render(partial: "controllers/identifiers")

    assert_dom("div[data-controller=?]", "reference")
  end

  test "nested controllers" do
    render(partial: "controllers/nested_controllers")

    assert_select("div[data-controller=?]", "users--list-item")
  end

  test "multiple controllers" do
    render(partial: "controllers/multiple_controllers")

    assert_dom("div[data-controller=?]", "clipboard list-item")
  end

  test "cross-controller coordination" do
    render(partial: "controllers/cross_controller_coordination")

    assert_dom_equal(<<~HTML, rendered)
      <div data-controller="clipboard effects" data-action="clipboard:copy->effects#flash">
        PIN: <input type="text" value="1234" readonly="readonly" data-clipboard-target="source">
        <button data-action="clipboard#copy">Copy to Clipboard</button>
      </div>
    HTML
  end
end
