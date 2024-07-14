require "stimulus_builder/form_builder"
require "stimulus_builder/element"

module StimulusBuilder
  class HelperDelegate
    ELEMENT_NAMES = [
      :div, :span, :input, :button, :img
    ].freeze

    private_constant :ELEMENT_NAMES

    def initialize(view_context)
      @view_context = view_context
    end

    def form_for(record, options = {}, &block)
      options[:builder] ||= FormBuilder

      @view_context.form_for(record, options, &block)
    end

    ELEMENT_NAMES.each do |element_name|
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
                **options.merge(element.attributes)
              )
          end
        end
      end
    end
  end
end
