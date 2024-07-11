require "stimulus_builder/controller"
require "stimulus_builder/controller_attribute"
require "stimulus_builder/element_representable"

module StimulusBuilder
  class FormBuilder < ActionView::Helpers::FormBuilder
    include ElementRepresentable

    def initialize(object_name, object, template, options)
      @attributes = []

      super(object_name, object, template, options)
    end

    def <<(attribute)
      super(attribute)

      options[:html] ||= {}
      options[:html].merge!(attributes)
    end
  end
end
