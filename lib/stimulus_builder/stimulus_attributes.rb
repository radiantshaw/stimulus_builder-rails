class StimulusBuilder::StimulusAttributes
  def initialize(attributes)
    @attributes = attributes
  end

  def to_h
    attributes_hash = {}

    @attributes.each do |attribute|
      attribute_value = attribute.value
      next unless attribute_value.present?

      attributes_hash.merge!(attribute.name => attribute_value)
    end

    attributes_hash
  end
end
