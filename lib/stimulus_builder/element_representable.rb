module StimulusBuilder
  module ElementRepresentable
    def attributes
      @attributes.inject({}) do |memo, attribute|
        memo.merge(attribute)
      end
    end

    def <<(attribute)
      update_attributes!(attribute)
    end

    def connect(identifier_name, props = nil)
      Controller.new(identifier_name, self).tap do |controller|
        self << ControllerAttribute.new(controller)

        unless props.nil?
          create_value_attributes!(controller, props[:values]) if props[:values].present?
          create_class_attributes!(controller, props[:classes]) if props[:classes].present?
        end
      end
    end

    def use(controller_name)
      Outlet.new(controller_name)
    end

    def fire(**options, &block)
      on(nil, **options, &block)
    end

    def on(event, at = nil, **options, &block)
      self << ActionAttribute.new(ActionDescriptor.new(event, block.call, at, **options))

      # FIXME: This is required so that when this method is called from Ruby files,
      # it doesn't output the value that gets returned by the above line.
      ''
    end

    private

    def create_value_attributes!(identifier, value_props)
      value_props.each do |value_name, value_value|
        self << ValueAttribute.new(identifier, value_name, value_value)
      end
    end

    def create_class_attributes!(identifier, class_props)
      class_props.each do |class_name, class_value|
        self << ClassAttribute.new(identifier, class_name, class_value)
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
    end

    def attribute_index(attribute)
      @attributes.index do |iterable_attribute|
        attribute.name == iterable_attribute.name
      end
    end
  end
end
