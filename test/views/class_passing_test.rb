require "test_helper"
require "stimulus_builder/helper"

class ClassPassingTest < ActionView::TestCase
  include StimulusBuilder::Helper

  test "passes CSS classes to the controller via the `classes!` method" do
    to_render =
      stimulated.div do |component|
        _search = component.connect(:search)

        _search.classes!(loading: "search--busy")
      end

    render(html: to_render)

    assert_select("div[data-search-loading-class=?]", "search--busy")
  end
end
