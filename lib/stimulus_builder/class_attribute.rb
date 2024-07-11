require "stimulus_builder/attribute"

module StimulusBuilder
  class ClassAttribute < Attribute
    def initialize(identifier, logical_name, klass)
      @identifier = identifier
      @logical_name, @klass = logical_name.to_s, klass
    end

    def name
      "data-#{@identifier}-#{@logical_name.dasherize}-class"
    end

    def value
      @klass
    end
  end
end
