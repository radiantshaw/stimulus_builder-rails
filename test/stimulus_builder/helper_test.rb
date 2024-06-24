require "test_helper"
require "stimulus_builder/helper"

class StimulusBuilder::HelperTest < ActionView::TestCase
  include StimulusBuilder::Helper

  def test_single_controller_symbol
    assert_equal(
      '<div data-controller="slider"></div>',
      stimulated.div(controlled_by: :slider)
    )
  end

  def test_single_controller_string
    assert_equal(
      '<div data-controller="slider"></div>',
      stimulated.div(controlled_by: "slider")
    )
  end

  def test_multiple_controller_symbols
    assert_equal(
      '<div data-controller="slider display"></div>',
      stimulated.div(controlled_by: [:slider, :display])
    )
  end

  def test_multiple_controller_strings
    assert_equal(
      '<div data-controller="slider display"></div>',
      stimulated.div(controlled_by: ["slider", "display"])
    )
  end

  def test_multi_word_single_controller_symbol
    assert_equal(
      '<div data-controller="zoom-slider"></div>',
      stimulated.div(controlled_by: :zoom_slider)
    )
  end

  def test_multi_word_single_controller_string
    assert_equal(
      '<div data-controller="zoom-slider"></div>',
      stimulated.div(controlled_by: "zoom_slider")
    )
  end

  def test_multi_word_multiple_controller_symbols
    assert_equal(
      '<div data-controller="zoom-slider display-toggle"></div>',
      stimulated.div(controlled_by: [:zoom_slider, :display_toggle])
    )
  end

  def test_multi_word_multiple_controller_strings
    assert_equal(
      '<div data-controller="zoom-slider display-toggle"></div>',
      stimulated.div(controlled_by: ["zoom_slider", "display_toggle"])
    )
  end

  def test_modular_single_controller
    assert_equal(
      '<div data-controller="slider--zoom"></div>',
      stimulated.div(controlled_by: "slider/zoom")
    )
  end

  def test_multi_word_modular_single_controller
    assert_equal(
      '<div data-controller="slick-slider--linear-zoom"></div>',
      stimulated.div(controlled_by: "slick_slider/linear_zoom")
    )
  end

  def test_modular_multiple_controller
    assert_equal(
      '<div data-controller="slider--zoom toggle--display"></div>',
      stimulated.div(controlled_by: ["slider/zoom", "toggle/display"])
    )
  end

  def test_multi_word_modular_multiple_controller
    assert_equal(
      '<div data-controller="slick-slider--linear-zoom visibility-toggle--clear-display"></div>',
      stimulated.div(controlled_by: ["slick_slider/linear_zoom", "visibility_toggle/clear_display"])
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

  def test_global_event_attachment
    actual =
      stimulated.div(controlled_by: "slider") do |slider, _element|
        _element.on('click', slider.step, attach_to: 'document')
        _element.on('hover', slider.slide, attach_to: 'window')
      end

    expected = <<~HTML.chomp
      <div data-controller="slider" data-action="click@document->slider#step hover@window->slider#slide"></div>
    HTML

    assert_equal(expected, actual)
  end

  def test_action_options
    actual =
      stimulated.div(controlled_by: "slider") do |slider, _element|
        _element.fire(slider.step, stop: true)
        _element.on('hover', slider.slide, stop: true, passive: false)
      end

    expected = <<~HTML.chomp
      <div data-controller="slider" data-action="slider#step:stop hover->slider#slide:stop:!passive"></div>
    HTML

    assert_equal(expected, actual)
  end
end
