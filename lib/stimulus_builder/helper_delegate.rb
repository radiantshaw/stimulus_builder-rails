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

    [:div, :span, :input].each do |element_name|
      define_method(element_name) do |content = nil, **options, &block|
        Element.new.then do |element|
          @view_context.capture do
            block.call(element)
          end.then do |inner_html|
            @view_context
              .tag
              .public_send(
                element_name,
                inner_html,
                **element.attributes
              )
          end
        end
      end
    end
  end
end
