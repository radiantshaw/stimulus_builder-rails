module StimulusBuilder
  class Attribute
    def multi?
      false
    end

    def name
      raise NotImplementedError
    end

    def value
      raise NotImplementedError
    end
  end
end
