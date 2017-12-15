require 'blacklight'
require 'blacklight_date_range_limit'
require 'rails'

module BlacklightDateRangeLimit
  class Engine < Rails::Engine
    # Need to tell asset pipeline to precompile the excanvas
    # we use for IE.
    initializer "blacklight_date_range_limit.assets", :after => "assets" do
      Rails.application.config.assets.precompile += %w( flot/excanvas.min.js )
    end

    config.action_dispatch.rescue_responses.merge!(
      "BlacklightDateRangeLimit::InvalidDateRange" => :not_acceptable
    )
  end
end
