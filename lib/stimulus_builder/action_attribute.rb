module StimulusBuilder
  class ActionAttribute < Attribute
    def initialize(*action_descriptors)
      @action_descriptors = action_descriptors
    end

    def name
      "data-action"
    end

    def value
      @action_descriptors.join(" ").html_safe
    end

    def +(action_attribute)
      self.class.new(*(@action_descriptors + action_attribute.action_descriptors))
    end

    def multi?
      true
    end

    protected

    attr_reader :action_descriptors
  end
end
