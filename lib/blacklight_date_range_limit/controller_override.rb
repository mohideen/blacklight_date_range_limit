# Meant to be applied on top of a controller that implements
# Blacklight::SolrHelper. Will inject date range limiting behaviors
# to solr parameters creation.
module BlacklightDateRangeLimit
  module ControllerOverride
    extend ActiveSupport::Concern

    included do
      helper BlacklightDateRangeLimit::ViewHelperOverride
      helper DateRangeLimitHelper
    end

  end
end
