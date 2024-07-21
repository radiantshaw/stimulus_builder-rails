module StimulusBuilder
  class ActionDescriptor
    def initialize(event, handler, target = nil, **options)
      @event, @handler = event, handler
      @target, @options = target, options
    end

    def to_s
      descriptor = ""

      if @event.present?
        descriptor += @event

        if @target.present?
          descriptor += "@#{@target}"
        end

        descriptor += "->"
      end


      descriptor + "#{@handler}" + processed_options
    end

    private

    def processed_options
      @options.inject("") do |processed_options, (option, condition)|
        processed_options +=
          if condition == true
            ":#{option}"
          elsif condition == false
            ":!#{option}"
          end
      end
    end
  end
end
