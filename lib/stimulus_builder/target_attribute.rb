require "stimulus_builder/attribute"

module StimulusBuilder
  class TargetAttribute < Attribute
    def initialize(identifier, name)
      @identifier = identifier
      @names = [name]
    end

    def name
      "data-#{@identifier}-target"
    end

    def value
      properties.join(" ")
    end

    def <<(name)
      @names << name
    end

    private

    def properties
      @names.map do |name|
        name.camelize(:lower)
      end
    end
  end
end
