require "stimulus_builder/action_descriptor"
require "stimulus_builder/action_attribute"
require "stimulus_builder/controller_attribute"
require "stimulus_builder/element_representation"
require "stimulus_builder/outlet"
require "stimulus_builder/element_representable"

module StimulusBuilder
  class Element
    include ElementRepresentation
    include ElementRepresentable

    def initialize
      @attributes = []
      @controller_index = nil
      @action_index = nil
      @target_indexes = {}
    end

    # FIXME: This is needed to not render this element in tests.
    def to_s
      ''.freeze
    end
  end
end
