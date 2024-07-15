module StimulusBuilder
  class Controller
    MODULE_SEPARATOR = "/".freeze
    IDENTIFIER_SEPARATOR = "--".freeze

    private_constant :MODULE_SEPARATOR, :IDENTIFIER_SEPARATOR

    def initialize(controller_name, element)
      @controller_name = controller_name.to_s
      @element = element
    end

    def method_missing(action_method, *args)
      if action_method.ends_with?("=".freeze)
        args[0] << TargetAttribute.new(self, action_method[..-2])
      else
        params = args[0] || {}
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
