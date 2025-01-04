module StimulusBuilder
  class ParamAttribute < Attribute
    def initialize(identifier, name, param)
      @identifier = identifier
      @name, @param = name.to_s, param
    end

    def name
      "data-#{@identifier}-#{dasherized_name}-param"
    end

    def value
      @param
    end

    private

    def dasherized_name
      @name.dasherize
    end
  end
end
