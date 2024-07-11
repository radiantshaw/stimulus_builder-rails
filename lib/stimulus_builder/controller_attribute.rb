require "stimulus_builder/attribute"

module StimulusBuilder
  class ControllerAttribute < Attribute
    def initialize(controller)
      @controllers = [controller]
    end

    def name
      "data-controller"
    end

    def value
      @controllers.join(" ")
    end

    def <<(controller)
      @controllers << controller
    end

    def +(controller_attribute)
      @controllers += controller_attribute.controllers

      self
    end

    def multi?
      true
    end

    protected

    attr_reader :controllers
  end
end
