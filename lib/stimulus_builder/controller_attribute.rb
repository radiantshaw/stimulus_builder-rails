module StimulusBuilder
  class ControllerAttribute < Attribute
    def initialize(*controllers)
      @controllers = controllers
    end

    def name
      "data-controller"
    end

    def value
      @controllers.join(" ")
    end

    def +(controller_attribute)
      self.class.new(*(@controllers + controller_attribute.controllers))
    end

    def multi?
      true
    end

    protected

    attr_reader :controllers
  end
end
