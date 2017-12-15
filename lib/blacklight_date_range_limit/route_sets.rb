module BlacklightDateRangeLimit
  # This module is monkey-patch included into Blacklight::Routes, so that
  # map_resource will route to catalog#date_range_limit, for our action
  # that fetches and returns range segments -- that action is
  # also monkey patched into (eg) CatalogController.
  module RouteSets
    extend ActiveSupport::Concern


    included do |klass|
      # Have to add ours BEFORE existing,
      # so catalog/date_range_limit can take priority over
      # being considered a document ID.
      klass.default_route_sets = [:date_range_limit] + klass.default_route_sets
    end


    protected


    # Add route for (eg) catalog/date_range_limit, pointing to the date_range_limit
    # method we monkey patch into (eg) CatalogController.
    def date_range_limit(primary_resource)
      add_routes do |options|
        get "#{primary_resource}/date_range_limit" => "#{primary_resource}#date_range_limit"
      end
    end
  end
end
