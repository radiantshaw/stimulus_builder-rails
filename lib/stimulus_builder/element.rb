require "stimulus_builder/action_descriptor"
require "stimulus_builder/action_attribute"
require "stimulus_builder/controller_attribute"
require "stimulus_builder/element_representation"
require "stimulus_builder/outlet"

module StimulusBuilder
  class Element
    include ElementRepresentation

    def initialize
      @attributes = []
      @controller_index = nil
      @action_index = nil
      @target_indexes = {}
    end

    def attributes
      @attributes.inject({}) do |memo, attribute|
        memo.merge(attribute)
      end
    end

    def connect(controller_name)
      controller = StimulusBuilder::Controller.new(controller_name, self)

      if @controller_index.nil?
        @attributes << StimulusBuilder::ControllerAttribute.new(controller)
        @controller_index = @attributes.length - 1
      else
        @attributes[@controller_index] << controller
      end

      controller
    end

    def use(controller_name)
      StimulusBuilder::Outlet.new(controller_name)
    end

    def fire(handler, **options)
      on(nil, handler, **options)
    end

    def on(event, handler, at: nil, **options)
      action_descriptor = StimulusBuilder::ActionDescriptor.new(event, handler, at, **options)

      if @action_index.nil?
        @attributes << StimulusBuilder::ActionAttribute.new(action_descriptor)
        @action_index = @attributes.length - 1
      else
        @attributes[@action_index] << action_descriptor
      end

      # FIXME: This is required so that when this method is called from Ruby files,
      # it doesn't output the value that gets returned by the above line.
      ''
    end

    # FIXME: This is needed to not render this element in tests.
    def to_s
      ''.freeze
    end
  end
end
