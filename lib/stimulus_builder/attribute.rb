module StimulusBuilder
  class Attribute
    def to_hash
      { name => value }
    end

    def multi?
      false
    end
  end
end
