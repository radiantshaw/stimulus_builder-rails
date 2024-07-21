module StimulusBuilder
  class Element
    include ElementRepresentable

    def initialize
      @attributes = []
    end

    # FIXME: This is needed to not render this element in tests.
    def to_s
      ''.freeze
    end
  end
end
