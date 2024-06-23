require "test_helper"
require "stimulus_builder/helper"

class StimulusBuilder::HelperTest < ActionView::TestCase
  include StimulusBuilder::Helper

  def test_single_controller_declaration
    assert_equal(
      '<div data-controller="slider"></div>',
      stimulated.div(controlled_by: "slider")
    )
  end

  def test_multiple_controller_declaration
    assert_equal(
      '<div data-controller="slider display"></div>',
      stimulated.div(controlled_by: ["slider", "display"])
    )
  end

  def test_single_default_action_declaration
    actual =
      stimulated.div(controlled_by: "slider") do |slider, _element|
        _element.fire(slider.step)
      end

    expected = <<~HTML.chomp
      <div data-controller="slider" data-action="slider#step"></div>
    HTML

    assert_equal(expected, actual)
  end

  def test_multiple_default_action_declaration
    actual =
      stimulated.div(controlled_by: "slider") do |slider, _element|
        _element.fire(slider.step)
        _element.fire(slider.slide)
      end

    expected = <<~HTML.chomp
      <div data-controller="slider" data-action="slider#step slider#slide"></div>
    HTML

    assert_equal(expected, actual)
  end

  def test_single_action_declaration_with_event
    actual =
      stimulated.div(controlled_by: "slider") do |slider, _element|
        _element.on('click', slider.step)
      end

    expected = <<~HTML.chomp
      <div data-controller="slider" data-action="click->slider#step"></div>
    HTML

    assert_equal(expected, actual)
  end

  def test_multiple_action_declaration_with_event
    actual =
      stimulated.div(controlled_by: "slider") do |slider, _element|
        _element.on('click', slider.step)
        _element.on('hover', slider.slide)
      end

    expected = <<~HTML.chomp
      <div data-controller="slider" data-action="click->slider#step hover->slider#slide"></div>
    HTML

    assert_equal(expected, actual)
  end

  def test_action_declaration_with_and_without_event
    actual =
      stimulated.div(controlled_by: "slider") do |slider, _element|
        _element.fire(slider.step)
        _element.on('hover', slider.slide)
      end

    expected = <<~HTML.chomp
      <div data-controller="slider" data-action="slider#step hover->slider#slide"></div>
    HTML

    assert_equal(expected, actual)
  end

  def test_mix_of_multiple_controllers_and_actions_with_and_without_event
    actual =
      stimulated.div(controlled_by: ["slider", "display"]) do |slider, display, _element|
        _element.fire(slider.step)
        _element.on('hover', slider.slide)

        _element.fire(display.toggle)
        _element.on('change', display.clear)
      end

    expected = <<~HTML.chomp
      <div data-controller="slider display" data-action="slider#step hover->slider#slide display#toggle change->display#clear"></div>
    HTML

    assert_equal(expected, actual)
  end
end
