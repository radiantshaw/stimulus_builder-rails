require "stimulus_builder/attribute"

module StimulusBuilder
  class ActionAttribute < Attribute
    def initialize(action_descriptor)
      @action_descriptors = [action_descriptor]
    end

    def name
      "data-action"
    end

    def value
      @action_descriptors.join(" ").html_safe
    end

    def <<(action_descriptor)
      @action_descriptors << action_descriptor
    end
  end
end
