module StimulusBuilder
  class OutletAttribute < Attribute
    def initialize(identifier, outlet, selector)
      @identifier = identifier
      @outlet = outlet
      @selector = selector
    end

    def name
      "data-#{@identifier}-#{@outlet}-outlet"
    end

    def value
      @selector
    end
  end
end
