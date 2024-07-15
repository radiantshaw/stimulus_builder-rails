require "stimulus_builder/identifier"
require "stimulus_builder/attribute"

module StimulusBuilder
  class ParamAttribute < Attribute
    attr_reader :value

    def initialize(identifier, name, value)
      @identifier = identifier
      @name, @value = name.to_s, value
    end

    def name
      "data-#{@identifier}-#{dasherized_name}-param"
    end

    def to_hash
      { name => value }
    end

    private

    def dasherized_name
      @name.dasherize
    end
  end
end
