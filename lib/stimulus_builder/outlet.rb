class StimulusBuilder::Outlet
  MODULE_SEPARATOR = "/".freeze
  IDENTIFIER_SEPARATOR = "--".freeze

  private_constant :MODULE_SEPARATOR, :IDENTIFIER_SEPARATOR

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    identifier
  end

  private

  def identifier
    @name
      .split(MODULE_SEPARATOR)
      .map(&:dasherize)
      .join(IDENTIFIER_SEPARATOR)
  end
end
