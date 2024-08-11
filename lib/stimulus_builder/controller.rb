module StimulusBuilder
  class Controller
    MODULE_SEPARATOR = "/".freeze
    IDENTIFIER_SEPARATOR = "--".freeze

    private_constant :MODULE_SEPARATOR, :IDENTIFIER_SEPARATOR

    def initialize(controller_name, element)
      @controller_name = controller_name.to_s
      @element = element
    end

    def method_missing(action_method, element = VoidElement.new, **kargs)
      if action_method.end_with?("=".freeze)
        element << TargetAttribute.new(self, action_method.to_s.chop)
      else
        params = kargs || {}
        Handler.new(self, action_method, params)
      end
    end

    def [](event_name)
      "#{self}:#{event_name.to_s.dasherize}"
    end

    def []=(selector, outlet)
      @element << OutletAttribute.new(self, outlet, selector)
    end

    def to_s
      to_str
    end

    def to_str
      controller_identifier
    end

    private

    def controller_identifier
      @controller_name
        .split(MODULE_SEPARATOR)
        .map(&:dasherize)
        .join(IDENTIFIER_SEPARATOR)
    end
  end
end
