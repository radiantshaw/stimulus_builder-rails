module StimulusBuilder
  class Railtie < ::Rails::Railtie
    initializer "stimulus_builder.helper" do
      ActionView::Base.send :include, StimulusBuilder::Helper
    end
  end
end
