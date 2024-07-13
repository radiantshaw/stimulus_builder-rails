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

    def check_box(method, options = {}, checked_value = "1", unchecked_value = "0")
      Element.new.then do |element|
        yield(element)

        super(method, options.merge(element.attributes), checked_value, unchecked_value)
      end
    end
  end
end
