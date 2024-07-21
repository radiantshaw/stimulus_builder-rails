require "test_helper"

class ClassPassingTest < ActionView::TestCase
  test "pass classes" do
    render(partial: "classes/pass_classes")

    assert_dom("form[data-controller=\"search\"]") do
      assert_dom("[data-search-loading-class=?]", "search--busy")
    end
  end

  test "naming conventions" do
    render(partial: "classes/naming_conventions")

    assert_dom("form[data-controller=\"search\"]") do
      assert_dom("[data-search-loading-class=?]", "search--busy")
      assert_dom("[data-search-no-results-class=?]", "search--empty")
    end
  end
end
