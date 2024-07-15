require "test_helper"

class OutletReferenceTest < ActionView::TestCase
  test "locates another controller as an outlet" do
    render(partial: "outlets/reference_controllers")

    assert_dom("div[data-controller=\"chat\"]") do
      assert_dom("div[data-chat-user-status-outlet=?]", ".online-user")
    end
  end
end
