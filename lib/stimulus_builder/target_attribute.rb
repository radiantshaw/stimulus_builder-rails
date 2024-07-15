module StimulusBuilder
  class TargetAttribute < Attribute
    def initialize(identifier, *target_names)
      @identifier = identifier
      @target_names = target_names
    end

    def name
      "data-#{@identifier}-target"
    end

    def value
      properties.join(" ")
    end

    def multi?
      true
    end

    def +(target_attribute)
      self.class.new(@identifier, *(@target_names + target_attribute.target_names))
    end

    protected

    attr_reader :target_names

    private

    def properties
      @target_names.map do |target_name|
        target_name.camelize(:lower)
      end
    end
  end
end
