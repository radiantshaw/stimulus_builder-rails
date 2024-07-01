class StimulusBuilder::Identifier
  MODULE_SEPARATOR = "/".freeze
  IDENTIFIER_SEPARATOR = "--".freeze

  private_constant :MODULE_SEPARATOR, :IDENTIFIER_SEPARATOR

  def initialize(controller_name)
    @controller_name = controller_name.to_s
  end

  def to_s
    @controller_name
      .split(MODULE_SEPARATOR)
      .map(&:dasherize)
      .join(IDENTIFIER_SEPARATOR)
  end
end
