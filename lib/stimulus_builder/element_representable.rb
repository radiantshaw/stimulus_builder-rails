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

    def connect(identifier_name)
      Controller.new(identifier_name, self).tap do |controller|
        self << ControllerAttribute.new(controller)
      end
    end

    private

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
