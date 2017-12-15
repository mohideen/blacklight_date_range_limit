require 'blacklight'
require 'blacklight_date_range_limit'
require 'rails'

module BlacklightDateRangeLimit
  class Engine < Rails::Engine
    config.action_dispatch.rescue_responses.merge!(
      "BlacklightDateRangeLimit::InvalidDateRange" => :not_acceptable
    )
  end
end
