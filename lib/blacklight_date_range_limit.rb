# BlacklightDateRangeLimit

module BlacklightDateRangeLimit
  require 'blacklight_date_range_limit/date_range_limit_builder'
  require 'blacklight_date_range_limit/controller_override'
  require 'blacklight_date_range_limit/view_helper_override'

  require 'blacklight_date_range_limit/version'
  require 'blacklight_date_range_limit/engine'

  # Raised when an invalid date range is encountered
  class InvalidDateRange < TypeError; end

  mattr_accessor :labels, :classes
  self.labels = {
    :missing => "Unknown"
  }
  self.classes = {
    form: 'date_range_limit subsection form-inline',
    submit: 'submit btn btn-default'
  }

  # Add element to array only if it's not already there
  def self.safe_arr_add(array, element)
    array << element unless array.include?(element)
  end

  # Convenience method for returning date range config hash from
  # blacklight config, for a specific solr field, in a normalized
  # way.
  #
  # Returns false if date range limiting not configured.
  # Returns hash even if configured to 'true'
  # for consistency.
  def self.date_range_config(blacklight_config, solr_field)
    field = blacklight_config.facet_fields[solr_field.to_s]

    return false unless field.date_range

    config = field.date_range
    config = { partial: field.partial } if config === true

    config
  end
end
