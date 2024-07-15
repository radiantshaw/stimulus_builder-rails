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

    def button(value = nil, options = {})
      Element.new.then do |element|
        @template.capture do
          yield(element, value)
        end.then do |inner_html|
          super(value, options.merge(element.attributes)) { inner_html }
        end
      end
    end
  end
end
