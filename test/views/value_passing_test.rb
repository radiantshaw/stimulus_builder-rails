require "test_helper"

class ValuePassingTest < ActionView::TestCase
  test "pass values" do
    render(partial: "values/pass_values")

    assert_dom("div[data-controller=\"loader\"]") do
      assert_select("[data-loader-url-value=?]", "/messages")
    end
  end

  test "naming conventions" do
    render(partial: "values/naming_conventions")

    assert_dom("div[data-controller=\"loader\"]") do
      assert_select("[data-loader-content-type-value=?]", "application/json")
    end
  end
end
