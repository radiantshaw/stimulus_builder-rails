module StimulusBuilder
  module Helper
    def stimulated
      HelperDelegate.new(self)
    end
  end
end
