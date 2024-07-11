require "stimulus_builder/form_builder"
require "stimulus_builder/element"

module StimulusBuilder
  class HelperDelegate
    def initialize(view_context)
      @view_context = view_context
    end

    def form_for(record, options = {}, &block)
      options[:builder] ||= FormBuilder

      @view_context.form_for(record, options, &block)
    end

    def div(&block)
      element = Element.new
      inner_html = yield(element)
      @view_context.tag.div(inner_html, **element.attributes)
    end
  end
end
