# Meant to be applied on top of a controller that implements
# Blacklight::SolrHelper. Will inject date range limiting behaviors
# to solr parameters creation.
require 'blacklight_date_range_limit/segment_calculation'
module BlacklightDateRangeLimit
  module ControllerOverride
    extend ActiveSupport::Concern

    included do
      helper BlacklightDateRangeLimit::ViewHelperOverride
      helper DateRangeLimitHelper
    end

    # Action method of our own!
    # Delivers a _partial_ that's a display of a single fields date_range facets.
    # Used when we need a second Solr query to get date_range facets, after the
    # first found min/max from result set.
    def date_range_limit
      # We need to swap out the add_date_range_limit_params search param filter,
      # and instead add in our fetch_specific_date_range_limit filter,
      # to fetch only the date_range limit segments for only specific
      # field (with start/end params) mentioned in query params
      # date_range_field, date_range_start, and date_range_end

      @response, _ = search_results(params) do |search_builder|
        search_builder.except(:add_date_range_limit_params).append(:fetch_specific_date_range_limit)
      end

      render('blacklight_date_range_limit/date_range_segments', :locals => {:solr_field => params[:date_range_field]}, :layout => !request.xhr?)
    end
  end
end
