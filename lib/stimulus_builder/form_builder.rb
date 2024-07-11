require "stimulus_builder/controller"
require "stimulus_builder/controller_attribute"

module StimulusBuilder
  class FormBuilder < ActionView::Helpers::FormBuilder
    def initialize(object_name, object, template, options)
      @attributes = []

      super(object_name, object, template, options)
    end

    def <<(attribute)
      update_attributes!(attribute)
    end

    def connect(identifier_name)
      Controller.new(identifier_name).tap do |controller|
        self << ControllerAttribute.new(controller)
      end
    end

    private

    def attributes
      @attributes.inject({}) do |memo, attribute|
        memo.merge(attribute)
      end
    end

    def update_attributes!(attribute)
      if attribute.multi?
        unless (current_index = attribute_index(attribute)).nil?
          @attributes[current_index] += attribute
        else
          @attributes << attribute
        end
      else
        @attributes << attribute
      end

      options[:html] ||= {}
      options[:html].merge!(attributes)
    end

    def attribute_index(attribute)
      @attributes.index do |iterable_attribute|
        attribute.class === iterable_attribute
      end
    end
  end
end
