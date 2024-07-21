module StimulusBuilder
  class ValueAttribute < Attribute
    def initialize(identifier, key, value)
      @identifier = identifier
      @key, @value = key.to_s, value
    end

    def name
      "data-#{@identifier}-#{@key.dasherize}-value"
    end

    def value
      @value
    end
  end
end
