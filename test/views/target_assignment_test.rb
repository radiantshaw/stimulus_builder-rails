require "test_helper"

class TargetAssignmentTest < ActionView::TestCase
  test "referencing elements" do
    render(partial: "targets/referencing_elements")

    assert_dom("div[data-controller=\"search\"]") do
      assert_dom("> input[data-search-target=?]", "query")
      assert_dom("> div[data-search-target=?]", "errorMessage")
      assert_dom("> div[data-search-target=?]", "results")
    end
  end

  test "shared targets" do
    render(partial: "targets/shared_targets")

    assert_dom("form[data-controller=\"search checkbox\"]") do
      assert_select("> input[data-search-target=?][data-checkbox-target=?]", "projects", "input")
      assert_select("> input[data-search-target=?][data-checkbox-target=?]", "messages", "input")
    end
  end

  test "naming conventions" do
    render(partial: "targets/naming_conventions")

    assert_dom("div[data-controller=\"search\"]") do
      assert_select("> span[data-search-target=?]", "camelCase")
    end
  end
end
