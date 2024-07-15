require "test_helper"

class ParamPassingTest < ActionView::TestCase
  test "pass params" do
    render(partial: "params/pass_params")

    assert_dom("div[data-controller=\"item\"]") do
      assert_dom("button[data-item-id-param=?]", "12345")
      assert_dom("button[data-item-url-param=?]", "/votes")
      assert_dom("button[data-item-payload-param=?]", { "value" => "1234567" }.to_json)
      assert_dom("button[data-item-active-param=?]", "true")
    end
  end
end
